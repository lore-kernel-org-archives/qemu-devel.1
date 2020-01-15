Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E41C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7652084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf2D5ZOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7652084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkAV-0002Id-RT
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irk9G-0001Dt-S9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irk9D-00030A-4Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:59:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irk9D-0002zk-0Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579100394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GYXbndxuVLwjwrUeXkrjbZpZELhNhiT8fxnA8rTfTc=;
 b=Tf2D5ZOdn2GZru7ZrBDOT4hwxdv1Qaf3koa688/ccLzyJptD3tFyzNc3Vxy+BBPV9X1b+4
 2ou9dyjmMuHiBjqQKTzPj1TThJxw7OQGlTPYNoJLdpRctoxPaAM40pui3xvwcbs/9OMhFS
 OShurLrAloXze4jncy+foIlSHREGCWM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-HxgENMeGPv6VNP248g-1Aw-1; Wed, 15 Jan 2020 09:59:53 -0500
Received: by mail-qv1-f71.google.com with SMTP id f16so11216166qvr.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 06:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b2t/lBaz/BRdyRqsxDl51uFxWKiCqyQvChrgFLnXSyA=;
 b=Iy6meB/a5p72FhtDR9ihFQEoHR1mhLZ99v8u7jtSFIo9dyL+zmh+lTyP5W1BM1d86d
 mCuxiBnhisvaohkYGWDYUOuFEuc8spI7g+GIa1wMH5rRJzs3S1BdFwqwXcEUz7FT3WJu
 CY7o1kGLkq3oUmhpMDqyXZR3PGy7nJy1aWRwM0VhUes5ueQKSC1SjCIlpPvT82KIL0yi
 li1TuG0yvitqZmfsJYvVaIp5fuTGoYEjv62ufDRs2mpsirQoWbQlOW8VIr43GD1zbXR/
 ykkVb3CS9Xj2iMDBoCIIqRaFEqoxjXhZqBgmCHvE25RMtoSKL70MA8wkLKr5POrmYLdf
 HVBQ==
X-Gm-Message-State: APjAAAWBoZr+VX9jg1n62c79Eu9uUV7A0Ox0JAWyTZQ/Z7apq9NWa43t
 OiIAjusuo614ztSEuowJOoLkoDDsBNX/tItCSSbMtBqPKO512l96eT01WGaqCjzPXvvX+ShdUu2
 H1jG+AYtbYX7xpC8=
X-Received: by 2002:ae9:e109:: with SMTP id g9mr27601629qkm.141.1579100392594; 
 Wed, 15 Jan 2020 06:59:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfueRUX3xdBL9Ru+4B0vHeNfk0tNi1+AefOuiWbOyIK9EAHltNxTLoqzVS0pM9l9NV/e/rEQ==
X-Received: by 2002:ae9:e109:: with SMTP id g9mr27601594qkm.141.1579100392247; 
 Wed, 15 Jan 2020 06:59:52 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id p185sm8606421qkd.126.2020.01.15.06.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 06:59:51 -0800 (PST)
Date: Wed, 15 Jan 2020 09:59:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 05/13] virtio-iommu: Endpoint and domains structs and
 helpers
Message-ID: <20200115145949.GC233443@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-6-eric.auger@redhat.com>
 <20200113202301.GD201624@xz-x1>
 <51267d84-c805-a4a1-8084-b278721a5b3f@redhat.com>
 <20200114180734.GB225163@xz-x1>
 <f3da181d-094b-a647-31ea-bdb47eab5c1b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f3da181d-094b-a647-31ea-bdb47eab5c1b@redhat.com>
X-MC-Unique: HxgENMeGPv6VNP248g-1Aw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 02:00:22PM +0100, Auger Eric wrote:
> Hi Peter,
>=20
>=20
> On 1/14/20 7:07 PM, Peter Xu wrote:
> > On Tue, Jan 14, 2020 at 09:51:59AM +0100, Auger Eric wrote:
> >> Hi Peter,
> >=20
> > Hi, Eric,
> >=20
> > [...]
> >=20
> >>>
> >>>> +{
> >>>> +    VirtIOIOMMUEndpoint *ep;
> >>>> +
> >>>> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> >>>> +    if (ep) {
> >>>> +        return ep;
> >>>> +    }
> >>>> +    if (!virtio_iommu_mr(s, ep_id)) {
> >>>
> >>> Could I ask when this will trigger?
> >>
> >> This can happen when a device is attached to a domain and its RID does
> >> not correspond to one of the devices protected by the iommu.
>=20
> >=20
> > So will it happen only because of a kernel driver bug?
>=20
> Yes, at the moment, because virtio_iommu_mr() only gets called on device
> attach to a domain.
>=20
> The spec says:
> "If the endpoint identified by endpoint doesn=E2=80=99t exist, the device=
 MUST
> reject the request and set status to VIRTIO_IOMMU_S_NOENT"

Sure.  I just wanted to make sure I didn't miss anything, because I
really can't see when this extra logic can help, say, right now we
only have one vIOMMU at least for VT-d, so all devices will be managed
by that.  But yeah if that's explicitly mentioned in the spec, I'd
agree we should follow that.

> >=20
> > Also, I think the name of "virtio_iommu_mr" is confusing on that it
> > returned explicitly a MemoryRegion however it's never been used:
>=20
> I use the same prototype as for smmu_iommu_mr(). Returning the iommu mr
> will allow to proceed with further RID based operations like invalidation=
s.
>=20
> The same logic is used in vtd_context_device_invalidate.

I'm fine with this.  Let's keep virtio_iommu_mr() as you prefer.

Another thing I'd like to mention is that, I don't think "the same
logic is used in VT-d" matters much. If we think something is wrong
(even if it's the same in VT-d), why not we fix both? :-)

Thanks,

>=20
>=20
> >=20
> > (since they're not in the same patch I'm pasting)
> >=20
> > static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
> > {
> >     uint8_t bus_n, devfn;
> >     IOMMUPciBus *iommu_pci_bus;
> >     IOMMUDevice *dev;
> >=20
> >     bus_n =3D PCI_BUS_NUM(sid);
> >     iommu_pci_bus =3D iommu_find_iommu_pcibus(s, bus_n);
> >     if (iommu_pci_bus) {
> >         devfn =3D sid & 0xFF;
> >         dev =3D iommu_pci_bus->pbdev[devfn];
> >         if (dev) {
> >             return &dev->iommu_mr;
> >         }
> >     }
> >     return NULL;
> > }
> >=20
> > Maybe "return !!dev" would be enough, then make the return a boolean?
> > Then we can rename it to virtio_iommu_has_device().
> >=20
> > PS. I think we can also drop IOMMU_PCI_DEVFN_MAX (after all you even
> > didn't use it here!) and use PCI_DEVFN_MAX, and replace 0xFF.
> well intel iommu and smmu use a similar constant (PCI_DEVFN_MAX,
> SMMU_PCI_DEVFN_MAX resp.). I use it in virtio_iommu_find_add_as

--=20
Peter Xu


