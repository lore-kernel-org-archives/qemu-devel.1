Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44AFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 19:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAF620781
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agAtaC0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5ZxB-0001Qn-Ks
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 15:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k5ZwN-0000oO-1G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 15:28:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k5ZwK-0007KW-7v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 15:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597174082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeM9e3GFw5tXedVgQiYmjOhHFM7vPLjPZcfN8numLzU=;
 b=agAtaC0wPnZbFq6t55QLWZgyoaIvgJMyzVNDnrmHQgZk9rQIeUf8XKYC+Gx7mvFBk0qRm0
 YRTD7wF2aodVUDOyrWyz7ukHpRK/ninDX6PTUJ/cVEo5ykspx0H8kUEX8W/uk7u3qGRhUR
 fyVeY8BIeR1gEx2yq2C4HbVI27vVd6A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-BRGPc9MwNJSNrlCDlHjcDg-1; Tue, 11 Aug 2020 15:28:00 -0400
X-MC-Unique: BRGPc9MwNJSNrlCDlHjcDg-1
Received: by mail-qv1-f72.google.com with SMTP id j8so10381954qvu.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 12:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JeM9e3GFw5tXedVgQiYmjOhHFM7vPLjPZcfN8numLzU=;
 b=oQTHeFi8FjxE/0QqLVYjJW40ySWWy3M8ivoOxjabkJvXojwu/VQWkocFuBaPrps7L2
 kSBBzClX3A0IBsEXbDJtA+8jKmrdzs/1kF3XACdIGS8a0NiSHO2I10yoBRB2Z/BXB+93
 TY/6AScSChgbBYDIJzFFhJCUKsAGIJvzytcmjL3lOkoq65H1vqcgTSPEjz0at5ZF5BqS
 GYvxh3hAn4U/AXLv/63BjjMZOze8RwDg58NAA3ziuO/cwaoSwTjHdDUgnaO6e/oyVwV2
 syKONAerbi8oZwPvp/JzoiDUb+taMQ7wW/pUcU2RJo54U2Lv1Dth6NwQaeBgE8NXZOg0
 Pa/A==
X-Gm-Message-State: AOAM5311or5bqBnHA9/wIrSIFSoTf1cCdhTOSJhrug3rM53q9xTbuEJC
 d8mzKSE1zPXcg/Uh5//XT0imqsbLPNIg55ej6N7khyPXABlNL60BtEPrFAsVS4ihVVu2uDK71+F
 MHdIWEQveq+xZYL4=
X-Received: by 2002:a37:674d:: with SMTP id b74mr2781584qkc.84.1597174080012; 
 Tue, 11 Aug 2020 12:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLDcO2xMQpz2ebzawHGOpCwe8pU1akcheG9Zuf8W3UFHK4mlIVuoexBzNjOVUbrAr8EfYGdA==
X-Received: by 2002:a37:674d:: with SMTP id b74mr2781563qkc.84.1597174079648; 
 Tue, 11 Aug 2020 12:27:59 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id z24sm17507100qki.57.2020.08.11.12.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 12:27:58 -0700 (PDT)
Date: Tue, 11 Aug 2020 15:27:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v3 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200811192757.GB6353@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <CAJaqyWf24F8ERAuvYj+0Xv=+cYj4v1MCmvCmQFTqcfLVYYCVuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf24F8ERAuvYj+0Xv=+cYj4v1MCmvCmQFTqcfLVYYCVuQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Eugenio,

On Tue, Aug 11, 2020 at 08:10:44PM +0200, Eugenio Perez Martin wrote:
> Using this patch as a reference, I'm having problems to understand:
> 
> - I'm not sure that the flag name expresses clearly the notifier capability.

The old code is kind of messed up for dev-iotlb invalidations, by always
sending UNMAP notifications for both iotlb and dev-iotlb invalidations.

Now if we introduce the new DEV_IOTLB type, we can separate the two:

  - We notify IOMMU_NOTIFIER_UNMAP for iotlb invalidations

  - We notify IOMMU_NOTIFIER_DEV_IOTLB for dev-iotlb invalidations

Vhost should always be with ats=on when vIOMMU enabled, so it will enable
device iotlb.  Then it does not need iotlb (UNMAP) invalidation any more
because they'll normally be duplicated (one is to invalidate vIOMMU cache, one
is to invalidate device cache).

Also, we can drop UNMAP type for vhost if we introduce DEV_IOTLB.  It works
just like on the real hardwares - the device won't be able to receive iotlb
invalidation messages, but only device iotlb invalidation messages.  Here
vhost (or, virtio-pci) is the device.

> - What would be the advantages of using another field (NotifierType?)
> in the notifier to express that it accepts arbitrary ranges for
> unmapping? (If I understood correctly Jason's proposal)

(Please refer to above too..)

> - Is it possible (or advisable) to skip all the page splitting in
> vtd_page_walk if the memory range notifier supports these arbitrary
> ranges? What would be the disadvantages? (Maybe in a future patch). It
> seems it is advisable to me, but I would like to double confirm.

vtd_page_walk is not used for dev-iotlb, we don't need to change that.  We also
want to explicitly keep the page granularity of vtd_page_walk for the other
IOMMU notifiers, e.g. vfio.

Though we'll need to modify vtd_process_device_iotlb_desc() to only send
notifications to the notifiers that registered with DEV_IOTLB flag.

Hope it helps..

Thanks,

-- 
Peter Xu


