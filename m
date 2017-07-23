Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZP5h-0004cP-HD
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZP5g-00078B-Lk
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:11:09 -0400
Received: from mail-yb0-x22f.google.com ([2607:f8b0:4002:c09::22f]:34578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZP5g-00077P-H2
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:11:08 -0400
Received: by mail-yb0-x22f.google.com with SMTP id z37so19650114ybh.1
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 15:11:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Mon, 24 Jul 2017 00:11:07 +0200
Message-ID: <CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

> Suppose we have these two segments:
>  SEGMENT 1: start 0x1000, end 0x2fff, data all 0xff
>  SEGMENT 2: start 0x2000, end 0x3fff, data all 0x00
>
> Clearly for the memory 0x1000..0x1fff we want the 0xff
> data, and for 0x3000..0x3fff we want 0x00.
> But for the memory 0x2000..0x2fff which is in
> both segment 1 and segment 2, should QEMU load
> 0xff or 0x00 bytes ?
>
> We shouldn't pick randomly or just do whatever our
> implementation "happens to do" -- we need to look
> at what the ELF spec says must happen and do that.
I don't see how linker could allow that to happen.
If two section overlaps one of them should be of NOLOAD type.
Otherwise linker complains the overlapping of LMA.

So for me just ignore NOLOAD section would do the trick.

> The patch you have here will affect QEMU's handling
> of ROMs of all types, because the loader.c code
> handles all the registered ROM images, not just those
> that the ELF loader creates from ELF files.
>
> (PS: these questions are partly aimed at the other
> QEMU developers who I cc'd, not just you.)
>
Thanks PPM. This is really beyond my knowledge and hope someone could
help making a clean patch!

BR, Yanghao
