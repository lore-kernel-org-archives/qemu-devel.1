Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636BC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FAA2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/Jhe4ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FAA2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7pm-0003YJ-J5
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH7l4-0003bl-PF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH7l3-000803-0k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH7l2-0007zN-Sm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585149351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV/qB4XiviO7kh1hhG2n4hx9rW8OBYrSXnkFMevqrEY=;
 b=X/Jhe4eaxRA8TkMKou1paBR6OWvdp06viqKvOGlu9FBfLjZZbcUcj4kMykT3bqSTgQbjaH
 wLHpFjH0OC0ms+21fIHNsyEbdMX1RcBGqZfYq5r9f8aqwKKgbV+sh+gmZ7zjos8pxdVJSK
 pFOQUgV3NZ+XjXMlkRth96wN1KMji9U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-F-ThaBcENIyeQxv7d1uIhQ-1; Wed, 25 Mar 2020 11:15:48 -0400
X-MC-Unique: F-ThaBcENIyeQxv7d1uIhQ-1
Received: by mail-wr1-f70.google.com with SMTP id l17so1300903wro.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=85Iz7qm55ak28GWxIHEHs8MmNnZEjWo4E+H4mhBr6/Q=;
 b=Z4pNLZYmvhzXdAYrpvwlZlE+tBd2BMcU/6X3MFiHTYLpi3R4T845MEXuyHKRA5Cn+/
 b5TuwENCjtsES9hN+U/pMvdCSbawl+NBa9YGpp+ZNc1yXgVKjdso5Ft0drVumlqin/p9
 hPo3RJL6sAGNXWz1olHjEuuPmb4xw5VCJWAJLhLInqUafZ1ujM6kQ2EAUYNNeMLU9A68
 t3IqphoSA2AwXxQ47KJZMYMwjHtzkT4TwZdHeE0SJOwPzhHgCwdu7uFFzbT7cQiDXX6p
 3BU7QZgxAehuI2wlC5TjCJKzdRZxtcVQoG8VBU/rlGfLRplWwOtthXyUozva+HwltiUY
 I5VA==
X-Gm-Message-State: ANhLgQ1lxRmMG/17xrSkaVWgWTae3cJrpHPyRas2pACFE6bYgbLwwWus
 iHUlXRSoJXLtz1gx1H+PgogXVkfbk/WTntI+2AxSsih4O7swLKCAnr972IMs+NmGrPXGefo5r3i
 kObbohON3m9RowhU=
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr3936826wmb.8.1585149347011;
 Wed, 25 Mar 2020 08:15:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtvttgse0+xLvAuZ1+Y+vqPJhjVQWmRMDmQ8GkvLI7/TEIhbBiRpP5z+u7oZYO7GONLwyERYg==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr3936803wmb.8.1585149346812;
 Wed, 25 Mar 2020 08:15:46 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id y80sm10091321wmc.45.2020.03.25.08.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:46 -0700 (PDT)
Date: Wed, 25 Mar 2020 11:15:40 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Message-ID: <20200325151540.GE354390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-20-git-send-email-yi.l.liu@intel.com>
 <20200324182623.GD127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A202340@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A202340@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Wed, Mar 25, 2020 at 01:36:03PM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, March 25, 2020 2:26 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 19/22] intel_iommu: process PASID-based iotlb in=
validation
> >=20
> > On Sun, Mar 22, 2020 at 05:36:16AM -0700, Liu Yi L wrote:
> > > This patch adds the basic PASID-based iotlb (piotlb) invalidation
> > > support. piotlb is used during walking Intel VT-d 1st level page
> > > table. This patch only adds the basic processing. Detailed handling
> > > will be added in next patch.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 57
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h | 13 ++++++++++
> > >  2 files changed, 70 insertions(+)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > b007715..b9ac07d 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -3134,6 +3134,59 @@ static bool vtd_process_pasid_desc(IntelIOMMUS=
tate
> > *s,
> > >      return (ret =3D=3D 0) ? true : false;  }
> > >
> > > +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> > > +                                        uint16_t domain_id,
> > > +                                        uint32_t pasid) { }
> > > +
> > > +static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t =
domain_id,
> > > +                             uint32_t pasid, hwaddr addr, uint8_t am=
,
> > > +bool ih) { }
> > > +
> > > +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> > > +                                    VTDInvDesc *inv_desc) {
> > > +    uint16_t domain_id;
> > > +    uint32_t pasid;
> > > +    uint8_t am;
> > > +    hwaddr addr;
> > > +
> > > +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> > > +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
> > > +        error_report_once("non-zero-field-in-piotlb_inv_desc hi: 0x%=
" PRIx64
> > > +                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val=
[0]);
> > > +        return false;
> > > +    }
> > > +
> > > +    domain_id =3D VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
> > > +    pasid =3D VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
> > > +    switch (inv_desc->val[0] & VTD_INV_DESC_IOTLB_G) {
> > > +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
> > > +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
> > > +        break;
> > > +
> > > +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> > > +        am =3D VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> > > +        addr =3D (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1])=
;
> > > +        if (am > VTD_MAMV) {
> >=20
> > I saw this of spec 10.4.2, MAMV:
> >=20
> >         Independent of value reported in this field, implementations
> >         supporting SMTS must support address-selective PASID-based
> >         IOTLB invalidations (p_iotlb_inv_dsc) with any defined address
> >         mask.
> >=20
> > Does it mean we should even support larger AM?
> >=20
> > Besides that, the patch looks good to me.
>=20
> I don't think so. This field is for second-level table in scalable mode
> and the translation table in legacy mode. For first-level table, it alway=
s
> supports page selective invalidation and all the supported masks
> regardless of the PSI support bit and the MAMV field in the CAP_REG.

Yes that's exactly what I wanted to ask...  Let me try again.

I thought VTD_MAMV was only for 2nd level page table, not for
pasid-iotlb invalidations.  So I think we should remove this "if"
check (that corresponds to "we should even support larger AM"), right?

--=20
Peter Xu


