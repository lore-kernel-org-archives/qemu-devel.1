Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D66C20739
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9/KGeFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D66C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2iP-0006Ea-O3
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2R5-0003m2-LY; Thu, 01 Oct 2020 13:32:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2Qw-00058b-6o; Thu, 01 Oct 2020 13:32:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id 13so254196wmf.0;
 Thu, 01 Oct 2020 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1ZWU0q/wLKZaNlMHILN5QTmn2K6YVpvwa/fqWxRxYp8=;
 b=e9/KGeFQAEGu8p3R5E5c0eGmxHFjkU8QWTNH0xef1eWy0Ev0PNiEQIoPtkOjfwdUxu
 oUiYhd5ItMyGle/Ky23dr6OeH9yYREpZ43hlBu/EIe9DouIGBt0h74qeuFjaOZ+DO8ur
 Ggvw7/EBaaPGBcXYoQ1q/eco2kAbyUpif7pdut6uE8hXbdLrk6Qa5QpIoufH4Fx1Kod/
 kbTIU0TPjD51SQzD3Y8ut5LzgXzQYO7FUpM+2EM38CRx7/HOIYfbRAODPVu9T7Qv8Bre
 7koobqsYerf8GqIz836t9lU4SbHWu6trtsqqVHqeyqJIj5C0D9vtBezrToYh8njLfzvX
 acsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ZWU0q/wLKZaNlMHILN5QTmn2K6YVpvwa/fqWxRxYp8=;
 b=QaKZlSPUgLD4Mf35RzEL0j1nby/Ym7uc0HoxkfdNiRUmHmXNY9ObteE1OeGvoA/lfG
 5AMrGrUl94f4v+G21YL8q4uB5+yRnWAV3VsmjbY0WW9y2zswugu4IaBDN9tAkPzmnj78
 r6Fyh1dmXZQnn6Rnc/PAAN0O7vFh2UMn10/bOjyj2vHTl89f7X+8sVqRQh/cHxtBdRMO
 YdK9DLFwnOM05YLTi3BBHBBvC9ZvQ/UvvY7j4t3t4ho4mZozGKfUcKKY7dL4YCQAoFdE
 QYsefq3o5EAA0zVu4sY6O39/13Z8ifNNVr1PYYGjSQdfVTzP56Q1ZSh4XKm/eBoKsBws
 SAvA==
X-Gm-Message-State: AOAM531aNQsaWM6RXZkwLGo6DO6yVPUqaL7Z3t3WujjP0zFgZ6cMsv8P
 c5ZpY4OXMqrfOyw73ncn3js=
X-Google-Smtp-Source: ABdhPJwOpRqlUMcG/NFssygTEjTE24wYVV4kAgMGepTs6be05lq6ubNAK5MXe1h3gHhwiLKMdUutPA==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr1051196wmk.184.1601573513519; 
 Thu, 01 Oct 2020 10:31:53 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u12sm10158213wrt.81.2020.10.01.10.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:31:52 -0700 (PDT)
Subject: Re: [PATCH v2] hw/block/nand: Decommission the NAND museum
To: qemu-devel@nongnu.org
References: <20200915171639.1355800-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <619d329d-f6b3-1e73-e151-a58e366db15d@amsat.org>
Date: Thu, 1 Oct 2020 19:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915171639.1355800-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.26,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping qemu-block or qemu-arm?

On 9/15/20 7:16 PM, Philippe Mathieu-Daudé wrote:
> This is the QEMU equivalent of this Linux commit (but 7 years later):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7025a43a9da2
> 
>     The MTD subsystem has its own small museum of ancient NANDs
>     in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
>     The museum contains stone age NANDs with 256 bytes pages, as well
>     as iron age NANDs with 512 bytes per page and up to 8MiB page size.
> 
>     It is with great sorrow that I inform you that the museum is being
>     decommissioned. The MTD subsystem is out of budget for Kconfig
>     options and already has too many of them, and there is a general
>     kernel trend to simplify the configuration menu.
> 
>     We remove the stone age exhibits along with closing the museum,
>     but some of the iron age ones are transferred to the regular NAND
>     depot. Namely, only those which have unique device IDs are
>     transferred, and the ones which have conflicting device IDs are
>     removed.
> 
> The machine using this device are:
> - axis-dev88
> - tosa (via tc6393xb_init)
> - spitz based (akita, borzoi, terrier)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Peter, as 4 of the 5 machines are ARM-based, can this go via your tree?
> ---
>  hw/block/nand.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index 5c8112ed5a4..5f01ba2bc44 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -138,7 +138,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
>  # define ADDR_SHIFT		16
>  # include "nand.c"
>  
> -/* Information based on Linux drivers/mtd/nand/nand_ids.c */
> +/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
>  static const struct {
>      int size;
>      int width;
> @@ -154,15 +154,14 @@ static const struct {
>      [0xe8] = { 1,	8,	8, 4, 0 },
>      [0xec] = { 1,	8,	8, 4, 0 },
>      [0xea] = { 2,	8,	8, 4, 0 },
> -    [0xd5] = { 4,	8,	9, 4, 0 },
>      [0xe3] = { 4,	8,	9, 4, 0 },
>      [0xe5] = { 4,	8,	9, 4, 0 },
> -    [0xd6] = { 8,	8,	9, 4, 0 },
>  
> -    [0x39] = { 8,	8,	9, 4, 0 },
> -    [0xe6] = { 8,	8,	9, 4, 0 },
> -    [0x49] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
> -    [0x59] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
> +    [0x6b] = { 4,        8,        9, 4, 0 },
> +    [0xe3] = { 4,        8,        9, 4, 0 },
> +    [0xe5] = { 4,        8,        9, 4, 0 },
> +    [0xd6] = { 8,        8,        9, 4, 0 },
> +    [0xe6] = { 8,        8,        9, 4, 0 },
>  
>      [0x33] = { 16,	8,	9, 5, 0 },
>      [0x73] = { 16,	8,	9, 5, 0 },
> 

