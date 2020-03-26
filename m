Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77DFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA1420737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic6e0mBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA1420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSAg-0001BM-4K
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHSA2-0000e9-2s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHSA0-00019j-9a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:03:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHSA0-00019M-3t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585227779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evRg8WzGEz7x+U12OARajrVLlcSVvtwo5Xe+/Kysb7g=;
 b=ic6e0mBaszc6m2OnaCL/FNua9mY0bxrKAQFkz8KGmwD6Gb5ZkfBK7AtrAda1DJhUL+AuHp
 Eoe3SK4yb9Y0AgZ6jz7WQ3sk8qgq9neymYWD/SXVjpHD/60ONCkcEmwpjfy8G+yxh9yDLI
 /wJh7c5jQljwd3GKLsmf4sWeJlU0Pxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-1kuBZVg9MTm4_3mK_mKL2g-1; Thu, 26 Mar 2020 09:02:57 -0400
X-MC-Unique: 1kuBZVg9MTm4_3mK_mKL2g-1
Received: by mail-wm1-f69.google.com with SMTP id y1so2430034wmj.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aFL1ls+s+Uuiosop9UleN9TMvWOg15DAPu9qEfNR8Rg=;
 b=JLjKVWTR8GvNysZ3eKMsepqA4gL7Rn2MzBGGdO02kOGDCRluz58PxdPOLNnsgq79rU
 BypmbWsJN231ARDf7v84B/pd7Y3YG/7n5F1wocUbXmHuTX0QzqWUNWRGsQBOkzhNa7yD
 NSikC9ToUMinb7F3e1OQAh5lcYxnbGMzdF8tTjgAVUPQRXdmIUPAGbbuuRZxWvAkExxY
 uRCHrZyAuudDUK9tQIIoZIOzjEdIwVchuyKFnYDmsKVhmdIkRgjXTdXJJXk9zgZqby0h
 RrN+H9zdxPjK7CRoOjG4ERAdqfsLkfExnRMTY4gOltp6wKwD6P0eAdmDqOj1S614MPSH
 YlLw==
X-Gm-Message-State: ANhLgQ2yB7KB1BdLcbMkXfbH1QC9FYPVI1n4G5bEvjyx4GTOBg0ZCeZj
 /2CiEI5T3avYSkUGeNpzDXe4PB4GeBOlKf7sAKMoXoSZ/gtB47NsvvOQAixc2+9q0/zZEW/iuQP
 ZxHeQvfTseJ2gSX4=
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr3051566wmb.8.1585227773279;
 Thu, 26 Mar 2020 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMgRy6rIRFIPEDHNzKZwjriK2grTT250mENOTsiMhkAWF5QKOJ25G/UwMdgEy1VCjOXC5BLQ==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr3051540wmb.8.1585227773049;
 Thu, 26 Mar 2020 06:02:53 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n9sm3506624wru.50.2020.03.26.06.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:02:52 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:02:48 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
 invalidation to host
Message-ID: <20200326130248.GB422390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-21-git-send-email-yi.l.liu@intel.com>
 <20200324183423.GE127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2022C5@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A203E63@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A203E63@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 05:41:39AM +0000, Liu, Yi L wrote:
> > From: Liu, Yi L
> > Sent: Wednesday, March 25, 2020 9:22 PM
> > To: 'Peter Xu' <peterx@redhat.com>
> > Subject: RE: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
> > invalidation to host
> >=20
> > > From: Peter Xu <peterx@redhat.com>
> > > Sent: Wednesday, March 25, 2020 2:34 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotl=
b
> > > invalidation to host
> > >
> > > On Sun, Mar 22, 2020 at 05:36:17AM -0700, Liu Yi L wrote:
> > > > This patch propagates PASID-based iotlb invalidation to host.
> > > >
> > > > Intel VT-d 3.0 supports nested translation in PASID granular.
> > > > Guest SVA support could be implemented by configuring nested
> > > > translation on specific PASID. This is also known as dual stage DMA
> > > > translation.
> > > >
> > > > Under such configuration, guest owns the GVA->GPA translation which
> > > > is configured as first level page table in host side for a specific
> > > > pasid, and host owns GPA->HPA translation. As guest owns first leve=
l
> > > > translation table, piotlb invalidation should be propagated to host
> > > > since host IOMMU will cache first level page table related mappings
> > > > during DMA address translation.
> > > >
> > > > This patch traps the guest PASID-based iotlb flush and propagate it
> > > > to host.
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Richard Henderson <rth@twiddle.net>
> > > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > ---
> > > >  hw/i386/intel_iommu.c          | 139
> > > +++++++++++++++++++++++++++++++++++++++++
> > > >  hw/i386/intel_iommu_internal.h |   7 +++
> > > >  2 files changed, 146 insertions(+)
> > > >
> > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > > b9ac07d..10d314d 100644
> > > > --- a/hw/i386/intel_iommu.c
> > > > +++ b/hw/i386/intel_iommu.c
> > > > @@ -3134,15 +3134,154 @@ static bool
> > > vtd_process_pasid_desc(IntelIOMMUState *s,
> > > >      return (ret =3D=3D 0) ? true : false;  }
> > > >
> > > > +/**
> > > > + * Caller of this function should hold iommu_lock.
> > > > + */
> > > > +static void vtd_invalidate_piotlb(IntelIOMMUState *s,
> > > > +                                  VTDBus *vtd_bus,
> > > > +                                  int devfn,
> > > > +                                  DualIOMMUStage1Cache
> > > > +*stage1_cache) {
> > > > +    VTDHostIOMMUContext *vtd_dev_icx;
> > > > +    HostIOMMUContext *host_icx;
> > > > +
> > > > +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> > > > +    if (!vtd_dev_icx) {
> > > > +        goto out;
> > > > +    }
> > > > +    host_icx =3D vtd_dev_icx->host_icx;
> > > > +    if (!host_icx) {
> > > > +        goto out;
> > > > +    }
> > > > +    if (host_iommu_ctx_flush_stage1_cache(host_icx, stage1_cache))=
 {
> > > > +        error_report("Cache flush failed");
> > >
> > > I think this should not easily be triggered by the guest, but just in
> > > case... Let's use
> > > error_report_once() to be safe.
> >=20
> > Agreed.
> >=20
> > > > +    }
> > > > +out:
> > > > +    return;
> > > > +}
> > > > +
> > > > +static inline bool vtd_pasid_cache_valid(
> > > > +                          VTDPASIDAddressSpace *vtd_pasid_as) {
> > > > +    return vtd_pasid_as->iommu_state &&
                    ^^^^^^^^^^^^^^^^^^^^^^^^^

> > >
> > > This check can be dropped because always true?
> > >
> > > If you agree with both the changes, please add:
> > >
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> >=20
> > I think the code should ensure all the pasid_as in hash table is valid.=
 And we can
> > since all the operations are under protection of iommu_lock.
> >=20
> Peter,
>=20
> I think my reply was wrong. pasid_as in has table may be stale since
> the per pasid_as cache_gen may be not identical with the cache_gen
> in iommu_state. e.g. vtd_pasid_cache_reset() only increases the
> cache_gen in iommu_state. So there will be pasid_as in hash table
> which has cached pasid entry but its cache_gen is not equal to the
> one in iommu_state. For such pasid_as, we should treat it as stale.
> So I guess the vtd_pasid_cache_valid() is still necessary.

I guess you misread my comment. :)

I was saying the "vtd_pasid_as->iommu_state" check is not needed,
because iommu_state was always set if the address space is created.
vtd_pasid_cache_valid() is needed.

Also, please double confirm that vtd_pasid_cache_reset() should drop
all the address spaces (as I think it should), not "only increase the
cache_gen".  IMHO you should only increase the cache_gen in the PSI
hook (vtd_pasid_cache_psi()) only.

Thanks,

--=20
Peter Xu


