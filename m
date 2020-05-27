Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34290C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F165C207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbIFw1JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F165C207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdv8x-0000VT-7m
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdv8H-000807-9V
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:26:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdv8F-00040B-8b
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590582361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btXZKAxoSKRP8KXwveqzXH8x2Xy0ZxtWf7TObdqst+M=;
 b=hbIFw1JRPSWHQDGwOru5Hw9LnfiPp366VU2EqsL1K1dgt1460+9wKYKWmRnb9G1AslYClF
 VkEh6Y684ViW5Y6JlEX32HNZM8xM/OUuJMi4YryGQstrbhFL/0Afg+CiqETcFBZOVR9J96
 /QeIORR0C4MbN1+XsiUO0qZXd22mRp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gpwqTzFpOpG96XLjtVxUTw-1; Wed, 27 May 2020 08:26:00 -0400
X-MC-Unique: gpwqTzFpOpG96XLjtVxUTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00464107ACF5;
 Wed, 27 May 2020 12:25:59 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86EFA60C05;
 Wed, 27 May 2020 12:25:47 +0000 (UTC)
Date: Wed, 27 May 2020 14:25:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 14/22] microvm: use 2G split unconditionally
Message-ID: <20200527142545.32e91049@redhat.com>
In-Reply-To: <20200526044839.bncj6iltugnzgfmy@sirius.home.kraxel.org>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-15-kraxel@redhat.com>
 <20200521112921.641f12bb@redhat.com>
 <20200525114508.hhvyzjiqja6knz6l@sirius.home.kraxel.org>
 <20200525183615.5f8e67d3@redhat.com>
 <20200526044839.bncj6iltugnzgfmy@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 06:48:39 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > > Well, I think we can (should) drop max-ram-below-4g too.  There is
> > > no reason to use that with microvm, other that shooting yourself into
> > > the foot (by making mmio overlap with ram).
> > > 
> > > With that being gone too there isn't much logic left ...  
> > 
> > I wonder if we need 2G split for microvm at all?
> > Can we map 1 contiguous big blob from 0 GPA and overlay bios & other x86 TOLUD stuff?  
> 
> I think it would work, but it has some drawbacks:
> 
>   (1) we loose a bit of memory.
          it's probably not a big enough to care about, we do similar ovarlay mapping on pc/q35
          at the beginning of RAM
>   (2) we loose a gigabyte page.
          I'm not sure waht exactly we loose in this case.
          Lets assume we allocating guest 5G of continuous RAM using 1G huge pages,
          in this case I'd think that on host side MMIO overlay won't affect RAM blob
          on guest side pagetables will be fragmented due to MMIO holes, but guest still
          could use huge pages smaller ones in fragmented area and 1G where there is no fragmentation.

>   (3) we wouldn't have guard pages (unused address space) between
>       between ram and mmio space.
           if it's holes' mmio,then do we really need them (access is going to be terminated
           either in always valid RAM or in valid mmio hole)?
> 
> take care,
>   Gerd
> 
> 


