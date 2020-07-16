Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D693C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 01:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A192078C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 01:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWnh6L6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A192078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvsGm-0001bc-Ec
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 21:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jvsG0-00016Y-W1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 21:00:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jvsFx-000571-LP
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 21:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594861211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVJqRen2FlRThoCe2vo06blEUNfPh3TRfo0te8r0r+A=;
 b=jWnh6L6A4bjdDWZ06zZN3eMgD2hWhpI9AM3pkA85olj07xqOyl3CMOEBXzRGnlHvV1GObQ
 SGEbxDjKfkK+bq/sZpxUgPbCaROx2NjmKR9t579QW4zZFqFwHL4zUo/6O3beAfGsZGUky2
 zu6u1lDx8vwikPD0Q6Ebw6dtDp1zAks=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Cn-ANwnTNOqYH2s7I1Jxqw-1; Wed, 15 Jul 2020 21:00:09 -0400
X-MC-Unique: Cn-ANwnTNOqYH2s7I1Jxqw-1
Received: by mail-qk1-f200.google.com with SMTP id p126so2685799qkf.15
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 18:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BVJqRen2FlRThoCe2vo06blEUNfPh3TRfo0te8r0r+A=;
 b=YmGM716cV2p5mrn8zBNv6ulTdnBmM+UA7xdd2BY2rW9cR8cmR/aCqtCNDv8InNnl0V
 iF6AsFrYL+L5auuwQiDsa35ZU+bpkVjmkcu1bec5Uym4c2MbW7G8XCViuvO+wi21kHwd
 TakD7R2CJF8xme92hnkY865pP6waRnja9jEuSphcxxSS8FFKQPpTaHiUpbECyS/lnVJW
 glMdymMrYpsA7h5V96Ggd1S7WUhtBsKHm3tbm9SzTfZ1jd5Qc2x4/E3++Sgq+KmOOM82
 cFM0YbJuHcNc6XRAfpUgd/Q6NUZf4gcRsjRlG06OnkqL/itajpwRYM4SORXFu0wyD7o4
 OjjQ==
X-Gm-Message-State: AOAM531D1HqQcOX2tOLQ45MGcaxlmP2zu43i2mJMbppUmyNUHhZ0Feq8
 8rZWXwv1B/MBAK+ht6fYK0EPJ8VxocYYrP28QJtXMoBhGJRkIDA+A3FMGxFXWpv4W0P3oYIo6wq
 bmrNLQLyAkzjyxao=
X-Received: by 2002:a37:61cb:: with SMTP id v194mr1658993qkb.314.1594861209032; 
 Wed, 15 Jul 2020 18:00:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWb7ms7XZguAAJ/6ItHf+ZZewc3gbEI43Gvrur4OF8s2YY6Ofny+YO4Bw0ku6KP4+yPpqOCA==
X-Received: by 2002:a37:61cb:: with SMTP id v194mr1658966qkb.314.1594861208574; 
 Wed, 15 Jul 2020 18:00:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id j24sm4365453qkl.79.2020.07.15.18.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 18:00:07 -0700 (PDT)
Date: Wed, 15 Jul 2020 21:00:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200716010005.GA535743@xz-x1>
References: <20200703130338.GD6677@xz-x1>
 <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
 <20200707195429.GF88106@xz-x1>
 <5004a059-6eb0-4ef3-40b7-94dfbf9ec08f@redhat.com>
 <20200708141657.GA199122@xz-x1>
 <14b1ca26-448d-0feb-7529-6546809aaa59@redhat.com>
 <20200709141037.GF199122@xz-x1>
 <fb2f8d35-3f04-55ac-e0c0-7eeedbaf2429@redhat.com>
 <20200710133005.GL199122@xz-x1>
 <05bb512c-ca0a-e80e-1eed-446e918ad729@redhat.com>
MIME-Version: 1.0
In-Reply-To: <05bb512c-ca0a-e80e-1eed-446e918ad729@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 21:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 12:04:16PM +0800, Jason Wang wrote:
> 
> On 2020/7/10 下午9:30, Peter Xu wrote:
> > On Fri, Jul 10, 2020 at 02:34:11PM +0800, Jason Wang wrote:
> > > On 2020/7/9 下午10:10, Peter Xu wrote:
> > > > On Thu, Jul 09, 2020 at 01:58:33PM +0800, Jason Wang wrote:
> > > > > > > - If we care the performance, it's better to implement the MAP event for
> > > > > > > vhost, otherwise it could be a lot of IOTLB miss
> > > > > > I feel like these are two things.
> > > > > > 
> > > > > > So far what we are talking about is whether vt-d should have knowledge about
> > > > > > what kind of events one iommu notifier is interested in.  I still think we
> > > > > > should keep this as answered in question 1.
> > > > > > 
> > > > > > The other question is whether we want to switch vhost from UNMAP to MAP/UNMAP
> > > > > > events even without vDMA, so that vhost can establish the mapping even before
> > > > > > IO starts.  IMHO it's doable, but only if the guest runs DPDK workloads.  When
> > > > > > the guest is using dynamic iommu page mappings, I feel like that can be even
> > > > > > slower, because then the worst case is for each IO we'll need to vmexit twice:
> > > > > > 
> > > > > >      - The first vmexit caused by an invalidation to MAP the page tables, so vhost
> > > > > >        will setup the page table before IO starts
> > > > > > 
> > > > > >      - IO/DMA triggers and completes
> > > > > > 
> > > > > >      - The second vmexit caused by another invalidation to UNMAP the page tables
> > > > > > 
> > > > > > So it seems to be worse than when vhost only uses UNMAP like right now.  At
> > > > > > least we only have one vmexit (when UNMAP).  We'll have a vhost translate()
> > > > > > request from kernel to userspace, but IMHO that's cheaper than the vmexit.
> > > > > Right but then I would still prefer to have another notifier.
> > > > > 
> > > > > Since vtd_page_walk has nothing to do with device IOTLB. IOMMU have a
> > > > > dedicated command for flushing device IOTLB. But the check for
> > > > > vtd_as_has_map_notifier is used to skip the device which can do demand
> > > > > paging via ATS or device specific way. If we have two different notifiers,
> > > > > vhost will be on the device iotlb notifier so we don't need it at all?
> > > > But we can still have iommu notifier that only registers to UNMAP even after we
> > > > introduce dev-iotlb notifier?  We don't want to do page walk for them as well.
> > > > TCG should be the only one so far, but I don't know.. maybe there can still be
> > > > new ones?
> > > 
> > > I think you're right. But looking at the codes, it looks like the check of
> > > vtd_as_has_map_notifier() was only used in:
> > > 
> > > 1) vtd_iommu_replay()
> > > 2) vtd_iotlb_page_invalidate_notify() (PSI)
> > > 
> > > For the replay, it's expensive anyhow. For PSI, I think it's just about one
> > > or few mappings, not sure it will have obvious performance impact.
> > > 
> > > And I had two questions:
> > > 
> > > 1) The codes doesn't check map for DSI or GI, does this match what spec
> > > said? (It looks to me the spec is unclear in this part)
> > Both DSI/GI should cover maps too?  E.g. vtd_sync_shadow_page_table() in
> > vtd_iotlb_domain_invalidate().
> 
> 
> I meant the code doesn't check whether there's an MAP notifier :)

It's actually checked, because it loops over vtd_as_with_notifiers, and only
MAP notifiers register to that. :)

But I agree with you that it should be cleaner to introduce the dev-iotlb
notifier type.

> 
> 
> > 
> > > 2) for the replay() I don't see other implementations (either spapr or
> > > generic one) that did unmap (actually they skip unmap explicitly), any
> > > reason for doing this in intel IOMMU?
> > I could be wrong, but I'd guess it's because vt-d implemented the caching mode
> > by leveraging the same invalidation strucuture, so it's harder to make all
> > things right (IOW, we can't clearly identify MAP with UNMAP when we receive an
> > invalidation request, because MAP/UNMAP requests look the same).
> > 
> > I didn't check others, but I believe spapr is doing it differently by using
> > some hypercalls to deliver IOMMU map/unmap requests, which seems a bit close to
> > what virtio-iommu is doing.  Anyway, the point is if we have explicit MAP/UNMAP
> > from the guest, logically the replay indeed does not need to do any unmap
> > because we don't need to call replay() on an already existing device but only
> > for e.g. hot plug.
> 
> 
> But this looks conflict with what memory_region_iommu_replay( ) did, for
> IOMMU that doesn't have a replay method, it skips UNMAP request:
> 
>     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
>         iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_idx);
>         if (iotlb.perm != IOMMU_NONE) {
>             n->notify(n, &iotlb);
>         }
> 
> I guess there's no knowledge of whether guest have an explicit MAP/UMAP for
> this generic code. Or replay implies that guest doesn't have explicit
> MAP/UNMAP?

I think it matches exactly with a hot plug case?  Note that when IOMMU_NONE
could also mean the translation does not exist.  So it's actually trying to map
everything that can be translated and then notify().

> 
> (btw, the code shortcut the memory_region_notify_one(), not sure the reason)

I think it's simply because memory_region_notify_one() came later. :)

> 
> 
> >   VT-d does not have that clear interface, so VT-d needs to
> > maintain its own mapping structures, and also vt-d is using the same replay &
> > page_walk operations to sync all these structures, which complicated the vt-d
> > replay a bit.  With that, we assume replay() can be called anytime on a device,
> > and we won't notify duplicated MAPs to lower layer like vfio if it is mapped
> > before.  At the meantime, since we'll compare the latest mapping with the one
> > we cached in the iova tree, UNMAP becomes possible too.
> 
> 
> AFAIK vtd_iommu_replay() did a completely UNMAP:
> 
>     /*
>      * The replay can be triggered by either a invalidation or a newly
>      * created entry. No matter what, we release existing mappings
>      * (it means flushing caches for UNMAP-only registers).
>      */
>     vtd_address_space_unmap(vtd_as, n);
> 
> Since it doesn't do any comparison with iova tree. Will this cause
> unnecessary UNMAP to be sent to VFIO?

I feel like that can be removed now, but needs some testings...

Thanks,

-- 
Peter Xu


