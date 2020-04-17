Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2CBC38A2C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A88F21D95
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niEPODbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A88F21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOqD-0005xf-Ei
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thatlemon@gmail.com>) id 1jPOpU-0005HD-7Q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thatlemon@gmail.com>) id 1jPOpR-00009S-LC
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:06:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1jPOpQ-00006r-8f
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:06:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id x25so2522351wmc.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=t049tPTWuQGmt7oQLivwMJYJhpKdXyVYu2P8qMMUd+o=;
 b=niEPODbRS1hDPYMyRjfm/yCvNNmn18re0lRIZKFb4DUOMACiAIjezcJBNOWXQIZiUq
 6H+wRFBGUB3NQ3s5ly0QAk95sAkFSsyZlrqaAFHCrRdJ7eKtw+z4mhCPrEqddkVruiLL
 fcJjTEuSPX5AJOApjm0yCjfrdKu9yfJ/wLhDeN/Xz4AkKTYtYXx8Xd30rmjyrhrUyEPL
 klpxfasrzvoK1beb98NYBwUlEOV8vKkV6+FQKT37qJiM+t1JALgwXRVS8l2Rc8oBXoVH
 wtL9IVqAcUm17zfvpy7Gb71pv6wSujiXEm+7ugGFxmeJDPywp6b6NprKI1HbpcqCmwNG
 lXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t049tPTWuQGmt7oQLivwMJYJhpKdXyVYu2P8qMMUd+o=;
 b=d943juF5E+Lnj4AbhNH4ZI+LWBFtPmcIHCbkJMGrvGvv7JyTkN7BJt2b8U6viFAOu8
 TLyVjIX1+dHeBQxMaO+vZuWwBZxYX2+suvV30dsOyxxl0WKCpATKJjkcr+ipA+d4hQ66
 atcTu5osPhh5+RJD0vmsQuJBFUiJiM+JQa9oP7wojwf1vG15/H3lsxi221j0GHCKlAVP
 60s9P1YCOGcLr5HxrELVlTa6TAEfJVrXFagNuMaVhqc0dqKtC9mS/m+F80beCRYiSx+K
 jQ9an5AcW5SOdJeGbzcITZdBd08Dl2PctfBAjnmWw6/BQJ3L+P3l5uqhoSD2onfIEgIz
 /OMg==
X-Gm-Message-State: AGi0PuabnXLt0eL4kSDDnHzvRdRrmQ5KM2LsWQLH2DafRz71Aob03Jgj
 Pp0h9xcfkm7lmhoEUBiv23Y=
X-Google-Smtp-Source: APiQypIUFWa+hPY4vaDv2vFRT4mCULN3ZrYp4PdAlB4Yb+13jM9tyZE/S5qhC+WIO46hNirn4nz9NQ==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr2731347wme.75.1587121593900; 
 Fri, 17 Apr 2020 04:06:33 -0700 (PDT)
Received: from [192.168.1.199] (93-43-179-29.ip93.fastwebnet.it.
 [93.43.179.29])
 by smtp.gmail.com with ESMTPSA id 5sm7444483wmg.34.2020.04.17.04.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 04:06:33 -0700 (PDT)
Subject: Re: [PATCH] linux-user/sparc64: Translate flushw opcode
From: LemonBoy <thatlemon@gmail.com>
To: qemu-devel@nongnu.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com
References: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Message-ID: <37bfb13b-7562-1c61-6563-197b4618f680@gmail.com>
Date: Fri, 17 Apr 2020 13:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping, I forgot to CC the SPARC mantainers in the previous mail.

On 10/04/20 23:14, LemonBoy wrote:
> From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
> From: LemonBoy <thatlemon@gmail.com>
> Date: Fri, 10 Apr 2020 22:55:26 +0200
> Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
> 
> The ifdef logic should unconditionally compile in the `xop == 0x2b` case
> when targeting sparc64.
> 
> Fix the handling of window spill traps by keeping cansave into account
> when calculating the new CWP.
> 
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  bsd-user/main.c             | 4 +++-
>  linux-user/sparc/cpu_loop.c | 4 +++-
>  target/sparc/translate.c    | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 770c2b267a..d6b1c997e3 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -413,7 +413,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 7645cc04ca..20a7401126 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -69,7 +69,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 9416a551cf..1a4efd4ed6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
>  #endif
>                  gen_store_gpr(dc, rd, cpu_tmp0);
>                  break;
> +#endif
> +#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
>              } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
>  #ifdef TARGET_SPARC64
>                  gen_helper_flushw(cpu_env);
> 

