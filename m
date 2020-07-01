Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0D720760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOl92/2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbgB-000833-CJ
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqbfJ-0007Z6-6D
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:16:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqbfG-0006S5-Me
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593605793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEZqRyA1feFr4Gu2xP1Ey2UTnpIIG61cFcXKKIArD/I=;
 b=SOl92/2dEOglEgpqcTFdRmamI0PehGs9o5X4Olq9N1bFKV8tBlroGL1Z1GhqPPvmn8rNoX
 m9vT3kDmtL9PuO+jlVvooBZK574qrrxtAycvfXABM6qCP7IpDuNO5k6roKTGI0+JKZR+FA
 0KDTnrpKDBY3HFS3hv42R72ikOuTUHM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Ms1T3nFqOP2mWPNui8xshA-1; Wed, 01 Jul 2020 08:16:30 -0400
X-MC-Unique: Ms1T3nFqOP2mWPNui8xshA-1
Received: by mail-qk1-f200.google.com with SMTP id 13so5079299qkk.10
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rEZqRyA1feFr4Gu2xP1Ey2UTnpIIG61cFcXKKIArD/I=;
 b=BCP5edclIYJ5mz8VXdtY6Mf0Bm7NvwH8DGkG+FKBw7lfNliNFmMLLI0sa5YG5XgAqX
 kq6g0ojWTYHELlK8c2JZGvSZBj7g61dIX2HBdsjDCXGz3hmFhONkJWiDfkF2peFptn2O
 dBBSo2UzK9p+KzGl3GBeTBbkCnE6Co4oMayL0cuel7teEbgvOGA5V0oiREd+ntEZgeqi
 JwQSSPYHIs7LYBgwy6bMk8U1hkRGFCnx399BXGW+3sAYqKIvNZXvbYIacHHASyFysn8u
 A0Kgcs92MInX92DHgHRr01/fbNHjMneuRDRycCvsu1E8alGtPudySQqt+syUgR7eqexh
 85rA==
X-Gm-Message-State: AOAM532gPqok3kdwZrV6wW8cYAMe74wmbLqtZCerV15C0SXld4a76GUe
 vbjDZn73mZaJH2+FlJOHSJuNa+xBpz79xZIx2sBL3j1dB/TSClQGeB4oYVAH5DWlyIf2Ar+c33D
 LGxex/dV4bUO0OoM=
X-Received: by 2002:a05:620a:79a:: with SMTP id
 26mr18039783qka.169.1593605789846; 
 Wed, 01 Jul 2020 05:16:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8qCpsidGBZzPvV0pBW8BqmYyw1Uyrvb0alDsqxK2C9tpgo5K0k9hNjSthsufsLEPrrkUvuw==
X-Received: by 2002:a05:620a:79a:: with SMTP id
 26mr18039755qka.169.1593605789532; 
 Wed, 01 Jul 2020 05:16:29 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c24sm6182101qtd.82.2020.07.01.05.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:16:28 -0700 (PDT)
Date: Wed, 1 Jul 2020 08:16:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200701121626.GD40675@xz-x1>
References: <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
 <20200630052148-mutt-send-email-mst@kernel.org>
 <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
 <20200630152050.GC3138@xz-x1>
 <d9dd8662-33e3-03fe-f227-f519858534e0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d9dd8662-33e3-03fe-f227-f519858534e0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 04:11:49PM +0800, Jason Wang wrote:
> 
> On 2020/6/30 下午11:20, Peter Xu wrote:
> > On Tue, Jun 30, 2020 at 05:23:31PM +0800, Jason Wang wrote:
> > > > > Ok, we had a dedicated mr for interrupt:
> > > > > 
> > > > > memory_region_add_subregion_overlap(MEMORY_REGION(&vtd_dev_as->iommu),
> > > > > VTD_INTERRUPT_ADDR_FIRST,
> > > > > &vtd_dev_as->iommu_ir, 1);
> > > > > 
> > > > > So it should be fine. I guess the reason that I'm asking is that I thought
> > > > > "IR" means "Interrupt remapping" but in fact it means "Interrupt Region"?
> > I was meaning "interrupt remapping", and of course it's the interrupt region
> > too when IR enabled...
> 
> 
> Right.
> 
> 
> > 
> > > > > But I'm still not clear about the invalidation part for interrupt region,
> > > > > maybe you can elaborate a little more on this.
> > > > > 
> > > > > Btw, I think guest can trigger the assert in vtd_do_iommu_translate() if we
> > > > > teach vhost to DMA to that region:
> > > > Why would we want to?
> > > 
> > > I meant a buggy(malicious) guest driver.
> > Yes seems possible.  Do you want to post a patch?  Let me know if you want me
> > to...  Thanks,
> 
> 
> Yes please.

Oh wait...  Actually the comment above explains...

    /*
     * We have standalone memory region for interrupt addresses, we
     * should never receive translation requests in this region.
     */
    assert(!vtd_is_interrupt_addr(addr));

I overlooked myself that the IR region will be there even if ir=off.  So I
think the assert should stand.

-- 
Peter Xu


