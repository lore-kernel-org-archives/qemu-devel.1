Received: from eggs.gnu.org ([2001:4830:134:3::10]:42882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJL7m-0001xn-Mk
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJL7h-0004by-2f
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:15:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJL7g-0004bV-Tf
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:15:05 -0500
References: <CAFEAcA9dz9pO_mQ1xtmsT7MW6kXXnNaedgmXe1Eh0Cp53zPz5Q@mail.gmail.com>
	<f058c3d3-3d8e-4995-0bf7-abadd2c48d99@redhat.com>
	<CAFEAcA_t0PYZ68HZruWjpeLsU=iOtPbdP9=ETPWXwG+iBRPGrA@mail.gmail.com>
	<0c5530cd-6f56-bce6-9fdf-91c1468324e4@redhat.com>
	<CAFEAcA8h6qU5g7t_YE3b-DJEG-gNrCYqYcp6488xQWX00yZuhg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7109142-28ee-773a-63cb-945ee0fc7ad8@redhat.com>
Date: Mon, 27 Nov 2017 16:14:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8h6qU5g7t_YE3b-DJEG-gNrCYqYcp6488xQWX00yZuhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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

On 27/11/2017 16:06, Peter Maydell wrote:
> On 27 November 2017 at 15:53, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>> On 27/11/2017 15:47, Peter Maydell wrote:
>>> I have a patch from rth based on an idea he and I came up with:
>>> we add a field to the PageDesc struct to store the thread id of
>>> the thread that last touches the flags. If you come into the
>>> segv handler and the page flags/last-modified-by field say "should be
>>> writeable and somebody else updated it" then you mark the page as
>>> "last modified by this thread" and retry the access. If the
>>> flags say "should be writeable, last modified by this thread"
>>> then you know the page state hasn't changed since this thread
>>> last saw it as "definitely not causing segvs because of cached TBs",
>>> and so that should be passed on as a guest SEGV.
>> Clever, but why would si_code not work?...
> Do we have a guarantee that it's absolutely never the case that
> you can get a SEGV with si_code SEGV_ACCERR for an access to memory
> that's mapped writeable (and conversely that we'll always get
> SEGV_ACCERR for the "mapped nonwriteable" case)? If it's ever possible
> then the guest will go into an infinite loop of taking segfaults that
> should be delivered to the guest but which we just retry the failing
> access for forever...

At least for x86, yes.

For ARM, the syndrome values that trigger SEGV_ACCERR are 9-11 and
13-15, which seems sane to me but I know much less about ARM than x86.

So I would say "yes except for kernel bugs".

Paolo
