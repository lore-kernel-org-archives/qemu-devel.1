Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E0720772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoLYs+yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E0720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJESO-0001fy-Cl
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jJER7-0000eo-Jg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jJER5-0003I0-8s
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:48:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jJER5-0003Gp-4q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585651678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38QBf+KUJW2bcghEae4V9VBYJdyliTaWn0kE2CZJrjA=;
 b=RoLYs+yceUOQIPpdPIkegsV7StaRHzD8LpIMfOfHK4qEsVBToqZ4P8VoS3et2wslXugPeV
 hEixh8WAe3LdlVmk+ockYox4phUaaiMrkkWUeVypglvEo11dmfO2g0A5FzCs6eg5ZYJgVK
 wELOyH1dg1I96AJQu9VaBbqwM/M3PoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-CrfPxV5DPL6H_ElCT05g3g-1; Tue, 31 Mar 2020 06:47:57 -0400
X-MC-Unique: CrfPxV5DPL6H_ElCT05g3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E8418AB2C4;
 Tue, 31 Mar 2020 10:47:55 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD921100EBB7;
 Tue, 31 Mar 2020 10:47:42 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 08/22] vfio/common: provide PASID alloc/free hooks
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peterx@redhat.com
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-9-git-send-email-yi.l.liu@intel.com>
Message-ID: <e6d9a5bc-fd54-c220-067d-0597ad8e86fc@redhat.com>
Date: Tue, 31 Mar 2020 12:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-9-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
 pbonzini@redhat.com, hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi,

On 3/30/20 6:24 AM, Liu Yi L wrote:
> This patch defines vfio_host_iommu_context_info, implements the PASID
> alloc/free hooks defined in HostIOMMUContextClass.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/vfio/common.c                      | 69 +++++++++++++++++++++++++++++++++++
>  include/hw/iommu/host_iommu_context.h |  3 ++
>  include/hw/vfio/vfio-common.h         |  4 ++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index c276732..5f3534d 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1179,6 +1179,53 @@ static int vfio_get_iommu_type(VFIOContainer *container,
>      return -EINVAL;
>  }
>  
> +static int vfio_host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx,
> +                                           uint32_t min, uint32_t max,
> +                                           uint32_t *pasid)
> +{
> +    VFIOContainer *container = container_of(iommu_ctx,
> +                                            VFIOContainer, iommu_ctx);
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
you can easily avoid using argsz variable
> +    int ret;
> +
> +    argsz = sizeof(req);
> +    req.argsz = argsz;
> +    req.flags = VFIO_IOMMU_PASID_ALLOC;
> +    req.alloc_pasid.min = min;
> +    req.alloc_pasid.max = max;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
> +        ret = -errno;
> +        error_report("%s: %d, alloc failed", __func__, ret);
better use %m directly or strerror(errno)
also include vbasedev->name?
> +        return ret;
> +    }
> +    *pasid = req.alloc_pasid.result;
> +    return 0;
> +}
> +
> +static int vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
> +                                          uint32_t pasid)
> +{
> +    VFIOContainer *container = container_of(iommu_ctx,
> +                                            VFIOContainer, iommu_ctx);
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
same
> +    int ret;
> +
> +    argsz = sizeof(req);
> +    req.argsz = argsz;
> +    req.flags = VFIO_IOMMU_PASID_FREE;
> +    req.free_pasid = pasid;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
> +        ret = -errno;
> +        error_report("%s: %d, free failed", __func__, ret);
same
> +        return ret;
> +    }
> +    return 0;
> +}
> +
>  static int vfio_init_container(VFIOContainer *container, int group_fd,
>                                 Error **errp)
>  {
> @@ -1791,3 +1838,25 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>      }
>      return vfio_eeh_container_op(container, op);
>  }
> +
> +static void vfio_host_iommu_context_class_init(ObjectClass *klass,
> +                                                       void *data)
> +{
> +    HostIOMMUContextClass *hicxc = HOST_IOMMU_CONTEXT_CLASS(klass);
> +
> +    hicxc->pasid_alloc = vfio_host_iommu_ctx_pasid_alloc;
> +    hicxc->pasid_free = vfio_host_iommu_ctx_pasid_free;
> +}
> +
> +static const TypeInfo vfio_host_iommu_context_info = {
> +    .parent = TYPE_HOST_IOMMU_CONTEXT,
> +    .name = TYPE_VFIO_HOST_IOMMU_CONTEXT,
> +    .class_init = vfio_host_iommu_context_class_init,
Ah OK

This is the object inheriting from the abstract TYPE_HOST_IOMMU_CONTEXT.
I initially thought VTDHostIOMMUContext was, sorry for the misunderstanding.

Do you expect other HostIOMMUContext backends? Given the name and ops,
it looks really related to VFIO?

Thanks

Eric


> +};
> +
> +static void vfio_register_types(void)
> +{
> +    type_register_static(&vfio_host_iommu_context_info);
> +}
> +
> +type_init(vfio_register_types)
> diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
> index 35c4861..227c433 100644
> --- a/include/hw/iommu/host_iommu_context.h
> +++ b/include/hw/iommu/host_iommu_context.h
> @@ -33,6 +33,9 @@
>  #define TYPE_HOST_IOMMU_CONTEXT "qemu:host-iommu-context"
>  #define HOST_IOMMU_CONTEXT(obj) \
>          OBJECT_CHECK(HostIOMMUContext, (obj), TYPE_HOST_IOMMU_CONTEXT)
> +#define HOST_IOMMU_CONTEXT_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(HostIOMMUContextClass, (klass), \
> +                         TYPE_HOST_IOMMU_CONTEXT)
>  #define HOST_IOMMU_CONTEXT_GET_CLASS(obj) \
>          OBJECT_GET_CLASS(HostIOMMUContextClass, (obj), \
>                           TYPE_HOST_IOMMU_CONTEXT)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fd56420..0b07303 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -26,12 +26,15 @@
>  #include "qemu/notify.h"
>  #include "ui/console.h"
>  #include "hw/display/ramfb.h"
> +#include "hw/iommu/host_iommu_context.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
>  
>  #define VFIO_MSG_PREFIX "vfio %s: "
>  
> +#define TYPE_VFIO_HOST_IOMMU_CONTEXT "qemu:vfio-host-iommu-context"
> +
>  enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
> @@ -71,6 +74,7 @@ typedef struct VFIOContainer {
>      MemoryListener listener;
>      MemoryListener prereg_listener;
>      unsigned iommu_type;
> +    HostIOMMUContext iommu_ctx;
>      Error *error;
>      bool initialized;
>      unsigned long pgsizes;
> 


