Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF4DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8ED20850
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etfbaZ58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8ED20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ews-0002ch-1T
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1EfD-0000Wg-KY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1EfC-0002Uh-E1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:51:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:40145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1EfC-0002U8-7Q
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:51:54 -0400
Received: by mail-pg1-x531.google.com with SMTP id w10so6233953pgj.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mCGFjmpL5LYx44Ksk7wLwwmbzaVxCSF5m272QcmvH3Q=;
 b=etfbaZ58dncykYN5jWaW648ZP/E2ZR+7hjMceC7wR2yJf9d1z6xfoOmvI6/4j3YL+v
 5vLdipuN6UBxRyAFzjXeDXLmrb86xc5SUiFjuGkp0/IOkoxOva71Ot5RWKLKSD3QKRLd
 tV8GU/WfZqi1cvUmGb7HMwodys3CHwgD8VNv0hB1905UXWepJiIpEgZjapo76STiJKaK
 O5MX65nN9ErxKeugk8aILOmzN//pCleMT72Z62Or3xY2yM5XKYFxpdJioFhicUsq/UUh
 WkWQeKr5gZxjT657vlRhj4Dubs5pc0bm+XVJX/STPdh/mBseYa4qZ583vz55X25TmF1i
 3ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mCGFjmpL5LYx44Ksk7wLwwmbzaVxCSF5m272QcmvH3Q=;
 b=pJVYH9ETBin7nH17q9MEE+lRJwJbrbkw3buK8k0tLNoXIC2DHGEsWZpm9MLh5iplWC
 gERifvi+Z+YvrNL34H7cV0i1xO8VC31btbnvjVAfEZ+eF/ovGWb55yzgkFcRxhij7bm8
 TX14THGJa2FxZI/ol5SfQ+hg5R5oUjoH3gNLVqeW3jADplQCMNsmdlbB7QFTtzq+gNt0
 82c3Nn+aAgQVFegyq61TWqiWseDjKHnsl1uYxavl0U4R8JKdtM6wk6bTXNJ5/KxwbS+y
 tESielw8Sz5Pm8BIH+sPMRuK/5y5pc7clUhtgigtqg4nspryczMj67HbcwaRU/lFlMhH
 s/Gg==
X-Gm-Message-State: APjAAAUFQ0RFBIh32SHXFU1jV0D/wvJeG9tTPHUrKa2K8xJlY5gqmcMq
 WvdW+69XzSNWy3u9nvVrc0x+GoAnTy4=
X-Google-Smtp-Source: APXvYqw7JztbBbsWr4DTct93QGJ6uvXjIqmY/cx0rg7qAxNN3NFmackY9sAN2hCTEXqlCMIrgmEvyw==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr5385462pgq.101.1566586311726; 
 Fri, 23 Aug 2019 11:51:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a6sm2939565pjv.30.2019.08.23.11.51.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 11:51:50 -0700 (PDT)
To: tony.nguyen@bt.com, tony.nguyen.git@mail.com, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
 <a61e429b-6493-3ad0-cd22-07832dbcc1f7@linaro.org>
 <1566563109661.99467@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fd82e309-c833-e5d7-9384-72205c201254@linaro.org>
Date: Fri, 23 Aug 2019 11:51:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566563109661.99467@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: Re: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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

On 8/23/19 5:25 AM, tony.nguyen@bt.com wrote:
> Frustratingly, I keep getting blocked.

Whee!  They have all arrived and applied correctly.
Thanks for your persistence.

r~

