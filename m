Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E848CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAA72084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVxZvOnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAA72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO7G7-00044z-20
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO7FD-0002Pv-6w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO7FC-0008A8-0j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:35:38 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:46033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO7FB-00089s-RR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:35:37 -0400
Received: by mail-yb1-xb41.google.com with SMTP id q143so1494288ybg.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eoQ5RUlazJH/zK/qRHmEBTFSbyhDTg+agGcmfeRFkC8=;
 b=XVxZvOnMBVDqutq2iLD2scMclcgwS+GPPpw9fqxd+F97bJp3xwg447lRt9+VWWEBD8
 x/JcENsNJyqcneT60Dy1iDPTgHvz8INq8qDAy/BvOKDa1LvlMfUkaWCbRJjuwCXsguL1
 r8deLmyonv6jPZzUows8JX9AZwNP1HFCoHyYIwVyY0aSrOlc650ktk0BLjUotxqu4pr4
 fh86q6JyJa9dToUodY2kMG0m4gDMy1M3td10pHYu2x0F+sz2clVVme7bdnpfn8C4BPpA
 9//LYEnDPTROK8A7NUzkJeO4uLv17WA5a+lxKNsvyj4inJHpPSYM/gfhgw5avu8c0ttW
 rQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eoQ5RUlazJH/zK/qRHmEBTFSbyhDTg+agGcmfeRFkC8=;
 b=C3xguAUtHnAI71zGWHiM5UuMcqGgYxv0PUtKhcs8IVxtyyq46w64vAiXcs9yR/QhX6
 gs/LxNgVx8supHIp/icZaJs7HKayge5RI6vhwIJKs839QyMJv+ebN53noZf5TQ70SITe
 jxvaCNzGtrGzn1yNs+XfCFrQTvvpDlEMMBN4Cw20hl/KsPNbbPbaSzlojQWDdKP2yXiT
 1lOERQy1E33e846TJM8Zp1QppMOc4A1lbzNEtAn8dVsbuOoLzrkPXL2s5zAftSjHf40U
 gq9hBei8x0s22Dni9XE5sCkd7FdmPnNY7AiGKFkKUdqBj9XogSZL0RfKHOVUOIhgs9kO
 MrWQ==
X-Gm-Message-State: APjAAAUFqE277FM5RCsNkdsQIQAHkGPMPI9tFyyH+49GoBz5psFE2yXz
 LELcBbNwuuTkbq+3gY6T9+3CrQ==
X-Google-Smtp-Source: APXvYqyqlm4TxEt6+VP8vdfYeRi/XMG2DrDBArC6jqcz1erkUJnCiyTxKFvBIUkt1G49S3jD4Xlg5Q==
X-Received: by 2002:a25:146:: with SMTP id 67mr5318320ybb.471.1572039336681;
 Fri, 25 Oct 2019 14:35:36 -0700 (PDT)
Received: from [172.20.40.202] ([206.121.8.178])
 by smtp.gmail.com with ESMTPSA id d192sm1289780ywb.3.2019.10.25.14.35.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 14:35:36 -0700 (PDT)
Subject: Re: [PATCH] ptimer: Remove old ptimer_init_with_bh() API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191025142411.17085-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5806249b-df06-80b7-e5c5-810414be8881@linaro.org>
Date: Fri, 25 Oct 2019 17:35:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025142411.17085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 10:24 AM, Peter Maydell wrote:
> Now all the users of ptimers have converted to the transaction-based
> API, we can remove ptimer_init_with_bh() and all the code paths
> that are used only by bottom-half based ptimers, and tidy up the
> documentation comments to consider the transaction-based API the
> only possibility.
> 
> The code changes result from:
>  * s->bh no longer exists
>  * s->callback is now always non-NULL
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/ptimer.h | 45 +++++++++++-----------
>  hw/core/ptimer.c    | 91 ++++++++-------------------------------------
>  2 files changed, 36 insertions(+), 100 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

