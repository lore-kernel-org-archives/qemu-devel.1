Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URI_WP_DIRINDEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0CC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316C8206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOBV7gBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316C8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUBX-0008HA-5F
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGUAN-0007qg-P4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGUAL-0003Eb-2I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:59:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGUAK-0003EA-Rs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584997159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdVghb0UizTwy//pKkPY9WiXsBXAYtdQDRgQOBDpmwE=;
 b=fOBV7gBeUxmCJWIc/tC5DjUCXwP88/bo21To0i6UgYLP1I3zXMUlsMm9ayoEQ2DY94mt0h
 Mn0QmJH4a904tqFikRIgpO0ODl24OTgR6QcL61tkzTYKd80cGP9mKWP4XRbJhNfUY9sMgs
 5zUUgON8H28QOFkYFvkwQHyn51dMVXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-uxe9_6-eNx2suY9amTCZTw-1; Mon, 23 Mar 2020 16:58:55 -0400
X-MC-Unique: uxe9_6-eNx2suY9amTCZTw-1
Received: by mail-wm1-f70.google.com with SMTP id m4so513712wme.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 13:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y8VQAEc4YAeEN6M257SUREUMwxpCtK02OFut6H/UATU=;
 b=eBMzzCUslj217B/JOKjh7TBeJpfqSR8B2r/huQiipybD3/dxn1F2v/ryGnEx/FZJv6
 c9nX+L7nq68CV/MIee/1xmLcSVfczOYOpOM5oMuYIohA3ppJnWEjt+Kes/GXSNsh3ijh
 ISjQWnq8f3h6XCa8lMlYsYJrCovPqCBKJv9+pF5aIcKTi3AV/qZWiFL4z8fOO92ObWGO
 TE/Aqu2ABG9ofmv6IiSqFuEAvSEI2hO1S6hC8Hk/OUuTveiVWrJCzirEpY3+MofJS1Ef
 Std+9g8CRXVUSSRnFUd9R81IosqYjBuMQhj3JF1h1WNIeCixNQp2UIHl2qm3lLxpw3vB
 dMRw==
X-Gm-Message-State: ANhLgQ3rcv9stkRAUrxI5JSdjozRCzBlBANczIG0L68f53JcyxSRj+gL
 YJ4KpvxfgeGPEhHE8TIVhAegx0SmS9sIr78u0vAhPHyJQ/aTgCgbXoun4V4NTWBuQ5qgtcrrQgW
 AZ+jSuUlwtAJZf/s=
X-Received: by 2002:adf:8182:: with SMTP id 2mr30982767wra.37.1584997133936;
 Mon, 23 Mar 2020 13:58:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvuHU3mT9WAHbvRL8Qzx//EY6L5u4P+IFx88svQCyb/I96uUzUyTPqPtbdYK4UUZ+KaHUDgXQ==
X-Received: by 2002:adf:8182:: with SMTP id 2mr30982733wra.37.1584997133556;
 Mon, 23 Mar 2020 13:58:53 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a13sm25859236wrh.80.2020.03.23.13.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 13:58:52 -0700 (PDT)
Date: Mon, 23 Mar 2020 16:58:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 04/22] hw/iommu: introduce HostIOMMUContext
Message-ID: <20200323205849.GO127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-5-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-5-git-send-email-yi.l.liu@intel.com>
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:01AM -0700, Liu Yi L wrote:
> Currently, many platform vendors provide the capability of dual stage
> DMA address translation in hardware. For example, nested translation
> on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
> and etc. In dual stage DMA address translation, there are two stages
> address translation, stage-1 (a.k.a first-level) and stage-2 (a.k.a
> second-level) translation structures. Stage-1 translation results are
> also subjected to stage-2 translation structures. Take vSVA (Virtual
> Shared Virtual Addressing) as an example, guest IOMMU driver owns
> stage-1 translation structures (covers GVA->GPA translation), and host
> IOMMU driver owns stage-2 translation structures (covers GPA->HPA
> translation). VMM is responsible to bind stage-1 translation structures
> to host, thus hardware could achieve GVA->GPA and then GPA->HPA
> translation. For more background on SVA, refer the below links.
>  - https://www.youtube.com/watch?v=3DKq_nfGK5MwQ
>  - https://events19.lfasiallc.com/wp-content/uploads/2017/11/\
> Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf
>=20
> In QEMU, vIOMMU emulators expose IOMMUs to VM per their own spec (e.g.
> Intel VT-d spec). Devices are pass-through to guest via device pass-
> through components like VFIO. VFIO is a userspace driver framework
> which exposes host IOMMU programming capability to userspace in a
> secure manner. e.g. IOVA MAP/UNMAP requests. Thus the major connection
> between VFIO and vIOMMU are MAP/UNMAP. However, with the dual stage
> DMA translation support, there are more interactions between vIOMMU and
> VFIO as below:
>  1) PASID allocation (allow host to intercept in PASID allocation)
>  2) bind stage-1 translation structures to host
>  3) propagate stage-1 cache invalidation to host
>  4) DMA address translation fault (I/O page fault) servicing etc.
>=20
> With the above new interactions in QEMU, it requires an abstract layer
> to facilitate the above operations and expose to vIOMMU emulators as an
> explicit way for vIOMMU emulators call into VFIO. This patch introduces
> HostIOMMUContext to stand for hardware IOMMU w/ dual stage DMA address
> translation capability. And introduces HostIOMMUContextClass to provide
> methods for vIOMMU emulators to propagate dual-stage translation related
> requests to host. As a beginning, PASID allocation/free are defined to
> propagate PASID allocation/free requests to host which is helpful for the
> vendors who manage PASID in system-wide. In future, there will be more
> operations like bind_stage1_pgtbl, flush_stage1_cache and etc.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/Makefile.objs                      |   1 +
>  hw/iommu/Makefile.objs                |   1 +
>  hw/iommu/host_iommu_context.c         | 112 ++++++++++++++++++++++++++++=
++++++
>  include/hw/iommu/host_iommu_context.h |  75 +++++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>  create mode 100644 hw/iommu/Makefile.objs
>  create mode 100644 hw/iommu/host_iommu_context.c
>  create mode 100644 include/hw/iommu/host_iommu_context.h
>=20
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 660e2b4..cab83fe 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -40,6 +40,7 @@ devices-dirs-$(CONFIG_MEM_DEVICE) +=3D mem/
>  devices-dirs-$(CONFIG_NUBUS) +=3D nubus/
>  devices-dirs-y +=3D semihosting/
>  devices-dirs-y +=3D smbios/
> +devices-dirs-y +=3D iommu/
>  endif
> =20
>  common-obj-y +=3D $(devices-dirs-y)
> diff --git a/hw/iommu/Makefile.objs b/hw/iommu/Makefile.objs
> new file mode 100644
> index 0000000..e6eed4e
> --- /dev/null
> +++ b/hw/iommu/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y +=3D host_iommu_context.o
> diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.=
c
> new file mode 100644
> index 0000000..af61899
> --- /dev/null
> +++ b/hw/iommu/host_iommu_context.c

I'm not 100% sure it's the best place to put this; I thought hw/ is
for emulated devices while this is some host utility, but I could be
wrong.  However it'll always be some kind of backend of a vIOMMU,
so...  Maybe we can start with this until someone else disagrees.

> @@ -0,0 +1,112 @@
> +/*
> + * QEMU abstract of Host IOMMU
> + *
> + * Copyright (C) 2020 Intel Corporation.
> + *
> + * Authors: Liu Yi L <yi.l.liu@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object.h"
> +#include "qapi/visitor.h"
> +#include "hw/iommu/host_iommu_context.h"
> +
> +int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
> +                               uint32_t max, uint32_t *pasid)
> +{
> +    HostIOMMUContextClass *hicxc;
> +
> +    if (!host_icx) {
> +        return -EINVAL;
> +    }
> +
> +    hicxc =3D HOST_IOMMU_CONTEXT_GET_CLASS(host_icx);
> +
> +    if (!hicxc) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(host_icx->flags & HOST_IOMMU_PASID_REQUEST) ||
> +        !hicxc->pasid_alloc) {
> +        return -EINVAL;
> +    }
> +
> +    return hicxc->pasid_alloc(host_icx, min, max, pasid);
> +}
> +
> +int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid=
)
> +{
> +    HostIOMMUContextClass *hicxc;
> +
> +    if (!host_icx) {
> +        return -EINVAL;
> +    }
> +
> +    hicxc =3D HOST_IOMMU_CONTEXT_GET_CLASS(host_icx);
> +    if (!hicxc) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(host_icx->flags & HOST_IOMMU_PASID_REQUEST) ||
> +        !hicxc->pasid_free) {
> +        return -EINVAL;
> +    }
> +
> +    return hicxc->pasid_free(host_icx, pasid);
> +}
> +
> +void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
> +                         const char *mrtypename,
> +                         uint64_t flags)
> +{
> +    HostIOMMUContext *host_icx;
> +
> +    object_initialize(_host_icx, instance_size, mrtypename);
> +    host_icx =3D HOST_IOMMU_CONTEXT(_host_icx);
> +    host_icx->flags =3D flags;
> +    host_icx->initialized =3D true;
> +}
> +
> +void host_iommu_ctx_destroy(HostIOMMUContext *host_icx)
> +{
> +    host_icx->flags =3D 0x0;
> +    host_icx->initialized =3D false;
> +}

Can we simply put this into .instance_finalize() and be called
automatically when the object loses the last refcount?

Actually an easier way may be dropping this directly..  If the object
is to be destroyed then IMHO we don't need to care about flags at all,
we just free memories we use, but for this object it's none.

> +
> +static void host_icx_init_fn(Object *obj)
> +{
> +    HostIOMMUContext *host_icx =3D HOST_IOMMU_CONTEXT(obj);
> +
> +    host_icx->flags =3D 0x0;
> +    host_icx->initialized =3D false;

Here is also a bit strange...  IIUC the only way to init this object
is via host_iommu_ctx_init() where all these flags will be set.  But
if so, then we're setting all these twice always.  Maybe this function
can be dropped too?

Thanks,

> +}
> +
> +static const TypeInfo host_iommu_context_info =3D {
> +    .parent             =3D TYPE_OBJECT,
> +    .name               =3D TYPE_HOST_IOMMU_CONTEXT,
> +    .class_size         =3D sizeof(HostIOMMUContextClass),
> +    .instance_size      =3D sizeof(HostIOMMUContext),
> +    .instance_init      =3D host_icx_init_fn,
> +    .abstract           =3D true,
> +};
> +
> +static void host_icx_register_types(void)
> +{
> +    type_register_static(&host_iommu_context_info);
> +}
> +
> +type_init(host_icx_register_types)
> diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/hos=
t_iommu_context.h
> new file mode 100644
> index 0000000..cfbf5ac
> --- /dev/null
> +++ b/include/hw/iommu/host_iommu_context.h
> @@ -0,0 +1,75 @@
> +/*
> + * QEMU abstraction of Host IOMMU
> + *
> + * Copyright (C) 2020 Intel Corporation.
> + *
> + * Authors: Liu Yi L <yi.l.liu@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_IOMMU_CONTEXT_H
> +#define HW_IOMMU_CONTEXT_H
> +
> +#include "qemu/queue.h"
> +#include "qemu/thread.h"
> +#include "qom/object.h"
> +#include <linux/iommu.h>
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/hwaddr.h"
> +#endif
> +
> +#define TYPE_HOST_IOMMU_CONTEXT "qemu:host-iommu-context"
> +#define HOST_IOMMU_CONTEXT(obj) \
> +        OBJECT_CHECK(HostIOMMUContext, (obj), TYPE_HOST_IOMMU_CONTEXT)
> +#define HOST_IOMMU_CONTEXT_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(HostIOMMUContextClass, (obj), \
> +                         TYPE_HOST_IOMMU_CONTEXT)
> +
> +typedef struct HostIOMMUContext HostIOMMUContext;
> +
> +typedef struct HostIOMMUContextClass {
> +    /* private */
> +    ObjectClass parent_class;
> +
> +    /* Allocate pasid from HostIOMMUContext (a.k.a. host software) */
> +    int (*pasid_alloc)(HostIOMMUContext *host_icx,
> +                       uint32_t min,
> +                       uint32_t max,
> +                       uint32_t *pasid);
> +    /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
> +    int (*pasid_free)(HostIOMMUContext *host_icx,
> +                      uint32_t pasid);
> +} HostIOMMUContextClass;
> +
> +/*
> + * This is an abstraction of host IOMMU with dual-stage capability
> + */
> +struct HostIOMMUContext {
> +    Object parent_obj;
> +#define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
> +    uint64_t flags;
> +    bool initialized;
> +};
> +
> +int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
> +                               uint32_t max, uint32_t *pasid);
> +int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid=
);
> +
> +void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
> +                         const char *mrtypename,
> +                         uint64_t flags);
> +void host_iommu_ctx_destroy(HostIOMMUContext *host_icx);
> +
> +#endif
> --=20
> 2.7.4
>=20

--=20
Peter Xu


