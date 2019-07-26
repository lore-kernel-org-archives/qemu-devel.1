Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A7FC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D378F22CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXpjXxs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D378F22CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0Vl-0002w5-R7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0VV-0001zx-DK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0VU-0007Iu-5p
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0VT-0007Hj-VP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id g2so24561110pfq.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+rE+b7U3Gi0cBQ0TBvpFajlfZCgG2WHm1fCLfIQbXfs=;
 b=sXpjXxs0Tv6bK6ES5gJQqu0UgIaBRfU9QYcBTHzOdjOHX7AQHuMQ27e3d5P+r0Me2p
 LPbD4ATkPqCVSnmKVPNXrqjrvEgw/x5ONFexJZMiFHmu7X6ADB34uhsWUY9Uy/b0a1IV
 PVZKSDDsokQrzh0qx7LxPwfj+Iatp0zg4Pn8Y10KEeNKtUP6Pi2+53JY6/pVr+AhyvCx
 peLeKUY0xn4krgohSE6YqV8e7Eyhg8J71TELlF2Dsa4tMa5cQbws7is8tiHOA6iczLXy
 DJ8ITwVwVaKPmkt5eBUs/y+8IJCH0CraZjmw4sjqslIZBkTWMeQW/qf7oA+tlGTYcSiC
 ZU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+rE+b7U3Gi0cBQ0TBvpFajlfZCgG2WHm1fCLfIQbXfs=;
 b=B3SaFKYCrBCdjTjHlCqGK+dW0QoDWO1DAWwy4PsjVNPYDzaGoMByAklcCpgl7/KTn1
 M2IugRGR6c30KFcnmbzrEO+UbvkQWgBro2PaWClwM4a58lJu+3OVckzDjLcr/D2Q82in
 ENshXCBUeIAPjW2S7EQ3bL2c+snSY5YW/dlvaKyYO+dGAsnsPm3Lq2J5AKxKAAPUa/VD
 62DnyHgRNKiT5yjpqCRS+CfoJBVAWNolmBtz6BAkij6eDZKa+E7pIflrPsIJL45Qn7SW
 BbSVgkO/vvufnMmHjf7HEre5st/LrAZ8bEwNtar3zAFEwcmDR/o1ZeLnmx7prcZ4gZIr
 H80A==
X-Gm-Message-State: APjAAAUOA9TdchXTg9Pl0SSE5kHzKeME2xnLgQScUi59UK32tIlOatX3
 vHU+c99Z/tV+5Zmaai/GPTtXmw==
X-Google-Smtp-Source: APXvYqwtVhbd6jbOZdHtrMpkYpk7ZkBWFU0N4q+4yU5nrFIVIG41a6U38IM2A9IdTecAp0G9KfjnpQ==
X-Received: by 2002:a17:90a:21cc:: with SMTP id
 q70mr101134325pjc.56.1564148614922; 
 Fri, 26 Jul 2019 06:43:34 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i15sm57408791pfd.160.2019.07.26.06.43.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:43:34 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123545422.59810@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <425e4d5b-984d-3b30-9b0b-a7d35516cf62@linaro.org>
Date: Fri, 26 Jul 2019 06:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123545422.59810@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v5 06/15] hw/virtio: Access MemoryRegion
 with MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:45 PM, tony.nguyen@bt.com wrote:
> No-op SIZE_MEMOP macro allows us to later easily convert
> memory_region_dispatch_{read|write} paramter "unsigned size" into a
> size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/virtio/virtio-pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

