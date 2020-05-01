Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1404C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB80208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfHp6TRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB80208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXf3-0008KZ-MW
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUXdl-0005wy-EB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUXdW-0002l0-7w
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:31:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUXHY-0005Gs-7C
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588345730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toESbShGTF2QzgIWxAm+x076zKSUGpl/RHTr0NruCSI=;
 b=AfHp6TRel8kdg3tK+SR3L40Gv4uskcIv/h7kjgiXo5ccvxYpHzt2C4iENgZLLpeBR+JuHI
 JdN5Y+b8pLR3a6MWvDHOEFXzeKpL4s/VzzSWGwQs55ck0kisuxs/gNX/aONN1ZnFKjRJfi
 8Gfox/DR+W8tqwAERdfgQTFiFOuPDe4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-TW5Mx5cNOemjgzSZ4ricVA-1; Fri, 01 May 2020 11:08:49 -0400
X-MC-Unique: TW5Mx5cNOemjgzSZ4ricVA-1
Received: by mail-wr1-f72.google.com with SMTP id s11so5806697wru.6
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EKeNvEYPKiQqOEXseo+ZU6MuLnDHJM1wGN/uvBwrDyk=;
 b=l0EZq5yhA0mIyIPgeEpSudj5PtApm7oxq91kZuZfO2c8r4fL3xfGqAmyUFoeImdA97
 ziiKuOoaMgo1QXVqiVr2Ls24AXg265VYy1ohjHXrnZ6TPT84Qczhg6emFWn95T0HF8iN
 ldjQJxb4wMHwHDgS+6PO1teoJTGE1BZkOjvuLRAAkILtRagNH4xLVgPcXW70s+SKTsa7
 aCR7cE4g+jpGw3Vwh0+4WGrMbO2YjaLQO5GjiTr4/nzQAg2dXV6Ln45ODFE3XrnJkf7L
 e5TaHK8vvcC5QHr8B6CbclGxg3ubwxpzvljeih6lYxcAScQXNo7YkPkcZpKalag05Ltd
 xtIw==
X-Gm-Message-State: AGi0PuZdEhlOrf4rmy7dgQ5Uyfl/HyFsiJLjjtAh/6HrKKzZGO3fjBkC
 PezQltmxTm8Rxz0RgoRzH5253ABeOK/tjZ7ueIJSf8ysHlG2TwHBElDDfDPI8E07H04uW8UjJiF
 DP7yKmaVBvwpeUCc=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr28100wmc.132.1588345725010;
 Fri, 01 May 2020 08:08:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypIU82+PALJuIWrUxFXuW6EHfZaxKcqY2ZKu+w4lHmzCJOadfm7jVHp6MJ0vUyws4kXMUfBVkQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr28077wmc.132.1588345724691;
 Fri, 01 May 2020 08:08:44 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id g6sm4939911wrw.34.2020.05.01.08.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 08:08:44 -0700 (PDT)
Subject: Re: [PATCH v1 5/7] disas: include an optional note for the start of
 disassembly
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501145713.19822-1-alex.bennee@linaro.org>
 <20200501145713.19822-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd5c3bde-81b4-6d77-7c66-f2839904ccac@redhat.com>
Date: Fri, 1 May 2020 17:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501145713.19822-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, riku.voipio@iki.fi,
 richard.henderson@linaro.org, laurent@vivier.eu,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 4:57 PM, Alex Benn=C3=A9e wrote:
> This will become useful shortly for providing more information about
> output assembly inline. While there fix up the indenting and code
> formatting in disas().
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/disas/disas.h     |  2 +-
>   include/exec/log.h        |  4 ++--
>   accel/tcg/translate-all.c |  4 ++--
>   disas.c                   | 15 +++++++++++----
>   tcg/tcg.c                 |  4 ++--
>   5 files changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index 36c33f6f19..1b6e035e32 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -7,7 +7,7 @@
>   #include "cpu.h"
>  =20
>   /* Disassemble this for me please... (debugging). */
> -void disas(FILE *out, void *code, unsigned long size);
> +void disas(FILE *out, void *code, unsigned long size, const char *note);
>   void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>                     target_ulong size);
>  =20
> diff --git a/include/exec/log.h b/include/exec/log.h
> index fcc7b9e00b..3ed797c1c8 100644
> --- a/include/exec/log.h
> +++ b/include/exec/log.h
> @@ -56,13 +56,13 @@ static inline void log_target_disas(CPUState *cpu, ta=
rget_ulong start,
>       rcu_read_unlock();
>   }
>  =20
> -static inline void log_disas(void *code, unsigned long size)
> +static inline void log_disas(void *code, unsigned long size, const char =
*note)
>   {
>       QemuLogFile *logfile;
>       rcu_read_lock();
>       logfile =3D atomic_rcu_read(&qemu_logfile);
>       if (logfile) {
> -        disas(logfile->fd, code, size);
> +        disas(logfile->fd, code, size, note);
>       }
>       rcu_read_unlock();
>   }
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index e4f703a7e6..cdf58bb420 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1800,7 +1800,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>               size_t data_size =3D gen_code_size - code_size;
>               size_t i;
>  =20
> -            log_disas(tb->tc.ptr, code_size);
> +            log_disas(tb->tc.ptr, code_size, NULL);
>  =20
>               for (i =3D 0; i < data_size; i +=3D sizeof(tcg_target_ulong=
)) {
>                   if (sizeof(tcg_target_ulong) =3D=3D 8) {
> @@ -1814,7 +1814,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                   }
>               }
>           } else {
> -            log_disas(tb->tc.ptr, gen_code_size);
> +            log_disas(tb->tc.ptr, gen_code_size, NULL);
>           }
>           qemu_log("\n");
>           qemu_log_flush();
> diff --git a/disas.c b/disas.c
> index 3937da6157..bb74650633 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -586,7 +586,7 @@ char *plugin_disas(CPUState *cpu, uint64_t addr, size=
_t size)
>   }
>  =20
>   /* Disassemble this for me please... (debugging). */
> -void disas(FILE *out, void *code, unsigned long size)
> +void disas(FILE *out, void *code, unsigned long size, const char *note)
>   {
>       uintptr_t pc;
>       int count;
> @@ -674,10 +674,17 @@ void disas(FILE *out, void *code, unsigned long siz=
e)
>       for (pc =3D (uintptr_t)code; size > 0; pc +=3D count, size -=3D cou=
nt) {
>           fprintf(out, "0x%08" PRIxPTR ":  ", pc);
>           count =3D print_insn(pc, &s.info);
> -=09fprintf(out, "\n");
> -=09if (count < 0)
> -=09    break;
> +        if (note) {
> +            fprintf(out, "\t\t%s\n", note);
> +            note =3D NULL;
> +        } else {
> +            fprintf(out, "\n");
> +        }
> +        if (count < 0) {
> +            break;
> +        }
>       }
> +
>   }
>  =20
>   /* Look up symbol for debugging purpose.  Returns "" if unknown. */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index dd4b3d7684..a2268d9db0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1092,7 +1092,7 @@ void tcg_prologue_init(TCGContext *s)
>               size_t data_size =3D prologue_size - code_size;
>               size_t i;
>  =20
> -            log_disas(buf0, code_size);
> +            log_disas(buf0, code_size, NULL);
>  =20
>               for (i =3D 0; i < data_size; i +=3D sizeof(tcg_target_ulong=
)) {
>                   if (sizeof(tcg_target_ulong) =3D=3D 8) {
> @@ -1106,7 +1106,7 @@ void tcg_prologue_init(TCGContext *s)
>                   }
>               }
>           } else {
> -            log_disas(buf0, prologue_size);
> +            log_disas(buf0, prologue_size, NULL);
>           }
>           qemu_log("\n");
>           qemu_log_flush();
>=20


