Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B34C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83008207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WM38JX29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83008207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwOD-00066k-7S
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDwFH-0004l6-L3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDwFG-00036S-7Z
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:49:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDwFF-00036G-Uv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:49:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id w8so1021425plq.5
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z3gBxANTmMlvSszNb1CLSxf+62Wo8XMMRjW6XvESveo=;
 b=WM38JX29zyRvdZC7r5CpdzTvFO8T9YyjNonNIIqMHpsBWaHgQkooJD+JWHaqh0NssJ
 uYd0+brhvbmVBSbYOiO8ddoSlVQgdrSWPTz927J47+LtFnx5NQmIn/q6LrIFAzHxgq9n
 duB2A6wns2whkDVwlfvxpS9GkUMVxyGh0HzSIRxedlvFoXRcAD5o6myGpbqnYs4ybpkB
 /hBQbNt8fI6lg6TUtWYEJQT2DhbPfrysTbKMiq8pgFHXzxBKOMMCMuANRBX4lDwYRnWX
 a1cr1erY1EMEG/nYdE6Dw3Oqb+Y3Xhdcb16xQGjsqcTyFl1LvSdgMha/uHP3orYlCKaz
 NDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z3gBxANTmMlvSszNb1CLSxf+62Wo8XMMRjW6XvESveo=;
 b=Usu9IIRRBY3HSz7Ps7Zn1iLSc9v5DoA5xIXM4K1fEcbaBeyn6AaUOitz8pLELz6Y5k
 ZvFxb0ruH/B5Wc5UAJWzVKZqi81VVXBROCagzxFZOqzZ20voD5wI1ihP/p79SR0ACyxJ
 mJ3Y7YIHhrlD4l1ojRSg3ow0kvn6Vto3q1Yr336k5iEooZfuHaqrfhVLoyr1j3sLCIEq
 rFfXWmIaOa7Ta9ofestNFLVtqEN2oqJLxWCUCjxdZ9cnLBtjLuAHe8D1pYulJDtmmOOk
 P+5zeAAOpV0ePwNhTI0zTPwxKPEz/wP0lgS8pWqVEPEkyEDbw6gGmdBZ7/9K/ltb4jpr
 AcCg==
X-Gm-Message-State: APjAAAX7tfEi55CFu9DUwb2YhytAW4pcJFTH+g5FPxhrxcLuWyLSMJJc
 TFVtvvxWvrsz0GaQL3T34ebWog==
X-Google-Smtp-Source: APXvYqw8/behoqb8WD6AyiqDEW0r16nRY52k8qbDa91Z+GLlC5S8Yebe7IOHB2ULCJAuPO7Sow2c5g==
X-Received: by 2002:a17:902:5a01:: with SMTP id
 q1mr6651850pli.335.1569613776437; 
 Fri, 27 Sep 2019 12:49:36 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id v15sm3643422pfn.27.2019.09.27.12.49.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 12:49:35 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: use Vsr macros in BCD helpers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <582f9eb2-c61d-84e5-e61d-4be485770bfd@linaro.org>
Date: Fri, 27 Sep 2019 12:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

On 9/26/19 1:44 PM, Mark Cave-Ayland wrote:
> This allows us to remove more endian-specific defines from int_helper.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 72 ++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

