Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A4C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757C920872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyKtcLON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757C920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83V5-0000m1-Hi
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i83UO-0000Jf-Ku
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i83UM-0002En-Ud
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:20:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i83UM-0002EQ-Nh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:20:54 -0400
Received: by mail-ot1-x343.google.com with SMTP id z26so13442665oto.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ChLZpOSIasJD2e2hDCmnTwAoC2jiOHY9SKjUyomkuIk=;
 b=AyKtcLON51mFur5LMUnUOdSiNEUTmJJTzDxzeVns/LM0OYjmPBQ7nrGPieBKYNcIeA
 owt/s5TL4VOIbK4nJgOreTkqIJN/T9MgUJCP6W+5BCd7F2ZFxS1AK5vctxbhlPBpP7To
 jQ6dmMNoTgH1OCZnjTZtKbZcDa9pFy9bNk17gTWy7n9AYJskLPoYfoPH8UloBNDC5K38
 JVlf/0T44EwVag8ziYlvMQzcdtj2Unep2gcVn1A6bbQGkMtLvAzDBc6ZJHGnomgrsEJO
 //fbejRU0XjLkFO6vn+iaPdL0DD6vgRZPfFXx/tbRQZeBlaOU8oqID/yywjT61eCe/6g
 ltPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ChLZpOSIasJD2e2hDCmnTwAoC2jiOHY9SKjUyomkuIk=;
 b=MfIkDlFFNnkta7A6XFyqkcNFI7WXvTAlU9I7FgBPIu62gLYH9p95YthY5zdvXDiU5f
 noQQvJq0Aes9ptBPtlcvtytyV4Nzdld4DExP6Jc4YktCpO+J2Sa+W9scDUAB9+1T4AUu
 r6qXTqVOLgXzQppdi39HXZJJzuz6IKNW2u/SOXoysYg1Wukjxe5uHNyIV+2HU34RZy3D
 tfBAwtBh6T+VRbbGdbK91XrrWX1lkWzgaPe2IWLBhtL/1SvfEHkFi5R8GS7eoURYEvWc
 idm2bDICm338+DJY2EwNKW20TKyP1+Ep7isBvDSJJJk+ThZatloBl1XgO1Gl+JD4fMm3
 vpgw==
X-Gm-Message-State: APjAAAWuIX5t7B0XimUrj8elpG8FeuMpBhQpUFwBu8cQPAhE8fEK8k9b
 uCPS+R+NNcwWLD5QduHuaWMbWI7TpeyjnPi1zWQ=
X-Google-Smtp-Source: APXvYqzikrOdRXA+cnp2e4g9SF0TmCxMdSaOqdQBPBLD+mHMzgVm2hXJvgfXpuspHID+uIhPPfthITyYRxpe4z6Eumo=
X-Received: by 2002:a9d:127:: with SMTP id 36mr24534080otu.64.1568211653856;
 Wed, 11 Sep 2019 07:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 07:20:53
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 07:20:53
 -0700 (PDT)
In-Reply-To: <1568207966-25202-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1568207966-25202-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 11 Sep 2019 16:20:53 +0200
Message-ID: <CAL1e-=hS=qed_Kn-Qq1wpL4FL2bU7Gm7n3OfHkoh+xiMx6dxug@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] target/mips: gdbstub: Revert commit 8e0b373
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
Cc: Libo Zhou <zhlb29@foxmail.com>, arikalo@wavecomp.com, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.09.2019. 15.21, "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Libo Zhou <zhlb29@foxmail.com>
>
> Multiple report from users were received regarding failures
> of "packet g" comminucation with gdb. Revert this commit until
> a better solution is developed.
>
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Libo Zhou <zhlb29@foxmail.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/gdbstub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
> index ebcc98b..bbb2544 100644
> --- a/target/mips/gdbstub.c
> +++ b/target/mips/gdbstub.c
> @@ -38,7 +38,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, uint8_t
*mem_buf, int n)
>              return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr0);
>          default:
>              if (env->CP0_Status & (1 << CP0St_FR)) {
> -                return gdb_get_reg64(mem_buf,
> +                return gdb_get_regl(mem_buf,
>                      env->active_fpu.fpr[n - 38].d);
>              } else {
>                  return gdb_get_regl(mem_buf,
> @@ -99,7 +99,6 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t
*mem_buf, int n)
>              break;
>          default:
>              if (env->CP0_Status & (1 << CP0St_FR)) {
> -                uint64_t tmp =3D ldq_p(mem_buf);
>                  env->active_fpu.fpr[n - 38].d =3D tmp;
>              } else {
>                  env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX] =3D tmp;
> --
> 2.7.4
>
>
