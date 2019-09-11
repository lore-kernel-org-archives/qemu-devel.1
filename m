Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91270C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B633206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWtjWpgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B633206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84Rm-0001OX-Gq
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8458-0007Vi-Ng
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8456-0002rj-Np
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:54 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8456-0002qb-Ir
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:52 -0400
Received: by mail-qk1-x741.google.com with SMTP id x134so21119567qkb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qeGNq13pRXExtoYrhyXf1yMnJAAINV+hOy8ZWFKRetM=;
 b=VWtjWpgFQSOeDCOljulzUYjJf3lGrg5ygYdqCgb/+0wgbDbhznBJiPiakhP9d9ohEF
 iQlfaM9AfKPfnT4Kf8sc5vz40YKiFBrLk9ai1bjDA2rKgfkUP2AYR7mXABDX3aEpsaQ3
 s4sG6rFQpAshdyGleYxNVHx+AyI3l3qDJuhfS89k4+7TOrPXjdAQ1eapWtByHoBx87dq
 gpIp8lQaemYZ4Nj3lUg6EkQHGP3xZTEh6F3eRRPKwFlUC+xNYkikYF6cxrKbLGMn8cfp
 50KfmIkrXi2BkdkBJRKbJF3LyrKpVBHxwN/HpKebUprEa5qVxTTjM2GHmyfMr4VrODEA
 fbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qeGNq13pRXExtoYrhyXf1yMnJAAINV+hOy8ZWFKRetM=;
 b=gBEES0trYJYFoQWFNGXXkTvrEQJE8BPfx0NgnF3LWdZZHukoVhqFCMVIHeJN4KZwPn
 lHwlvEkKSbd0+xj6y/+/4WnB0RoR1tQWYQUdXV14Tatf2TNL+4UYKMBgq00Jeic6qgcB
 rhrvUcnCrmlXutMEx/sxMDmmwsM/pi8IJYVcGGIjcIpfrg+2+Pnhf0gPGz7X80Yi8UYR
 EjB+gCJT2F7DW0y0OI209iiKBmEHlFLWkfqEoMFfOIeXkaSgRELFtDA6z/+vVi5jZKoS
 5j7XKdGdC7lhhLB4k2TEs9IJZDUmi3lgMARQsEgkrObRe0Z+tx7cCjVAau/Dr3TKBXEE
 q6uQ==
X-Gm-Message-State: APjAAAWaEo0Noyaw90NE8kzRtiaEE5PUDcRIdXdDUQhul4HHy0khq6DD
 XPAX89Jki7blLmnS71ZdYMXkfQ==
X-Google-Smtp-Source: APXvYqyz16hZT1ESV+yPKdDk0TIviSTr1jwMOpVMt/I50A6ZxddM7IFv+DF4E9piiNZP/GFbAeolxw==
X-Received: by 2002:a37:c206:: with SMTP id i6mr6425338qkm.114.1568213929965; 
 Wed, 11 Sep 2019 07:58:49 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id l3sm9091792qtc.33.2019.09.11.07.58.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:58:49 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <27a01bdc-637d-ee1c-904d-af5fc9436825@linaro.org>
Date: Wed, 11 Sep 2019 10:58:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH v2 08/28] s390x/tcg: MVPG: Properly wrap
 the addresses
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We have to mask of any unused bits. While at it, document what exactly is
> missing.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


