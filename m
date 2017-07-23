Received: from eggs.gnu.org ([2001:4830:134:3::10]:35972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZO4N-0003ex-0b
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 17:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZO4M-0007AA-4h
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 17:05:42 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZO4L-00079V-QH
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 17:05:42 -0400
Received: by mail-wm0-x233.google.com with SMTP id c184so17598801wmd.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 14:05:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2017 22:05:20 +0100
Message-ID: <CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
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
To: Hua Yanghao <huayanghao@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 July 2017 at 21:58, Hua Yanghao <huayanghao@gmail.com> wrote:
>> (1) does this change give the right behaviour for
>> which of the two overlapping segment is honoured?
>> (I *think* the correct answer is that the second
>> segment in the program header table should be
>> loaded second, ie its definition of the memory
>> contents is used, not that of the first segment)
> I am not sure if I understood this point. linker will check for
> section overlaps and if linker
> did not complain why should qemu complain. qemu should simply follow
> the LMA for each
> section and ignore NOLOAD section for me this is the sane behavior.

Suppose we have these two segments:
 SEGMENT 1: start 0x1000, end 0x2fff, data all 0xff
 SEGMENT 2: start 0x2000, end 0x3fff, data all 0x00

Clearly for the memory 0x1000..0x1fff we want the 0xff
data, and for 0x3000..0x3fff we want 0x00.
But for the memory 0x2000..0x2fff which is in
both segment 1 and segment 2, should QEMU load
0xff or 0x00 bytes ?

We shouldn't pick randomly or just do whatever our
implementation "happens to do" -- we need to look
at what the ELF spec says must happen and do that.

>> (2) should we allow the overlap only for ELF files but
>> retain the complain for overlapping ROMs of other types?
>> (eg by having the elf loader create "rom"s which
>> don't overlap by trimming the overlap itself)
> I think this should only apply for ELF files. (this is the only thing
> I care or understood so far,
> so not touching other types of input binaries ... however I am not
> sure if I am capable to provide
> a right patch to handle the ROM files properly, I only looked into
> qemu code starting today ...)

The patch you have here will affect QEMU's handling
of ROMs of all types, because the loader.c code
handles all the registered ROM images, not just those
that the ELF loader creates from ELF files.

(PS: these questions are partly aimed at the other
QEMU developers who I cc'd, not just you.)

thanks
-- PMM
