Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDEE206D8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsVnTk5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDEE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k33b3-00041o-F9
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 16:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k33Zu-0003MD-TI
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:30:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k33Zr-00060O-S8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596573024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3VXSAPpUQQNgNCgJuKI0W1EKybMMe3BhH0aRrRNZ0A=;
 b=MsVnTk5MFhnIYa6FRWiZVmKT6CnkY2HB3o3sL5aPob/18+4GeN+rW9/wFkqmBbeV3AolsH
 wYWijPF3zGlHKV98GT7tThkPvlMAs9qHsYmNXmb5JjlUkREW3A/CTajfjmbeIT6PLg7+Fx
 aNVL+W29LvMEU55gRGYYy96mymUxi+4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-1AdhPZXUMU2Goxa_oTLn2w-1; Tue, 04 Aug 2020 16:30:21 -0400
X-MC-Unique: 1AdhPZXUMU2Goxa_oTLn2w-1
Received: by mail-qv1-f69.google.com with SMTP id z10so6074105qvm.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 13:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a3VXSAPpUQQNgNCgJuKI0W1EKybMMe3BhH0aRrRNZ0A=;
 b=Kf2w1yq06nJnVmK7h3paxe37kRW+fIHC0Y2TzCCFRshGdPGHd/ud1xtAH+CgByiemu
 uXS5aj9ovHm2gA0/VQdlhxMbcQ3GkhZYsjOs+XWV3zKML8S7hZSbAMuGZbH8lTCywYd0
 QyA+wSYbdsBL/ZPir1DK+Q5xnYFdx3jypMdg/NRE6ixdFVzccyWdBtfK+qs5g7ZS8a4+
 mLmaJGFz/YsEe+XN94UgicZ/ezXpzvecXDAiVcntVQ0P5UVakBxutg8g1su7WNv+EwXn
 gOys5XiTmECvXPKDnue+WAyDE4I+t6yoMArsV9AD8mJYGhbK80NtaGpPreead03ieq28
 29Nw==
X-Gm-Message-State: AOAM531LdihdqGNukhcTFjwewbZOH2AMsPH/bMTWjZ1mN5rS6NoezSSz
 oJ+A61HkGGVhP9h/QK4v8kT9fGKa2hTY/7YNYLQ6pZnCA/BWLN6KPtAwN8KcC94Tt9nOvhp2FJ0
 4FZgzHG0QArf5DOc=
X-Received: by 2002:ad4:5748:: with SMTP id q8mr116376qvx.217.1596573020614;
 Tue, 04 Aug 2020 13:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9VlU/xmlCxsLHeO/u3cc6UuJjSPjh86Q7xWy6XDRYQiU82STBzxf5e5IzQUwc/U01qnDGPQ==
X-Received: by 2002:ad4:5748:: with SMTP id q8mr116354qvx.217.1596573020356;
 Tue, 04 Aug 2020 13:30:20 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id x67sm24161112qke.136.2020.08.04.13.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 13:30:19 -0700 (PDT)
Date: Tue, 4 Aug 2020 16:30:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200804203018.GD90726@xz-x1>
References: <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <7c17ff0c1be07c3e490fb02abb2b39a1d9f269b8.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7c17ff0c1be07c3e490fb02abb2b39a1d9f269b8.camel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
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
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 06:00:34PM +0200, Eugenio Pérez wrote:
> On Fri, 2020-07-03 at 15:24 +0800, Jason Wang wrote:
> > On 2020/7/2 下午11:45, Peter Xu wrote:
> > > On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
> > > > So I think we agree that a new notifier is needed?
> > > Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?
> > 
> > That should work but I wonder something as following is better.
> > 
> > Instead of introducing new flags, how about carry the type of event in 
> > the notifier then the device (vhost) can choose the message it want to 
> > process like:
> > 
> > static vhost_iommu_event(IOMMUNotifier *n, IOMMUTLBEvent *event)
> > 
> > {
> > 
> > switch (event->type) {
> > 
> > case IOMMU_MAP:
> > case IOMMU_UNMAP:
> > case IOMMU_DEV_IOTLB_UNMAP:
> > ...
> > 
> > }
> > 
> > Thanks
> > 
> > 
> 
> Hi!
> 
> Sorry, I thought I had this clear but now it seems not so clear to me. Do you mean to add that switch to the current
> vhost_iommu_unmap_notify, and then the "type" field to the IOMMUTLBEntry? Is that the scope of the changes, or there is
> something I'm missing?
> 
> If that is correct, what is the advantage for vhost or other notifiers? I understand that move the IOMMUTLBEntry (addr,
> len) -> (iova, mask) split/transformation to the different notifiers implementation could pollute them, but this is even a deeper change and vhost is not insterested in other events but IOMMU_UNMAP, isn't?
> 
> On the other hand, who decide what type of event is? If I follow the backtrace of the assert in 
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01015.html, it seems to me that it should be
> vtd_process_device_iotlb_desc. How do I know if it should be IOMMU_UNMAP or IOMMU_DEV_IOTLB_UNMAP? If I set it in some
> function of memory.c, I should decide the type looking the actual notifier, isn't?

(Since Jason didn't reply yesterday, I'll try to; Jason, feel free to correct
 me...)

IMHO whether to put the type into the IOMMUTLBEntry is not important.  The
important change should be that we introduce IOMMU_DEV_IOTLB_UNMAP (or I'd
rather call it IOMMU_DEV_IOTLB directly which is shorter and cleaner).  With
that information we can make the failing assertion conditional for MAP/UNMAP
only.  We can also allow dev-iotlb messages to take arbitrary addr_mask (so it
becomes a length of address range; imho we can keep using addr_mask for
simplicity, but we can comment for addr_mask that for dev-iotlb it can be not a
real mask).

Thanks,

-- 
Peter Xu


