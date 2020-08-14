Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF24C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3095E20829
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYwBfwhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3095E20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dI9-0003jZ-Fc
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dHY-0003BB-L9
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:14:20 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dHW-0006T8-2h
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:14:20 -0400
Received: by mail-pg1-x543.google.com with SMTP id t6so4842506pgq.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W/wUZOH5ocCYaxtdFeNeV+AHNSModoUQ1LO31NfMKFA=;
 b=cYwBfwhesFb/1funJnrCKQpm2JzwMCpjBJutJMgWpppjzezWedLfIZhK4bC9YrWvia
 4NScMwAoJSgFLrx77fQKND69g75BXoAXffyqpPAbUYpm5+Zg2xej8uqrF62ksyhT0g47
 dPvJ3dwcJj/UaD6SBISj/c89JSNqO9iwhSDDb5JJ8DLq01l2+JAc/PKh0gPI5LR9dYxj
 zHY6HZhqzV04JrJ4VAoArgS/6wyMWWGjonLqAr/B1ladfuH8Tyr2cEzlWnujfXrCLt43
 CVAjtC2gpmZUriUE+mrgTOfpSVS9SIx3xqiSDqFNDJXX0pshvdt1gEPQhyFfkNwOauee
 hiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W/wUZOH5ocCYaxtdFeNeV+AHNSModoUQ1LO31NfMKFA=;
 b=uSmgHeySg6fiGkdOYPWg42074eybZjgvFCDwqsvtbHJ1iqH/+HEHrait4j/duaFNWF
 tDOkaVtCnzf4Ng6URCMIA81f5JpsPIQwXurhuWvS89rGowr7EJzfafhi2ALDIE1R0cuz
 NLQtkB0mV21Hju8udIchqVwxgdAtvGlPiqCcv0OXwUAdknPLw6YMPJvsGvTjJkDGRNHx
 qqwhLisJTINTCBSSjujzlJRi7NoraPhg7yYleGpNI7rWMIx3qZ20Mb/yYXPDD7IwU/Xz
 RujLxSJOkA0QiVEWaNINs/Es2TZTyz2It4kw3/BK4I1MYUsxVUVgHhVKszGNi6RvNoDS
 tD+g==
X-Gm-Message-State: AOAM531WKVMFDCa4kFzf+TtICXOSzsoS0OrBVjPC5J4k8Rcr8ZjG1VTf
 k4SRkW4HFXDtUPKBQr90k40qNg==
X-Google-Smtp-Source: ABdhPJxk/ZxTXQq5EfQH/JWVl0IFoPFeJw389xqj9Jc9qAjrPGVU+9+ju+w5+Qqm8CJ4s+7o8uNVtw==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr2300825pgn.273.1597425256591; 
 Fri, 14 Aug 2020 10:14:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t69sm8901617pgd.66.2020.08.14.10.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:14:15 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/musicpal: Use AddressSpace for DMA transfers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814125533.4047-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b20c1d3c-8ddd-4e77-9fb1-8e52badad5b2@linaro.org>
Date: Fri, 14 Aug 2020 10:14:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814125533.4047-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 5:55 AM, Philippe Mathieu-Daudé wrote:
> Allow the device to execute the DMA transfers in a different
> AddressSpace.
> 
> We keep using the system_memory address space, but via the
> proper dma_memory_access() API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/musicpal.c | 45 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


