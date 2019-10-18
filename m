Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DDDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgXW5aJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXfq-0007Wi-KR
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXf3-00073p-OW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXf2-0004eK-QH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:11:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXf2-0004dr-IH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:11:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id c3so3302187plo.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IE1+1RgUCn6hXD/ZCIKmfLspJdChThFeQk25+Nba6HQ=;
 b=RgXW5aJIhNOr/bWKxnwZ71bxXQ+opYd/OVlUOCTLRGNRmSziJPNS0EgH1sBlPp9mpL
 OSAALGQq6jnuN7LRvTHBVRfkbsr6FEDGB6Nhq4RIAm/7v+BMXVp65Uwyl/lSauLSXbT+
 OaDvbxC6dGA58q892vl21nyje3h2rz/PnErwwExLTfJz9NUDIDCfdWiQE6tTSvRwzHdA
 YL2MqZpxK/N1dpXQRqrC3ZivSV9iki00xBgpG45/hlp6FbesM5gem+CxM9f4bOk5oUgo
 WKWwR5GVbywsOVQoP/bgf1kb7xsXtI6Gs/css/JzQ8xK3tSUlqigXjPRw4UW2iDH3u2D
 qhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IE1+1RgUCn6hXD/ZCIKmfLspJdChThFeQk25+Nba6HQ=;
 b=sDQHrHS+xrzWG0CG4uTHMi6QMmVLZ2gQOXF5LZ8Qd6ARCDkjpQv4R0OzLmrxzkOFFw
 qPC9+JWsk6hSlMEoRLrB3iAYaajya2VHatfhI0L3V6iBSFE0fLjGtu7pW1OGqJyTkDqr
 BlmO++bEViWowbm+oQMYb/BsOkjae7w/zIGUBKwzOAczV8D+V8gb9JNa3wGVlLuvY9FP
 Nu6bj2jr/DqruWcZdBiZNBO7uSpiwoum9IpV8MLfTiBuS6c9cLZquDTGkMkzM1vpcYnk
 1y/b0X+ywvmukSQX7QnK6qyU37pmGu3W9RvXZHfDMVOFyE9ZktN9UJZw5gNgCjCd97zJ
 Gcfw==
X-Gm-Message-State: APjAAAWR3hqIfbeF0ZqRLaDDc7Px4WISblf9jbOv8+yOiLwfkRM0+2fl
 8Boz2/IpHU1I+feMxbqiAGS9Pg==
X-Google-Smtp-Source: APXvYqy1FlC8werNPHLA7mKDiNVRvCL+MFvTlv/LbhUdcoizNcjCC5PjrB2WdQ2rwjgf9ZipcAPkvQ==
X-Received: by 2002:a17:902:8c96:: with SMTP id
 t22mr11296471plo.290.1571425899178; 
 Fri, 18 Oct 2019 12:11:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t125sm8517733pfc.80.2019.10.18.12.11.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 12:11:38 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW
 INDICATION
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <20ec7d6d-455b-2e6f-43fb-75884f580d34@linaro.org>
Date: Fri, 18 Oct 2019 12:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161044.6983-6-david@redhat.com>
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 9:10 AM, David Hildenbrand wrote:
> Testing this, there seems to be something messed up. We are dealing with
> unsigned numbers. "Each operand is treated as an unsigned binary integer."
> Let's just implement as written in the PoP:
> 
> "A subtraction is performed by adding the contents of
>  the second operand with the bitwise complement of
>  the third operand along with a borrow indication from
>  the rightmost bit position of the fourth operand and
>  the result is placed in the first operand."
> 
> Fixes: 48390a7c2716 ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW INDICATION")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate_vx.inc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


