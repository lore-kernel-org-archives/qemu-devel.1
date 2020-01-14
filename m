Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C35C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7B92467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR2Tg2HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B92467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNj8-0007rJ-FQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1irNi2-0006z1-T8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1irNhx-0008PP-TI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:02:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1irNhx-0008OC-Lz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579014137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6zu5ALT81dX84/+UakBV64LvdD89zDlq6MaDEKS1Mc=;
 b=bR2Tg2HXYtFWIhV0cC4Kh5CROq3Z8ZfUWxMNLy7ZyDNbmH2apTTuG5RRiKVbGWNBMvKD+x
 pojuUK2ItUQ9muevM382WDyY7FIPvmiTkZYRBj0bAllCt2OxZmcdgj7aOJkI5NKhqdxLS9
 dvhM97Q5dTTrAD2x+MWkrxNA28mVsXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-pmw7tkZVOr6LchVJ-rHaOA-1; Tue, 14 Jan 2020 10:02:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8082D100551B
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 15:02:14 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A983842B8;
 Tue, 14 Jan 2020 15:02:07 +0000 (UTC)
Date: Tue, 14 Jan 2020 08:02:06 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] memory: Allow a MemoryRegion to be marked no_vhost
Message-ID: <20200114080206.6465c70e@x1.home>
In-Reply-To: <20200114021723-mutt-send-email-mst@kernel.org>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <20200113173647.84842-3-dgilbert@redhat.com>
 <20200114021723-mutt-send-email-mst@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pmw7tkZVOr6LchVJ-rHaOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jasowang@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 02:19:39 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 13, 2020 at 05:36:46PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Allow a memory region to be marked as 'no_vhost' and
> > exclude that region from vhost's list build.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>  
> 
> I thought we agreed vfio needs this as well?
> I'd rather this had some meaning not just "no vhost" ...
> no_dma?

Sorry, why does vfio need this?  Are we intending to disallow
peer-to-peer DMA?  A vfio device MMIO range could certainly be a DMA
target, but we need to stick to basic CPU operations to access it (ie.
no multimedia extensions like used in memcpy), that's what brought
about the ram device memory region type.  Thanks,

Alex

> > ---
> >  hw/virtio/vhost.c     |  3 ++-
> >  include/exec/memory.h | 21 +++++++++++++++++++++
> >  memory.c              | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 774d87d98e..462498bfe6 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -402,7 +402,8 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
> >      bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
> >                       ~(1 << DIRTY_MEMORY_MIGRATION);
> >      result = memory_region_is_ram(section->mr) &&
> > -        !memory_region_is_rom(section->mr);
> > +             !memory_region_is_rom(section->mr) &&
> > +             !memory_region_get_no_vhost(section->mr);
> >  
> >      /* Vhost doesn't handle any block which is doing dirty-tracking other
> >       * than migration; this typically fires on VGA areas.
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index aef8123d48..f475c06d63 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -394,6 +394,7 @@ struct MemoryRegion {
> >      bool ram_device;
> >      bool enabled;
> >      bool warning_printed; /* For reservations */
> > +    bool no_vhost;
> >      uint8_t vga_logging_count;
> >      MemoryRegion *alias;
> >      hwaddr alias_offset;
> > @@ -1625,6 +1626,26 @@ void memory_region_set_readonly(MemoryRegion *mr, bool readonly);
> >   */
> >  void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
> >  
> > +/**
> > + * memory_region_set_no_vhost: Make vhost ignore a memory region
> > + *
> > + * Makes vhost ignore a memory region, useful if it isn't real
> > + * DMAble memory and is at inconvenient addresses
> > + *
> > + * @mr: the region being updated.
> > + * @no_vhost: true to ignore
> > + */
> > +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost);
> > +
> > +/**
> > + * memory_region_set_no_vhost: Test if memory region is marked no vhost
> > + *
> > + * Test if the no_vhost flag is set on the memory region
> > + *
> > + * @mr: the region being tested.
> > + */
> > +bool memory_region_get_no_vhost(const MemoryRegion *mr);
> > +
> >  /**
> >   * memory_region_rom_device_set_romd: enable/disable ROMD mode
> >   *
> > diff --git a/memory.c b/memory.c
> > index d7b9bb6951..9371998e30 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -2136,6 +2136,21 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
> >      }
> >  }
> >  
> > +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
> > +{
> > +    if (mr->no_vhost != no_vhost) {
> > +        memory_region_transaction_begin();
> > +        mr->no_vhost = no_vhost;
> > +        memory_region_update_pending |= mr->enabled;
> > +        memory_region_transaction_commit();
> > +    }
> > +}
> > +
> > +bool memory_region_get_no_vhost(const MemoryRegion *mr)
> > +{
> > +    return mr->no_vhost;
> > +}
> > +
> >  void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> >  {
> >      if (mr->romd_mode != romd_mode) {
> > -- 
> > 2.24.1  
> 
> 


