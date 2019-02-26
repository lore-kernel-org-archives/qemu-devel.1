Received: from eggs.gnu.org ([209.51.188.92]:51346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyiqf-0005cF-UH
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyiqd-0004vr-Ns
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:57:05 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyiqX-0004fu-47
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:56:58 -0500
Received: by mail-wr1-x441.google.com with SMTP id w2so15325219wrt.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:56:43 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190226193408.23862-1-armbru@redhat.com>
Date: Tue, 26 Feb 2019 19:56:40 +0000
Message-ID: <87wolml3wn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] pflash: Fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e posted this patch to address an XXX comment in
> pflash_cfi01_realize() the other day:

If I send you v5 will you include that in your series?

>
> Subject: [PATCH v2] hw/block: report when pflash backing file isn't align=
ed
> Message-Id: <20190215122808.22301-1-alex.bennee@linaro.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg04166.html
>
> Review led me to look into its callers.  Most of them are pleasantly
> boring: they create flash memory of some fixed size at some fixed
> address.  A few are more creative, and some of the creative ones look
> quite broken to me.  Fix them, and clean up some along the way.
>
> v2:
> * PATCH 01+10: Style cleanups [checkpatch]
> * PATCH 02: Rewritten [Peter, Philippe]
> * PATCH 03+04: New [Philippe]
> * PATCH 06: Commit message improved, FIXME added, accidental
>   replacement of 64 * KiB by 65536 backed out [Zoltan]
> * PATCH 07: Style tweak [Alex, David]
> * PATCH 08: Commit message typo [Philippe]
> * PATCH 11: Commit message typo [L=C3=A1szl=C3=B3]
> * Old PATCH 10 dropped [Max, Peter]
>
> Markus Armbruster (11):
>   pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02
>   pflash_cfi01: Do not exit() on guest aborting "write to buffer"
>   pflash_cfi01: Log use of flawed "write to buffer"
>   pflash: Rename *CFI_PFLASH* to *PFLASH_CFI*
>   hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2}
>   sam460ex: Don't size flash memory to match backing image
>   ppc405_boards: Don't size flash memory to match backing image
>   r2d: Flash memory creation is confused about size, mark FIXME
>   mips_malta: Clean up definition of flash memory size somewhat
>   pflash: Clean up after commit 368a354f02b part 1
>   pflash: Clean up after commit 368a354f02b part 2
>
>  hw/arm/collie.c                          |   9 +-
>  hw/arm/digic_boards.c                    |   3 +-
>  hw/arm/gumstix.c                         |   8 +-
>  hw/arm/mainstone.c                       |   4 +-
>  hw/arm/musicpal.c                        |   8 +-
>  hw/arm/omap_sx1.c                        |   8 +-
>  hw/arm/versatilepb.c                     |   3 +-
>  hw/arm/vexpress.c                        |  10 +-
>  hw/arm/virt.c                            |   3 +-
>  hw/arm/xilinx_zynq.c                     |   5 +-
>  hw/arm/z2.c                              |   5 +-
>  hw/block/pflash_cfi01.c                  | 123 ++++++++++++-----------
>  hw/block/pflash_cfi02.c                  |  79 ++++++++-------
>  hw/i386/pc_sysfw.c                       |  10 +-
>  hw/lm32/lm32_boards.c                    |   8 +-
>  hw/lm32/milkymist.c                      |   4 +-
>  hw/microblaze/petalogix_ml605_mmu.c      |   5 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |   4 +-
>  hw/mips/mips_malta.c                     |  15 ++-
>  hw/mips/mips_r4k.c                       |   4 +-
>  hw/ppc/ppc405_boards.c                   |  57 ++++-------
>  hw/ppc/sam460ex.c                        |  41 +++++---
>  hw/ppc/virtex_ml507.c                    |   4 +-
>  hw/sh4/r2d.c                             |  11 +-
>  hw/xtensa/xtfpga.c                       |  12 +--
>  include/hw/block/flash.h                 |  57 +++++++----
>  26 files changed, 257 insertions(+), 243 deletions(-)


--
Alex Benn=C3=A9e
