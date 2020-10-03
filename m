Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA096C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E7E206B5
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw0A0M29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E7E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlSh-0005S3-DM
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlQn-00043Z-DF; Sat, 03 Oct 2020 13:34:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlQk-00026k-0j; Sat, 03 Oct 2020 13:34:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id g4so5184719wrs.5;
 Sat, 03 Oct 2020 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZJxSGf+k2fRY3+8WPoIY5XuHZfje2g9U1YdaT4hvrTI=;
 b=Lw0A0M299o8nvOY9K+SA5YnHxLbCT2Xicuq2dK7EAbekHshm4QUMKJVH1rYrRPR6Q5
 /QSZjVq+1WjaSv8l+ersaiLga/Hk2i0bixXkRt8id4OWeNPj0LCWCTIvp0pZzh4eCL0g
 L9sJtFSmQ9MoNoagIgmir2uMy6CRPRMNPFTkkF1bsnHbFjmkuQh9yYSsaAbn5LeevCki
 Zha8QynRfRIMyTL6sADbnjdTUS16udVBzuPLkTyzuXcz9O3EUn3+7EYm3C7/YderWBQQ
 vG0aTfEgXY9EDmY0MvmYgUMWIpoZxEoFD6jOr2NpqM/1HRoPRRqptAx2WRec7/uY/RRs
 RVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZJxSGf+k2fRY3+8WPoIY5XuHZfje2g9U1YdaT4hvrTI=;
 b=oQgibV2zIuhJFqdFKad2wIm2OgsjZONJooDEvpON/rVOEUuOgvKmPShQ56+QnXJUSD
 IoSpbxTYYxOSOoGBaiqIM4uqmvbMoZRkGLwkImtbZjV8wvOtLNOkdKnSWhKJaKrjzo45
 ame+u9syo3nARov0FW3Ys46o9qcEWZgrptCrAb3a0Mf+rNNUSQ3FhkxsnHx3CrWyjiIk
 J721q3cQNxBqIB86rB8wbvRLyh1PdrRMYQZVD7rRAmk+YQgy3Ht7/U96HJZxX9NXImvd
 tbZuWAPK94+tWJvcRkgIIqyGgCcOUosBaFwcMLy/l0vSW8hYPHL1UmLqk9bsegoGQ/rQ
 3aXQ==
X-Gm-Message-State: AOAM532S+ZCDLZJE0Mm2vosPuLbcgZ3s87xqvfmNSLKNwNSq6PmW1Qsm
 m3PUYiTJ861CgM/maVC2eYI=
X-Google-Smtp-Source: ABdhPJx4ZGVnd8h3kyZsTfkBc/iCQFIPM4hju5UCCyR9VTkgtlECuGKO4rrNQyr14nnQXlBbmpUuPw==
X-Received: by 2002:adf:f643:: with SMTP id x3mr2022034wrp.180.1601746484193; 
 Sat, 03 Oct 2020 10:34:44 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u15sm5676629wml.21.2020.10.03.10.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:34:43 -0700 (PDT)
Subject: Re: [PATCH v10 4/8] linux-user/elfload: Fix coding style in
 load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96bd930b-e11c-150c-b4ab-670cd8f46aa6@amsat.org>
Date: Sat, 3 Oct 2020 19:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002215955.254866-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:59 PM, Richard Henderson wrote:
> Fixing this now will clarify following patches.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/elfload.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f6022fd704..7572a32a30 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2531,9 +2531,15 @@ static void load_elf_image(const char *image_name, int image_fd,
>              abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
>              int elf_prot = 0;
>  
> -            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
> -            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
> -            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
> +            if (eppnt->p_flags & PF_R) {
> +                elf_prot |= PROT_READ;
> +            }
> +            if (eppnt->p_flags & PF_W) {
> +                elf_prot |= PROT_WRITE;
> +            }
> +            if (eppnt->p_flags & PF_X) {
> +                elf_prot |= PROT_EXEC;
> +            }
>  
>              vaddr = load_bias + eppnt->p_vaddr;
>              vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
> 


