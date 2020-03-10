Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71027C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CD320675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMLXdGGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CD320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgKU-0003hW-Dh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgI6-0008AC-R4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgI3-0003WE-RG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBgI3-0003Tc-HX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id a141so1702276wme.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uapDUvA2ltILOBI4S8FJB9subs3BWsq9e+DFbOY269w=;
 b=WMLXdGGObq2lyTsEUIIe+p3oEB9PlUE3Q8DC/X55xrVJHvsjXHpxAqxR3qMMiFa2RV
 5iRE11nK2JmAYoo//Jq++KG/llI28b7I8ED9lLdaAtRMwJlmhRYCCE0r4lyRyK2ReDz1
 1dXxLajQUcrFQwaZyP/h7BfGlgsubbgYYjgm2M15wpfio8Xi0Dc1iGjXGVwt3uTA7e8r
 sPQVSudpqpzESBzmcrSu/dKnb63BvTAVSfq32ZjRKus9JPfERrLuM579pe+D5kHU6hxN
 tuXzWcj4FZjkwBo+uq2e1MXYwL4waLQgB+Y/1vgQhjXdzSIOAlTQB/3oa8NfOpa58Wly
 6Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uapDUvA2ltILOBI4S8FJB9subs3BWsq9e+DFbOY269w=;
 b=adFV1UqzeIf2/z/MssRITkre6aOGlgFIjh4a3UpT76c5P8af1ktQIssKBC6yo9ftZm
 hcSFuLuQzsfwOwM1inr9Ns5sHP/FfZ+ndUcHyEK1GRO/LfS24V8mbnHV5sf/M39YbUsU
 EyCnlpaEELpc9J3nqfJzrBUNscDNMRDAs4CIQgfT7m9JGEKp2svjGbcRnKeHYuLETXAP
 UUKZZYx/af0xX0Unhej4yJ/9C0A/hqpG0+RI4rS/Im9GtPh3HPs5sVYUpr6M5OFJ2Iw5
 /saICqHTa7Oyj+r3fdpeRhUhxy4/EbwrmGbmkDqej8t6CnamAjFXsv9XoaashQiy6/nK
 wmtA==
X-Gm-Message-State: ANhLgQ2gOkDodvBfe8qV1I5PdgcvT+Du7tVjUoqe8WpcNKyMTt8KYiT8
 cMa5Us4nstUJNZsroWkRsiEMgkHDEI0=
X-Google-Smtp-Source: ADFU+vuDu0ibPYZoNt8GGXFMdZT5Df9tRUis/sp7Dj4CLdzSWM2puDIJ2SHwXqWcXxS3G23s7w8HgA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr2500485wmj.41.1583852126048;
 Tue, 10 Mar 2020 07:55:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l64sm4481767wmf.30.2020.03.10.07.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:55:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 027F61FF7E;
 Tue, 10 Mar 2020 14:55:24 +0000 (GMT)
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-6-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 5/5] docs: Be consistent about capitalization of 'Arm'
In-reply-to: <20200309215818.2021-6-peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 14:55:23 +0000
Message-ID: <871rq0i7j8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The company 'Arm' went through a rebranding some years back
> involving a recapitalization from 'ARM' to 'Arm'. As a result
> our documentation is a bit inconsistent between the two forms.
> It's not worth trying to update everywhere in QEMU, but it's
> easy enough to make docs/ consistent.
>
> Note that "ARMv8" and similar architecture names, and
> older CPU names like "ARM926" still retain all-caps.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> I don't feel very strongly about this change, but it
> looked a bit odd where earlier rearrangements in this
> series meant that some documents had a mix of both styles,
> so I thought I might as well fix all of docs/.
> ---
>  docs/can.txt                     | 2 +-
>  docs/devel/atomics.txt           | 2 +-
>  docs/devel/multi-thread-tcg.txt  | 8 ++++----
>  docs/replay.txt                  | 2 +-
>  docs/specs/fw_cfg.txt            | 2 +-
>  docs/devel/kconfig.rst           | 2 +-
>  docs/devel/loads-stores.rst      | 2 +-
>  docs/devel/tcg.rst               | 2 +-
>  docs/specs/tpm.rst               | 6 +++---
>  docs/system/arm/cpu-features.rst | 4 ++--
>  docs/system/arm/integratorcp.rst | 2 +-
>  docs/system/arm/musicpal.rst     | 2 +-
>  docs/system/arm/nseries.rst      | 2 +-
>  docs/system/arm/palm.rst         | 2 +-
>  docs/system/arm/realview.rst     | 4 ++--
>  docs/system/arm/sx1.rst          | 2 +-
>  docs/system/arm/versatile.rst    | 2 +-
>  docs/system/arm/xscale.rst       | 2 +-
>  docs/user/main.rst               | 8 ++++----
>  19 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/docs/can.txt b/docs/can.txt
> index 9fa6ed51c82..11ed8f2d68b 100644
> --- a/docs/can.txt
> +++ b/docs/can.txt
> @@ -13,7 +13,7 @@ controller is implemented.
>=20=20
>  The PCI addon card hardware has been selected as the first CAN
>  interface to implement because such device can be easily connected
> -to systems with different CPU architectures (x86, PowerPC, ARM, etc.).
> +to systems with different CPU architectures (x86, PowerPC, Arm, etc.).
>=20=20
>  The project has been initially started in frame of RTEMS GSoC 2013
>  slot by Jin Yang under our mentoring  The initial idea was to provide ge=
neric
> diff --git a/docs/devel/atomics.txt b/docs/devel/atomics.txt
> index a4db3a4aaad..67bdf826280 100644
> --- a/docs/devel/atomics.txt
> +++ b/docs/devel/atomics.txt
> @@ -87,7 +87,7 @@ Sequentially consistent loads and stores can be done us=
ing:
>      atomic_xchg(ptr, val) for stores
>=20=20
>  However, they are quite expensive on some platforms, notably POWER and
> -ARM.  Therefore, qemu/atomic.h provides two primitives with slightly
> +Arm.  Therefore, qemu/atomic.h provides two primitives with slightly
>  weaker constraints:
>=20=20
>      typeof(*ptr) atomic_mb_read(ptr)
> diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tc=
g.txt
> index 782bebc28b4..3c85ac0eab9 100644
> --- a/docs/devel/multi-thread-tcg.txt
> +++ b/docs/devel/multi-thread-tcg.txt
> @@ -227,7 +227,7 @@ minimise contention.
>  (Current solution)
>=20=20
>  MMIO access automatically serialises hardware emulation by way of the
> -BQL. Currently ARM targets serialise all ARM_CP_IO register accesses
> +BQL. Currently Arm targets serialise all ARM_CP_IO register accesses
>  and also defer the reset/startup of vCPUs to the vCPU context by way
>  of async_run_on_cpu().
>=20=20
> @@ -268,7 +268,7 @@ ordered backends this could become a NOP.
>  Aside from explicit standalone memory barrier instructions there are
>  also implicit memory ordering semantics which comes with each guest
>  memory access instruction. For example all x86 load/stores come with
> -fairly strong guarantees of sequential consistency where as ARM has
> +fairly strong guarantees of sequential consistency whereas Arm has
>  special variants of load/store instructions that imply acquire/release
>  semantics.
>=20=20
> @@ -317,7 +317,7 @@ x86 cmpxchg instruction.
>=20=20
>  The second type offer a pair of load/store instructions which offer a
>  guarantee that a region of memory has not been touched between the
> -load and store instructions. An example of this is ARM's ldrex/strex
> +load and store instructions. An example of this is Arm's ldrex/strex
>  pair where the strex instruction will return a flag indicating a
>  successful store only if no other CPU has accessed the memory region
>  since the ldrex.
> @@ -339,7 +339,7 @@ CURRENT OPEN QUESTIONS:
>=20=20
>  The TCG provides a number of atomic helpers (tcg_gen_atomic_*) which
>  can be used directly or combined to emulate other instructions like
> -ARM's ldrex/strex instructions. While they are susceptible to the ABA
> +Arm's ldrex/strex instructions. While they are susceptible to the ABA
>  problem so far common guests have not implemented patterns where
>  this may be a problem - typically presenting a locking ABI which
>  assumes cmpxchg like semantics.
> diff --git a/docs/replay.txt b/docs/replay.txt
> index f4619a62a3d..70c27edb362 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -19,7 +19,7 @@ Deterministic replay has the following features:
>     the memory, state of the hardware devices, clocks, and screen of the =
VM.
>   * Writes execution log into the file for later replaying for multiple t=
imes
>     on different machines.
> - * Supports i386, x86_64, and ARM hardware platforms.
> + * Supports i386, x86_64, and Arm hardware platforms.
>   * Performs deterministic replay of all operations with keyboard and mou=
se
>     input devices.
>=20=20
> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> index 08c00bdf44a..8f1ebc66fa4 100644
> --- a/docs/specs/fw_cfg.txt
> +++ b/docs/specs/fw_cfg.txt
> @@ -82,7 +82,7 @@ Selector Register IOport: 0x510
>  Data Register IOport:     0x511
>  DMA Address IOport:       0x514
>=20=20
> -=3D=3D=3D ARM Register Locations =3D=3D=3D
> +=3D=3D=3D Arm Register Locations =3D=3D=3D
>=20=20
>  Selector Register address: Base + 8 (2 bytes)
>  Data Register address:     Base + 0 (8 bytes)
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index b7bca447046..e5df72b3422 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -8,7 +8,7 @@ time different targets can share large amounts of code.  =
For example,
>  a POWER and an x86 board can run the same code to emulate a PCI network
>  card, even though the boards use different PCI host bridges, and they
>  can run the same code to emulate a SCSI disk while using different
> -SCSI adapters.  ARM, s390 and x86 boards can all present a virtio-blk
> +SCSI adapters.  Arm, s390 and x86 boards can all present a virtio-blk
>  disk to their guests, but with three different virtio guest interfaces.
>=20=20
>  Each QEMU target enables a subset of the boards, devices and buses that
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 03aa9e7ff80..0d99eb24c1b 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -302,7 +302,7 @@ way QEMU defines the view of memory that a device or =
CPU has.
>  or bus fabric.)
>=20=20
>  Each CPU has an AddressSpace. Some kinds of CPU have more than
> -one AddressSpace (for instance ARM guest CPUs have an AddressSpace
> +one AddressSpace (for instance Arm guest CPUs have an AddressSpace
>  for the Secure world and one for NonSecure if they implement TrustZone).
>  Devices which can do DMA-type operations should generally have an
>  AddressSpace. There is also a "system address space" which typically
> diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
> index 4956a30a4e6..4ebde44b9d7 100644
> --- a/docs/devel/tcg.rst
> +++ b/docs/devel/tcg.rst
> @@ -83,7 +83,7 @@ memory until the end of the translation block.  This is=
 done for internal
>  emulation state that is rarely accessed directly by the program and/or c=
hanges
>  very often throughout the execution of a translation block---this includ=
es
>  condition codes on x86, delay slots on SPARC, conditional execution on
> -ARM, and so on.  This state is stored for each target instruction, and
> +Arm, and so on.  This state is stored for each target instruction, and
>  looked up on exceptions.
>=20=20
>  MMU emulation
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index da9eb39ca97..5e61238bc5f 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -25,7 +25,7 @@ QEMU files related to TPM TIS interface:
>=20=20
>  Both an ISA device and a sysbus device are available. The former is
>  used with pc/q35 machine while the latter can be instantiated in the
> -ARM virt machine.
> +Arm virt machine.
>=20=20
>  CRB interface
>  -------------
> @@ -331,7 +331,7 @@ In case a pSeries machine is emulated, use the follow=
ing command line:
>      -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddri=
ve-virtio-disk0,id=3Dvirtio-disk0 \
>      -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
>=20=20
> -In case an ARM virt machine is emulated, use the following command line:
> +In case an Arm virt machine is emulated, use the following command line:
>=20=20
>  .. code-block:: console
>=20=20
> @@ -346,7 +346,7 @@ In case an ARM virt machine is emulated, use the foll=
owing command line:
>      -drive if=3Dpflash,format=3Draw,file=3Dflash0.img,readonly \
>      -drive if=3Dpflash,format=3Draw,file=3Dflash1.img
>=20=20
> -  On ARM, ACPI boot with TPM is not yet supported.
> +  On Arm, ACPI boot with TPM is not yet supported.
>=20=20
>  In case SeaBIOS is used as firmware, it should show the TPM menu item
>  after entering the menu with 'ESC'.
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-featu=
res.rst
> index 7495b7b672b..2d5c06cd016 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -5,9 +5,9 @@ CPU features are optional features that a CPU of supporti=
ng type may
>  choose to implement or not.  In QEMU, optional CPU features have
>  corresponding boolean CPU proprieties that, when enabled, indicate
>  that the feature is implemented, and, conversely, when disabled,
> -indicate that it is not implemented. An example of an ARM CPU feature
> +indicate that it is not implemented. An example of an Arm CPU feature
>  is the Performance Monitoring Unit (PMU).  CPU types such as the
> -Cortex-A15 and the Cortex-A57, which respectively implement ARM
> +Cortex-A15 and the Cortex-A57, which respectively implement Arm
>  architecture reference manuals ARMv7-A and ARMv8-A, may both optionally
>  implement PMUs.  For example, if a user wants to use a Cortex-A15 without
>  a PMU, then the `-cpu` parameter should contain `pmu=3Doff` on the QEMU
> diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integrato=
rcp.rst
> index 3232b43a08b..e6f050f602b 100644
> --- a/docs/system/arm/integratorcp.rst
> +++ b/docs/system/arm/integratorcp.rst
> @@ -1,7 +1,7 @@
>  Integrator/CP (``integratorcp``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> -The ARM Integrator/CP board is emulated with the following devices:
> +The Arm Integrator/CP board is emulated with the following devices:
>=20=20
>  -  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
>=20=20
> diff --git a/docs/system/arm/musicpal.rst b/docs/system/arm/musicpal.rst
> index 35c22212486..9de380edf81 100644
> --- a/docs/system/arm/musicpal.rst
> +++ b/docs/system/arm/musicpal.rst
> @@ -4,7 +4,7 @@ Freecom MusicPal (``musicpal``)
>  The Freecom MusicPal internet radio emulation includes the following
>  elements:
>=20=20
> --  Marvell MV88W8618 ARM core.
> +-  Marvell MV88W8618 Arm core.
>=20=20
>  -  32 MB RAM, 256 KB SRAM, 8 MB flash.
>=20=20
> diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst
> index b000b6d13bb..cd9edf5d88b 100644
> --- a/docs/system/arm/nseries.rst
> +++ b/docs/system/arm/nseries.rst
> @@ -4,7 +4,7 @@ Nokia N800 and N810 tablets (``n800``, ``n810``)
>  Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
>  48) emulation supports the following elements:
>=20=20
> --  Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
> +-  Texas Instruments OMAP2420 System-on-chip (ARM1136 core)
>=20=20
>  -  RAM and non-volatile OneNAND Flash memories
>=20=20
> diff --git a/docs/system/arm/palm.rst b/docs/system/arm/palm.rst
> index 0eabf63e0e7..47ff9b36d46 100644
> --- a/docs/system/arm/palm.rst
> +++ b/docs/system/arm/palm.rst
> @@ -4,7 +4,7 @@ Palm Tungsten|E PDA (``cheetah``)
>  The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
>  following elements:
>=20=20
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +-  Texas Instruments OMAP310 System-on-chip (ARM925T core)
>=20=20
>  -  ROM and RAM memories (ROM firmware image can be loaded with
>     -option-rom)
> diff --git a/docs/system/arm/realview.rst b/docs/system/arm/realview.rst
> index 8e08eb5da16..65f5be346b1 100644
> --- a/docs/system/arm/realview.rst
> +++ b/docs/system/arm/realview.rst
> @@ -1,7 +1,7 @@
>  Arm Realview boards (``realview-eb``, ``realview-eb-mpcore``, ``realview=
-pb-a8``, ``realview-pbx-a9``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20=20
> -Several variants of the ARM RealView baseboard are emulated, including
> +Several variants of the Arm RealView baseboard are emulated, including
>  the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
>  certain Linux kernel configurations work out of the box on these boards.
>=20=20
> @@ -14,7 +14,7 @@ The following devices are emulated:
>=20=20
>  -  ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
>=20=20
> --  ARM AMBA Generic/Distributed Interrupt Controller
> +-  Arm AMBA Generic/Distributed Interrupt Controller
>=20=20
>  -  Four PL011 UARTs
>=20=20
> diff --git a/docs/system/arm/sx1.rst b/docs/system/arm/sx1.rst
> index 321993bc098..8bce30d4b25 100644
> --- a/docs/system/arm/sx1.rst
> +++ b/docs/system/arm/sx1.rst
> @@ -4,7 +4,7 @@ Siemens SX1 (``sx1``, ``sx1-v1``)
>  The Siemens SX1 models v1 and v2 (default) basic emulation. The
>  emulation includes the following elements:
>=20=20
> --  Texas Instruments OMAP310 System-on-chip (ARM 925T core)
> +-  Texas Instruments OMAP310 System-on-chip (ARM925T core)
>=20=20
>  -  ROM and RAM memories (ROM firmware image can be loaded with
>     -pflash) V1 1 Flash of 16MB and 1 Flash of 8MB V2 1 Flash of 32MB
> diff --git a/docs/system/arm/versatile.rst b/docs/system/arm/versatile.rst
> index 48b6ca0a020..51221c30a48 100644
> --- a/docs/system/arm/versatile.rst
> +++ b/docs/system/arm/versatile.rst
> @@ -1,7 +1,7 @@
>  Arm Versatile boards (``versatileab``, ``versatilepb``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20=20
> -The ARM Versatile baseboard is emulated with the following devices:
> +The Arm Versatile baseboard is emulated with the following devices:
>=20=20
>  -  ARM926E, ARM1136 or Cortex-A8 CPU
>=20=20
> diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
> index 19da2eff352..89ec93e904e 100644
> --- a/docs/system/arm/xscale.rst
> +++ b/docs/system/arm/xscale.rst
> @@ -4,7 +4,7 @@ Sharp XScale-based PDA models (``akita``, ``borzoi``, ``s=
pitz``, ``terrier``)
>  The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
>  and \"Terrier\") emulation includes the following peripherals:
>=20=20
> --  Intel PXA270 System-on-chip (ARM V5TE core)
> +-  Intel PXA270 System-on-chip (ARMv5TE core)
>=20=20
>  -  NAND Flash memory
>=20=20
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index ca69f7727d5..bd99b0fdbe9 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -35,7 +35,7 @@ QEMU user space emulation has the following notable fea=
tures:
>     On Linux, QEMU can emulate the ``clone`` syscall and create a real
>     host thread (with a separate virtual CPU) for each emulated thread.
>     Note that not all targets currently emulate atomic operations
> -   correctly. x86 and ARM use a global lock in order to preserve their
> +   correctly. x86 and Arm use a global lock in order to preserve their
>     semantics.
>=20=20
>  QEMU was conceived so that ultimately it can emulate itself. Although it
> @@ -173,11 +173,11 @@ Other binaries
>  user mode (Alpha)
>  ``qemu-alpha`` TODO.
>=20=20
> -user mode (ARM)
> +user mode (Arm)
>  ``qemu-armeb`` TODO.
>=20=20
> -user mode (ARM)
> -``qemu-arm`` is also capable of running ARM \"Angel\" semihosted ELF
> +user mode (Arm)
> +``qemu-arm`` is also capable of running Arm \"Angel\" semihosted ELF
>  binaries (as implemented by the arm-elf and arm-eabi Newlib/GDB
>  configurations), and arm-uclinux bFLT format binaries.


--=20
Alex Benn=C3=A9e

