Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17F1207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBmK87xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17F1207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxAS-0005hq-Qz
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdx9V-0004zp-8W
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:35:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdx9T-0002dR-Kv
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590590126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKxoEE+BG3qxOUVv0Ue8Hx9aOtDaoNDq/wWxBr5SYyw=;
 b=eBmK87xXdR9DZ3/XZbc+uKL7bxaxItC5SYdHUYUc4LSQYjvjEK2O2YnyP9rk+FK6QjLCTb
 4vO9Va1wGe8ZVwp4EWCgj1SNc+ShgYERs2K+ndNZYE00Vzh6mJyMKji9Zz74TPoblrr1iX
 FiNAjfc6aPpI7ffRQc6J5r2X9Xc4h5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-5SF_7Q6YNbi9btlls8-rvw-1; Wed, 27 May 2020 10:35:22 -0400
X-MC-Unique: 5SF_7Q6YNbi9btlls8-rvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF6A18FE870;
 Wed, 27 May 2020 14:35:21 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9432F1BCBE;
 Wed, 27 May 2020 14:35:10 +0000 (UTC)
Date: Wed, 27 May 2020 16:35:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 14/22] microvm: use 2G split unconditionally
Message-ID: <20200527163507.094f7c0f@redhat.com>
In-Reply-To: <20200527162646.694b2d47@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-15-kraxel@redhat.com>
 <20200521112921.641f12bb@redhat.com>
 <20200525114508.hhvyzjiqja6knz6l@sirius.home.kraxel.org>
 <20200525183615.5f8e67d3@redhat.com>
 <20200526044839.bncj6iltugnzgfmy@sirius.home.kraxel.org>
 <20200527142545.32e91049@redhat.com>
 <58ced517-1ad4-c895-afe6-fec690791f4f@redhat.com>
 <20200527162646.694b2d47@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 27 May 2020 16:26:46 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 27 May 2020 15:06:28 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 27/05/20 14:25, Igor Mammedov wrote:  
> > >>   (2) we loose a gigabyte page.    
> > >           I'm not sure waht exactly we loose in this case.
> > >           Lets assume we allocating guest 5G of continuous RAM using 1G huge pages,
> > >           in this case I'd think that on host side MMIO overlay won't affect RAM blob
> > >           on guest side pagetables will be fragmented due to MMIO holes, but guest still
> > >           could use huge pages smaller ones in fragmented area and 1G where there is no fragmentation.    
> > 
> > Access to the 3G-4G area would not be able to use 1G EPT pages.  
> Could it use 2Mb pages instead of 1Gb?
> Do we really care about 1 gigabyte huge page in microvm intended usecase?
> (fast starting VMs for microservices like FaaS, which unlikely would use much memory to begin with)

my interest in having single memory region, is in possibility of drop in conversion to [nv|pc-dimm] later on
without breaking ABI. (I'm not sure that we actually need it though)


> > But why use 2G split instead of 3G?  There's only very little MMIO and
> > no PCI hole (including no huge MMCONFIG BAR) on microvm.
> > 
> > Paolo
> >   
> 
> 


