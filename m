Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBEC2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfVySvsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBEC2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Zhb-0004vQ-K1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 19:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZgC-0003z8-4G
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZgB-0005IM-9q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0ZgB-0005I6-47
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:06:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id gn20so2195202plb.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x2L4yQYt71Xp+X9Mvmur16LsftHq4n5rx4IbKMTVl6k=;
 b=rfVySvsF7SIosGVNHPlDKHXvHia6GNO9ZmcxwpmYFETriCiatPuw4BN7fWiWzOIMu4
 F8tfet0gp9tsXQiOIriaIrIdtPmN6C6uuXb9d8+75p7/99rexUh7XGRiVx9wBH/S2nRo
 LsjaHDEGSZ70n4Rrr+4i7okYbu+K+qE98XPpggnwQCAt9Vw1S8RVCe7zyeulxk5BNJLL
 pU7OVMTLl03sc7O4PCUGq4XqDOWVDkJPc1Xs8DVAfEtBY9HQxdwPY+IGTOr0II7eFTXW
 lSh791QGUN49i8E1g+2fXOzJ5WiLkJjwjxsjbWzBLpQWMxG/Za+q8LbyGqPItvQwmidB
 6iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x2L4yQYt71Xp+X9Mvmur16LsftHq4n5rx4IbKMTVl6k=;
 b=BWTunTYdT41t1EP4IyljTGSsuYFmiPKDNeVyZJWfHc/dIa+qkLJNp2xIBiqc2tLxr5
 AwIGSNZapHzwPGJywT0kvQbCu3VQPLPsEElqjG6lKVuERu6f4ERI2dYMq4z6M2TcoXhm
 Gl38NWrlUUXbgJTIV9oFHKO9Nkdg5BCWB66gAtNMZMQvt/Fyw4b0Uhd60TVb0jIiJy2O
 QIVIBgOpxPkAiHX4Tr5qrHiW7tOLhPKFP/e12O7oT272THgFXsilP9irvhyKBYBTs8w3
 QZOynCjXhq6WZ/wKGgFskRZBn+uMuGNoAFB6i9j5sCYH6uk4zEpcbAMILRaPlnCnStGZ
 dCaQ==
X-Gm-Message-State: APjAAAUyrhs2jbw2E4tlNzlJCtEFOtO7EtgnbtaU+6BQ3fnIcQTpsmH/
 nXhSG2k/w7/Te+YRrxpG54OspZX0COw=
X-Google-Smtp-Source: APXvYqyVEXF2jE4Dq1gOwF4XzGmSsrXEI/Bf0gG5EJ00q+vfkg5zRF9J7tg2hL1X33AufxJkryMPsA==
X-Received: by 2002:a17:902:ab96:: with SMTP id
 f22mr37187531plr.147.1566428769895; 
 Wed, 21 Aug 2019 16:06:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b126sm12603938pfb.110.2019.08.21.16.06.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 16:06:09 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
 <20190821122315.18015-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6966aefd-1045-b545-1db7-fbf253215da9@linaro.org>
Date: Wed, 21 Aug 2019 16:06:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821122315.18015-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/tricore: Use translate_loop
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 5:23 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>     - save hflags in tricore_tr_init_disas_context()
> 
>  target/tricore/translate.c | 118 +++++++++++++++++++++++--------------
>  1 file changed, 74 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

