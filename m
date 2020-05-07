Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB0C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D28207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5EvVmtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D28207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiUS-00024B-3q
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jWiTG-0000G3-PL
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:29:58 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jWiTF-0006bP-DN
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:29:58 -0400
Received: by mail-io1-xd41.google.com with SMTP id w11so6575983iov.8
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VeRnnQUznvu7LSne06x6VjtuEYy1rBhhG7+vVLUXSdM=;
 b=T5EvVmtWQ54arI0JInV+aU0r9bOE0NTkV/O2Igcfrfp968xxOm8WLrOtg+FP6f2EaR
 Xdx1UQzd7snI/PiFEk01Lmt4swyEiNNOPabd6jJpD8FZi3hLIcnUm4wZ5+pLbZeQ5pVv
 Kq20AxX9qyqXM1lFsgBCo8AI1zlQ4tMuv+8APTxLYy2O7mK3dDOzBGK4jjE6EOwwj7gd
 hXaanq+XgYMqdsUCs729PVKtPS/XZGZSK9WxEUWZL9rF07KRErcnumjYLpDFY7jJigJv
 v88qHPbJO3Ph8vQHmtM0MhBDh+5C9X0ODXQ9aFqbst7cBTf4TIzy+lp2/zlRs8ap21MI
 D/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VeRnnQUznvu7LSne06x6VjtuEYy1rBhhG7+vVLUXSdM=;
 b=foreCyv476BvH0TKKRfCTDvFMeVdtQvl4oG72t3Ukv92tMtfRhV8TqdXVC//0ukzbr
 h5iCdtVH6CrZOVLehjI62FkvVwV+UOtB3mbmLuQwmTU5u2aY9SuYc1ADi39ym1WROH48
 9xJ5F2VT88dag+ZR6gskXkRqbSVrqoQcYiFvRJFM/wYnmRWlFp1u1mLDOYKk9Iv7PtQ7
 3OMIjMSSKs8yhRR780Ex+vZre4Kv4tgYTz4Jj0IQ5Dnfp2WYKvc+RSo8309xLhuJoJhq
 K1pd9vrJv1fGjy9za4PvQPfhvSZQf1JkXVV3UHeW+Wm/9NMOxSZY+0rdH9T2EU13bRob
 YsVQ==
X-Gm-Message-State: AGi0PuYHMKxKNMRXmghir23FgQckTRVIS0YwTRJyKegzY3i5IcaYbxoi
 YPx+erLVZTnrGCPpjHJrmTYcYaepdnQiQ22rpeQ=
X-Google-Smtp-Source: APiQypJaQJkRf7RQ09064D3MfYuAhZh3MS4fT3AZrTCWT3yCpb7lSrPCyj+fdhfAZtapnejAumwWm7MtDqZl22f4b1s=
X-Received: by 2002:a6b:d10c:: with SMTP id l12mr3341174iob.44.1588865395691; 
 Thu, 07 May 2020 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
 <37bfb13b-7562-1c61-6563-197b4618f680@gmail.com>
 <aa9d3549-eba0-0e0f-175d-d8abb92ff1de@vivier.eu>
In-Reply-To: <aa9d3549-eba0-0e0f-175d-d8abb92ff1de@vivier.eu>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 7 May 2020 17:29:44 +0200
Message-ID: <CACXAS8C-KsREK+xYLHGTHp0n3of3NveON3+X-MB9OFJVkd1VMg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/sparc64: Translate flushw opcode
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: LemonBoy <thatlemon@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 4:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Hi,
>
> could someone with SPARC knowledge review this patch?
> I'd like to add it to linux-user queue.
>

Since it's TCG, I'd really preferred a review from Richard.

Regards,
Artyom
>
> Le 17/04/2020 =C3=A0 13:06, LemonBoy a =C3=A9crit :
> > Ping, I forgot to CC the SPARC mantainers in the previous mail.
> >
> > On 10/04/20 23:14, LemonBoy wrote:
> >> From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
> >> From: LemonBoy <thatlemon@gmail.com>
> >> Date: Fri, 10 Apr 2020 22:55:26 +0200
> >> Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
> >>
> >> The ifdef logic should unconditionally compile in the `xop =3D=3D 0x2b=
` case
> >> when targeting sparc64.
> >>
> >> Fix the handling of window spill traps by keeping cansave into account
> >> when calculating the new CWP.
> >>
> >> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> >> ---
> >>  bsd-user/main.c             | 4 +++-
> >>  linux-user/sparc/cpu_loop.c | 4 +++-
> >>  target/sparc/translate.c    | 2 ++
> >>  3 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/bsd-user/main.c b/bsd-user/main.c
> >> index 770c2b267a..d6b1c997e3 100644
> >> --- a/bsd-user/main.c
> >> +++ b/bsd-user/main.c
> >> @@ -413,7 +413,9 @@ static void save_window(CPUSPARCState *env)
> >>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> >>      env->wim =3D new_wim;
> >>  #else
> >> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> >> +    /* cansave is zero if the spill trap handler is triggered by `sav=
e` and */
> >> +    /* nonzero if triggered by a `flushw` */
> >> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave =
- 2));
> >>      env->cansave++;
> >>      env->canrestore--;
> >>  #endif
> >> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> >> index 7645cc04ca..20a7401126 100644
> >> --- a/linux-user/sparc/cpu_loop.c
> >> +++ b/linux-user/sparc/cpu_loop.c
> >> @@ -69,7 +69,9 @@ static void save_window(CPUSPARCState *env)
> >>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> >>      env->wim =3D new_wim;
> >>  #else
> >> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> >> +    /* cansave is zero if the spill trap handler is triggered by `sav=
e` and */
> >> +    /* nonzero if triggered by a `flushw` */
> >> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave =
- 2));
> >>      env->cansave++;
> >>      env->canrestore--;
> >>  #endif
> >> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> >> index 9416a551cf..1a4efd4ed6 100644
> >> --- a/target/sparc/translate.c
> >> +++ b/target/sparc/translate.c
> >> @@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, =
unsigned int insn)
> >>  #endif
> >>                  gen_store_gpr(dc, rd, cpu_tmp0);
> >>                  break;
> >> +#endif
> >> +#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
> >>              } else if (xop =3D=3D 0x2b) { /* rdtbr / V9 flushw */
> >>  #ifdef TARGET_SPARC64
> >>                  gen_helper_flushw(cpu_env);
> >>
> >
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

