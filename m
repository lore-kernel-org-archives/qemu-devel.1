Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZPHI-0007hC-2o
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZPHG-0001AH-Vc
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:23:08 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZPHG-000190-Ng
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 18:23:06 -0400
Received: by mail-wm0-x230.google.com with SMTP id c184so10879936wmd.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 15:23:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2017 23:22:45 +0100
Message-ID: <CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
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

On 23 July 2017 at 23:11, Hua Yanghao <huayanghao@gmail.com> wrote:
>> Suppose we have these two segments:
>>  SEGMENT 1: start 0x1000, end 0x2fff, data all 0xff
>>  SEGMENT 2: start 0x2000, end 0x3fff, data all 0x00
>>
>> Clearly for the memory 0x1000..0x1fff we want the 0xff
>> data, and for 0x3000..0x3fff we want 0x00.
>> But for the memory 0x2000..0x2fff which is in
>> both segment 1 and segment 2, should QEMU load
>> 0xff or 0x00 bytes ?
>>
>> We shouldn't pick randomly or just do whatever our
>> implementation "happens to do" -- we need to look
>> at what the ELF spec says must happen and do that.
> I don't see how linker could allow that to happen.
> If two section overlaps one of them should be of NOLOAD type.
> Otherwise linker complains the overlapping of LMA.

I have seen ELF files which have this overlap and
where both segments are PT_LOAD. (I think in the cases
I've seen the contents in both segments agree rather than
being different data, but a loader is not going to be
expected to do a comparison of the file data.)

> So for me just ignore NOLOAD section would do the trick.

We already ignore all the ELF segments which are not
of type PT_LOAD:
http://git.qemu.org/?p=qemu.git;a=blob;f=include/hw/elf_ops.h;h=a172a6068a48e233dd802043b3304a9e0a5d3be6;hb=HEAD#l353

If you're hitting this error case then I think the
affected segments must both be of type PT_LOAD.
(If you're not sure you can post here the output
of running 'objdump -p' on the binary or otherwise
show us the program header.)

PS: you're consistently saying "section", but in the
ELF format "section" and "segment" are two different
things. QEMU doesn't actually look at the section table.
In an ELF file, sections are used by the linker, but a
program loader like QEMU (or the Linux kernel)
looks only at the segment table in the program header.

thanks
-- PMM
