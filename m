Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706CAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB2320702
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTiFN8nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB2320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYc0-0007b4-8a
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jpYb8-0007AZ-1s
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:47:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50132
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jpYb4-0008Dy-OX
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593355672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBWc9fuvd8KVNYmzjEEwO6Wb/9vYInQjiP1TLT8/+/U=;
 b=MTiFN8nqrU7mEVYCtl0E0lvUVnRVl9dUM8pKdz8wqwTBc7wMC3hGac5xA8Y4Z9bvfp7b6p
 TaBNoqqHFiso6IEqKHPqOkymYu0zHSiEG6a5L8fuMDS9B0plGB8VinxLo0N45+I4hRrptg
 J7brAIGoziIwNxuCobZqC5mix3gb7Vc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-52xdpizIMM2Dht3kIvHBLw-1; Sun, 28 Jun 2020 10:47:50 -0400
X-MC-Unique: 52xdpizIMM2Dht3kIvHBLw-1
Received: by mail-qt1-f199.google.com with SMTP id g6so10371991qtr.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vBWc9fuvd8KVNYmzjEEwO6Wb/9vYInQjiP1TLT8/+/U=;
 b=kQ7NpSAqd0m0f/E9QRM7OylRIrmy7a0cJRQqmNCS0SSI1N7HrNp17AVpFu5tjXzmGw
 Ujdx9LmofaZzC1ZsXjjRHc5qQahvr0pUsmKsUDI01S9hjmpXptog0jKfHyzhJ1lXRgDk
 crb7HCt6MnNZdFw/OgGiMeTmNHKZpRF0BX8kqo8hRCPmFoberjzMuYAdpGr6JA8Rl5An
 KYhsAYqMSToWT0QjD7jsQ4Jw5qqvrr5QuvNy4AH6VgYZQp9P0CE74fNiO55jyFnZYzM6
 ILfdqrv1DO8f7oy6VgBePR4/mdvVXQmMoc692od9doGCvQCtQNTCL5QZIeUHZJ4Zk31h
 B3qA==
X-Gm-Message-State: AOAM533fWULb+ZCY7YZhdX9s5X0I/CSU5rhPyIsgSx6yScCWpqJM0Zp8
 sg/ONPXOd3QJoyuRcUNYZ+6KN2sgGXfh2D2KJCQchY7DAUoDGcOid5Zwdz0vS7cv2um/315HTXP
 XPkIpOLZdkTyEx2A=
X-Received: by 2002:a0c:e710:: with SMTP id d16mr11686900qvn.158.1593355669756; 
 Sun, 28 Jun 2020 07:47:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJeCfI7+XBg9jYtbYH2yPJ3RcfslCzP/R+CqfsYMOPtjAvE3LmsfQJTSDlhFWgP/2YpqdIxQ==
X-Received: by 2002:a0c:e710:: with SMTP id d16mr11686872qvn.158.1593355669274; 
 Sun, 28 Jun 2020 07:47:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id f54sm15472231qte.76.2020.06.28.07.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:47:48 -0700 (PDT)
Date: Sun, 28 Jun 2020 10:47:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200628144746.GA239443@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 10:47:52
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
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 03:03:41PM +0800, Jason Wang wrote:
> 
> On 2020/6/27 上午5:29, Peter Xu wrote:
> > Hi, Eugenio,
> > 
> > (CCing Eric, Yan and Michael too)
> > 
> > On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
> > > diff --git a/memory.c b/memory.c
> > > index 2f15a4b250..7f789710d2 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> > >           return;
> > >       }
> > > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > I can understand removing the assertion should solve the issue, however imho
> > the major issue is not about this single assertion but the whole addr_mask
> > issue behind with virtio...
> 
> 
> I don't get here, it looks to the the range was from guest IOMMU drivers.

Yes.  Note that I didn't mean that it's a problem in virtio, it's just the fact
that virtio is the only one I know that would like to support arbitrary address
range for the translated region.  I don't know about tcg, but vfio should still
need some kind of page alignment in both the address and the addr_mask.  We
have that assumption too across the memory core when we do translations.

A further cause of the issue is the MSI region when vIOMMU enabled - currently
we implemented the interrupt region using another memory region so it split the
whole DMA region into two parts.  That's really a clean approach to IR
implementation, however that's also a burden to the invalidation part because
then we'll need to handle things like this when the listened range is not page
alighed at all (neither 0-0xfedffff, nor 0xfef0000-MAX).  If without the IR
region (so the whole iommu address range will be a single FlatRange), I think
we probably don't need most of the logic in vtd_address_space_unmap() at all,
then we can directly deliver all the IOTLB invalidations without splitting into
small page aligned ranges to all the iommu notifiers.  Sadly, so far I still
don't have ideal solution for it, because we definitely need IR.

> 
> 
> > 
> > For normal IOTLB invalidations, we were trying our best to always make
> > IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what we're
> > doing with the loop in vtd_address_space_unmap().
> 
> 
> I'm sure such such assumption can work for any type of IOMMU.
> 
> 
> > 
> > But this is not the first time that we may want to break this assumption for
> > virtio so that we make the IOTLB a tuple of (start, len), then that len can be
> > not a address mask any more.  That seems to be more efficient for things like
> > vhost because iotlbs there are not page based, so it'll be inefficient if we
> > always guarantee the addr_mask because it'll be quite a lot more roundtrips of
> > the same range of invalidation.  Here we've encountered another issue of
> > triggering the assertion with virtio-net, but only with the old RHEL7 guest.
> > 
> > I'm thinking whether we can make the IOTLB invalidation configurable by
> > specifying whether the backend of the notifier can handle arbitary address
> > range in some way.  So we still have the guaranteed addr_masks by default
> > (since I still don't think totally break the addr_mask restriction is wise...),
> > however we can allow the special backends to take adavantage of using arbitary
> > (start, len) ranges for reasons like performance.
> > 
> > To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_MASK
> > to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend) can
> > take arbitrary address mask, then it can be any value and finally becomes a
> > length rather than an addr_mask.  Then for every iommu notify() we can directly
> > deliver whatever we've got from the upper layer to this notifier.  With the new
> > flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
> > declares this capability.  Then no matter for device iotlb or normal iotlb, we
> > skip the complicated procedure to split a big range into small ranges that are
> > with strict addr_mask, but directly deliver the message to the iommu notifier.
> > E.g., we can skip the loop in vtd_address_space_unmap() if the notifier is with
> > ARBITRARY flag set.
> 
> 
> I'm not sure coupling IOMMU capability to notifier is the best choice.

IMHO it's not an IOMMU capability.  The flag I wanted to introduce is a
capability of the one who listens to the IOMMU TLB updates.  For our case, it's
virtio/vhost's capability to allow arbitrary length. The IOMMU itself
definitely has some limitation on the address range to be bound to an IOTLB
invalidation, e.g., the device-iotlb we're talking here only accept both the
iova address and addr_mask to be aligned to 2**N-1.

> 
> How about just convert to use a range [start, end] for any notifier and move
> the checks (e.g the assert) into the actual notifier implemented (vhost or
> vfio)?

IOMMUTLBEntry itself is the abstraction layer of TLB entry.  Hardware TLB entry
is definitely not arbitrary range either (because AFAICT the hardware should
only cache PFN rather than address, so at least PAGE_SIZE aligned).
Introducing this flag will already make this trickier just to avoid introducing
another similar struct to IOMMUTLBEntry, but I really don't want to make it a
default option...  Not to mention I probably have no reason to urge the rest
iommu notifier users (tcg, vfio) to change their existing good code to suite
any of the backend who can cooperate with arbitrary address ranges...

Thanks,

-- 
Peter Xu


