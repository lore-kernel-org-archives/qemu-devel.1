Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78035C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1FC20786
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfwT4PDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1FC20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptzJ-00087D-IO
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jptvK-0005kN-3s
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:34:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jptvG-0007kh-Nq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593437649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6G6ZOFeKfJZLTLZq79XL775/fwg88HTrCznauUmAspc=;
 b=dfwT4PDzS/v903EnoiTkRVeTC9KSu2IhaZ+iI0vojvMnk6bnh0yU6By90Sp88CHJ2d/5bh
 bc5ydWeTxV4znso52eCwtJEM0vQ7ChrDdzSjvTNj57EULOd7kWQ/CQXPS6fbWOqfqBe3k4
 8St+8RCEdbDeq4oLrWGK+KWp/3F37IM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-D0BAG1XbMriG9Jc1n0NEmA-1; Mon, 29 Jun 2020 09:34:08 -0400
X-MC-Unique: D0BAG1XbMriG9Jc1n0NEmA-1
Received: by mail-qk1-f200.google.com with SMTP id q6so3707352qke.21
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 06:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6G6ZOFeKfJZLTLZq79XL775/fwg88HTrCznauUmAspc=;
 b=VYa3H/0E8smqvvbyp9p2NdksV9DGHpaaDdyze2GQLMXEqmiK0l2Zx0bBD+iWRXBCQT
 F/nCpMNLI+wXd+YW/BWAG/2rstDhutp3gnVklib0Jhlul4YtjG83HfI9BrGaMmUTOaS4
 DCFrWS34N5lsXavRT7fvSRn6kELfh904Tn7MLroN8qpDCPSwakpaz7DfMx0saqYPUCqF
 /k8DTCMS1A68lbfXvpA3G0JLoKp2W/rANOVwh7vLB2kGQ8Ckqf2THlArwQiWXCmYzf+q
 uFIKMD5Grhw9Uh6+yUmq0C7wdWgUt5E7UA+z4XWPlGdg8l1KCHiW7opFbZ4BONpm04JJ
 Zb3Q==
X-Gm-Message-State: AOAM532NPFrJwNlrXBXua2FFZeaPzjcYBBX4jDzRim5XJ1GffpWY0rTd
 /dH88V/p4TSP3CMQRsHf/rIIBmCqAp5J0H4c7sh4uaeGR2w8IylbY4TT4XTeVROotr13didW5eY
 gRgozH/BDrBeKN5o=
X-Received: by 2002:a37:67c8:: with SMTP id b191mr15202098qkc.60.1593437646825; 
 Mon, 29 Jun 2020 06:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCm+421ABZLvznNAweWPd6Kyng8CAdcLHOb3FDQ8WwpAkuExfhCAsqbnlxX0JyelpkwEdpNQ==
X-Received: by 2002:a37:67c8:: with SMTP id b191mr15202066qkc.60.1593437646395; 
 Mon, 29 Jun 2020 06:34:06 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id r76sm15844454qka.30.2020.06.29.06.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:34:05 -0700 (PDT)
Date: Mon, 29 Jun 2020 09:34:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200629133403.GA266532@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
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

On Mon, Jun 29, 2020 at 01:51:47PM +0800, Jason Wang wrote:
> 
> On 2020/6/28 下午10:47, Peter Xu wrote:
> > On Sun, Jun 28, 2020 at 03:03:41PM +0800, Jason Wang wrote:
> > > On 2020/6/27 上午5:29, Peter Xu wrote:
> > > > Hi, Eugenio,
> > > > 
> > > > (CCing Eric, Yan and Michael too)
> > > > 
> > > > On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
> > > > > diff --git a/memory.c b/memory.c
> > > > > index 2f15a4b250..7f789710d2 100644
> > > > > --- a/memory.c
> > > > > +++ b/memory.c
> > > > > @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
> > > > >            return;
> > > > >        }
> > > > > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > > > I can understand removing the assertion should solve the issue, however imho
> > > > the major issue is not about this single assertion but the whole addr_mask
> > > > issue behind with virtio...
> > > 
> > > I don't get here, it looks to the the range was from guest IOMMU drivers.
> > Yes.  Note that I didn't mean that it's a problem in virtio, it's just the fact
> > that virtio is the only one I know that would like to support arbitrary address
> > range for the translated region.  I don't know about tcg, but vfio should still
> > need some kind of page alignment in both the address and the addr_mask.  We
> > have that assumption too across the memory core when we do translations.
> 
> 
> Right but it looks to me the issue is not the alignment.
> 
> 
> > 
> > A further cause of the issue is the MSI region when vIOMMU enabled - currently
> > we implemented the interrupt region using another memory region so it split the
> > whole DMA region into two parts.  That's really a clean approach to IR
> > implementation, however that's also a burden to the invalidation part because
> > then we'll need to handle things like this when the listened range is not page
> > alighed at all (neither 0-0xfedffff, nor 0xfef0000-MAX).  If without the IR
> > region (so the whole iommu address range will be a single FlatRange),
> 
> 
> Is this a bug? I remember that at least for vtd, it won't do any DMAR on the
> intrrupt address range

I don't think it's a bug, at least it's working as how I understand...  that
interrupt range is using an IR region, that's why I said the IR region splits
the DMAR region into two pieces, so we have two FlatRange for the same
IOMMUMemoryRegion.

> 
> 
> >   I think
> > we probably don't need most of the logic in vtd_address_space_unmap() at all,
> > then we can directly deliver all the IOTLB invalidations without splitting into
> > small page aligned ranges to all the iommu notifiers.  Sadly, so far I still
> > don't have ideal solution for it, because we definitely need IR.
> 
> 
> Another possible (theoretical) issue (for vhost) is that it can't trigger
> interrupt through the interrupt range.

Hmm.. Could you explain?  When IR is enabled, all devices including virtio
who send interrupt to 0xfeeXXXXX should be trapped by IR.

> 
> 
> > 
> > > 
> > > > For normal IOTLB invalidations, we were trying our best to always make
> > > > IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what we're
> > > > doing with the loop in vtd_address_space_unmap().
> > > 
> > > I'm sure such such assumption can work for any type of IOMMU.
> > > 
> > > 
> > > > But this is not the first time that we may want to break this assumption for
> > > > virtio so that we make the IOTLB a tuple of (start, len), then that len can be
> > > > not a address mask any more.  That seems to be more efficient for things like
> > > > vhost because iotlbs there are not page based, so it'll be inefficient if we
> > > > always guarantee the addr_mask because it'll be quite a lot more roundtrips of
> > > > the same range of invalidation.  Here we've encountered another issue of
> > > > triggering the assertion with virtio-net, but only with the old RHEL7 guest.
> > > > 
> > > > I'm thinking whether we can make the IOTLB invalidation configurable by
> > > > specifying whether the backend of the notifier can handle arbitary address
> > > > range in some way.  So we still have the guaranteed addr_masks by default
> > > > (since I still don't think totally break the addr_mask restriction is wise...),
> > > > however we can allow the special backends to take adavantage of using arbitary
> > > > (start, len) ranges for reasons like performance.
> > > > 
> > > > To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_MASK
> > > > to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend) can
> > > > take arbitrary address mask, then it can be any value and finally becomes a
> > > > length rather than an addr_mask.  Then for every iommu notify() we can directly
> > > > deliver whatever we've got from the upper layer to this notifier.  With the new
> > > > flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
> > > > declares this capability.  Then no matter for device iotlb or normal iotlb, we
> > > > skip the complicated procedure to split a big range into small ranges that are
> > > > with strict addr_mask, but directly deliver the message to the iommu notifier.
> > > > E.g., we can skip the loop in vtd_address_space_unmap() if the notifier is with
> > > > ARBITRARY flag set.
> > > 
> > > I'm not sure coupling IOMMU capability to notifier is the best choice.
> > IMHO it's not an IOMMU capability.  The flag I wanted to introduce is a
> > capability of the one who listens to the IOMMU TLB updates.  For our case, it's
> > virtio/vhost's capability to allow arbitrary length. The IOMMU itself
> > definitely has some limitation on the address range to be bound to an IOTLB
> > invalidation, e.g., the device-iotlb we're talking here only accept both the
> > iova address and addr_mask to be aligned to 2**N-1.
> 
> 
> I think this go back to one of our previous discussion of whether to
> introduce a dedicated notifiers for device IOTLB.
> 
> For IOMMU, it might have limitation like GAW, but for device IOTLB it
> probably doesn't. That's the reason we hit the assert here.

I feel like even for hardware it shouldn't be arbitrary either, because the
device iotlb sent from at least vt-d driver is very restricted too (borrowing
the comment you wrote :):

    /* According to ATS spec table 2.4:
     * S = 0, bits 15:12 = xxxx     range size: 4K
     * S = 1, bits 15:12 = xxx0     range size: 8K
     * S = 1, bits 15:12 = xx01     range size: 16K
     * S = 1, bits 15:12 = x011     range size: 32K
     * S = 1, bits 15:12 = 0111     range size: 64K
     * ...
     */

> 
> 
> > 
> > > How about just convert to use a range [start, end] for any notifier and move
> > > the checks (e.g the assert) into the actual notifier implemented (vhost or
> > > vfio)?
> > IOMMUTLBEntry itself is the abstraction layer of TLB entry.  Hardware TLB entry
> > is definitely not arbitrary range either (because AFAICT the hardware should
> > only cache PFN rather than address, so at least PAGE_SIZE aligned).
> > Introducing this flag will already make this trickier just to avoid introducing
> > another similar struct to IOMMUTLBEntry, but I really don't want to make it a
> > default option...  Not to mention I probably have no reason to urge the rest
> > iommu notifier users (tcg, vfio) to change their existing good code to suite
> > any of the backend who can cooperate with arbitrary address ranges...
> 
> 
> Ok, so it looks like we need a dedicated notifiers to device IOTLB.

Or we can also make a new flag for device iotlb just like current UNMAP? Then
we replace the vhost type from UNMAP to DEVICE_IOTLB.  But IMHO using the
ARBITRARY_LENGTH flag would work in a similar way.  DEVICE_IOTLB flag could
also allow virtio/vhost to only receive one invalidation (now IIUC it'll
receive both iotlb and device-iotlb for unmapping a page when ats=on), but then
ats=on will be a must and it could break some old (misconfiged) qemu because
afaict previously virtio/vhost could even work with vIOMMU (accidentally) even
without ats=on.

Thanks,

-- 
Peter Xu


