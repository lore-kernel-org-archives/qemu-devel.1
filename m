Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B02C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7E3206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1kxfLDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7E3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZpRK-0004g1-VO
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpQl-0004CO-Ng
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:32:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpQk-000110-UC
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:32:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id h17so5748174wrc.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mjv0baDWgjqOcCjt+uB1JBccHb6zHIVjpH3BzamjgIU=;
 b=K1kxfLDCHNU0YxfRdJTzF8Ezlbnn5Jb/6wLpH5hk3tGN0DO1GgfbEl7J5d0EjK9rJZ
 lD6cODdPcUEtEYDQLYZ9ALFLJyeh+oSJfqbyjXhKpkN+9WiwO/VjyOlhdUOxjXk07jvH
 5LFgYRHhra9KsYpVaQstAkkPEhNUbnoSSD2cnKYAPadNCeaAVQPyXTu4aPR+3oSXLf0k
 C7q+WFj9LrXMTNzElHmrJ12dsdv6R/Z9r5xbz8hbARdKGu5SyaXXZJJHngjrVMY/VxLM
 zonSH3922bDNPC2woByDkA4BPhw063IV4tkvspxDWcDUHAlnbKKqWrT6LRm3KtcDSnLv
 gFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mjv0baDWgjqOcCjt+uB1JBccHb6zHIVjpH3BzamjgIU=;
 b=g6L4hvdRvSsGsijGkyRzgE6Dg3JLrK1mjG8Cbjeb+gohR42Sfkq5zWGfxWO/BDUSv4
 9P6scZ4LnlLhWhYsqSJnOCsVCGquekuBDgwOQNqIpJ6UVqjHSI5OPEj64AI0W8pxKUAx
 Md7qkjZ9tRZqim7nZsldGJGj9OimsOJj4Rib9R6aycErd9KwkNtzzAD6YzblqxHSbw+p
 JvgdCKKTtc3j8YrBOVG6o0DBHhX9ks1a1nCjBZytESd3IVUahi+Ma+EprWL5FRASweIH
 3dK5s+7859Ep1LhV/S/ppIpZ2RrYAEd3Y6HgFZQ0e33cP5YzhpDn9bH+GWTAwfh5ZBQ6
 BzUA==
X-Gm-Message-State: AOAM533tMba7KQLvtWJ44peAFceyIb0brDxbrR2VFA6HBjwa1WLOPd2m
 Kvc/tFxHMbYm3UeB3vJ7kUA=
X-Google-Smtp-Source: ABdhPJzTRfU2PQLt/qcGAIz56Ydlw7U5fvEk8n2oX5UlY4qIX/Yy+gxWSW3S2pCK6SBCGxmLXnBYkw==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr7966348wrw.295.1589607133605; 
 Fri, 15 May 2020 22:32:13 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c80sm6706157wme.15.2020.05.15.22.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 22:32:12 -0700 (PDT)
Subject: Re: [PATCH 05/10] softfloat: Name compare relation enum
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <debf80c9-318f-ad10-f86f-709610a0e2a2@amsat.org>
Date: Sat, 16 May 2020 07:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515190153.6017-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 9:01 PM, Richard Henderson wrote:
> Give the previously unnamed enum a typedef name.  Use it in the
> prototypes of compare functions.  Use it to hold the results
> of the compare functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h         | 25 +++++++++++----------
>   target/i386/ops_sse.h           |  8 +++----
>   fpu/softfloat.c                 | 40 ++++++++++++++++++---------------
>   target/arm/vfp_helper.c         |  2 +-
>   target/hppa/op_helper.c         |  7 +++---
>   target/i386/fpu_helper.c        |  8 +++----
>   target/openrisc/fpu_helper.c    |  4 ++--
>   target/ppc/int_helper.c         | 13 ++++++-----
>   target/s390x/fpu_helper.c       | 22 +++++++++---------
>   target/sparc/fop_helper.c       |  4 ++--
>   target/unicore32/ucf64_helper.c |  6 ++---
>   target/xtensa/fpu_helper.c      |  6 ++---
>   12 files changed, 75 insertions(+), 70 deletions(-)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ca75f764aa..7f84235122 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -85,12 +85,13 @@ this code that are retained.
>   /*----------------------------------------------------------------------------
>   | Software IEC/IEEE floating-point ordering relations
>   *----------------------------------------------------------------------------*/
> -enum {
> +
> +typedef enum {
>       float_relation_less      = -1,
>       float_relation_equal     =  0,
>       float_relation_greater   =  1,
>       float_relation_unordered =  2
> -};
> +} FloatRelation;
[...]

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

