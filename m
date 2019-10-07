Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96435C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4459A205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKNvSRxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4459A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVSj-0006u8-II
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVDR-0000H2-IV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHVDP-0004ra-7J
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:46:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHVDO-0004qQ-N4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:46:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id y21so26290wmi.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=S5NmXQr6PxVobekzYNPlsRGes7kD3kKDI/OTOtfQgho=;
 b=NKNvSRxkxR85byovGPB/crvzGKJKts39MzgBvLM0gqBRQxyRr1fYYg5Mq9cdUMXTur
 C8gBuwbzkUr5OfM2EnvNt8KUN94Appb8sbm8UtUIuKcluiCZ46An6K8anvDSITBT/zbw
 UZ24dGz1pjw1wWe/Hkp3IeQvSPl35p3VU0ycaRJW4TWRYoJo0TPikobHruAW7aYtag1w
 hsMv//rgLSNKMGv6pjlviZGmGwxdEECaY4k4uO8QLbEN3Kx7ErkfE9EyQ9xeWXQeoxCC
 24oX5KBwtwCUTYYOagvj+4k7M3d+4ohAW4YDoq5PTJ0zRlGo0FlpLlNR5VqCdsyAw032
 H8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=S5NmXQr6PxVobekzYNPlsRGes7kD3kKDI/OTOtfQgho=;
 b=o2jW+yawjBUf5u4/C1FibkEyTjNPZijtRogr5PQ5pqpTAVQ+obIIgAEyHFSneWAv0k
 UR0no7FvWTrUbn0XHB0cJupmSCFH+ylreqDbFgwp/J0Yt/mRClAh5vvC7oy5w5MiNpex
 dQcp3X7rjkiDyWuZw/1vYV2fgyytWNw8QOs9xIs5QhWR6clCL/SbtvF6A0DCBG3S12zc
 IoryJGPBHvqTyZbtrQpiSxKsTDiiETxPnHjCC4y//eyORhdvWb1p5hbef5g0VeVYsJev
 1mhu8qolqKy5/UT6mQE4dSxJjuKDDdniB9M3zN8DC8nqHsZs4T534BbC/VxgEo+PsHY3
 yp+Q==
X-Gm-Message-State: APjAAAVtHSLnHZRX1eWsp+C0gSmeLwdJvoxEctOklijh0/jupBkYWpIG
 +1rOPPpU3OP5TWsedYVl8LesDg==
X-Google-Smtp-Source: APXvYqy/tR7jZMWJ/xrBBDL8v1xLNRw6ggeet62Fyd1NftRM34zoOIVpMlGQJQCSPnELjzOaFvz4IA==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr21881401wmc.125.1570463185278; 
 Mon, 07 Oct 2019 08:46:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q66sm13098936wme.39.2019.10.07.08.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:46:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD04C1FF87;
 Mon,  7 Oct 2019 16:46:23 +0100 (BST)
References: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Subject: Re: [PATCH] target/mips: add gdb xml files
In-reply-to: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
Date: Mon, 07 Oct 2019 16:46:23 +0100
Message-ID: <87a7ack180.fsf@linaro.org>
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, philmd@redhat.com,
 Qemu Devel <qemu-devel@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mikhail Abakumov <mikhail.abakumov@ispras.ru> writes:

> From: Mikhail Abakumov <mikhail.abakumov@ispras>

Hmm the email got truncated here.

>
> This patch add xml files with gdb registers for mips.
>
> Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras>
> ---
>  configure               |  3 ++
>  gdb-xml/mips-core.xml   | 84 +++++++++++++++++++++++++++++++++++++++++
>  gdb-xml/mips64-core.xml | 84
> +++++++++++++++++++++++++++++++++++++++++

Otherwise for the configure/xml:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I assume the changes will go in via a MIPS tree.

>  target/mips/cpu.c       | 11 ++++++
>  4 files changed, 182 insertions(+)
>  create mode 100644 gdb-xml/mips-core.xml
>  create mode 100644 gdb-xml/mips64-core.xml
>
> diff --git a/configure b/configure
> index 8f8446f52b..5bb2c62194 100755
> --- a/configure
> +++ b/configure
> @@ -7466,12 +7466,14 @@ case "$target_name" in
>    mips|mipsel)
>      mttcg=3D"yes"
>      TARGET_ARCH=3Dmips
> +    gdb_xml_files=3D"mips-core.xml"
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>    ;;
>    mipsn32|mipsn32el)
>      mttcg=3D"yes"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
> +    gdb_xml_files=3D"mips64-core.xml"
>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
> @@ -7479,6 +7481,7 @@ case "$target_name" in
>      mttcg=3D"yes"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
> +    gdb_xml_files=3D"mips64-core.xml"
>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>    ;;
>    moxie)
> diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml
> new file mode 100644
> index 0000000000..a46b2993eb
> --- /dev/null
> +++ b/gdb-xml/mips-core.xml
> @@ -0,0 +1,84 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without
> modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.mips">
> +  <reg name=3D"zero" bitsize=3D"32"/>
> +  <reg name=3D"at" bitsize=3D"32"/>
> +  <reg name=3D"v0" bitsize=3D"32"/>
> +  <reg name=3D"v1" bitsize=3D"32"/>
> +  <reg name=3D"a0" bitsize=3D"32"/>
> +  <reg name=3D"a1" bitsize=3D"32"/>
> +  <reg name=3D"a2" bitsize=3D"32"/>
> +  <reg name=3D"a3" bitsize=3D"32"/>
> +  <reg name=3D"t0" bitsize=3D"32"/>
> +  <reg name=3D"t1" bitsize=3D"32"/>
> +  <reg name=3D"t2" bitsize=3D"32"/>
> +  <reg name=3D"t3" bitsize=3D"32"/>
> +  <reg name=3D"t4" bitsize=3D"32"/>
> +  <reg name=3D"t5" bitsize=3D"32"/>
> +  <reg name=3D"t6" bitsize=3D"32"/>
> +  <reg name=3D"t7" bitsize=3D"32"/>
> +  <reg name=3D"s0" bitsize=3D"32"/>
> +  <reg name=3D"s1" bitsize=3D"32"/>
> +  <reg name=3D"s2" bitsize=3D"32"/>
> +  <reg name=3D"s3" bitsize=3D"32"/>
> +  <reg name=3D"s4" bitsize=3D"32"/>
> +  <reg name=3D"s5" bitsize=3D"32"/>
> +  <reg name=3D"s6" bitsize=3D"32"/>
> +  <reg name=3D"s7" bitsize=3D"32"/>
> +  <reg name=3D"t8" bitsize=3D"32"/>
> +  <reg name=3D"t9" bitsize=3D"32"/>
> +  <reg name=3D"k0" bitsize=3D"32"/>
> +  <reg name=3D"k1" bitsize=3D"32"/>
> +  <reg name=3D"gp" bitsize=3D"32"/>
> +  <reg name=3D"sp" bitsize=3D"32"/>
> +  <reg name=3D"s8" bitsize=3D"32"/>
> +  <reg name=3D"ra" bitsize=3D"32"/>
> +  <reg name=3D"sr" bitsize=3D"32"/>
> +  <reg name=3D"lo" bitsize=3D"32"/>
> +  <reg name=3D"hi" bitsize=3D"32"/>
> +  <reg name=3D"bad" bitsize=3D"32"/>
> +  <reg name=3D"cause" bitsize=3D"32"/>
> +  <reg name=3D"pc" bitsize=3D"32"/>
> +
> +  <reg name=3D"f0" bitsize=3D"32" regnum=3D"38"/>
> +  <reg name=3D"f1" bitsize=3D"32"/>
> +  <reg name=3D"f2" bitsize=3D"32"/>
> +  <reg name=3D"f3" bitsize=3D"32"/>
> +  <reg name=3D"f4" bitsize=3D"32"/>
> +  <reg name=3D"f5" bitsize=3D"32"/>
> +  <reg name=3D"f6" bitsize=3D"32"/>
> +  <reg name=3D"f7" bitsize=3D"32"/>
> +  <reg name=3D"f8" bitsize=3D"32"/>
> +  <reg name=3D"f9" bitsize=3D"32"/>
> +  <reg name=3D"f10" bitsize=3D"32"/>
> +  <reg name=3D"f11" bitsize=3D"32"/>
> +  <reg name=3D"f12" bitsize=3D"32"/>
> +  <reg name=3D"f13" bitsize=3D"32"/>
> +  <reg name=3D"f14" bitsize=3D"32"/>
> +  <reg name=3D"f15" bitsize=3D"32"/>
> +  <reg name=3D"f16" bitsize=3D"32"/>
> +  <reg name=3D"f17" bitsize=3D"32"/>
> +  <reg name=3D"f18" bitsize=3D"32"/>
> +  <reg name=3D"f19" bitsize=3D"32"/>
> +  <reg name=3D"f20" bitsize=3D"32"/>
> +  <reg name=3D"f21" bitsize=3D"32"/>
> +  <reg name=3D"f22" bitsize=3D"32"/>
> +  <reg name=3D"f23" bitsize=3D"32"/>
> +  <reg name=3D"f24" bitsize=3D"32"/>
> +  <reg name=3D"f25" bitsize=3D"32"/>
> +  <reg name=3D"f26" bitsize=3D"32"/>
> +  <reg name=3D"f27" bitsize=3D"32"/>
> +  <reg name=3D"f28" bitsize=3D"32"/>
> +  <reg name=3D"f29" bitsize=3D"32"/>
> +  <reg name=3D"f30" bitsize=3D"32"/>
> +  <reg name=3D"f31" bitsize=3D"32"/>
> +  <reg name=3D"fsr" bitsize=3D"32" group=3D"float"/>
> +  <reg name=3D"fir" bitsize=3D"32" group=3D"float"/>
> +  <reg name=3D"fp" bitsize=3D"32" group=3D"float"/>
> +</feature>
> diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml
> new file mode 100644
> index 0000000000..cc1a15ad56
> --- /dev/null
> +++ b/gdb-xml/mips64-core.xml
> @@ -0,0 +1,84 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without
> modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.mips64">
> +  <reg name=3D"zero" bitsize=3D"64"/>
> +  <reg name=3D"at" bitsize=3D"64"/>
> +  <reg name=3D"v0" bitsize=3D"64"/>
> +  <reg name=3D"v1" bitsize=3D"64"/>
> +  <reg name=3D"a0" bitsize=3D"64"/>
> +  <reg name=3D"a1" bitsize=3D"64"/>
> +  <reg name=3D"a2" bitsize=3D"64"/>
> +  <reg name=3D"a3" bitsize=3D"64"/>
> +  <reg name=3D"t0" bitsize=3D"64"/>
> +  <reg name=3D"t1" bitsize=3D"64"/>
> +  <reg name=3D"t2" bitsize=3D"64"/>
> +  <reg name=3D"t3" bitsize=3D"64"/>
> +  <reg name=3D"t4" bitsize=3D"64"/>
> +  <reg name=3D"t5" bitsize=3D"64"/>
> +  <reg name=3D"t6" bitsize=3D"64"/>
> +  <reg name=3D"t7" bitsize=3D"64"/>
> +  <reg name=3D"s0" bitsize=3D"64"/>
> +  <reg name=3D"s1" bitsize=3D"64"/>
> +  <reg name=3D"s2" bitsize=3D"64"/>
> +  <reg name=3D"s3" bitsize=3D"64"/>
> +  <reg name=3D"s4" bitsize=3D"64"/>
> +  <reg name=3D"s5" bitsize=3D"64"/>
> +  <reg name=3D"s6" bitsize=3D"64"/>
> +  <reg name=3D"s7" bitsize=3D"64"/>
> +  <reg name=3D"t8" bitsize=3D"64"/>
> +  <reg name=3D"t9" bitsize=3D"64"/>
> +  <reg name=3D"k0" bitsize=3D"64"/>
> +  <reg name=3D"k1" bitsize=3D"64"/>
> +  <reg name=3D"gp" bitsize=3D"64"/>
> +  <reg name=3D"sp" bitsize=3D"64"/>
> +  <reg name=3D"s8" bitsize=3D"64"/>
> +  <reg name=3D"ra" bitsize=3D"64"/>
> +  <reg name=3D"sr" bitsize=3D"64"/>
> +  <reg name=3D"lo" bitsize=3D"64"/>
> +  <reg name=3D"hi" bitsize=3D"64"/>
> +  <reg name=3D"bad" bitsize=3D"64"/>
> +  <reg name=3D"cause" bitsize=3D"64"/>
> +  <reg name=3D"pc" bitsize=3D"64"/>
> +
> +  <reg name=3D"f0" bitsize=3D"64" regnum=3D"38"/>
> +  <reg name=3D"f1" bitsize=3D"64"/>
> +  <reg name=3D"f2" bitsize=3D"64"/>
> +  <reg name=3D"f3" bitsize=3D"64"/>
> +  <reg name=3D"f4" bitsize=3D"64"/>
> +  <reg name=3D"f5" bitsize=3D"64"/>
> +  <reg name=3D"f6" bitsize=3D"64"/>
> +  <reg name=3D"f7" bitsize=3D"64"/>
> +  <reg name=3D"f8" bitsize=3D"64"/>
> +  <reg name=3D"f9" bitsize=3D"64"/>
> +  <reg name=3D"f10" bitsize=3D"64"/>
> +  <reg name=3D"f11" bitsize=3D"64"/>
> +  <reg name=3D"f12" bitsize=3D"64"/>
> +  <reg name=3D"f13" bitsize=3D"64"/>
> +  <reg name=3D"f14" bitsize=3D"64"/>
> +  <reg name=3D"f15" bitsize=3D"64"/>
> +  <reg name=3D"f16" bitsize=3D"64"/>
> +  <reg name=3D"f17" bitsize=3D"64"/>
> +  <reg name=3D"f18" bitsize=3D"64"/>
> +  <reg name=3D"f19" bitsize=3D"64"/>
> +  <reg name=3D"f20" bitsize=3D"64"/>
> +  <reg name=3D"f21" bitsize=3D"64"/>
> +  <reg name=3D"f22" bitsize=3D"64"/>
> +  <reg name=3D"f23" bitsize=3D"64"/>
> +  <reg name=3D"f24" bitsize=3D"64"/>
> +  <reg name=3D"f25" bitsize=3D"64"/>
> +  <reg name=3D"f26" bitsize=3D"64"/>
> +  <reg name=3D"f27" bitsize=3D"64"/>
> +  <reg name=3D"f28" bitsize=3D"64"/>
> +  <reg name=3D"f29" bitsize=3D"64"/>
> +  <reg name=3D"f30" bitsize=3D"64"/>
> +  <reg name=3D"f31" bitsize=3D"64"/>
> +  <reg name=3D"fsr" bitsize=3D"64" group=3D"float"/>
> +  <reg name=3D"fir" bitsize=3D"64" group=3D"float"/>
> +  <reg name=3D"fp" bitsize=3D"64" group=3D"float"/>
> +</feature>
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index bbcf7ca463..014f1db59e 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -181,6 +181,11 @@ static ObjectClass *mips_cpu_class_by_name(const
> char *cpu_model)
>      return oc;
>  }
>
> +static gchar *mips_gdb_arch_name(CPUState *cs)
> +{
> +    return g_strdup("mips");
> +}
> +
>  static void mips_cpu_class_init(ObjectClass *c, void *data)
>  {
>      MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);
> @@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClass *c,
> void *data)
>      cc->tlb_fill =3D mips_cpu_tlb_fill;
>  #endif
>
> +    cc->gdb_arch_name =3D mips_gdb_arch_name;
> +#ifdef TARGET_MIPS64
> +    cc->gdb_core_xml_file =3D "mips64-core.xml";
> +#else
> +    cc->gdb_core_xml_file =3D "mips-core.xml";
> +#endif
>      cc->gdb_num_core_regs =3D 73;
>      cc->gdb_stop_before_watchpoint =3D true;
>  }


--
Alex Benn=C3=A9e

