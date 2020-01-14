Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F8C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3315224673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDSOefLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3315224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKM4-0006Ew-Qj
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irKKz-00057N-Hr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irKKv-0006M6-M0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irKKv-0006M2-IB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579001177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIiiwiIzOLxS16AzMTvpCuWAFQTSNwjxHp7YzuBKN1c=;
 b=hDSOefLqdaHiFWkWhs1qjDunpiZ2/1h8waugB4QFJ9ZwRePP9jqMeTKUv4JmS3AmkdaYg/
 YR/ThRATDLhNeV/+6QcIZFVlzrcxv8vL+2/WImV/94jN2cVwstuJikW3j0PHLpsrvPZkOG
 BTgLK5gIuXjEuzDBtirpI9H2d57lvLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-hsTrBIAePXSLW_T6NsYd1A-1; Tue, 14 Jan 2020 06:26:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 209C7593A0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:26:14 +0000 (UTC)
Received: from work-vm (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E43EC86C63;
 Tue, 14 Jan 2020 11:26:10 +0000 (UTC)
Date: Tue, 14 Jan 2020 11:26:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] memory: Allow a MemoryRegion to be marked no_vhost
Message-ID: <20200114112608.GF2812@work-vm>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <20200113173647.84842-3-dgilbert@redhat.com>
 <20200114021723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200114021723-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hsTrBIAePXSLW_T6NsYd1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: jasowang@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Jan 13, 2020 at 05:36:46PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Allow a memory region to be marked as 'no_vhost' and
> > exclude that region from vhost's list build.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> I thought we agreed vfio needs this as well?
> I'd rather this had some meaning not just "no vhost" ...
> no_dma?

VFIO tends to be unplugged on migration anyway (at the moment);
but I'm happy to change the name if everyone is happy with the rest of
the series and we can agree on the new name,

Dave

> > ---
> >  hw/virtio/vhost.c     |  3 ++-
> >  include/exec/memory.h | 21 +++++++++++++++++++++
> >  memory.c              | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 774d87d98e..462498bfe6 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -402,7 +402,8 @@ static bool vhost_section(struct vhost_dev *dev, Me=
moryRegionSection *section)
> >      bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
> >                       ~(1 << DIRTY_MEMORY_MIGRATION);
> >      result =3D memory_region_is_ram(section->mr) &&
> > -        !memory_region_is_rom(section->mr);
> > +             !memory_region_is_rom(section->mr) &&
> > +             !memory_region_get_no_vhost(section->mr);
> > =20
> >      /* Vhost doesn't handle any block which is doing dirty-tracking ot=
her
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
> > @@ -1625,6 +1626,26 @@ void memory_region_set_readonly(MemoryRegion *mr=
, bool readonly);
> >   */
> >  void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)=
;
> > =20
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
> > + * memory_region_set_no_vhost: Test if memory region is marked no vhos=
t
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
> > @@ -2136,6 +2136,21 @@ void memory_region_set_nonvolatile(MemoryRegion =
*mr, bool nonvolatile)
> >      }
> >  }
> > =20
> > +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
> > +{
> > +    if (mr->no_vhost !=3D no_vhost) {
> > +        memory_region_transaction_begin();
> > +        mr->no_vhost =3D no_vhost;
> > +        memory_region_update_pending |=3D mr->enabled;
> > +        memory_region_transaction_commit();
> > +    }
> > +}
> > +
> > +bool memory_region_get_no_vhost(const MemoryRegion *mr)
> > +{
> > +    return mr->no_vhost;
> > +}
> > +
> >  void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mod=
e)
> >  {
> >      if (mr->romd_mode !=3D romd_mode) {
> > --=20
> > 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


