Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357BDC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F3E206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvlpzcIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F3E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOliK-0003ES-JP
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlhE-0002HN-P1; Sat, 03 Oct 2020 13:51:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlhD-0004MG-5q; Sat, 03 Oct 2020 13:51:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so4670950wmi.1;
 Sat, 03 Oct 2020 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bh3lXGz4KMFoW1Duf/q+SyxiwmL7JXHKrBkWEz9YXC0=;
 b=KvlpzcIToroDnQ4t7I6Ag4YmxDCkIQGJDhxaxtsucHe8cwFxaI0c+9V0pRN5G3/vrd
 d2yVl8ANbvm+Nr8RFyV35ZuwJGNqxL7Gtk2LME/tB20Io16aWsG09sr/8Qbb8hT0xYQD
 fCmEuUO3OxWmmIb3P7KcdeHA5SBXlt5a5NPH7OI6jLigRx0845BkQXOoIKBnohenutQK
 KVW8jsLT3tksr3mjZ5YN9fs0EG/mSyL0YmHDpQKYr+4TSmRH2yxsxQx/X/3Xya2Ad2xE
 B+tryErz9x74egIB+1ju412Hanxu/mhWfp1L/OeE55xoXZQHY8ZTtk8ESEEXXhiPr+4u
 1gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bh3lXGz4KMFoW1Duf/q+SyxiwmL7JXHKrBkWEz9YXC0=;
 b=FZLpHy+yewe++WlpHFw0DfWZHYLYvQ04IdyUpzDvFiIj3qzKj7+NJ56dg+16zZTPpH
 UNImVJDrQu7bVIzhktJOAvazAYFohZOK8fmBeVQPQ7iOvW8YD4bR+cjG1sxHK6KInx2j
 NcnZzaQ+fERGX3nvOmBm65Z9CJaP6LWc4Lj325oUcqel2AgOGF3NemE0VOQv9OcT4v7s
 TwNaixpTx25OzAcCrve4K/yiQ9vZRpbXTxFMTmlsS3gBOwSN3nuSQ1fThdeBp2QhMB8R
 8g1jv6ad4yYuUi9HBTBAGZCtFxE/s++bsv89la3oZ1YA3XBvV23pMgUNCsrmvejlKgp3
 n0fw==
X-Gm-Message-State: AOAM533ALognGuSLfBjbHZNdAAOrLtHCA7/gn7wckNhNxa/4cAC6crgD
 Eqc65/Nib9esuAXwcGluDK4=
X-Google-Smtp-Source: ABdhPJzrGxOdGZ6iaX8RbLsJPkWe/QPwD2ad+HW6iAvYgps0mfMekGOqP2zUj3oZljofiTpebjO7NA==
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr149657wmm.138.1601747505384; 
 Sat, 03 Oct 2020 10:51:45 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f5sm5895820wmh.16.2020.10.03.10.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:51:44 -0700 (PDT)
Subject: Re: [PATCH v10 5/8] linux-user/elfload: Adjust iteration over phdr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a3983a6-56a2-9803-1b3c-496af5cd01a8@amsat.org>
Date: Sat, 3 Oct 2020 19:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002215955.254866-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:59 PM, Richard Henderson wrote:
> The second loop uses a loop induction variable, and the first
> does not.  Transform the first to match the second, to simplify
> a following patch moving code between them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/elfload.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 7572a32a30..735ebfa190 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2426,17 +2426,18 @@ static void load_elf_image(const char *image_name, int image_fd,
>      loaddr = -1, hiaddr = 0;
>      info->alignment = 0;
>      for (i = 0; i < ehdr->e_phnum; ++i) {
> -        if (phdr[i].p_type == PT_LOAD) {
> -            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
> +        struct elf_phdr *eppnt = phdr + i;
> +        if (eppnt->p_type == PT_LOAD) {
> +            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
>              if (a < loaddr) {
>                  loaddr = a;
>              }
> -            a = phdr[i].p_vaddr + phdr[i].p_memsz;
> +            a = eppnt->p_vaddr + eppnt->p_memsz;
>              if (a > hiaddr) {
>                  hiaddr = a;
>              }
>              ++info->nsegs;
> -            info->alignment |= phdr[i].p_align;
> +            info->alignment |= eppnt->p_align;
>          }
>      }
>  
> 


