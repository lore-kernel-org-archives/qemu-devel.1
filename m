Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04246C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BE920702
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoOdCPLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BE920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1Bj-0007Ad-3r
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo10z-00055K-MA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:44:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jo10w-0006vh-Vm
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592988253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdtqNw4S2sMH7eUDuZk9zxPX3WT6TtdpJqM3mburjNg=;
 b=LoOdCPLWwtulJuVv1xoEz4zgRzMZFfrWRAQ1JN/YMIfcN67tXWTEhDsIWBD+Un1sA6D869
 sCARKPLJQ0DYA5X3Hk7fVOeoy6EJjzfdee9nam8VU/BkbA7xOVUnGpottWdYZA/hWGm+UG
 nw9wEgops9nbuDfIDIez8nuBAjkzNNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-zteVp9sNPsG0hEVPPaN2Rw-1; Wed, 24 Jun 2020 04:44:09 -0400
X-MC-Unique: zteVp9sNPsG0hEVPPaN2Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A956E18585A2;
 Wed, 24 Jun 2020 08:44:07 +0000 (UTC)
Received: from gondolin (ovpn-113-3.ams2.redhat.com [10.36.113.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8662B1A835;
 Wed, 24 Jun 2020 08:43:53 +0000 (UTC)
Date: Wed, 24 Jun 2020 10:43:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 11/17] vfio: Get migration capability flags for
 container
Message-ID: <20200624104350.4e19d503.cohuck@redhat.com>
In-Reply-To: <1592684486-18511-12-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-12-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 Eric Auger <eric.auger@redhat.com>, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 01:51:20 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added helper functions to get IOMMU info capability chain.
> Added function to get migration capability information from that
> capability chain for IOMMU container.
> 
> Similar change was proposed earlier:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03759.html
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/common.c              | 91 +++++++++++++++++++++++++++++++++++++++----
>  include/hw/vfio/vfio-common.h |  3 ++
>  2 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 90e9a854d82c..e0d3d4585a65 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1229,6 +1229,75 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
>      return 0;
>  }
>  
> +static int vfio_get_iommu_info(VFIOContainer *container,
> +                               struct vfio_iommu_type1_info **info)
> +{
> +
> +    size_t argsz = sizeof(struct vfio_iommu_type1_info);
> +
> +    *info = g_new0(struct vfio_iommu_type1_info, 1);
> +again:
> +    (*info)->argsz = argsz;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
> +        g_free(*info);
> +        *info = NULL;
> +        return -errno;
> +    }
> +
> +    if (((*info)->argsz > argsz)) {
> +        argsz = (*info)->argsz;
> +        *info = g_realloc(*info, argsz);

Do we need to guard against getting a bogus argsz value causing a huge
allocation that might fail and crash the program?

> +        goto again;
> +    }
> +
> +    return 0;
> +}

(...)

> @@ -1314,15 +1384,20 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           * existing Type1 IOMMUs generally support any IOVA we're
>           * going to actually try in practice.
>           */
> -        info.argsz = sizeof(info);
> -        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, &info);
> -        /* Ignore errors */
> -        if (ret || !(info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
> +        ret = vfio_get_iommu_info(container, &info);

Previously, we ignored errors from the IOMMU_GET_INFO ioctl, now we
error out. Was that change intended?

> +        if (ret) {
> +                goto free_container_exit;
> +        }
> +
> +        if (!(info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
>              /* Assume 4k IOVA page size */
> -            info.iova_pgsizes = 4096;
> +            info->iova_pgsizes = 4096;
>          }
> -        vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
> -        container->pgsizes = info.iova_pgsizes;
> +        vfio_host_win_add(container, 0, (hwaddr)-1, info->iova_pgsizes);
> +        container->pgsizes = info->iova_pgsizes;
> +
> +        vfio_get_iommu_info_migration(container, info);
> +        g_free(info);
>          break;
>      }
>      case VFIO_SPAPR_TCE_v2_IOMMU:
(...)


