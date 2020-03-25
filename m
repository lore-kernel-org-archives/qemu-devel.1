Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A62C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C2120719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2ve5a71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C2120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7iK-0000wp-6f
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jH7hd-0000EE-Uj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jH7hc-0005XV-Cq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:12:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jH7hc-0005VG-8X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585149139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpX64YQtJm4ujg56oJNHBQs9VC+OnT7YID8fWL1FT4s=;
 b=X2ve5a71V9TnEeGa9ztZp924Xe+ZlNsS6tgcIynTatp0YY7exVh1WHIR+5zfhfRokXK2j4
 3UdXAZP9Y27VTc+5FKPBbDuAP2cB4r3rojmWJM1ssmTI0oMwY2xqT2rWt35IARRh6xj4F8
 zpNP4TBSnbq6Uvu4rrT721lD0/vydAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-QAF3NmXFMImP1Q8T30WGPg-1; Wed, 25 Mar 2020 11:12:11 -0400
X-MC-Unique: QAF3NmXFMImP1Q8T30WGPg-1
Received: by mail-wm1-f69.google.com with SMTP id y1so1005728wmj.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BF8rpSmfd7uy+0GUmrMmaYfuGnMqUZoMQRMQpXoo6Oc=;
 b=ejoTVfcRa9H101G4b9LOSoTR+dGyH33CKnSvXjndrKDxR/343t5wtW6SfaV6lmNayG
 GjbcfD6YuhiVLgle4N1J7UirY51tUFBGWWBB3i1nehOqQG27VtWIo8XTq2fda8T7fRJU
 cZ7IDa6QIJPy5BFDXPMSYL2v7C/WQpJ2XCl2f5725dBnxOv1+Ii5Fp0E6Bf1GoAgP5tN
 DltOGoY3gEcKM+pwBozcwy1RiKKOkKVRo9h7/xJ7RZJ180J0F9t1OTOBSdtiDy6tbpZt
 5crQeFoooV8I37zbn82fRzYWuhhetLu1V15Di7Pplb5mA4OJv8RdzdAIN4YpQJUtgmdG
 EQLA==
X-Gm-Message-State: ANhLgQ3TlTjxHCfGzOvMOS78S2ryw65+eSADpqidIgDzAOv+Jb5ehwMO
 3bSeJto2QRibwm7+0YA44FXQfXCYGSXHBCecl1UKpZtJiUaXAqWWtjpP2jcxqMWktuItwUhgPfW
 fUZ63BgJizzqNtJc=
X-Received: by 2002:adf:82a6:: with SMTP id 35mr3958073wrc.307.1585149130667; 
 Wed, 25 Mar 2020 08:12:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJSAeAijCToDir/jXjYps+m1+WT66rSqwQyM4y5jMfMZPwTvoFMa55jDZ/hXUUp/cd520hqw==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr3958028wrc.307.1585149130322; 
 Wed, 25 Mar 2020 08:12:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k126sm9743577wme.4.2020.03.25.08.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:12:09 -0700 (PDT)
Date: Wed, 25 Mar 2020 11:12:05 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 17/22] intel_iommu: do not pass down pasid bind for
 PASID #0
Message-ID: <20200325151205.GD354390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-18-git-send-email-yi.l.liu@intel.com>
 <20200324181326.GB127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A201FC7@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A201FC7@SHSMSX104.ccr.corp.intel.com>
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

On Wed, Mar 25, 2020 at 10:42:25AM +0000, Liu, Yi L wrote:
> > From: Peter Xu < peterx@redhat.com>
> > Sent: Wednesday, March 25, 2020 2:13 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 17/22] intel_iommu: do not pass down pasid bind =
for PASID
> > #0
> >=20
> > On Sun, Mar 22, 2020 at 05:36:14AM -0700, Liu Yi L wrote:
> > > RID_PASID field was introduced in VT-d 3.0 spec, it is used for DMA
> > > requests w/o PASID in scalable mode VT-d. It is also known as IOVA.
> > > And in VT-d 3.1 spec, there is definition on it:
> > >
> > > "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is
> > > 0b), use a PASID value of 0 to perform address translation for
> > > requests without PASID."
> > >
> > > This patch adds a check against the PASIDs which are going to be boun=
d
> > > to device. For PASID #0, it is not necessary to pass down pasid bind
> > > request for it since PASID #0 is used as RID_PASID for DMA requests
> > > without pasid. Further reason is current Intel vIOMMU supports gIOVA
> > > by shadowing guest 2nd level page table. However, in future, if guest
> > > IOMMU driver uses 1st level page table to store IOVA mappings, then
> > > guest IOVA support will also be done via nested translation. When
> > > gIOVA is over FLPT, then vIOMMU should pass down the pasid bind
> > > request for PASID #0 to host, host needs to bind the guest IOVA page
> > > table to a proper PASID. e.g PASID value in RID_PASID field for PF/VF
> > > if ECAP_REG.RPS is clear or default PASID for ADI (Assignable Device
> > > Interface in Scalable IOV solution).
> > >
> > > IOVA over FLPT support on Intel VT-d:
> > > https://lkml.org/lkml/2019/9/23/297
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
> > >  hw/i386/intel_iommu.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > > 1e0ccde..b007715 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -1886,6 +1886,16 @@ static int vtd_bind_guest_pasid(IntelIOMMUStat=
e *s,
> > VTDBus *vtd_bus,
> > >      struct iommu_gpasid_bind_data *g_bind_data;
> > >      int ret =3D -1;
> > >
> > > +    if (pasid < VTD_MIN_HPASID) {
> > > +        /*
> > > +         * If pasid < VTD_HPASID_MIN, this pasid is not allocated
> >=20
> > s/VTD_HPASID_MIN/VTD_MIN_HPASID/.
>=20
> Got it.
>=20
> >=20
> > > +         * from host. No need to pass down the changes on it to host=
.
> > > +         * TODO: when IOVA over FLPT is ready, this switch should be
> > > +         * refined.
> >=20
> > What will happen if without this patch?  Is it a must?
>=20
> Before gIOVA is supported by nested translation, it is a must. This requi=
res
> IOVA over 1st level page table is ready in guest kernel, also requires th=
e
> QEMU/VFIO supports to bind the guest IOVA page table to host.
> Currently, guest kernel side is ready. However, QEMU and VFIO side is
> not.

OK:

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


