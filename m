Received: from eggs.gnu.org ([2001:4830:134:3::10]:33277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJKn6-0007p2-6N
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJKn1-0001wO-80
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJKn1-0001vX-1D
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:53:43 -0500
References: <CAFEAcA9dz9pO_mQ1xtmsT7MW6kXXnNaedgmXe1Eh0Cp53zPz5Q@mail.gmail.com>
	<f058c3d3-3d8e-4995-0bf7-abadd2c48d99@redhat.com>
	<CAFEAcA_t0PYZ68HZruWjpeLsU=iOtPbdP9=ETPWXwG+iBRPGrA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c5530cd-6f56-bce6-9fdf-91c1468324e4@redhat.com>
Date: Mon, 27 Nov 2017 15:53:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_t0PYZ68HZruWjpeLsU=iOtPbdP9=ETPWXwG+iBRPGrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] javac crash in user-mode emulation: races on
 page_unprotect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 27/11/2017 15:47, Peter Maydell wrote:
> On 27 November 2017 at 15:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 24/11/2017 18:18, Peter Maydell wrote:
>>>  * threads A & B both try to do a write to a page with code in it at
>>>    the same time (ie which we've made non-writeable, so SEGV)
>>>  * they race into the signal handler with this faulting address
>>>  * thread A happens to get to page_unprotect() first and takes the
>>>    mmap lock, so thread B sits waiting for it to be done
>>>  * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
>>>  * A can then continue OK (returns from signal handler to retry the
>>>    memory access)
>>>  * ...but when B gets the mmap lock it finds that the page is already
>>>    PAGE_WRITE, and so it exits page_unprotect() via the "not due to
>>>    protected translation" code path, and wrongly delivers the signal
>>>    to the guest rather than just retrying the access
>>>
>>> I'm not sure how best to fix this. We could make page_unprotect()
>>> say "if PAGE_WRITE is set, assume this call raced with another one
>>> and say 'this was caused by protected translation' without doing
>>> anything".
>>
>> Yes, I think this is the only solution since SIGSEGV is raised
>> asynchronously.  Even using a trylock would only narrow the race window
>> but not fix it.
> 
> I have a patch from rth based on an idea he and I came up with:
> we add a field to the PageDesc struct to store the thread id of
> the thread that last touches the flags. If you come into the
> segv handler and the page flags/last-modified-by field say "should be
> writeable and somebody else updated it" then you mark the page as
> "last modified by this thread" and retry the access. If the
> flags say "should be writeable, last modified by this thread"
> then you know the page state hasn't changed since this thread
> last saw it as "definitely not causing segvs because of cached TBs",
> and so that should be passed on as a guest SEGV.

Clever, but why would si_code not work?...

Paolo
