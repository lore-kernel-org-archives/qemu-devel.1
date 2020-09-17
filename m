Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F83C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBF920770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTeKMaUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF920770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqjc-0004H0-Hv
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIqhl-0002wP-Vn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIqhk-0001yH-1B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600336791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWSgbcBzg4cWtL5b5RCSUatW7JEAI/GyQ80ADBOGhu8=;
 b=VTeKMaUWxb6Xqi37Y6kvXgVAJzONGSt9PcIAtP4wUcGpns7lsJQ3Apeiukash6/BGo3Fr7
 A6whRFO3FSg3fHD69mT0IKpVNtVTFe/TOP+Bfd+sjoarD+epQl/FJD2mpcLgYk2PmZ5mxC
 RSbNURmqwoDrA05CM5mNtmxoCKrrujo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-OSzsdZQOOEmwcQHsch3YYQ-1; Thu, 17 Sep 2020 05:59:49 -0400
X-MC-Unique: OSzsdZQOOEmwcQHsch3YYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4436D1019629;
 Thu, 17 Sep 2020 09:59:48 +0000 (UTC)
Received: from gondolin (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB3C419D6C;
 Thu, 17 Sep 2020 09:59:36 +0000 (UTC)
Date: Thu, 17 Sep 2020 11:59:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] s390x/pci: Add routine to get the vfio dma
 available count
Message-ID: <20200917115934.4659537a.cohuck@redhat.com>
In-Reply-To: <a2599938-d0b8-4436-2cf6-ceed9bba28f3@linux.ibm.com>
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-5-git-send-email-mjrosato@linux.ibm.com>
 <0b28ae63-faad-953d-85c2-04bcdefeb7bf@redhat.com>
 <20200916122720.4c7d8671.cohuck@redhat.com>
 <a2599938-d0b8-4436-2cf6-ceed9bba28f3@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, alex.williamson@redhat.com, kvm@vger.kernel.org,
 pmorel@linux.ibm.com, schnelle@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 08:55:00 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 9/16/20 6:27 AM, Cornelia Huck wrote:
> > On Wed, 16 Sep 2020 09:21:39 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> On 9/15/20 9:14 PM, Matthew Rosato wrote: =20
> >>> Create new files for separating out vfio-specific work for s390
> >>> pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
> >>> ioctl to collect the current dma available count.
> >>>
> >>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >>> ---
> >>>   hw/s390x/meson.build     |  1 +
> >>>   hw/s390x/s390-pci-vfio.c | 54 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>   hw/s390x/s390-pci-vfio.h | 17 +++++++++++++++
> >>>   3 files changed, 72 insertions(+)
> >>>   create mode 100644 hw/s390x/s390-pci-vfio.c
> >>>   create mode 100644 hw/s390x/s390-pci-vfio.h
> >>> =20
> >=20
> > (...)
> >  =20
> >>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> >>> new file mode 100644
> >>> index 0000000..75e3ac1
> >>> --- /dev/null
> >>> +++ b/hw/s390x/s390-pci-vfio.c
> >>> @@ -0,0 +1,54 @@
> >>> +/*
> >>> + * s390 vfio-pci interfaces
> >>> + *
> >>> + * Copyright 2020 IBM Corp.
> >>> + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPL, version 2 o=
r (at
> >>> + * your option) any later version. See the COPYING file in the top-l=
evel
> >>> + * directory.
> >>> + */
> >>> +
> >>> +#include <sys/ioctl.h>
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "s390-pci-vfio.h"
> >>> +#include "hw/vfio/vfio-common.h"
> >>> +
> >>> +/*
> >>> + * Get the current DMA available count from vfio.  Returns true if v=
fio is
> >>> + * limiting DMA requests, false otherwise.  The current available co=
unt read
> >>> + * from vfio is returned in avail.
> >>> + */
> >>> +bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
> >>> +{
> >>> +    g_autofree struct vfio_iommu_type1_info *info;
> >>> +    uint32_t argsz;
> >>> +    int ret;
> >>> +
> >>> +    assert(avail);
> >>> +
> >>> +    argsz =3D sizeof(struct vfio_iommu_type1_info);
> >>> +    info =3D g_malloc0(argsz);
> >>> +    info->argsz =3D argsz;
> >>> +    /*
> >>> +     * If the specified argsz is not large enough to contain all
> >>> +     * capabilities it will be updated upon return.  In this case
> >>> +     * use the updated value to get the entire capability chain.
> >>> +     */
> >>> +    ret =3D ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> >>> +    if (argsz !=3D info->argsz) {
> >>> +        argsz =3D info->argsz;
> >>> +        info =3D g_realloc(info, argsz); =20
> >>
> >> Do we need to bzero [sizeof(struct vfio_iommu_type1_info)..argsz[? =20
> >=20
> > If we do, I think we need to do the equivalent in
> > vfio_get_region_info() as well?
> >  =20
>=20
> I agree that it would need to be in both places or neither -- I would=20
> expect the re-driven ioctl to overwrite the prior contents of info=20
> (unless we get a bad ret, but in this case we don't care what is in info)?
>=20
> Perhaps the fundamental difference between this code and=20
> vfio_get_region_info is that the latter checks for only a growing argsz=20
> and retries, whereas this code checks for !=3D so it's technically=20
> possible for a smaller argsz to trigger the retry here, and we wouldn't=20
> know for sure that all bytes from the first ioctl call were overwritten.

Nod. Relying on overwriting should be fine.

>=20
> What if I adjust this code to look like vfio_get_region_info:
>=20
> retry:
> 	info->argsz =3D argsz;
>=20
> 	if (ioctl(fd, VFIO_IOMMU_GET_INFO, info)) {
> 		// no need to g_free() bc of g_autofree
> 		return false;=09
> 	}
>=20
> 	if (info->argsz > argsz) {
> 		argsz =3D info->argsz;
> 		info =3D g_realloc(info, argsz);
> 		goto retry;
> 	}
>=20
> 	/* If the capability exists, update with the current value */
> 	return vfio_get_info_dma_avail(info, avail);
>=20
> Now we would only trigger when we are told by the host that the buffer=20
> must be larger.

I think that makes sense.

>=20
> > (Also, shouldn't we check ret before looking at info->argsz?)
> >  =20
>=20
> Yes, you are correct.  The above proposal would fix that issue too.
>=20
> >> =20
> >>> +        info->argsz =3D argsz;
> >>> +        ret =3D ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> >>> +    }
> >>> +
> >>> +    if (ret) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    /* If the capability exists, update with the current value */
> >>> +    return vfio_get_info_dma_avail(info, avail);
> >>> +}
> >>> + =20
> >=20
> > (...)
> >=20
> >  =20
>=20


