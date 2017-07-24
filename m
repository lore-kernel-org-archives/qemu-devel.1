Received: from eggs.gnu.org ([2001:4830:134:3::10]:49057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZgVn-0007uI-Qr
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZgVn-0000p4-0M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:47:15 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZgVm-0000oy-Or
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:47:14 -0400
Received: by mail-wm0-x22d.google.com with SMTP id c184so36667133wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 09:47:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 17:46:52 +0100
Message-ID: <CAFEAcA-R5DJUgT=fLDM4uYcRFyDWVm6hnJiPuS55jg=1AThZ6Q@mail.gmail.com>
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

On 23 July 2017 at 21:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> Does anybody know (a) what the ELF spec mandates
> for overlapping segments and (b) what the history
> and rationale for QEMU's overlapping-roms check is?

Having asked around a bit, it appears that it's fairly common
in the embedded world to treat the ELF "vaddr" as the "execution
address" and the ELF "paddr" as "load address", with the
size of the data to be loaded at the load address being
specified by "filesz". The typical application is where
an application is packed into ROM -- the ROM addresses are
the paddr values, and something at runtime will unpack
everything into the vaddr addresses where it eventually
runs from (and handle the zero-initialization).

The awkward part is that this is more pervasive convention
rather than actually written down as a specification, and
there's no way to tell whether a particular ELF file is
using it or not.

My current theory is that we can handle this with:
 * load the segment with the assumption that the
   memsz is the size to use (zero-filling), as
   we do now
 * _unless_ that would make it overlap with the following
   segment, in which case use the filesz

That ought to make all the ELF files we currently load
OK continue to load with the same semantics, and also
permit loading of ELF files using the ARM embedded
conventions. In some cases of ELF files using the
embedded convention but not tightly packing their
segments into ROM it will zero out some of the gaps
between segments, but I think that should be harmless.

thanks
-- PMM
