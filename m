Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22832C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B44207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRhpyv3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B44207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxT8-0002oN-2C
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdxS7-00017Z-EO
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:54:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdxS6-0007nn-Cm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590591281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEeSe1IRBQZQTY6sUBsPJ4KCOPChUURqmIR/pMWuNyA=;
 b=YRhpyv3desd4DVSob51BuZRPBVCqumF+2hTYCMafsR4Ci0DzV0SgKZGKOLP4qPGKtdEUpK
 jRvkP3xLj81FqV1ZyhGxZzobW0XO/1nmcgZLohT1cHmMFKoNvsFukh2zjj0tVOU/GBpoTB
 L1SVsRHXl/kLv7o/RHKclAiND+WoBcU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-xwDPXHVbPZmxBwn3B1EBfQ-1; Wed, 27 May 2020 10:54:40 -0400
X-MC-Unique: xwDPXHVbPZmxBwn3B1EBfQ-1
Received: by mail-ed1-f70.google.com with SMTP id m7so10228581edr.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lEeSe1IRBQZQTY6sUBsPJ4KCOPChUURqmIR/pMWuNyA=;
 b=Zv2BnbX6KffvrTaRZqS2D24iuEPvxwOcZN6zu76jL0P4Otd5EeWOawiyr+FAqLS8ln
 t7ARitiaZKKbrYOvcoCrl3mEbdSA1ifh4npfn3bX8QARxtvceQZmV6aCr0AKDG0L4sMo
 59Km/dcVMvHsrOk4MvLYt+wS8Z473hJiVFYtDHBglw/gRqc/X2D4y8HPeOOegIrklE3K
 Sa0HRwmJ7D4hr/y4rRbGuIXhUv3IlH2eUrFewPBiaIwf0ngt1BIx9VoREnKWg3jXFUjY
 5xQBURwZ0T4vuZQaUIF26dEns2nd2DXktxTXwAv/WB2kxdg4eR+GhKD/azookechGLNG
 F1lw==
X-Gm-Message-State: AOAM530lePeno5gz91/AuGnUMDsobjVEb4tFwUmti66oPSy7apBTM/jx
 GS9dQZ+LbN2bAYhOCONZo3eveZ63uFHwFz9tn0OoXJwSA6QLe9S0aHQoIfp0udziRiZ21fEvyvN
 ioSYN8gw6a0JWBcc=
X-Received: by 2002:a17:906:bce6:: with SMTP id
 op6mr6320880ejb.337.1590591279023; 
 Wed, 27 May 2020 07:54:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdhbrUmxczGQ/ob5QYR1T3Va4IS8PRMMQpuS4lQtRgJ1iKJdUQCgy1dGVQzKwtdebmkvwnsg==
X-Received: by 2002:a17:906:bce6:: with SMTP id
 op6mr6320854ejb.337.1590591278625; 
 Wed, 27 May 2020 07:54:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id f4sm3124661ejk.17.2020.05.27.07.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 07:54:38 -0700 (PDT)
Subject: Re: [PATCH v3 14/22] microvm: use 2G split unconditionally
To: Igor Mammedov <imammedo@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-15-kraxel@redhat.com>
 <20200521112921.641f12bb@redhat.com>
 <20200525114508.hhvyzjiqja6knz6l@sirius.home.kraxel.org>
 <20200525183615.5f8e67d3@redhat.com>
 <20200526044839.bncj6iltugnzgfmy@sirius.home.kraxel.org>
 <20200527142545.32e91049@redhat.com>
 <58ced517-1ad4-c895-afe6-fec690791f4f@redhat.com>
 <20200527162646.694b2d47@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdeb8406-eb41-160e-817a-010241ccd457@redhat.com>
Date: Wed, 27 May 2020 16:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200527162646.694b2d47@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/20 16:26, Igor Mammedov wrote:
> On Wed, 27 May 2020 15:06:28 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 27/05/20 14:25, Igor Mammedov wrote:
>>>>   (2) we loose a gigabyte page.  
>>>           I'm not sure waht exactly we loose in this case.
>>>           Lets assume we allocating guest 5G of continuous RAM using 1G huge pages,
>>>           in this case I'd think that on host side MMIO overlay won't affect RAM blob
>>>           on guest side pagetables will be fragmented due to MMIO holes, but guest still
>>>           could use huge pages smaller ones in fragmented area and 1G where there is no fragmentation.  
>>
>> Access to the 3G-4G area would not be able to use 1G EPT pages.
> Could it use 2Mb pages instead of 1Gb?

Yes, probably a mix of 2 MiB pages and 4 KiB pages around the memslot
splits.

> Do we really care about 1 gigabyte huge page in microvm intended usecase?
> (fast starting VMs for microservices like FaaS, which unlikely would use much memory to begin with)

I honestly don't think it's measurable, but at least in theory we care
because such workloads could have more TLB misses (relative to the
execution time) than long-lasting VMs.

Paolo


