Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CC7206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5cDkq8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CC7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDU4-0006Sq-Tz
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDSk-0005ai-FL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:05:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDDSi-0000gh-TY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598994303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fiFIiGq9PugSs6Ix7HWJBRqGwTo9szrwno+bbtDCrc=;
 b=T5cDkq8bTATufg7gZJXbTa3jQjgIbJ1bNJwpOYYsjqjkVtymHMnT/dpDSTfUHIilUNx7IB
 0gmf/3Vg9oQ/cIA59XorggwiWIwWXiPKh+QR7VUe0rli8smcSaa/k9c56C/XSvNF/15HXJ
 vkxvXOo074l4aftjDxNymizfF1KbP0M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-BfdIudfWNUizMgjI2gUwfw-1; Tue, 01 Sep 2020 17:04:28 -0400
X-MC-Unique: BfdIudfWNUizMgjI2gUwfw-1
Received: by mail-qv1-f70.google.com with SMTP id ff20so1934216qvb.7
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+fiFIiGq9PugSs6Ix7HWJBRqGwTo9szrwno+bbtDCrc=;
 b=QjtB+OJJlQ19/waRCCV7alReSZbme/sov+1ZaTKxWECbgl2hfm5VaBu+Vp0J0j0UIG
 75J6f8F5rEhAHi8ztFTyPvxXIpaHzc+YpaTF1ei6Xa5n5Seu5DDzxsLmN8wd7VAj/LKu
 pUwXIB+vvA/D4sAz4NRXVu7Td2jVCuTQid9/Rnm5HMnQdYETsdiNX2U/gxPyyz3spIia
 Ort7ukM4qO0fRoDe79m0y/jWGBtchbfr2axik62ECgcb2O3w8QTQxWCnVsaeRZHe21/p
 0Ut3KmjnYzQojIQI+dRKoiq/qOFUONzcdfibEaKX2SjhS311p3e3hXmeBmzYeHNTf8T1
 x4MA==
X-Gm-Message-State: AOAM530txRlSvz2wHt+17fKJqMtHl4ysl/GAXvyIjkfx8bLdCiMyOGwr
 2eQnQBeiLWVjJROno2j7z1lz3aYy59AhGMT7L9DykN7Ot8rSvRzAh0EGVwO9gvM6Gg7yy2H09xH
 DdaiGcmHs4SL4LTk=
X-Received: by 2002:a37:c404:: with SMTP id d4mr3753463qki.273.1598994267761; 
 Tue, 01 Sep 2020 14:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi5l2DvX2Ov5DhRM5DY17cW/giRnAGTqZ6SvbNuTLl6c332H2soW4U8o9pDXsbzemAOXHNfw==
X-Received: by 2002:a37:c404:: with SMTP id d4mr3753427qki.273.1598994267519; 
 Tue, 01 Sep 2020 14:04:27 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id m26sm3001780qtc.83.2020.09.01.14.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 14:04:26 -0700 (PDT)
Date: Tue, 1 Sep 2020 17:04:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v8 4/5] intel_iommu: Do not notify regular iotlb to
 device-iotlb notifiers
Message-ID: <20200901210424.GF3053@xz-x1>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200901142608.24481-5-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 04:26:07PM +0200, Eugenio Pérez wrote:
> This improves performance in case of netperf with vhost-net:
> * TCP_STREAM: From 1923.6Mbit/s to 2175.13Mbit/s (13%)
> * TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)
> * UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)
> * UDP_STREAM: No change observed (insignificant 0.1% improvement)

Just to confirm: are these numbers about applying this patch before/after, or
applying the whole series before/after?

Asked since we actually optimized two parts:

Firstly we avoid sending two invalidations for vhost.  That's done by the
previous patch, afaict.

Secondly, this patch avoids the page walk for vhost since not needed.

Am I right?

> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index cdddb089e7..fe82391b73 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1964,6 +1964,12 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (vtd_as->iommu.iommu_notify_flags & IOMMU_NOTIFIER_DEVIOTLB) {
> +            /* If IOMMU memory region is DEVICE IOTLB type, it does not make
> +             * sense to send regular IOMMU notifications. */
> +            continue;
> +        }
> +

We want to avoid vtd_sync_shadow_page_table() for vhost, however IMHO a better
expression would be:

    if (!(vtd_as->iommu.iommu_notify_flags &
        (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP))) {
        continue;
    }

The thing is we can't avoid the page sync if e.g. we're registered with
MAP|UNMAP|DEVIOTLB.  The important thing here, imho, is MAP|UNMAP because these
two messages are used for shadow page synchronizations, so we can skip that if
neither of the message is registered.

Besides, we can add this at the entry of vtd_sync_shadow_page_table() so that
all callers of vtd_sync_shadow_page_table() can benefit.

>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                        vtd_as->devfn, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce)) {
> -- 
> 2.18.1
> 

-- 
Peter Xu


