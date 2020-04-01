Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C49FC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AAF20678
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AAF20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJTwT-00073v-77
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 23:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJTvr-0006Yi-KV
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJTvq-0002Vj-FF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:20:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:38810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jJTvq-0002SY-6Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:20:46 -0400
IronPort-SDR: d6MS9V6fDv7m4/4QegVX0niWf7tImiN1pxjTlRt360FoE8x2vdYIhbFNgKzRb+6BQ/5XyMCtyB
 vBezko+RAzOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 20:20:45 -0700
IronPort-SDR: DPK9gyQBnEe3V8YRFGyinPVh5PBvRNVxBeQIZ+D4NvjJv4fxznqQzxh6YPavIs5efZ9H7Ygq3b
 9kqc4lwjuDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="450387728"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2020 20:20:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 20:20:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 20:20:44 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 31 Mar 2020 20:20:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 11:20:40 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 10/22] vfio/pci: set host iommu context to vIOMMU
Thread-Topic: [PATCH v2 10/22] vfio/pci: set host iommu context to vIOMMU
Thread-Index: AQHWBkpjlWASVTcKHUCJ2vYuB9rbdahiPwyAgAFDflA=
Date: Wed, 1 Apr 2020 03:20:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21C0FB@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-11-git-send-email-yi.l.liu@intel.com>
 <564d1a55-04df-a3bd-5241-e30f958a4e89@redhat.com>
In-Reply-To: <564d1a55-04df-a3bd-5241-e30f958a4e89@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric=1B$B!$=1B(B

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Tuesday, March 31, 2020 10:30 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 10/22] vfio/pci: set host iommu context to vIOMMU
>=20
> Yi,
>=20
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > For vfio-pci devices, it could use pci_device_set/unset_iommu() to
> > expose host iommu context to vIOMMU emulators. vIOMMU emulators could
> > make use the methods provided by host iommu context. e.g.
> > propagate requests to host iommu.
> I think I would squash this patch into the previous one.

sure, I can make it. :-)

> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/vfio/pci.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 5e75a95..c140c88
> > 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2717,6 +2717,7 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
> >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> >      VFIODevice *vbasedev_iter;
> >      VFIOGroup *group;
> > +    VFIOContainer *container;
> >      char *tmp, *subsys, group_path[PATH_MAX], *group_name;
> >      Error *err =3D NULL;
> >      ssize_t len;
> > @@ -3028,6 +3029,11 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
> >      vfio_register_req_notifier(vdev);
> >      vfio_setup_resetfn_quirk(vdev);
> >
> > +    container =3D vdev->vbasedev.group->container;
> > +    if (container->iommu_ctx.initialized) {
> Sin't it possible to dynamically allocate the iommu_ctx so that you can s=
imply check
> container->iommu_ctx and discard the initialized field?

iommu_ctx is allocated along with container as it is not a pointer in VFIOC=
ontainer.
The only way to check it is to have flag. :-)

Regards,
Yi Liu

