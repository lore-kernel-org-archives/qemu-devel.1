Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8679EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE6D206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjyaATIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZ4s-00007H-Cc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46576 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQZ3P-0007Wu-0D
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:13:56 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jQZ3N-0003yk-12
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:13:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35815)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jQZ3M-0003jA-2M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:13:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id r26so181906wmh.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ikob4EfMH6NAE7R5w9KB7JeBpWUTZhFPlEO9rrrosWI=;
 b=IjyaATIQOXqen11Hhv+3MueJySUnDPscpj2cpaUn1Z5DJ7TAdbfq6DNPudQYTJ0BOC
 42/LlGLuyLJfncSGW2FogCfunglJUdNR0JmpCJ7icTs+MfYt0hRkhTyBgWmZ37sHb7dt
 y4vmbp15BE2wsIlBi1CyDc+MCDgcl0frmwAMkkpXj0I5GEmoAMqzD9WoW6Bu10Xdyd/U
 EJo+G9zq7ea6s9pN3++fNnMnuY1sThbvTjfxQNE//mTCA44PcCRG/M4TFeXeakpducKD
 VKVODdo3+/DuVw08Iy0hbd8YuhzFhrVhhsEjy29H1GJQ+5Ze2D74q5YDFGE+WJaVR0s8
 Szsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ikob4EfMH6NAE7R5w9KB7JeBpWUTZhFPlEO9rrrosWI=;
 b=Q3y5ITZgUE3XqFWXlppig6Mb3KvNIsJFRf556PsWvQXwCq3HzRrfUGeLpW+olW1S0o
 SOidcphhTPVhXjxGc1adX/gJY0gXhpxf4IVX+4hj6rxQJwZdsyLipdeB12ybWH9SUZdT
 KQ7d5Sqjc5QisvnpndN/A8v9f4OPdmHXxlE4bSum9h/Eh3JJGn+Gb9KGDgt/g6pdKsr+
 Tx7HHAk7/+0CG13Nh/vM+YSinNACx+2KfV/f3wpkum7qzwl5AjlIpg9KA3SCI26W6vqh
 kEpBAZnhCMWHE5HYOqkYcwPZ6jdZU4Mgwi7Xop2PP6RdyB+JppIWp2UmTdu9wFK0qkaR
 qZsg==
X-Gm-Message-State: AGi0PuZlOC+g17Wg2E9gxuQbsXqq6wTnCodEFOvH6IBWEHpmv+9wJn0X
 CKDiZz90I2x7kaqPiuGeDQSXZw==
X-Google-Smtp-Source: APiQypLs2H61KyDa3dpRn7P+1Q9X03PpbkUaPfuS9YRYokFUqvVnOuK3NwUEpZrG5/XaZ9+IY0weww==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr64799wmi.103.1587399223921;
 Mon, 20 Apr 2020 09:13:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n6sm1830111wrs.81.2020.04.20.09.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 09:13:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C481D1FF7E;
 Mon, 20 Apr 2020 17:13:41 +0100 (BST)
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frederic.konrad@adacore.com
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
In-reply-to: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
Date: Mon, 20 Apr 2020 17:13:41 +0100
Message-ID: <877dyadtje.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org, laurent@vivier.eu,
 Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>,
 pierre@freepascal.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


frederic.konrad@adacore.com writes:

> From: KONRAD Frederic <frederic.konrad@adacore.com>
>
> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing=
 is
> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then exp=
ects
> a coldfire FPU instead of the default m68881 FPU.
>
> This is not OK because the m68881 floats registers are 96 bits wide so it
> crashes GDB with the following error message:
>
> (gdb) target remote localhost:7960
> Remote debugging using localhost:7960
> warning: Register "fp0" has an unsupported size (96 bits)
> warning: Register "fp1" has an unsupported size (96 bits)
> ...
> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes): =
   \
>   00000000000[...]0000
>
> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
>
> (gdb) tar rem :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x00000000 in ?? ()
> (gdb) p $fp0
> $1 =3D nan(0xffffffffffffffff)
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Well it solves the connection issue - but the FP values are still
hopelessly broken, from float_convs:

  from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)

in gdb

  fp0            <invalid float value> (raw 0x8c3a5900000000004066)

> ---
>  configure             |  2 +-
>  gdb-xml/m68k-core.xml | 29 +++++++++++++++++++++++++++++
>  target/m68k/cpu.c     | 30 +++++++++++++++++++++++++-----
>  3 files changed, 55 insertions(+), 6 deletions(-)
>  create mode 100644 gdb-xml/m68k-core.xml
>
> diff --git a/configure b/configure
> index 23b5e93..2b07b85 100755
> --- a/configure
> +++ b/configure
> @@ -7825,7 +7825,7 @@ case "$target_name" in
>    ;;
>    m68k)
>      bflt=3D"yes"
> -    gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-fp.xml"
> +    gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
>      TARGET_SYSTBL_ABI=3Dcommon
>    ;;
>    microblaze|microblazeel)
> diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
> new file mode 100644
> index 0000000..5b092d2
> --- /dev/null
> +++ b/gdb-xml/m68k-core.xml
> @@ -0,0 +1,29 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2008 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.m68k.core">
> +  <reg name=3D"d0" bitsize=3D"32"/>
> +  <reg name=3D"d1" bitsize=3D"32"/>
> +  <reg name=3D"d2" bitsize=3D"32"/>
> +  <reg name=3D"d3" bitsize=3D"32"/>
> +  <reg name=3D"d4" bitsize=3D"32"/>
> +  <reg name=3D"d5" bitsize=3D"32"/>
> +  <reg name=3D"d6" bitsize=3D"32"/>
> +  <reg name=3D"d7" bitsize=3D"32"/>
> +  <reg name=3D"a0" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"a1" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"a2" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"a3" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"a4" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"a5" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"fp" bitsize=3D"32" type=3D"data_ptr"/>
> +  <reg name=3D"sp" bitsize=3D"32" type=3D"data_ptr"/>
> +
> +  <reg name=3D"ps" bitsize=3D"32"/>
> +  <reg name=3D"pc" bitsize=3D"32" type=3D"code_ptr"/>
> +
> +</feature>
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 9445fcd..976e624 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -297,6 +297,21 @@ static void m68k_cpu_class_init(ObjectClass *c, void=
 *data)
>      dc->vmsd =3D &vmstate_m68k_cpu;
>  }
>=20=20
> +static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
> +{
> +    CPUClass *cc =3D CPU_CLASS(c);
> +
> +    cc->gdb_core_xml_file =3D "m68k-core.xml";
> +}
> +
> +#define DEFINE_M68K_CPU_TYPE_WITH_CLASS(cpu_model, initfn, classinit)   =
   \
> +    {                                                                   =
   \
> +        .name =3D M68K_CPU_TYPE_NAME(cpu_model),                        =
     \
> +        .instance_init =3D initfn,                                      =
     \
> +        .parent =3D TYPE_M68K_CPU,                                      =
     \
> +        .class_init =3D classinit,                                      =
     \
> +    }
> +
>  #define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
>      {                                           \
>          .name =3D M68K_CPU_TYPE_NAME(cpu_model),  \
> @@ -314,11 +329,16 @@ static const TypeInfo m68k_cpus_type_infos[] =3D {
>          .class_size =3D sizeof(M68kCPUClass),
>          .class_init =3D m68k_cpu_class_init,
>      },
> -    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> -    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68000", m68000_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68020", m68020_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68030", m68030_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68040", m68040_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
> +    DEFINE_M68K_CPU_TYPE_WITH_CLASS("m68060", m68060_cpu_initfn,
> +                                    m68k_cpu_class_init_m68k_core),
>      DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),


--=20
Alex Benn=C3=A9e

