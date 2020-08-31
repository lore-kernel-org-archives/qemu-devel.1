Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A12C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EF22083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EF22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrWe-00012r-U6
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDn-0004Yt-Ql
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:12 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDl-0001ZL-QR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:11 -0400
Received: by mail-qv1-f67.google.com with SMTP id m14so1852323qvt.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SjgWIsZuXFPtl3+R2qxjhWR5+JINNygoUiofAL6ajIc=;
 b=ZOsh/vZxd8acJPvYPrgYUvjAkXkbpMybkbvJxcc/lBTMY4PdCv0QMq5TSTxDGRUxMr
 OdS9eg/Z+uPGzn/ArWmbuXwdibFPutfI4ttTccdYZwEks3jjkzVYMHy4VWyHU4ja2OiW
 AuIvYluHr5FxssE0ewsYA/2peEB8VShSG+heSiQ/SQHSGdnWkpbvNkB3RTUaSyNcNxkd
 0Lm31P8t+JlHtOdY4za3ygKfnhFlETvUHhSi+TT5o45o5ivTN5BNrWLC4UUg0lxoR7eY
 TUwsi1HGqxSeSjtsRgzhOjgkI6q32JSw9CHDG4YcmM+OGI6BXGK2pFrgpF+dgx1364Ml
 q41Q==
X-Gm-Message-State: AOAM531LMVgiOKC4EDX9rfL+Vt8rN9U1pANciDEt5+tVitckj3Hsck+u
 Cvcrs0e51aq7XEmNVdwL3bEGFLJ8zgQFq8e1XxI=
X-Google-Smtp-Source: ABdhPJzbXTwMlKCHEK9iUVx0HIKGKaf7MKsvxxkEwEHnCKErFwPwMBCpDNQqTCRvluxbUlFBHfThGY3vxLQnHPj+TJA=
X-Received: by 2002:ad4:59d0:: with SMTP id el16mr3028940qvb.116.1598908808980; 
 Mon, 31 Aug 2020 14:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-10-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:51:42 +0200
Message-ID: <CAAdtpL53UOxEDFeEc7K+W-BjAUsqK7f2AkxLgc9qAkc88Ee1fQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/76] target/microblaze: Split out FSR from env->sregs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000966d6e05ae32f728"
Received-SPF: pass client-ip=209.85.219.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000966d6e05ae32f728
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:25, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Continue eliminating the sregs array in favor of individual members.
> Does not correct the width of FSR, yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  target/microblaze/cpu.h          | 1 +
>  linux-user/microblaze/cpu_loop.c | 4 ++--
>  target/microblaze/gdbstub.c      | 4 ++--
>  target/microblaze/op_helper.c    | 8 ++++----
>  target/microblaze/translate.c    | 6 ++++--
>  5 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 7d94af43ed..bcafef99b0 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -240,6 +240,7 @@ struct CPUMBState {
>      uint64_t msr;
>      uint64_t ear;
>      uint64_t esr;
> +    uint64_t fsr;
>      uint64_t sregs[14];
>      float_status fp_status;
>      /* Stack protectors. Yes, it's a hw feature.  */
> diff --git a/linux-user/microblaze/cpu_loop.c
> b/linux-user/microblaze/cpu_loop.c
> index c10e3e0261..da5e98b784 100644
> --- a/linux-user/microblaze/cpu_loop.c
> +++ b/linux-user/microblaze/cpu_loop.c
> @@ -96,10 +96,10 @@ void cpu_loop(CPUMBState *env)
>                  case ESR_EC_FPU:
>                      info.si_signo =3D TARGET_SIGFPE;
>                      info.si_errno =3D 0;
> -                    if (env->sregs[SR_FSR] & FSR_IO) {
> +                    if (env->fsr & FSR_IO) {
>                          info.si_code =3D TARGET_FPE_FLTINV;
>                      }
> -                    if (env->sregs[SR_FSR] & FSR_DZ) {
> +                    if (env->fsr & FSR_DZ) {
>                          info.si_code =3D TARGET_FPE_FLTDIV;
>                      }
>                      info._sifields._sigfault._addr =3D 0;
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index 05e22f233d..2634ce49fc 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -71,7 +71,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray
> *mem_buf, int n)
>          val =3D env->esr;
>          break;
>      case GDB_FSR:
> -        val =3D env->sregs[SR_FSR];
> +        val =3D env->fsr;
>          break;
>      case GDB_BTR:
>          val =3D env->sregs[SR_BTR];
> @@ -127,7 +127,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t
> *mem_buf, int n)
>          env->esr =3D tmp;
>          break;
>      case GDB_FSR:
> -        env->sregs[SR_FSR] =3D tmp;
> +        env->fsr =3D tmp;
>          break;
>      case GDB_BTR:
>          env->sregs[SR_BTR] =3D tmp;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index f01cf9be64..ae57d45536 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -175,19 +175,19 @@ static void update_fpu_flags(CPUMBState *env, int
> flags)
>      int raise =3D 0;
>
>      if (flags & float_flag_invalid) {
> -        env->sregs[SR_FSR] |=3D FSR_IO;
> +        env->fsr |=3D FSR_IO;
>          raise =3D 1;
>      }
>      if (flags & float_flag_divbyzero) {
> -        env->sregs[SR_FSR] |=3D FSR_DZ;
> +        env->fsr |=3D FSR_DZ;
>          raise =3D 1;
>      }
>      if (flags & float_flag_overflow) {
> -        env->sregs[SR_FSR] |=3D FSR_OF;
> +        env->fsr |=3D FSR_OF;
>          raise =3D 1;
>      }
>      if (flags & float_flag_underflow) {
> -        env->sregs[SR_FSR] |=3D FSR_UF;
> +        env->fsr |=3D FSR_UF;
>          raise =3D 1;
>      }
>      if (raise
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 411c7b6e49..c58c49ea8f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1810,7 +1810,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int
> flags)
>                   "debug=3D%x imm=3D%x iflags=3D%x fsr=3D%" PRIx64 " "
>                   "rbtr=3D%" PRIx64 "\n",
>                   env->msr, env->esr, env->ear,
> -                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
> +                 env->debug, env->imm, env->iflags, env->fsr,
>                   env->sregs[SR_BTR]);
>      qemu_fprintf(f, "btaken=3D%d btarget=3D%" PRIx64 " mode=3D%s(saved=
=3D%s) "
>                   "eip=3D%d ie=3D%d\n",
> @@ -1877,8 +1877,10 @@ void mb_tcg_init(void)
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear),
> "rear");
>      cpu_SR[SR_ESR] =3D
>          tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr),
> "resr");
> +    cpu_SR[SR_FSR] =3D
> +        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr),
> "rfsr");
>
> -    for (i =3D SR_ESR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
> +    for (i =3D SR_FSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
>          cpu_SR[i] =3D tcg_global_mem_new_i64(cpu_env,
>                            offsetof(CPUMBState, sregs[i]),
>                            special_regnames[i]);
> --
> 2.25.1
>
>
>

--000000000000966d6e05ae32f728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:25, Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Cont=
inue eliminating the sregs array in favor of individual members.<br>
Does not correct the width of FSR, yet.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
---<br>
=C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0linux-user/microblaze/cpu_loop.c | 4 ++--<br>
=C2=A0target/microblaze/gdbstub.c=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0target/microblaze/op_helper.c=C2=A0 =C2=A0 | 8 ++++----<br>
=C2=A0target/microblaze/translate.c=C2=A0 =C2=A0 | 6 ++++--<br>
=C2=A05 files changed, 13 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h<br>
index 7d94af43ed..bcafef99b0 100644<br>
--- a/target/microblaze/cpu.h<br>
+++ b/target/microblaze/cpu.h<br>
@@ -240,6 +240,7 @@ struct CPUMBState {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t msr;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t ear;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t esr;<br>
+=C2=A0 =C2=A0 uint64_t fsr;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sregs[14];<br>
=C2=A0 =C2=A0 =C2=A0float_status fp_status;<br>
=C2=A0 =C2=A0 =C2=A0/* Stack protectors. Yes, it&#39;s a hw feature.=C2=A0 =
*/<br>
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_l=
oop.c<br>
index c10e3e0261..da5e98b784 100644<br>
--- a/linux-user/microblaze/cpu_loop.c<br>
+++ b/linux-user/microblaze/cpu_loop.c<br>
@@ -96,10 +96,10 @@ void cpu_loop(CPUMBState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ESR_EC_F=
PU:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0info.si_signo =3D TARGET_SIGFPE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0info.si_errno =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
env-&gt;sregs[SR_FSR] &amp; FSR_IO) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
env-&gt;fsr &amp; FSR_IO) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0info.si_code =3D TARGET_FPE_FLTINV;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
env-&gt;sregs[SR_FSR] &amp; FSR_DZ) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
env-&gt;fsr &amp; FSR_DZ) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0info.si_code =3D TARGET_FPE_FLTDIV;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0info._sifields._sigfault._addr =3D 0;<br>
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c<br>
index 05e22f233d..2634ce49fc 100644<br>
--- a/target/microblaze/gdbstub.c<br>
+++ b/target/microblaze/gdbstub.c<br>
@@ -71,7 +71,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;esr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_FSR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;sregs[SR_FSR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;fsr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_BTR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D env-&gt;sregs[SR_BTR];<br>
@@ -127,7 +127,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *me=
m_buf, int n)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;esr =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_FSR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_FSR] =3D tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fsr =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case GDB_BTR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sregs[SR_BTR] =3D tmp;<br>
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c<=
br>
index f01cf9be64..ae57d45536 100644<br>
--- a/target/microblaze/op_helper.c<br>
+++ b/target/microblaze/op_helper.c<br>
@@ -175,19 +175,19 @@ static void update_fpu_flags(CPUMBState *env, int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0int raise =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; float_flag_invalid) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_FSR] |=3D FSR_IO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fsr |=3D FSR_IO;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; float_flag_divbyzero) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_FSR] |=3D FSR_DZ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fsr |=3D FSR_DZ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; float_flag_overflow) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_FSR] |=3D FSR_OF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fsr |=3D FSR_OF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; float_flag_underflow) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sregs[SR_FSR] |=3D FSR_UF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fsr |=3D FSR_UF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (raise<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index 411c7b6e49..c58c49ea8f 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -1810,7 +1810,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;debug=
=3D%x imm=3D%x iflags=3D%x fsr=3D%&quot; PRIx64 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rbtr=
=3D%&quot; PRIx64 &quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;msr,=
 env-&gt;esr, env-&gt;ear,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;debu=
g, env-&gt;imm, env-&gt;iflags, env-&gt;sregs[SR_FSR],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;debu=
g, env-&gt;imm, env-&gt;iflags, env-&gt;fsr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sreg=
s[SR_BTR]);<br>
=C2=A0 =C2=A0 =C2=A0qemu_fprintf(f, &quot;btaken=3D%d btarget=3D%&quot; PRI=
x64 &quot; mode=3D%s(saved=3D%s) &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;eip=3D=
%d ie=3D%d\n&quot;,<br>
@@ -1877,8 +1877,10 @@ void mb_tcg_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, ear), &quot;rear&quot;);<br>
=C2=A0 =C2=A0 =C2=A0cpu_SR[SR_ESR] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_global_mem_new_i64(cpu_env, offsetof(=
CPUMBState, esr), &quot;resr&quot;);<br>
+=C2=A0 =C2=A0 cpu_SR[SR_FSR] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_global_mem_new_i64(cpu_env, offsetof(CPUMB=
State, fsr), &quot;rfsr&quot;);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D SR_ESR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
+=C2=A0 =C2=A0 for (i =3D SR_FSR + 1; i &lt; ARRAY_SIZE(cpu_SR); i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_SR[i] =3D tcg_global_mem_new_i64(cpu_=
env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUMBState, sregs[i]),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0special_regnames[i]);<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000966d6e05ae32f728--

