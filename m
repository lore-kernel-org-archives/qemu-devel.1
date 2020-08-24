Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B4A2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOCeUR5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFE7-0000Ff-MC
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAFDJ-0007nW-QM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAFDI-0004eU-58
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598286051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZPqO0i9nwV9cKVEOUZrqTFf+kRqEfBSBGBt9p29VPU=;
 b=GOCeUR5NqctHoqWxdQaq6DTTjWSDrCj9myx5ehVyWYNy8fxPx1Zlp8a1cs65g2Fw9Nk57K
 tWcgWRQybE8LPAEjBByNGVZGrfd2mtYMZHjKKF0V0+vKEKARS93Y+BvMgyMIgPgb4o6CVE
 wzm8XSoy/dtbD4shvJ1w+DLKMbpvNvY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-HUazv-rYN3GUzbxl5k8CpA-1; Mon, 24 Aug 2020 12:20:48 -0400
X-MC-Unique: HUazv-rYN3GUzbxl5k8CpA-1
Received: by mail-qk1-f199.google.com with SMTP id 1so6749584qki.22
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EZPqO0i9nwV9cKVEOUZrqTFf+kRqEfBSBGBt9p29VPU=;
 b=QDK6WA4qZYGDcRV5aFTmBxYdBZQgu/TswX/+YTBtHk3TAkKsGvyDwlkK3EgQfPIFY4
 snNrXjHR0qtmEFuaXVeHCPTF8qFzSP6NNXuGVTjwGGRnYIKzW16fRGtTKcH0EOHf6Imf
 m1O1H03e+KC+NatDL26WF7u9jo2hkK2aj+9q+lv/whzkjAZyRAZguYUEMKVaHCYDqPRl
 hfy4S1DmhKhOMC3tUktu1lU3YL/RYHH8VxWz9XtKia392te/0XXssfDOhsWKZGPuhVSC
 5JzfBmDPwvZrhRCD6soCRLoqbmPYuFlr93Xcdzxpk2nbAovMzC8L+ZD0Gzq1+oL+QSU3
 X6mw==
X-Gm-Message-State: AOAM531UiJeB87AR3NbkJu8RWwpcd5V0PwFFwLPEc6GG9WuGviox5VXM
 STx1dOy97JsQQdPV87WUFN6lEdolULsSZnqaXL+G7QeUX/pFdHL3zeZd3JDngsFGnkI/ZMLNaFP
 iZLumeutAsPphfak=
X-Received: by 2002:a05:6214:1709:: with SMTP id
 db9mr5617589qvb.142.1598286044394; 
 Mon, 24 Aug 2020 09:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKz1vEw/5vRR+gk/q67juj9ndYT5x6NXmJHk0Z78d9heh3nFcVriVuguhPRLK5wyVbNFVjWQ==
X-Received: by 2002:a05:6214:1709:: with SMTP id
 db9mr5617562qvb.142.1598286044064; 
 Mon, 24 Aug 2020 09:20:44 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id j72sm9555088qke.20.2020.08.24.09.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:20:42 -0700 (PDT)
Date: Mon, 24 Aug 2020 12:20:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v5 3/3] intel_iommu: Do not notify regular iotlb to
 device-iotlb notifiers
Message-ID: <20200824162045.GA6424@xz-x1>
References: <20200824104738.20664-1-eperezma@redhat.com>
 <20200824104738.20664-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200824104738.20664-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 12:47:38PM +0200, Eugenio Pérez wrote:
> This improves performance in case of netperf with vhost-net:
> * TCP_STREAM: From 1374.81Mbit/s to 1845Mbit/s (37%)
> * TCP_RR: From 6559.36 trans/s to 7916.29/s (21%)
> * UDP_RR: From 6705.39 trans/s to 8199.39/s (22%)
> * UDP_STREAM: No change observed (not significant 0.1% improvement)

Good to know that we can get such a perf boost by removing the extra
invalidations!

> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2ad6b9d796..d539a9f281 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1959,6 +1959,12 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (vtd_as->iommu.iommu_notify_flags & IOMMU_NOTIFIER_DEVIOTLB) {
> +            /* If IOMMU memory region is DEVICE IOTLB type, it does not make
> +             * sense to send regular IOMMU notifications. */
> +            continue;
> +        }

Though here IMHO a cleaner approach (rather than checking explicitly against
DEVIOTLB flag) is to add a notification type into IOMMUTLBEntry.

Then for domain invalidation, the caller is responsible to pass the type
IOMMU_NOTIFIER_UNMAP into the type field. memory_region_notify_iommu_one() will
automatically skip the message if not registerd by the notifier.

Also, it would be nice to have this new type before or when introducing the
DEVIOTLB message, otherwise the DEVIOTLB patch can be still slightly confusing
by itself when notified as UNMAP.

So here's some patch layout I'm thinking:

  - patch 1: rename function, we can keep it

  - patch 2: introduce "type" for IOMMUTLBEntry, so far we only have MAP/UNMAP.
    Modify all callers of memory_region_notify_iommu*() to fill in the type
    correctly into IOMMUTLBEntry with map/unmap.  Won't hurt if we still keep
    filling in UNMAP even for DEVIOTLB since that's after all the same old
    behavior.

  - patch 3: introduce DEVIOTLB, switch the type field of dev-iotlb
    notifications to the new type and let vhost registers only to that.

  - patch 4: at last, fix the assertion since we've got the DEVIOTLB messages.

Would this be slightly cleaner?

Thanks,

-- 
Peter Xu


