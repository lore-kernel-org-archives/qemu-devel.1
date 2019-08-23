Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3CB21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJuQZIAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3CB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BbJ-00048O-KT
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BXV-0000aM-B0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BXU-000438-9h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:31:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1BXU-00042r-2B
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:31:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id g2so6698516pfq.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D1hoeKpjEE5G3Z5g8ax0q8e/gDb4rKpZOFQX89CV7rU=;
 b=OJuQZIAW//kCVG+tnriqUQjANWLgvuRAflywjhOrCEVVsUcuGpzKXnZ/N9CO7otWBr
 0VWU+M9siTmFX61N8cGFX20dekkZPmW12HQ1ABj2gcUTG8IpZT3Jjpc2pxhfKMGqBvM7
 pD77GMjnVB5B3dmnWD7e/tF22a8nRQ/ZZLd8OHfOST1h5Jz0pnFss8Lu8rcg5cvvSBuT
 2R7+Pk46rDt2fzhAOw1yxaU/UXJ1SCBUGfy3KRaC5HSYmZYdR7bhKLcDAyfjp/nevDqw
 ZgepJFeQvUJBtTAmN77bl03DupvXcI15I4HSZX77X/o9GIj6If9uHcQxBjbwEot/5jT9
 BQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D1hoeKpjEE5G3Z5g8ax0q8e/gDb4rKpZOFQX89CV7rU=;
 b=TEx6F2oXynqw1g+32rW7dG/p7ntIoZe8bwuvkHalq5iPvO/XUUFf18C/c6zaxiBtyy
 TtpH3GmsG0rZpCkJqZsyGRzpKIWqyA19Pku6ktH8lanw2xakhXCF5J1NkHCea4zuFav2
 coXqULeiuZJ7GSz6N7zxtHOK4N5SZpb9dG7MsOcdRzXAx9Gq5m+u7THgr4w8GppBW63/
 QlupJFG8EpvChXFDT9xqKNKRaZWW31+X9qNkVFRABkO2c5MJsDwqwIkYb1lwyDR35UTe
 /H7LeIZ4L66ggnG60VabM+pTOt0UGMijs35i6BdWHZhbS0UnI4pIfPP5eQ4CY2mFIWGH
 RdXA==
X-Gm-Message-State: APjAAAWxuri/doA6IxEiwaddTeblFZ+oA0Hoht5oJlcvnbHKkCSukGtI
 aq2P13v8X5eNX8l/aOhSVQTN6g==
X-Google-Smtp-Source: APXvYqyIL97WUR3XZad1OQ0h8KKGMbOLpPHNfKp5c8xi3JkFTf5hsjOLsYHBIvEJ4dzpDey6qVgEvA==
X-Received: by 2002:aa7:9591:: with SMTP id z17mr5979137pfj.215.1566574303177; 
 Fri, 23 Aug 2019 08:31:43 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e66sm5651135pfe.142.2019.08.23.08.31.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:31:42 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <98727e9f-7e20-52b1-25e6-96750ba068ea@linaro.org>
Date: Fri, 23 Aug 2019 08:31:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 6/9] hppa/tcg: Call probe_write() also
 for CONFIG_USER_ONLY
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> We now have a variant for CONFIG_USER_ONLY as well.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/hppa/op_helper.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


