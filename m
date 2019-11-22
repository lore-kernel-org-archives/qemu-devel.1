Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C13CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449D020715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+KWXQx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449D020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4dA-0007oN-6l
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iY4cQ-0007NM-PE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iY4cP-0000Hg-HX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:48:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iY4cP-0000Gy-A2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:48:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id l17so6548425wmh.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C83CqTTXMKHVxF9fBHADOxXrwQhrwdOuulbdHa0xEM0=;
 b=x+KWXQx9lCsyIw13nx2bQGMkKZekgoRL1uPL6UURHQngDKPPpSwF5A1mdDC1ygPeHV
 0UKn+fg0vY5KAn6VM3QdYheOoDfi8Tv8Rc3rxdgHUf824Lv3CRZYAQeJpqFnb3dCwS1E
 HpVajQa+aon87s6PF+2fXt5rY3c6z/5Pq6slOCMSxizPvACg+f0lu3kiY0tAQWK9xR7u
 i/GOkkiVsYWvtgl8WVyZUAa/t6qh2IdO3D84mHT//MSBCClKk9SRrctsgxkdWWgfU1j5
 ZR0WvyxXiBc/0TO8GWuHEmCnNeZAbh+mhuEAzYlh5jmkOGKp0L27wgD5daXNm60YW5tv
 fNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C83CqTTXMKHVxF9fBHADOxXrwQhrwdOuulbdHa0xEM0=;
 b=hl07StW2ArDXSJZ7c3t0vKRahTO2ZnuiiY3axpAWGr4U7JN5q0f1Ov0OQEAe6utTAU
 yTXZ7RsrRCZWrB6yYru2NjLavMkrA6kJNP4PPV2xzg0ZYH+x9ReQFoEXAX4RSf+s/hjM
 3ixlNN87xHyWlJU23/yD/PLwlqMPdYlxean6j6Xi1TSWLpPJnIK7tV37WKd1cBaEEfVk
 7wmtTll4T4dVBfldA06LUBUwcvXBMs1b9v3yL5eZzFrs+bW34Tac/4vasOHcAnGqmhuy
 /xDO/7Plp5VLjKiIl+HMDuFtQX+x450MeyBx1wqCTtJH28B/bN/gBJmIVxXP2aLXVDy/
 NBOg==
X-Gm-Message-State: APjAAAXjWO9r+jeZSC5tsn6O1nYpnx8RfZBulT9Wkj4N9iYfYSudjz1U
 /50W+lJjJJ93NyE1As8KPgk1Vw==
X-Google-Smtp-Source: APXvYqxRBn4AeFNTuZE/2M6a2FYrqu4hUAQ3XbbxBmWZb+BLLQrGrRHBafcKRnwSBEcA23qRT4teCw==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr15285356wmc.76.1574412523239; 
 Fri, 22 Nov 2019 00:48:43 -0800 (PST)
Received: from ?IPv6:2a00:23c5:4e1b:3700:8d83:30a1:2751:30ec?
 ([2a00:23c5:4e1b:3700:8d83:30a1:2751:30ec])
 by smtp.gmail.com with ESMTPSA id o189sm2829003wmo.23.2019.11.22.00.48.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 00:48:42 -0800 (PST)
Subject: Re: [PATCH v3 1/4] tcg: cputlb: Add probe_read
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20191121000843.24844-1-beata.michalska@linaro.org>
 <20191121000843.24844-2-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1536641d-9291-edd8-e04d-a457f5e50ced@linaro.org>
Date: Fri, 22 Nov 2019 08:16:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121000843.24844-2-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 1:08 AM, Beata Michalska wrote:
> Add probe_read alongside the write probing equivalent.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/exec/exec-all.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

