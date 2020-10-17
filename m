Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B524C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9D5206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G52KfXnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9D5206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTiPB-0005Zi-PW
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiNS-0004WG-2Q; Sat, 17 Oct 2020 05:19:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiNQ-0005ez-BT; Sat, 17 Oct 2020 05:19:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so6089799wrv.7;
 Sat, 17 Oct 2020 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VTvoe59wzRhzK/TvwlO5dqaQllVgc1n8AcpMP05DVd8=;
 b=G52KfXnwfpKdsw0NzUJoQ6sMFl7a2ytGrxh/PjB2njeVfkJXs6hk6+EoINxv/fGKDI
 IeYF5xvbWMI6PhmNy7EfjePk8pF2aKIqajyXJ/3ymr9X/pXKHKkkTYKii4ZdXNe34Te+
 JcwdZ8/b18bvcR087mMqjPkLe0uZos4eJpTPvMXBuozZCOcIZw1jG4CLeoZD8Kx/SVw2
 fYrlNTwSDqEZhiSC0ZDTRw25cbEIuS/VRHienBTKMfHtz4GSZuComctO86KY00WyiXbB
 eNWEp4XIbn5/Mi8GRzPcZh/WHXaLX1Ag1b7hHkoigVjh12odb3ISItCCmjl7ev6mmmEa
 VQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VTvoe59wzRhzK/TvwlO5dqaQllVgc1n8AcpMP05DVd8=;
 b=nUDmnWqWpDY7Uv7fLxP/wh9E+C4Cj3ZEtYRW3kkSjAaMHHtifI/pvs7md9AjKhwV1k
 tDc98BxC0cb2n4I0zHUx2TKAbXxAfd6dFVgyaO1pefkbisyGgXJ3Hv0coLoAmFPwcf2j
 mokfS8JD9CM4n6jVistK4WQzUUgF7cjKNc6cHnwAuzmjBQB3Xkra+e/DLFB/l9W0mCdI
 7kFe5R3PIhY1Zt6hH91T8JZVbNHSyTqWkOg9g9cazFb6R9ScDlm1/0n4FZiIok/2Vecm
 iTH4jP/ps3wf7HODdeyX7y1rKVUDuQXaOqTLfRMG1BLTIuIZrLWX3bREcDQcs4bTNWfz
 0RSg==
X-Gm-Message-State: AOAM532W3x3Xkidu8FP2ehZBx34fYECqHXv3N2i8sbUFpuW4RFT9WLyY
 cHkyqVQMskzNcB02E/76lhM=
X-Google-Smtp-Source: ABdhPJyX8BKdzK1m4cOlORgkh8fP5ZCS/R+1iJn2QNpVFlWF94RDtveW2phIQGUWMozRI3iva9wmBA==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr9256540wrq.155.1602926385536; 
 Sat, 17 Oct 2020 02:19:45 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p11sm7743195wrm.44.2020.10.17.02.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:19:45 -0700 (PDT)
Subject: Re: [PATCH v11 06/12] linux-user/elfload: Adjust iteration over phdr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201016184207.786698-1-richard.henderson@linaro.org>
 <20201016184207.786698-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3510d5df-b61e-383a-3858-a0e1d486bfdb@amsat.org>
Date: Sat, 17 Oct 2020 11:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016184207.786698-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:42 PM, Richard Henderson wrote:
> The second loop uses a loop induction variable, and the first
> does not.  Transform the first to match the second, to simplify
> a following patch moving code between them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   linux-user/elfload.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 290ef70222..210592aa90 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2426,17 +2426,18 @@ static void load_elf_image(const char *image_name, int image_fd,
>       loaddr = -1, hiaddr = 0;
>       info->alignment = 0;
>       for (i = 0; i < ehdr->e_phnum; ++i) {
> -        if (phdr[i].p_type == PT_LOAD) {
> -            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
> +        struct elf_phdr *eppnt = phdr + i;
> +        if (eppnt->p_type == PT_LOAD) {
> +            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
>               if (a < loaddr) {
>                   loaddr = a;
>               }
> -            a = phdr[i].p_vaddr + phdr[i].p_memsz;
> +            a = eppnt->p_vaddr + eppnt->p_memsz;
>               if (a > hiaddr) {
>                   hiaddr = a;
>               }
>               ++info->nsegs;
> -            info->alignment |= phdr[i].p_align;
> +            info->alignment |= eppnt->p_align;
>           }
>       }
>   
> 


