Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F973C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 01:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0382071B
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 01:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoERb/Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0382071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYgUn-0004jR-2s
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 20:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYgTz-0004J9-Oc
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 20:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYgTx-0002GR-GJ
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 20:14:35 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYgTx-0002Fq-7O
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 20:14:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id s71so9934182oih.11
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dhM8tW6iADmP4Zq3/79St2EjjSZx0X0XEVVeQsD6LMQ=;
 b=AoERb/Lc+ijkd6zRscQxT+LXmJG1wGU9h+a8tIcpw1jbNsDBOqT73oUBSQilMlV/xF
 VZd1PYY7EBLD+kUzcVtJeRKNvJ8I5Yo31pxjzJaksve5fcPV5sYAP60KoGNTwxG0qXBH
 g0bBrxj1LIQ0+paq4a4vmS76PsYIEuts8LdWSHqQ8XErJLYuHLieidZvg++w4K9mvMlC
 yp++7gajO2lPnFw4Y+7JIvAt0ziPYMOb8UkIyd0yJizCeD+twRdRojAhcmscEJTp+qWg
 RB+KTSkCAeyE3hkVZujrODmXKizdUGJWsVzOKA4tSh3brtxncR4JV/PO1yv5boSQANKt
 yflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dhM8tW6iADmP4Zq3/79St2EjjSZx0X0XEVVeQsD6LMQ=;
 b=EymoLiVHTLaKB27KCBDLvZwuUS5lA1uMrNsyGbpw9bl3IkBuLBUhketCm+AQmG/rsG
 IX6tZFBLBYDWL5MsWBAcG7KlJQDbfuZM5M+lYxHwP9BNyEQTUlICxr0cASNzsd+/Z6mB
 GPK9fj80ULXDuMYrC6SqVLolvdtuTkMLLUloJJV9FC5g/Elv1WD1hweDfRrzOFRmmeHt
 ouH4DM3m5Fgv6qaVnhPzyTj7R2g0Yo+omtIwYPlhjpVSS5xzlm1XqIdXVEAmhCJuuuEb
 C75R+bN5t+/i/MU4wPHti+pUr0mRLEbFEZneHb5rSdVIBMzPL512ICa/UX01IHD1/BBQ
 azhw==
X-Gm-Message-State: APjAAAVXKYRa4s5YXBDRX7H0gN64JNY1AIFKfIU3m5hloJkqQf9pxvsY
 kdrfW+NRal0VJMw21upxKH8v+Rt03b7ED/1xXYw=
X-Google-Smtp-Source: APXvYqzCeHgN7jJg7XGZH1hfQhwBswNyJ3d5UwprIUfCf7afMb+hfq+h40EOqBk4tYkdIGesPk7xGR6/YSX61wsZy7U=
X-Received: by 2002:aca:d17:: with SMTP id 23mr18166237oin.136.1574558072103; 
 Sat, 23 Nov 2019 17:14:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 23 Nov 2019 17:14:31
 -0800 (PST)
In-Reply-To: <20191029212430.20617-13-mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-13-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 02:14:31 +0100
Message-ID: <CAL1e-=gh6+=CuXeFYY9VZ_cjiPBevEmmu0aANnYNVK3TzWWmFw@mail.gmail.com>
Subject: Re: [PATCH v35 12/13] target/avr: Register AVR support with the rest
 of QEMU, the build system, and the WMAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000090e90505980d5e3e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000090e90505980d5e3e
Content-Type: text/plain; charset="UTF-8"

On Tuesday, October 29, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS                     |  9 +++++++++
>  arch_init.c                     |  2 ++
>  configure                       |  7 +++++++
>  default-configs/avr-softmmu.mak |  5 +++++
>  include/disas/dis-asm.h         |  6 ++++++
>  include/sysemu/arch_init.h      |  1 +
>  qapi/machine.json               |  3 ++-
>  target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
>  tests/machine-none-test.c       |  1 +
>  9 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 target/avr/Makefile.objs
>
>
Michael, hi.

Can you please do the following:

1. replace "4.2" with "5.0", as Eric hinted

2. divide this patch into three patches:

- target/avr: Register AVR support with the rest of QEMU
- target/avr: Update build system
- target/avr: Update MAINTAINERS file

(distribution of files to patches is obvious)

3. Add at least a sentence to the commit messages of three new patches

4. Don't forget to add Philippe's "Tested-by:"s to all three commit messages

5. At this stage you can add:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

to all three new patches.

6. Rearange last patches in your series so that their order look like this:
(prior to this you need to do split of the patch 13/13 as I described in my
response to it, half an hour ago)

- target/avr: Register AVR support with the rest of QEMU
- target/avr: Update build system
- target/avr: Add boot serial test
- target/avr: Add Avocado acceptance test
- target/avr: Update MAINTAINERS file

That way, the "MAINTAINERS" patch acts as some kind of signature. :-)

...........................

You may think that these are all unnecessary details, but, trust me, they
give a lot of quality and gravity to the series.


Yours, Aleksandar


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b27888533..01f951356f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,15 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Maintained
> +F: target/avr/
> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +
>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> diff --git a/arch_init.c b/arch_init.c
> index 705d0b94ad..6a741165b2 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -89,6 +89,8 @@ int graphic_depth = 32;
>  #define QEMU_ARCH QEMU_ARCH_UNICORE32
>  #elif defined(TARGET_XTENSA)
>  #define QEMU_ARCH QEMU_ARCH_XTENSA
> +#elif defined(TARGET_AVR)
> +#define QEMU_ARCH QEMU_ARCH_AVR
>  #endif
>
>  const uint32_t arch_type = QEMU_ARCH;
> diff --git a/configure b/configure
> index 3be9e92a24..e5dec62fde 100755
> --- a/configure
> +++ b/configure
> @@ -7516,6 +7516,10 @@ case "$target_name" in
>      mttcg="yes"
>      gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml
> arm-vfp.xml arm-vfp3.xml arm-neon.xml"
>    ;;
> +  avr)
> +    gdb_xml_files="avr-cpu.xml"
> +    target_compiler=$cross_cc_avr
> +  ;;
>    cris)
>    ;;
>    hppa)
> @@ -7735,6 +7739,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>        disas_config "ARM_A64"
>      fi
>    ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>    cris)
>      disas_config "CRIS"
>    ;;
> diff --git a/default-configs/avr-softmmu.mak
> b/default-configs/avr-softmmu.mak
> new file mode 100644
> index 0000000000..d1e1c28118
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_AVR_SAMPLE=y
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index e9c7dd8eb4..8bedce17ac 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -211,6 +211,12 @@ enum bfd_architecture
>  #define bfd_mach_m32r          0  /* backwards compatibility */
>    bfd_arch_mn10200,    /* Matsushita MN10200 */
>    bfd_arch_mn10300,    /* Matsushita MN10300 */
> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
> +#define bfd_mach_avr1          1
> +#define bfd_mach_avr2          2
> +#define bfd_mach_avr3          3
> +#define bfd_mach_avr4          4
> +#define bfd_mach_avr5          5
>    bfd_arch_cris,       /* Axis CRIS */
>  #define bfd_mach_cris_v0_v10   255
>  #define bfd_mach_cris_v32      32
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4cf1..893df26ce2 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>      QEMU_ARCH_NIOS2 = (1 << 17),
>      QEMU_ARCH_HPPA = (1 << 18),
>      QEMU_ARCH_RISCV = (1 << 19),
> +    QEMU_ARCH_AVR = (1 << 20),
>  };
>
>  extern const uint32_t arch_type;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..1fa2917ba9 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,11 +21,12 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # ppcemb: dropped in 3.1
> +# avr: since 4.2
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
> 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
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
> +DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> +decode-y = $(SRC_PATH)/target/avr/insn.decode
> +
> +target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
> +       $(call quiet-command, \
> +         $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth
> 16 $<, \
> +         "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y += translate.o cpu.o helper.o
> +obj-y += gdbstub.o
> +obj-$(CONFIG_SOFTMMU) += machine.o
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
>      /* tested targets list */
>      { "arm", "cortex-a15" },
>      { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
>      { "x86_64", "qemu64,apic-id=0" },
>      { "i386", "qemu32,apic-id=0" },
>      { "alpha", "ev67" },
> --
> 2.17.2 (Apple Git-113)
>
>

--00000000000090e90505980d5e3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 29, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmai=
l.com">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++++++<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0default-configs/avr-softmmu.<wbr>mak |=C2=A0 5 +++++<br>
=C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++=
++++<br>
=C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 ++-<br>
=C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++++++++++=
++++++++++++++++++<wbr>+++<br>
=C2=A0tests/machine-none-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A09 files changed, 66 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 default-configs/avr-softmmu.<wbr>mak<br>
=C2=A0create mode 100644 target/avr/Makefile.objs<br>
<br></blockquote><div><br></div><div>Michael, hi.</div><div><br></div><div>=
Can you please do the following:</div><div><br></div><div>1. replace &quot;=
4.2&quot; with &quot;5.0&quot;, as Eric hinted</div><div><br></div><div>2. =
divide this patch into three patches:</div><div><br></div><div><div style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">- ta=
rget/avr: Register AVR support with the rest of QEMU</div></div><div style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">- ta=
rget/avr: Update build system</div><div style=3D"color:rgb(34,34,34);font-s=
ize:14px;line-height:22.1200008392334px">- target/avr: Update MAINTAINERS f=
ile</div><div><br></div><div>(distribution of files to patches is obvious)<=
/div><div><div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px"><br></div><div style=3D"color:rgb(34,34,34);font-size:14px;=
line-height:22.1200008392334px">3. Add at least a sentence to the commit me=
ssages of three new patches</div><div style=3D"color:rgb(34,34,34);font-siz=
e:14px;line-height:22.1200008392334px"><br></div><div style=3D"color:rgb(34=
,34,34);font-size:14px;line-height:22.1200008392334px">4. Don&#39;t forget =
to add Philippe&#39;s &quot;Tested-by:&quot;s to all three commit messages<=
/div><div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000=
8392334px"><br></div><div style=3D"color:rgb(34,34,34);font-size:14px;line-=
height:22.1200008392334px">5. At this stage you can add:</div><div style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></d=
iv><div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083=
92334px"><div>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarko=
vic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br></div=
><div><br></div></div><div style=3D"color:rgb(34,34,34);font-size:14px;line=
-height:22.1200008392334px">to all three new patches.</div><div style=3D"co=
lor:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></div>=
<div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083923=
34px">6. Rearange last patches in your series so that their order look like=
 this: (prior to this you need to do split of the patch 13/13 as I describe=
d in my response to it, half an hour ago)</div><div style=3D"color:rgb(34,3=
4,34);font-size:14px;line-height:22.1200008392334px"><br></div></div><div><=
div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000839233=
4px">- target/avr: Register AVR support with the rest of QEMU</div></div><d=
iv style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334=
px">- target/avr: Update build system</div><div style=3D"color:rgb(34,34,34=
);font-size:14px;line-height:22.1200008392334px">- target/avr: Add boot ser=
ial test</div><div><div style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">- target/avr: Add Avocado acceptance test</div></d=
iv><div style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083=
92334px">- target/avr: Update MAINTAINERS file</div><div><br></div><div>Tha=
t way, the &quot;MAINTAINERS&quot; patch acts as some kind of signature. :-=
)</div><div><br></div><div>...........................</div><div><br></div>=
<div>You may think that these are all unnecessary details, but, trust me, t=
hey give a lot of quality and gravity to the series.</div><div><br></div><d=
iv><br></div><div>Yours, Aleksandar</div><div>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5b27888533..01f951356f 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,15 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.c=
om</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: hw/misc/avr_mask.c<br>
+F: hw/char/avr_usart.c<br>
+F: hw/timer/avr_timer16.c<br>
+F: hw/avr/<br>
+<br>
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">=
edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
diff --git a/arch_init.c b/arch_init.c<br>
index 705d0b94ad..6a741165b2 100644<br>
--- a/arch_init.c<br>
+++ b/arch_init.c<br>
@@ -89,6 +89,8 @@ int graphic_depth =3D 32;<br>
=C2=A0#define QEMU_ARCH QEMU_ARCH_UNICORE32<br>
=C2=A0#elif defined(TARGET_XTENSA)<br>
=C2=A0#define QEMU_ARCH QEMU_ARCH_XTENSA<br>
+#elif defined(TARGET_AVR)<br>
+#define QEMU_ARCH QEMU_ARCH_AVR<br>
=C2=A0#endif<br>
<br>
=C2=A0const uint32_t arch_type =3D QEMU_ARCH;<br>
diff --git a/configure b/configure<br>
index 3be9e92a24..e5dec62fde 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7516,6 +7516,10 @@ case &quot;$target_name&quot; in<br>
=C2=A0 =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0 =C2=A0gdb_xml_files=3D&quot;aarch64-core.<wbr>xml aarch64-fpu=
.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml&quot;<br>
=C2=A0 =C2=A0;;<br>
+=C2=A0 avr)<br>
+=C2=A0 =C2=A0 gdb_xml_files=3D&quot;avr-cpu.xml&quot;<br>
+=C2=A0 =C2=A0 target_compiler=3D$cross_cc_avr<br>
+=C2=A0 ;;<br>
=C2=A0 =C2=A0cris)<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0hppa)<br>
@@ -7735,6 +7739,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0disas_config &quot;ARM_A64&quot;<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0;;<br>
+=C2=A0 avr)<br>
+=C2=A0 =C2=A0 disas_config &quot;AVR&quot;<br>
+=C2=A0 ;;<br>
=C2=A0 =C2=A0cris)<br>
=C2=A0 =C2=A0 =C2=A0disas_config &quot;CRIS&quot;<br>
=C2=A0 =C2=A0;;<br>
diff --git a/default-configs/avr-softmmu.<wbr>mak b/default-configs/avr-sof=
tmmu.<wbr>mak<br>
new file mode 100644<br>
index 0000000000..d1e1c28118<br>
--- /dev/null<br>
+++ b/default-configs/avr-softmmu.<wbr>mak<br>
@@ -0,0 +1,5 @@<br>
+# Default configuration for avr-softmmu<br>
+<br>
+# Boards:<br>
+#<br>
+CONFIG_AVR_SAMPLE=3Dy<br>
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h<br>
index e9c7dd8eb4..8bedce17ac 100644<br>
--- a/include/disas/dis-asm.h<br>
+++ b/include/disas/dis-asm.h<br>
@@ -211,6 +211,12 @@ enum bfd_architecture<br>
=C2=A0#define bfd_mach_m32r=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 /* ba=
ckwards compatibility */<br>
=C2=A0 =C2=A0bfd_arch_mn10200,=C2=A0 =C2=A0 /* Matsushita MN10200 */<br>
=C2=A0 =C2=A0bfd_arch_mn10300,=C2=A0 =C2=A0 /* Matsushita MN10300 */<br>
+=C2=A0 bfd_arch_avr,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Atmel AVR microcontrolle=
rs.=C2=A0 */<br>
+#define bfd_mach_avr1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+#define bfd_mach_avr2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
+#define bfd_mach_avr3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
+#define bfd_mach_avr4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
+#define bfd_mach_avr5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5<br>
=C2=A0 =C2=A0bfd_arch_cris,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Axis CRIS */<br>
=C2=A0#define bfd_mach_cris_v0_v10=C2=A0 =C2=A0255<br>
=C2=A0#define bfd_mach_cris_v32=C2=A0 =C2=A0 =C2=A0 32<br>
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h<br>
index 62c6fe4cf1..893df26ce2 100644<br>
--- a/include/sysemu/arch_init.h<br>
+++ b/include/sysemu/arch_init.h<br>
@@ -24,6 +24,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_NIOS2 =3D (1 &lt;&lt; 17),<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_HPPA =3D (1 &lt;&lt; 18),<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_RISCV =3D (1 &lt;&lt; 19),<br>
+=C2=A0 =C2=A0 QEMU_ARCH_AVR =3D (1 &lt;&lt; 20),<br>
=C2=A0};<br>
<br>
=C2=A0extern const uint32_t arch_type;<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index ca26779f1a..1fa2917ba9 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -21,11 +21,12 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 is true even for &quot;qemu-system-x86_6=
4&quot;.<br>
=C2=A0#<br>
=C2=A0# ppcemb: dropped in 3.1<br>
+# avr: since 4.2<br>
=C2=A0#<br>
=C2=A0# Since: 3.0<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39; : &#39;SysEmuTarget&#39;,<br>
-=C2=A0 &#39;data&#39; : [ &#39;aarch64&#39;, &#39;alpha&#39;, &#39;arm&#39=
;, &#39;cris&#39;, &#39;hppa&#39;, &#39;i386&#39;, &#39;lm32&#39;,<br>
+=C2=A0 &#39;data&#39; : [ &#39;aarch64&#39;, &#39;alpha&#39;, &#39;arm&#39=
;, &#39;avr&#39;, &#39;cris&#39;, &#39;hppa&#39;, &#39;i386&#39;, &#39;lm32=
&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;m68k&#39;, &#39;micro=
blaze&#39;, &#39;microblazeel&#39;, &#39;mips&#39;, &#39;mips64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mips64el&#39;, &#39;m=
ipsel&#39;, &#39;moxie&#39;, &#39;nios2&#39;, &#39;or1k&#39;, &#39;ppc&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ppc64&#39;, &#39;risc=
v32&#39;, &#39;riscv64&#39;, &#39;s390x&#39;, &#39;sh4&#39;,<br>
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs<br>
new file mode 100644<br>
index 0000000000..2976affd95<br>
--- /dev/null<br>
+++ b/target/avr/Makefile.objs<br>
@@ -0,0 +1,33 @@<br>
+#<br>
+#=C2=A0 QEMU AVR CPU<br>
+#<br>
+#=C2=A0 Copyright (c) 2019 Michael Rolnik<br>
+#<br>
+#=C2=A0 This library is free software; you can redistribute it and/or<br>
+#=C2=A0 modify it under the terms of the GNU Lesser General Public<br>
+#=C2=A0 License as published by the Free Software Foundation; either<br>
+#=C2=A0 version 2.1 of the License, or (at your option) any later version.=
<br>
+#<br>
+#=C2=A0 This library is distributed in the hope that it will be useful,<br=
>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
+#=C2=A0 Lesser General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU Lesser General Public<b=
r>
+#=C2=A0 License along with this library; if not, see<br>
+#=C2=A0 &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=
=3D"_blank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+#<br>
+<br>
+DECODETREE =3D $(SRC_PATH)/scripts/<wbr>decodetree.py<br>
+decode-y =3D $(SRC_PATH)/target/avr/insn.<wbr>decode<br>
+<br>
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call quiet-command, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(PYTHON) $(DECODETREE) -o $@ --decode d=
ecode_insn --insnwidth 16 $&lt;, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;GEN&quot;, $(TARGET_DIR)$@)<br>
+<br>
+target/avr/translate.o: target/avr/decode_insn.inc.c<br>
+<br>
+obj-y +=3D translate.o cpu.o helper.o<br>
+obj-y +=3D gdbstub.o<br>
+obj-$(CONFIG_SOFTMMU) +=3D machine.o<br>
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c<br>
index 5953d31755..3e5c74e73e 100644<br>
--- a/tests/machine-none-test.c<br>
+++ b/tests/machine-none-test.c<br>
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0/* tested targets list */<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;arm&quot;, &quot;cortex-a15&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;aarch64&quot;, &quot;cortex-a57&quot; },<br>
+=C2=A0 =C2=A0 { &quot;avr&quot;, &quot;avr6-avr-cpu&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;x86_64&quot;, &quot;qemu64,apic-id=3D0&quot; },=
<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;i386&quot;, &quot;qemu32,apic-id=3D0&quot; },<b=
r>
=C2=A0 =C2=A0 =C2=A0{ &quot;alpha&quot;, &quot;ev67&quot; },<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--00000000000090e90505980d5e3e--

