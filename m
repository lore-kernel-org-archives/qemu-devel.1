Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78034C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBABD222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+x7y9K8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBABD222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNaG-0000On-BY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irNYt-0007PX-De
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irNYn-0005H9-OG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:52:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irNYn-0005Fe-4d
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579013566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEary7P/WkRBDtPwQR3eQJ+Pp1FeZrzBCL6TjoaMgZA=;
 b=H+x7y9K8D5UQUdGttmp6p+bm9gWaYvmlitGPxkN6c4IjTcOpjG7Eode4JfdQoFjgS4RPlG
 LP61yKJ2Q5ydnjp/Q8Ju5lWwnf74DUH1p6/3qtRjGXWLmEqjddtCHZFfLJmy1b5QQks47M
 rhxL3atXkHz6qY6qQa70lynTVHTQ+Zc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-7XQMCNJOMo-kznz4RlrjGw-1; Tue, 14 Jan 2020 09:52:43 -0500
Received: by mail-qk1-f199.google.com with SMTP id k10so8457755qki.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gR3etKuJ2vqWRuEB74XQmO80NvWb+FwaNSbI/Uhd9N0=;
 b=iQsg8s4KW1cZNOlBk1hWULErGtAZEeDkc4525cElnA93ZmQ6rJx9vuRU8jpH0rlZcH
 2GuA6nAmnEyhqXq/nhS61BXzizxFnEXTH2Oy+X/OI68qSUfBs79Wb99dSToTwzhpPK0h
 cqQBLMwo51ms7eLT6B0Q2gLuD68uN3IKGWesemHhKbKwZPFmLTsrgkolueSyRKsDxZD+
 3Gt8O6L0elS6rYWkVdmeSESypRM7s8d4CaLKx1ago0Kh/vUr/2DUIfFW6bkSz0zz/diu
 ACXukT4RaQZ0aG/w0s6ImbPMMrHINGuSWkGAHlUTJ816ZTnNnyQLOmNlPdX2OnMemEum
 L+AA==
X-Gm-Message-State: APjAAAXmPSTd57CpLno2zvQR/VTtuQl4z17AvNW3PVxmW9W1/H4w6CdL
 UFoajook7GoFiTFZyDu+df70PfvfeGWxiI49+IzR4jF/LU4pXlICTShQ/4xezm369SMWtTbDucC
 HwVZkR6gXOzcXN24=
X-Received: by 2002:a05:620a:4db:: with SMTP id
 27mr22847274qks.146.1579013562872; 
 Tue, 14 Jan 2020 06:52:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv9qI39/pkWgvG8gGb/e9GWYa5q3vFRLI03bJrhxYCYTpGl8/fdPYycGG0fev7ppWAlG5gyA==
X-Received: by 2002:a05:620a:4db:: with SMTP id
 27mr22847262qks.146.1579013562659; 
 Tue, 14 Jan 2020 06:52:42 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id m68sm6718579qke.17.2020.01.14.06.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 06:52:41 -0800 (PST)
Date: Tue, 14 Jan 2020 09:52:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 2/3] memory: Allow a MemoryRegion to be marked no_vhost
Message-ID: <20200114095157-mutt-send-email-mst@kernel.org>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <20200113173647.84842-3-dgilbert@redhat.com>
 <20200114021723-mutt-send-email-mst@kernel.org>
 <20200114112608.GF2812@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200114112608.GF2812@work-vm>
X-MC-Unique: 7XQMCNJOMo-kznz4RlrjGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jasowang@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 11:26:08AM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Jan 13, 2020 at 05:36:46PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > Allow a memory region to be marked as 'no_vhost' and
> > > exclude that region from vhost's list build.
> > >=20
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > I thought we agreed vfio needs this as well?
> > I'd rather this had some meaning not just "no vhost" ...
> > no_dma?
>=20
> VFIO tends to be unplugged on migration anyway (at the moment);

But it still should ignore synic, right?

> but I'm happy to change the name if everyone is happy with the rest of
> the series and we can agree on the new name,
>=20
> Dave
>=20
> > > ---
> > >  hw/virtio/vhost.c     |  3 ++-
> > >  include/exec/memory.h | 21 +++++++++++++++++++++
> > >  memory.c              | 15 +++++++++++++++
> > >  3 files changed, 38 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 774d87d98e..462498bfe6 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -402,7 +402,8 @@ static bool vhost_section(struct vhost_dev *dev, =
MemoryRegionSection *section)
> > >      bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr)=
 &
> > >                       ~(1 << DIRTY_MEMORY_MIGRATION);
> > >      result =3D memory_region_is_ram(section->mr) &&
> > > -        !memory_region_is_rom(section->mr);
> > > +             !memory_region_is_rom(section->mr) &&
> > > +             !memory_region_get_no_vhost(section->mr);
> > > =20
> > >      /* Vhost doesn't handle any block which is doing dirty-tracking =
other
> > >       * than migration; this typically fires on VGA areas.
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index aef8123d48..f475c06d63 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -394,6 +394,7 @@ struct MemoryRegion {
> > >      bool ram_device;
> > >      bool enabled;
> > >      bool warning_printed; /* For reservations */
> > > +    bool no_vhost;
> > >      uint8_t vga_logging_count;
> > >      MemoryRegion *alias;
> > >      hwaddr alias_offset;
> > > @@ -1625,6 +1626,26 @@ void memory_region_set_readonly(MemoryRegion *=
mr, bool readonly);
> > >   */
> > >  void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatil=
e);
> > > =20
> > > +/**
> > > + * memory_region_set_no_vhost: Make vhost ignore a memory region
> > > + *
> > > + * Makes vhost ignore a memory region, useful if it isn't real
> > > + * DMAble memory and is at inconvenient addresses
> > > + *
> > > + * @mr: the region being updated.
> > > + * @no_vhost: true to ignore
> > > + */
> > > +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost);
> > > +
> > > +/**
> > > + * memory_region_set_no_vhost: Test if memory region is marked no vh=
ost
> > > + *
> > > + * Test if the no_vhost flag is set on the memory region
> > > + *
> > > + * @mr: the region being tested.
> > > + */
> > > +bool memory_region_get_no_vhost(const MemoryRegion *mr);
> > > +
> > >  /**
> > >   * memory_region_rom_device_set_romd: enable/disable ROMD mode
> > >   *
> > > diff --git a/memory.c b/memory.c
> > > index d7b9bb6951..9371998e30 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -2136,6 +2136,21 @@ void memory_region_set_nonvolatile(MemoryRegio=
n *mr, bool nonvolatile)
> > >      }
> > >  }
> > > =20
> > > +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
> > > +{
> > > +    if (mr->no_vhost !=3D no_vhost) {
> > > +        memory_region_transaction_begin();
> > > +        mr->no_vhost =3D no_vhost;
> > > +        memory_region_update_pending |=3D mr->enabled;
> > > +        memory_region_transaction_commit();
> > > +    }
> > > +}
> > > +
> > > +bool memory_region_get_no_vhost(const MemoryRegion *mr)
> > > +{
> > > +    return mr->no_vhost;
> > > +}
> > > +
> > >  void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_m=
ode)
> > >  {
> > >      if (mr->romd_mode !=3D romd_mode) {
> > > --=20
> > > 2.24.1
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


