Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06AB206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zN27r7lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06AB206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJQT-0003EX-4J
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJJPF-0001kR-UU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJJPD-0001F0-MS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:06:25 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJJPD-0001Da-HT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:06:23 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ng8so1263218pjb.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Sy++P87sbZEppNqxvVyVv9hQ+AuUFKZHo9Yat8XC9E0=;
 b=zN27r7lPfXuz7h4VK5GMvUSXyDl78V+oOkr8WLaZx8nvQFe0nq9DT1u3+VyjZq1zPx
 qk2pSM5qluSenikvBg1oRs/NTKgyb6uuPurHWovkvg35mMA46LHgn7ZCDbs9is2VPiun
 KdHOTxNGyT51CslW8O1uMIxIrLhAqJOXknnvIfGxCQuxQvfennnzXbgjhdXlt58KIDXk
 oVMrh0WZZFedkq7V583ZGFCKTv/M1m5XBs43vi7eFzfY5ROAT0/ROFhIg0nRusxE1jBj
 QGrATZRVMVrJ8x+zH5TefIK+pQXrrG5kTEntGiM4aJKGMsfEy62vERmqtZpJ6GmwUgu1
 Q4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sy++P87sbZEppNqxvVyVv9hQ+AuUFKZHo9Yat8XC9E0=;
 b=ph7Q9bZ0hZUd4+CjNkh/o1gjDiAZYCiyhlTGA27YXUsHna9R6BrQQaWUblukjr08WU
 gcCwguDfC4N4H887UcsfVZdMiIpYTdQQLnnxewFVszpNLwR9+UnDUOzf67zI438IevpG
 uDf2cJy/LXoaj6K5TeZUEgaHzhAyponRE5jSmEgqkr8t8WKygl2fT8zqt3OOCwvE9uSy
 mdsQrDAvT8ps/HicythMfhHU8YfoCeiNUm7kraGhOMedsW1hRZ8z6vC25P1LkZtlXNj8
 2+KRKPcF/RGm3BESQWcSsiLe8hl5jdVR8+GGHtwAn00/pCAAhiOoxJT8SegIqJcDv5hf
 6FYA==
X-Gm-Message-State: ANhLgQ2nilYl9QL6ciR9rqLoMnreR/CrgYClWApPYE8Q7e744WzQYuzN
 9YvziHfgv2c2Uzq37qX/GgbdmLoT/SA=
X-Google-Smtp-Source: ADFU+vuk4QWVqp62zm/aMEyNYtsQnIC1pA9SAmW3h+uVjUw4dJjpiu/UfciFYJDd2FkJuYaFtr/tKw==
X-Received: by 2002:a17:902:8e84:: with SMTP id
 bg4mr17617473plb.11.1585670780884; 
 Tue, 31 Mar 2020 09:06:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e204sm12773621pfh.199.2020.03.31.09.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:06:20 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Remove obsolete TODO note from
 get_phys_addr_lpae()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200331143407.3186-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c8317b5-68ca-c8b9-c6d7-917dc9bca526@linaro.org>
Date: Tue, 31 Mar 2020 09:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331143407.3186-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

On 3/31/20 7:34 AM, Peter Maydell wrote:
> An old comment in get_phys_addr_lpae() claims that the code does not
> support the different format TCR for VTCR_EL2.  This used to be true
> but it is not true now (in particular the aa64_va_parameters() and
> aa32_va_parameters() functions correctly handle the different
> register format by checking whether the mmu_idx is Stage2).
> Remove the out of date parts of the comment.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Randomly noticed this out of date comment while I was stepping
> through the code this afternoon...
> 
>  target/arm/helper.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

