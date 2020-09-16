Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583AEC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B3C20738
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USvrbC6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B3C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUfu-0001fm-E1
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIUfA-00019K-SC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:27:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIUf7-0005XO-G9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600252059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3r5BXKyztzEtBmeGNXveozgvRVkJArVKVoAQJjc9l+Q=;
 b=USvrbC6D7c0JGcPnhaKcfPYKeYKw84KCL8MayerBrxnd2+JJdTv+dU8wDB8KXHW+n1Ctix
 TRL5IYHz1P7BFyFAFB37EzLFa+MBsKEZURsZYdnBrsrl2pf07OqbDoPw59u6bSBwPnPZJK
 84tBqYhp7epJtJ2UBGxaAcSPCG1l4aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-7-CPFY-LMKqIfYhtz5ucNA-1; Wed, 16 Sep 2020 06:27:38 -0400
X-MC-Unique: 7-CPFY-LMKqIfYhtz5ucNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41F75186DD25;
 Wed, 16 Sep 2020 10:27:36 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 952AB60BFA;
 Wed, 16 Sep 2020 10:27:23 +0000 (UTC)
Date: Wed, 16 Sep 2020 12:27:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 4/5] s390x/pci: Add routine to get the vfio dma
 available count
Message-ID: <20200916122720.4c7d8671.cohuck@redhat.com>
In-Reply-To: <0b28ae63-faad-953d-85c2-04bcdefeb7bf@redhat.com>
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-5-git-send-email-mjrosato@linux.ibm.com>
 <0b28ae63-faad-953d-85c2-04bcdefeb7bf@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 06:27:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, Matthew Rosato <mjrosato@linux.ibm.com>,
 pmorel@linux.ibm.com, david@redhat.com, qemu-s390x@nongnu.org,
 schnelle@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, alex.williamson@redhat.com, mst@redhat.com,
 kvm@vger.kernel.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 09:21:39 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 9/15/20 9:14 PM, Matthew Rosato wrote:
> > Create new files for separating out vfio-specific work for s390
> > pci. Add the first such routine, which issues VFIO_IOMMU_GET_INFO
> > ioctl to collect the current dma available count.
> >=20
> > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > ---
> >  hw/s390x/meson.build     |  1 +
> >  hw/s390x/s390-pci-vfio.c | 54 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/s390x/s390-pci-vfio.h | 17 +++++++++++++++
> >  3 files changed, 72 insertions(+)
> >  create mode 100644 hw/s390x/s390-pci-vfio.c
> >  create mode 100644 hw/s390x/s390-pci-vfio.h
> >=20

(...)

> > diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> > new file mode 100644
> > index 0000000..75e3ac1
> > --- /dev/null
> > +++ b/hw/s390x/s390-pci-vfio.c
> > @@ -0,0 +1,54 @@
> > +/*
> > + * s390 vfio-pci interfaces
> > + *
> > + * Copyright 2020 IBM Corp.
> > + * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> > + * your option) any later version. See the COPYING file in the top-lev=
el
> > + * directory.
> > + */
> > +
> > +#include <sys/ioctl.h>
> > +
> > +#include "qemu/osdep.h"
> > +#include "s390-pci-vfio.h"
> > +#include "hw/vfio/vfio-common.h"
> > +
> > +/*
> > + * Get the current DMA available count from vfio.  Returns true if vfi=
o is
> > + * limiting DMA requests, false otherwise.  The current available coun=
t read
> > + * from vfio is returned in avail.
> > + */
> > +bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
> > +{
> > +    g_autofree struct vfio_iommu_type1_info *info;
> > +    uint32_t argsz;
> > +    int ret;
> > +
> > +    assert(avail);
> > +
> > +    argsz =3D sizeof(struct vfio_iommu_type1_info);
> > +    info =3D g_malloc0(argsz);
> > +    info->argsz =3D argsz;
> > +    /*
> > +     * If the specified argsz is not large enough to contain all
> > +     * capabilities it will be updated upon return.  In this case
> > +     * use the updated value to get the entire capability chain.
> > +     */
> > +    ret =3D ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> > +    if (argsz !=3D info->argsz) {
> > +        argsz =3D info->argsz;
> > +        info =3D g_realloc(info, argsz); =20
>=20
> Do we need to bzero [sizeof(struct vfio_iommu_type1_info)..argsz[?

If we do, I think we need to do the equivalent in
vfio_get_region_info() as well?

(Also, shouldn't we check ret before looking at info->argsz?)

>=20
> > +        info->argsz =3D argsz;
> > +        ret =3D ioctl(fd, VFIO_IOMMU_GET_INFO, info);
> > +    }
> > +
> > +    if (ret) {
> > +        return false;
> > +    }
> > +
> > +    /* If the capability exists, update with the current value */
> > +    return vfio_get_info_dma_avail(info, avail);
> > +}
> > +

(...)


