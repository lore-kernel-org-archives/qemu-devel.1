Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E90C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117D720774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7kZhjN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117D720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkpi-0007D7-8W
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGkof-0006D8-8I
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGkod-00051I-Rm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGkod-00050i-Nm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVkUNlaG6/2t1lB0z2Yu1vZ3CmA6jFzBU3i641sJhw0=;
 b=E7kZhjN1uAr1bkmzn2wPUfGq8b1nLYeCpxH1Cijm2q2JWCRNvVtQ4YPSXJQL73sgPCnXsG
 MspVinePZOlK9NcdVn7iDf6WjPh9eJcmAiJORTpdmlY2Uicy8zV3Isl6af+IatGp/B+NrG
 1mVAa5M7yaWirGdRk8KEWNoruwnaf/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-zU-ggaJsNnKzdhuaSTyhhA-1; Tue, 24 Mar 2020 10:45:59 -0400
X-MC-Unique: zU-ggaJsNnKzdhuaSTyhhA-1
Received: by mail-wm1-f71.google.com with SMTP id h203so1310074wme.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HJt9mIvAgLVdLWEY0GDl93Plvr0uiaSZhoPdCdZCYdw=;
 b=eTvt4jUKjCq7cL+nj0TNJgShT1sS+lCrYacQTaeegGr0RuzW2AZTHTKH3899OAY7h4
 /l3UO5qyBeOW9w/IMv9UrgylulKNBBmQVTjR5q7S5+VZxedBuDuLOWBPxzSBjIAF4X1b
 C2JT83sByC+ipby7+9vMQesXAFLPtzKAvVZYKUzVSt4uw/0aQ9+Bz5dz+5ywjxBHYy8Y
 Ea5vRVmwrUeFjuiPolmCWWZmyqtQhqmaAs+QnT1Z+oOVr2FeoIGgsT+WnBHhRABiaV4l
 qNAn4Z4Wk2LtDM627VWzpH/jWuyli29tW8QKEftS1oGWvesJv8KBlxNssGYyrKo+AFfz
 Frqg==
X-Gm-Message-State: ANhLgQ32xEL1SwTS7RV+O6ikBaYSgXl8K9t+rAyMdy/TkuKkfJlpV8R3
 cYO5GtWLxMvUIJqaJuIo7TrUYkhb+aiKEjmSPlRy3YHbXTN/Ys9tI/BXxUzbKeWlZJtN2XcXDbo
 X3FC9q2N6FPnMGb0=
X-Received: by 2002:a7b:c189:: with SMTP id y9mr5703999wmi.47.1585061158242;
 Tue, 24 Mar 2020 07:45:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu3gn+H/ovKrBwuieprSiD/Bt+3YN3Wqy5eSJ0ZzLpDcEbr5d4ayWoIJreCQgp2R23siVAHqg==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr5703971wmi.47.1585061158024;
 Tue, 24 Mar 2020 07:45:58 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id k9sm30312702wrd.74.2020.03.24.07.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 07:45:57 -0700 (PDT)
Date: Tue, 24 Mar 2020 10:45:53 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
Message-ID: <20200324144553.GU127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-9-git-send-email-yi.l.liu@intel.com>
 <20200323213943.GR127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2006A9@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A2006A9@SHSMSX104.ccr.corp.intel.com>
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
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 01:03:28PM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Tuesday, March 24, 2020 5:40 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v1 08/22] vfio: init HostIOMMUContext per-container
> >=20
> > On Sun, Mar 22, 2020 at 05:36:05AM -0700, Liu Yi L wrote:
> > > After confirming dual stage DMA translation support with kernel by
> > > checking VFIO_TYPE1_NESTING_IOMMU, VFIO inits HostIOMMUContet instanc=
e
> > > and exposes it to PCI layer. Thus vIOMMU emualtors may make use of
> > > such capability by leveraging the methods provided by HostIOMMUContex=
t.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/vfio/common.c                      | 80 +++++++++++++++++++++++++=
++++++++++
> > >  hw/vfio/pci.c                         | 13 ++++++
> > >  include/hw/iommu/host_iommu_context.h |  3 ++
> > >  include/hw/vfio/vfio-common.h         |  4 ++
> > >  4 files changed, 100 insertions(+)
> > >
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index c276732..e4f5f10 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -1179,10 +1179,55 @@ static int vfio_get_iommu_type(VFIOContainer
> > *container,
> > >      return -EINVAL;
> > >  }
> > >
> > > +static int vfio_host_icx_pasid_alloc(HostIOMMUContext *host_icx,
> >=20
> > I'm not sure about Alex, but ... icx is confusing to me.  Maybe "ctx"
> > as you always used?
>=20
> At first I used vfio_host_iommu_ctx_pasid_alloc(), found it is long, so I
> switched to "icx" which means iommu_context. Maybe the former one
> looks better as it gives more precise info.

vfio_host_iommu_ctx_pasid_alloc() isn't that bad imho.  I'll omit the
"ctx" if I want to make it even shorter, but "icx" might be ambiguous.

Thanks,

--=20
Peter Xu


