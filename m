Received: from eggs.gnu.org ([2001:4830:134:3::10]:57693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIHco-0005F6-RH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIHcn-0003LL-54
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:18:50 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:43344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIHcm-0003G1-O1
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:18:48 -0500
Received: by mail-ot0-x229.google.com with SMTP id 105so19273820oth.10
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 09:18:48 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 17:18:27 +0000
Message-ID: <CAFEAcA9dz9pO_mQ1xtmsT7MW6kXXnNaedgmXe1Eh0Cp53zPz5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] javac crash in user-mode emulation: races on
 page_unprotect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

I managed to track down the crash running javac in user-mode
emulation. The problem is that we can have several threads which
race in page_unprotect():

 * threads A & B both try to do a write to a page with code in it at
   the same time (ie which we've made non-writeable, so SEGV)
 * they race into the signal handler with this faulting address
 * thread A happens to get to page_unprotect() first and takes the
   mmap lock, so thread B sits waiting for it to be done
 * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
 * A can then continue OK (returns from signal handler to retry the
   memory access)
 * ...but when B gets the mmap lock it finds that the page is already
   PAGE_WRITE, and so it exits page_unprotect() via the "not due to
   protected translation" code path, and wrongly delivers the signal
   to the guest rather than just retrying the access

I'm not sure how best to fix this. We could make page_unprotect()
say "if PAGE_WRITE is set, assume this call raced with another one
and say 'this was caused by protected translation' without doing
anything". But I have a feeling that will mean we could end up looping
endlessly if we get a SEGV for a write to a writeable page (not
sure when this could happen, but maybe alignment issues?).

Anybody got a better idea?

thanks
-- PMM
