Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25A12071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQlrhYLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25A12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwhe-0006F1-Q8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuwgr-0005f8-Qx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuwgq-0001kO-AI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:59:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuwgq-0001ih-1a
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:59:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so1451282wro.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZmUmEug5AG28bLAgJ6PJuweGUXbP2m9I2E5+btjjs4w=;
 b=BQlrhYLqOQXCanLjBuAYXAyYvDzHYa53Q/HNC8GMGZn3YgX8+so4Dt3G3HWsZhcv4S
 KzR67JxB0z6jjpbI77Bz3mfQFkdZXSIWV/1csEPJHQphokuxBMTfHc5sSIi7jxAvF/4v
 L12/ZmPE+1FgVGN+kCGPHU3y50boYBrNSB8gJFOQvVFJIFNxMdD31zYMtj9pjstWpcwL
 irlLsQT9xk/vYbMQiVJ/y2nT6AwGVLxEdNrXs7T7MHR8jedmIWHLxuLldAz1jZFE2Sdy
 i2d+Qzh6KTAhxmdQc4Ys/d1mhN/8GtCvyfnBv4HvUecA/Pl3sFrOPHgKAs38qURUxLo3
 noVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZmUmEug5AG28bLAgJ6PJuweGUXbP2m9I2E5+btjjs4w=;
 b=IlPYBSjbnQFT111m75b2lnlXlODCMTxDiKl2O40H3HZ4FAlGUoT8FynyfQRbNCOKIr
 b9nqtoo7eIAgioWIxLei2OeoVhdBJVu6CCxyrVCdGJaVWcTnVojm40Usz9Znq0pz6sh1
 Cuo1jIiQ3mYlQmtiu28vl9pg0q1QBZFja/QyIirEqx1aEyFK21Disxbf1X7EpB5IQjpB
 Oy7DHJLpE0cp+kF9XYa6dlCW2BGu+JU76CZpi0f8UVXZgc5Hr+6eX5nR5mTF1eHs6P0j
 9QT02yw3JsyDQ8tws5tBEXUyum9Zs7t1LjZPWT9m5LVd3VekGTf8swYBcYfX21cSjF7t
 wuCw==
X-Gm-Message-State: APjAAAWOp8ZPSUVTSH6utxo/DRTQfKaJjhYRYhC/U8jmqbnQ6DP2y5Ek
 1tGsKJCcIUWn4D814r1xpJyg7A==
X-Google-Smtp-Source: APXvYqw4C2Gc+lLo+JULZMsoy+kz+1daIvNaPY9AHGBORNEDgSJBVmrVDhsk4uM24M9ViEFHFdeaZA==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr3729741wrr.27.1579863590776;
 Fri, 24 Jan 2020 02:59:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm6604421wrs.96.2020.01.24.02.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 02:59:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC0E41FF87;
 Fri, 24 Jan 2020 10:59:47 +0000 (GMT)
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-23-f4bug@amsat.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH rc2 22/25] target/avr: Update build system
In-reply-to: <20200124005131.16276-23-f4bug@amsat.org>
Date: Fri, 24 Jan 2020 10:59:47 +0000
Message-ID: <8736c5yva4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, S.E.Harris@kent.ac.uk,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, me@xcancerberox.com.ar,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, dovgaluk@ispras.ru,
 =?utf-8?Q?Marc-A?= =?utf-8?Q?ndr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org, mrolnik@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> Make AVR support buildable
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-Id: <20200118191416.19934-19-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure                       |  7 +++++++
>  default-configs/avr-softmmu.mak |  5 +++++
>  target/avr/Makefile.objs        | 34 +++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 target/avr/Makefile.objs
>
> diff --git a/configure b/configure
> index 557e4382ea..94e79ca634 100755
> --- a/configure
> +++ b/configure
> @@ -7612,6 +7612,10 @@ case "$target_name" in
>      mttcg=3D"yes"
>      gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-v=
fp.xml arm-vfp3.xml arm-neon.xml"
>    ;;
> +  avr)
> +    gdb_xml_files=3D"avr-cpu.xml"
> +    target_compiler=3D$cross_cc_avr

I don't think you want this here. target_compiler belongs in the
tests/tcg/configure.sh config.

A docker target with the compiler would also be nice.

> +  ;;
>    cris)
>    ;;
>    hppa)
> @@ -7831,6 +7835,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>        disas_config "ARM_A64"
>      fi
>    ;;
> +  avr)
> +    disas_config "AVR"
> +  ;;
>    cris)
>      disas_config "CRIS"
>    ;;
> diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmm=
u.mak
> new file mode 100644
> index 0000000000..80218add98
> --- /dev/null
> +++ b/default-configs/avr-softmmu.mak
> @@ -0,0 +1,5 @@
> +# Default configuration for avr-softmmu
> +
> +# Boards:
> +#
> +CONFIG_ARDUINO=3Dy
> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000000..7523e0c6e2
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,34 @@
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
> +	$(call quiet-command, \
> +	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<,=
 \
> +	  "GEN", $(TARGET_DIR)$@)
> +
> +target/avr/translate.o: target/avr/decode_insn.inc.c
> +
> +obj-y +=3D translate.o cpu.o helper.o
> +obj-y +=3D gdbstub.o
> +obj-y +=3D disas.o
> +obj-$(CONFIG_SOFTMMU) +=3D machine.o


--=20
Alex Benn=C3=A9e

