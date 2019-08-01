Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC4C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F00820644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B40FQv7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F00820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDJj-0007pZ-HH
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htDBV-00042O-VJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htDBV-0005v0-3t
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:40:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htDBU-0005uL-UI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:40:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id c3so11148220pfa.13
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cSh9pTP/TDVQ0uMpDyPRa4uGBYOl9b7YMvnUS06r5SA=;
 b=B40FQv7urwi0m7U0H9H82cBG8g7sTrZmOJuwvBRWeJwsqMuN4raT49ykT549jYAF0T
 E2bTvjJEbJTFbuzfDJz3hCxnq71+5xJHDm3DtSpojseclq0rhJMSx8B1//sOiSSBpbeb
 YtMENCzHCwR826VDPQji6PPPv6mm+jXq+52jzekxbxTbsMDtte+4ZAlVMuqH4AXRyyet
 azGzM5q8dlQ0qtlsaS05oN0vB+J+odZC2VReJtmHJjsvQ7Nh7/fDNH2RJQBnP/4c9u8T
 ZQUodTqEnY3kbTUKygAHeVAJKieKJsFhYVttPUBDwN4ravq7/Ye72x639rWd6bLEt4yW
 kuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cSh9pTP/TDVQ0uMpDyPRa4uGBYOl9b7YMvnUS06r5SA=;
 b=hqKQcwd/v4h1aCUVUCYMJNlA7g0ckJCvCo0pj6Ok8NsF6no+Hbvs9BbfJu1Djr7vMD
 lGkyMPOEQfQTDVqaZXWW931dnRfJ1qH8Ow0vfBoVuTqVjftxbp7mNCAlBoF15CwraLYp
 yZxOrnCsjYBET2g9hb4J5k5VfH8CyrIkzFAPDRpZJZBJ1YHOc4gYGdep+0HkRZlosRAe
 l3OQKBxFaAjosIWvaZWcV9HFVcZG9pzA9Jsz1nIP9ct3mWd6xYTPK8vFK33cvt6acbOH
 lMPOwZVgYYNGQuk1LacYmeJv6UJa0nwWtXcyWIke1ENmuHfz3Y2rZ+H4XHhTSM7+krT4
 LTbw==
X-Gm-Message-State: APjAAAW9iJksm1WWN4xCHkNbrmLEWe2z0ksB5/hRf/SyoAI8mL1hg6Qy
 kz2CaEW15XiLqCzAvkZ4IXz3tg==
X-Google-Smtp-Source: APXvYqzBAwcf3Bu/JlriqY1csoJKsnImpKRxu0t/pbHZe98tkThqasRYetkVMN6+qgA4rA150+VVSg==
X-Received: by 2002:a63:3148:: with SMTP id x69mr32497590pgx.300.1564674002698; 
 Thu, 01 Aug 2019 08:40:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c130sm69379127pfc.184.2019.08.01.08.40.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:40:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <58829f85-11e4-121a-5f9e-3d68306e3c0c@linaro.org>
Date: Thu, 1 Aug 2019 08:39:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 13/54] plugin: add user-facing API
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Add the API first to ease review.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - merge in changes to plugin install/reset/uninstall
>   - split api file
> v4
>   - s/is/it/
>   - more docstrings
>   - remove qemu_plugin_register_vcpu_mem_haddr_cb and related bits
>   - add qemu_plugin_get_hwaddr and related bits
>   - drop vcpu_index from tb_trans_cb_t
> ---
>  include/qemu/qemu-plugin.h | 351 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 351 insertions(+)
>  create mode 100644 include/qemu/qemu-plugin.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


