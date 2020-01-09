Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F052C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D8620678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcS701Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D8620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipTh5-0008WO-H9
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipTgD-00084b-N6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipTgC-0006oy-HC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:00:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipTgC-0006lD-AC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578560435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8Zijw7yY/sZS4jkAJGdrX4s/upl9nNFQ8ow3cB4P6Y=;
 b=XcS701PnZekDywM0IBza5j8S8L3Z/OHuahXSAavZcOcJIYR1d2mgamnYPacbxSlMsmbtVq
 nig3a+8GJxbp8GC/lNhx2G8AfgLqAHzRYZZ+OnohpTz7JY3oYsjXWjUWpoCKsqLd+LMT4j
 Bmuun5AHr5Mu4fK+AZzgcMfwMsS3uX0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-aGt0q9lVPhKnGGpcDQQ_Fw-1; Thu, 09 Jan 2020 04:00:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so2625223wrh.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 01:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a8Zijw7yY/sZS4jkAJGdrX4s/upl9nNFQ8ow3cB4P6Y=;
 b=jX5zE/6pFmleLM2lt4Q3YK6ItBeO4xV4n3te0GLOYoyjnzYK875zmdFTssu0JntKWj
 2JzANEUaDvXcxBE4nqnbR+SDBYr38F7KGfEYx/fGhoN7vrosF3uo2CcR6U9UcWE/zPUW
 San0z0+pRhpaH02X78tqiJ4RklEihJ0lp4027Or5clTAvGbL3+RzF3c70mQ3yGCNT5Sl
 t63Y3DKQHmmmY5vBlV53mTmPvOb8hyj/21gFBkbvrZNcrZWwNQpH9GwmZ9Tb2KEty1xC
 GwxV5OzI9+mVuzcJjJhMBqbP1Xp2NSd+6EpmDvvOhUSYZxmnDT9BePMYkbS0Weccub4z
 uGSA==
X-Gm-Message-State: APjAAAXjRusBTzJOCyrT5Shkv9kHyfngauac17uUbT4D6FV0+14J0DND
 4vkyN/zyYB5w9GJBkDBsgtkdw+z2TvEx1G/c8zUlXQGefahI+aLKuN8e+OPr0SRrGWcNMbMzTYC
 2EBWuCL9q+5WwksI=
X-Received: by 2002:adf:e78b:: with SMTP id n11mr9661662wrm.10.1578560430626; 
 Thu, 09 Jan 2020 01:00:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBBulcrLk2XHobbDNUmPFyd3LJ2T6Knca8qqMvZJ3yzIuvppiBpVToK7nvWiuW3xJ+Seln1g==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr9661629wrm.10.1578560430303; 
 Thu, 09 Jan 2020 01:00:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id o7sm2064000wmh.11.2020.01.09.01.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 01:00:29 -0800 (PST)
Subject: Re: [PATCH 0/4] vl: Fixes for cleanups to -accel
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109021710.1219-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <485e5c2c-cdf1-0a2f-aefa-8bbcd860c351@redhat.com>
Date: Thu, 9 Jan 2020 10:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109021710.1219-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: aGt0q9lVPhKnGGpcDQQ_Fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 09/01/20 03:17, Richard Henderson wrote:
> Running qemu-system-foo with no options should not generate
> a warning for "invalid accelerator bar".
> 
> Also, fix some mistakes made while moving the code from accel/accel.c.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>   vl: Remove unused variable in configure_accelerators
>   vl: Free accel_list in configure_accelerators
>   vl: Remove useless test in configure_accelerators
>   vl: Only choose enabled accelerators in configure_accelerators
> 
>  vl.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I've queued it, but feel free to beat me to sending a pull request.

Paolo


