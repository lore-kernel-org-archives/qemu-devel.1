Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C90206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7qhX4C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C90206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiOX-00058J-TX
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiMs-0004DH-Ty; Sat, 17 Oct 2020 05:19:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiMp-0005e4-M5; Sat, 17 Oct 2020 05:19:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so5612301wme.5;
 Sat, 17 Oct 2020 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r0Uh4nD7Tnsyxlo/xUFMZilSIHBibDTIWg9qK93Qy8A=;
 b=f7qhX4C2EFmSv6Tc8MyFVJa04Jus5zLZaMxKYeZdJcP92PlyLjhpBHLZSXLQdvNWSg
 zdDhXxn5MPtx12wc883jw8/JFxIpiYvMYodCn3evMIWZmLBOCP9vip245EZPEOL4PmDM
 FoWO9ibLJbgij1T7inrgB5ZqJ8I6VHC4lJrRIUmMJOIxjTZUU9oKmne2A0pvwTLRp7lD
 lKSB9a19cjT5BUg8QyJ4vb+2+LbFnBAFGxbn6tWzdW+OBZnU/yeEc+Z7TYzr15Ok/sZ6
 lm9D8kCmqS3E/ATcyGiffFU1Ffkd8CSaqBlScI8bdRk7YTf+dQTYwZzeEyzLW9MxKztg
 ctJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r0Uh4nD7Tnsyxlo/xUFMZilSIHBibDTIWg9qK93Qy8A=;
 b=ciBMMo8G/jImNayxHvHr2InWSlvZkhSMpCVFl6BIxpdrAYNlfCdp/m1gjzSTrz/tGX
 jZDJMP0/fnzGKZnFPK8S7iyYRWy794ajOB3klTqKZml4jbXWd0SXGTuCkn5oYzw0GJ+S
 EHv2bAYyK5+liIHI/ZwhEX3/iWI4fk8MdmoMuN4I9mIHALjcHv0EfKJwU3ibNQsHHeCQ
 B5zsF3DTIX98BSTNviIrRKDVa8KQq9IlhR9defoGIW9bgX8nv9f4/4DmMi44YR9OIbk+
 t/WYi6Ydl68MoM5PFQEbukTaBOiz7cmOfNlOVL2r1/aYjvCGjpdtFlqrcXbm49VYcfln
 JHbQ==
X-Gm-Message-State: AOAM531DlGmLdoulM+4Ci+jq+RvOJXwDoysqMLm7Ysktad6DoCWY4DI9
 JZW4LPMSRYH7erUBrU6PYLA=
X-Google-Smtp-Source: ABdhPJxZB/EEp7gS9uxr0wzMDHwhbCV8AWNMnfqxttVVq5ET0Ur1AoLgtib2OZTARW7w+/lmX4DEwA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr7966109wmj.80.1602926349267;
 Sat, 17 Oct 2020 02:19:09 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id q5sm8269236wrs.54.2020.10.17.02.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:19:08 -0700 (PDT)
Subject: Re: [PATCH v11 05/12] linux-user/elfload: Fix coding style in
 load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201016184207.786698-1-richard.henderson@linaro.org>
 <20201016184207.786698-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <99467678-4a1c-3ab4-cc7a-78a97679e4b7@amsat.org>
Date: Sat, 17 Oct 2020 11:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016184207.786698-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:42 PM, Richard Henderson wrote:
> Fixing this now will clarify following patches.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   linux-user/elfload.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 1a3150df7c..290ef70222 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2531,9 +2531,15 @@ static void load_elf_image(const char *image_name, int image_fd,
>               abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
>               int elf_prot = 0;
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
>               vaddr = load_bias + eppnt->p_vaddr;
>               vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
> 


