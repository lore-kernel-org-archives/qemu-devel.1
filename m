Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C3AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2A72068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY++GGLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2A72068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7hq-0007DC-0a
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7ff-0005MT-8I
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7fd-0006vI-HK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:04:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37805
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7fd-0006v6-Ck
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574424256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjlN2A0OrJHor3MAoF7wSi2PTwk+C/rk7Ud3u4FyuxU=;
 b=BY++GGLsyHhrUCXZd+q3eme470AddvFIkRahrT86XLO+FOTeoN57f5ek40oYWnBD2OCJTq
 Cmp63SiZuJ60iFSz2wEMyALESClolI3RgABTlRYg1d7lr9HOFuLRM3akBt/dySkGgBQs/h
 MFXu6O2AJmEtXnDDdQI0UrXYlQK0TD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-HzCAYDmyMICjCSEEHMx2hQ-1; Fri, 22 Nov 2019 07:04:15 -0500
Received: by mail-wm1-f71.google.com with SMTP id g14so3283626wmk.9
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MHCCxYpGJEshh/qP/TBzI8Pp9RD7qvRm/abXcF1w7j0=;
 b=dzcDlcL2Q4NKx88Ag7b/uL0A+VV5ZRSWx6q2Z8vA984uapQJwjFw/CHjSr6BEP89mV
 eqWAa50AWwSN6f0OwYxueJjEcT5Hjnm+7mR8ASrdQQmIMKbkBogI8k5ViqX4/rjMavRv
 8yJ1GxOoQxU7M2To0qqvbLcda1PD+2tCl30UG+y1L8oVsRZ54C+ML0v9TlgGAi2OFXgO
 aZMSRWT2l9IeL+3OQEs98meXR95xk60BqwriVfRK+uKyxMfH5urwwuoW09SJ6xu7nFn5
 wmgCVFYvABx5/95FoX7KeYSOS33fJH2InVBY7I9mzjWtqVHj4k4msu6y1vL82ZTCFJXt
 mu/w==
X-Gm-Message-State: APjAAAVTEOfTsMq3fQKjGrdxs+rtLaH3BwrDVvQenPMwbCqNEM/KblTF
 c4zYAdDfi8+2hh0g7bpCZbJBFXMWzRQeuAQ8qqYvWEfKl/8gawfY9IGf98t4BT2VPyglcvZ6nr1
 H8JorPKKAuqUAHRs=
X-Received: by 2002:a5d:4810:: with SMTP id l16mr2349184wrq.127.1574424254314; 
 Fri, 22 Nov 2019 04:04:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx64ketn9T7Yw0qRIIf4TO43a6W8cLRMoY9ugXiLt1pnJn9yb91Gaf56qvLRpsNWM1cl36Gqw==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr2349151wrq.127.1574424254064; 
 Fri, 22 Nov 2019 04:04:14 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id s11sm7206744wrr.43.2019.11.22.04.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 04:04:13 -0800 (PST)
Subject: Re: [PATCH v35 12/13] target/avr: Register AVR support with the rest
 of QEMU, the build system, and the WMAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-13-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ac353f3-6981-1404-15b0-bbc26dfe021d@redhat.com>
Date: Fri, 22 Nov 2019 13:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-13-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: HzCAYDmyMICjCSEEHMx2hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   MAINTAINERS                     |  9 +++++++++
>   arch_init.c                     |  2 ++
>   configure                       |  7 +++++++
>   default-configs/avr-softmmu.mak |  5 +++++
>   include/disas/dis-asm.h         |  6 ++++++
>   include/sysemu/arch_init.h      |  1 +
>   qapi/machine.json               |  3 ++-
>   target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
>   tests/machine-none-test.c       |  1 +
>   9 files changed, 66 insertions(+), 1 deletion(-)
>   create mode 100644 default-configs/avr-softmmu.mak
>   create mode 100644 target/avr/Makefile.objs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b27888533..01f951356f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,15 @@ S: Maintained
>   F: hw/arm/smmu*
>   F: include/hw/arm/smmu*
>  =20
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Maintained
> +F: target/avr/
> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +
>   CRIS TCG CPUs
>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   S: Maintained
> diff --git a/arch_init.c b/arch_init.c
> index 705d0b94ad..6a741165b2 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
>   #define QEMU_ARCH QEMU_ARCH_UNICORE32
>   #elif defined(TARGET_XTENSA)
>   #define QEMU_ARCH QEMU_ARCH_XTENSA
> +#elif defined(TARGET_AVR)
> +#define QEMU_ARCH QEMU_ARCH_AVR
>   #endif
>  =20
>   const uint32_t arch_type =3D QEMU_ARCH;
> diff --git a/configure b/configure
> index 3be9e92a24..e5dec62fde 100755
> --- a/configure
> +++ b/configure
> @@ -7516,6 +7516,10 @@ case "$target_name" in
>       mttcg=3D"yes"
>       gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-=
vfp.xml arm-vfp3.xml arm-neon.xml"
>     ;;
> +  avr)
> +    gdb_xml_files=3D"avr-cpu.xml"
> +    target_compiler=3D$cross_cc_avr
> +  ;;
>     cris)
>     ;;
>     hppa)
> @@ -7735,6 +7739,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>         disas_config "ARM_A64"
>       fi
>     ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>     cris)
>       disas_config "CRIS"
>     ;;
> diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmm=
u.mak
> new file mode 100644
> index 0000000000..d1e1c28118
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_AVR_SAMPLE=3Dy
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index e9c7dd8eb4..8bedce17ac 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -211,6 +211,12 @@ enum bfd_architecture
>   #define bfd_mach_m32r          0  /* backwards compatibility */
>     bfd_arch_mn10200,    /* Matsushita MN10200 */
>     bfd_arch_mn10300,    /* Matsushita MN10300 */
> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
> +#define bfd_mach_avr1          1
> +#define bfd_mach_avr2          2
> +#define bfd_mach_avr3          3
> +#define bfd_mach_avr4          4
> +#define bfd_mach_avr5          5
>     bfd_arch_cris,       /* Axis CRIS */
>   #define bfd_mach_cris_v0_v10   255
>   #define bfd_mach_cris_v32      32
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4cf1..893df26ce2 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>       QEMU_ARCH_NIOS2 =3D (1 << 17),
>       QEMU_ARCH_HPPA =3D (1 << 18),
>       QEMU_ARCH_RISCV =3D (1 << 19),
> +    QEMU_ARCH_AVR =3D (1 << 20),
>   };
>  =20
>   extern const uint32_t arch_type;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..1fa2917ba9 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,11 +21,12 @@
>   #        is true even for "qemu-system-x86_64".
>   #
>   # ppcemb: dropped in 3.1
> +# avr: since 4.2
>   #
>   # Since: 3.0
>   ##
>   { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', '=
lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>                'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000000..2976affd95
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,33 @@
> +#
> +#  QEMU AVR CPU
> +#
> +#  Copyright (c) 2019 Michael Rolnik
> +#
> +#  This library is free software; you can redistribute it and/or
> +#  modify it under the terms of the GNU Lesser General Public
> +#  License as published by the Free Software Foundation; either
> +#  version 2.1 of the License, or (at your option) any later version.
> +#
> +#  This library is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  Lesser General Public License for more details.
> +#
> +#  You should have received a copy of the GNU Lesser General Public
> +#  License along with this library; if not, see
> +#  <http://www.gnu.org/licenses/lgpl-2.1.html>
> +#
> +
> +DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
> +decode-y =3D $(SRC_PATH)/target/avr/insn.decode
> +
> +target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
> +=09$(call quiet-command, \
> +=09  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $=
<, \
> +=09  "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y +=3D translate.o cpu.o helper.o
> +obj-y +=3D gdbstub.o
> +obj-$(CONFIG_SOFTMMU) +=3D machine.o
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>       /* tested targets list */
>       { "arm", "cortex-a15" },
>       { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
>       { "x86_64", "qemu64,apic-id=3D0" },
>       { "i386", "qemu32,apic-id=3D0" },
>       { "alpha", "ev67" },
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


