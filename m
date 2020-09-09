Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5359EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1FF21D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1HGTfo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1FF21D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4BB-0002d5-M7
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4AD-0001iW-50
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:45:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4AB-0007px-I3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:45:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so3895079wrt.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ma6I72OdaAVJJPCCoXFICzkHdf8jIvcY0nrhoontqGM=;
 b=b1HGTfo/ib2gMJjRJKt9n6TMHSskigJdUrdVch9lXLcDDaQDNNfnXCjTbzc1IaQ0uP
 sbCbp5NcnZMJqCN2td3pHPtbnjpfG8lHsJ27n3eQrwzgYsKRo6ZpcYSVfTx5UPjJe3uj
 vArZYD5yOMk6Zl7SJjrdxlvbLzftxJU7aY0vgrYhSP9u39pvADlA8KLE7S/kfa6vExZf
 hXKay6xoM0j/S+tPO7xQqsCC9JDadgCdJoV1TuqDrfPonj2imyAYBhwBWpCPSrL/pT2o
 +UTu+81AestQMpNQ4Ctdcx4yBbCP+/zuXceQqaQAoVmiF5IDArkYPENQVPninh+rIJxr
 bjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ma6I72OdaAVJJPCCoXFICzkHdf8jIvcY0nrhoontqGM=;
 b=GqT+h7idg5/PS6lDWkY5MXtjBrZSk6ChJeNqGctTmTYUXioH3orUOv3DLD0tV4OIwF
 rhT5EHmXYQO9w2EgK5s6ktJey9XOlg8NJh7GEgVJ6nHCz1pIzg7++Svtw8YRFyXnOm03
 1q7+ePdFD8DLN3UDx8UZm0xVB9uCTlfk+TjnYsFNRkwLLzbueDC13BgxjBcJBF90d41K
 z9ZTK12DmhZ10lB4QJBtmoweEVr7Zv4E2Wk54lVUlcNChOEoULFQkvRKxEx57gyFFPXx
 PlJwlpLQhljLDTIu8pmyNscRYX2USUCzKUwe7y10nutgDWSpN5mxri/psUAu6kYhJwOz
 3XNQ==
X-Gm-Message-State: AOAM532u9zHQWh2V/GkK8mUCj+/V98ubB/rLXHTAzr6biL0aQCFWRxJ0
 tSm4YzI5n1uAc7G+sVw9JbWB2vRvKGY=
X-Google-Smtp-Source: ABdhPJwBwTOE4GzYW3BBcaPRTyxbnNJy7EcrRQZy5VuP9CqOjrJFgKRMGunlElgbS+CA+22LKIXVug==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr5053065wrq.61.1599673541910; 
 Wed, 09 Sep 2020 10:45:41 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c14sm5049798wrv.12.2020.09.09.10.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:45:41 -0700 (PDT)
Subject: Re: [PATCH 06/43] tcg: Remove TCGOpDef.used
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200909001647.532249-1-richard.henderson@linaro.org>
 <20200909001647.532249-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46a9ead4-2a8f-f5b2-f98b-830877ca5f02@amsat.org>
Date: Wed, 9 Sep 2020 19:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909001647.532249-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:16 AM, Richard Henderson wrote:
> The last user of this field disappeared in f69d277ece4.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index e8629b58c8..8804a8c4a2 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -1015,9 +1015,6 @@ typedef struct TCGOpDef {
>      uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
>      uint8_t flags;
>      TCGArgConstraint *args_ct;
> -#if defined(CONFIG_DEBUG_TCG)
> -    int used;
> -#endif
>  } TCGOpDef;
>  
>  extern TCGOpDef tcg_op_defs[];
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


