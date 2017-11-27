Received: from eggs.gnu.org ([2001:4830:134:3::10]:53635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJKYj-0002EH-0m
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJKYd-0003oT-Ch
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:57 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:42767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJKYd-0003oB-5N
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:51 -0500
Received: by mail-wr0-f173.google.com with SMTP id o14so26637012wrf.9
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 06:38:51 -0800 (PST)
References: <CAFEAcA9dz9pO_mQ1xtmsT7MW6kXXnNaedgmXe1Eh0Cp53zPz5Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f058c3d3-3d8e-4995-0bf7-abadd2c48d99@redhat.com>
Date: Mon, 27 Nov 2017 15:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dz9pO_mQ1xtmsT7MW6kXXnNaedgmXe1Eh0Cp53zPz5Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 24/11/2017 18:18, Peter Maydell wrote:
>  * threads A & B both try to do a write to a page with code in it at
>    the same time (ie which we've made non-writeable, so SEGV)
>  * they race into the signal handler with this faulting address
>  * thread A happens to get to page_unprotect() first and takes the
>    mmap lock, so thread B sits waiting for it to be done
>  * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
>  * A can then continue OK (returns from signal handler to retry the
>    memory access)
>  * ...but when B gets the mmap lock it finds that the page is already
>    PAGE_WRITE, and so it exits page_unprotect() via the "not due to
>    protected translation" code path, and wrongly delivers the signal
>    to the guest rather than just retrying the access
> 
> I'm not sure how best to fix this. We could make page_unprotect()
> say "if PAGE_WRITE is set, assume this call raced with another one
> and say 'this was caused by protected translation' without doing
> anything".

Yes, I think this is the only solution since SIGSEGV is raised
asynchronously.  Even using a trylock would only narrow the race window
but not fix it.

> But I have a feeling that will mean we could end up looping
> endlessly if we get a SEGV for a write to a writeable page (not
> sure when this could happen, but maybe alignment issues?).

Those would have to be detected via si_code (for the specific case of
invalid address alignment, that would be a SIGBUS with
si_code==BUS_ADRALN, not a SIGSEGV).

In general, I think that only SIGSEGV/SEGV_ACCERR needs to go down the
page_unprotect path.

Paolo
