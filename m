Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B4C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5641A206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXXrdgkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5641A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHMK-000437-H2
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWHL7-00037g-BT
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:31:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWHL6-0001VB-9q
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588761102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCeZL78dx3bGgvMKLGR7LbrSKR4Lgd+HH3Z6CDhsDnk=;
 b=gXXrdgkSPgDpkhf7F05N+msNQy0yl2FsFonX8yVOfq/qQGWBuNiSqdlvZp2FWYg2r7IL30
 b70qF4RkbBUWfS7BK+kmZyVAxYqTwhwWXQzfTWs2kBMm1LJn3fHpwvXc8yJG6+4MDJYp4s
 wMU+1mDpEXNUlxj67ywcjiLa4oR2Nq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-erS3x1RqPpqW7DfMH618Zg-1; Wed, 06 May 2020 06:31:41 -0400
X-MC-Unique: erS3x1RqPpqW7DfMH618Zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A522107ACCA;
 Wed,  6 May 2020 10:31:38 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 011806061B;
 Wed,  6 May 2020 10:31:27 +0000 (UTC)
Date: Wed, 6 May 2020 12:31:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v18 QEMU 16/18] vfio: Add ioctl to get dirty pages
 bitmap during dma unmap.
Message-ID: <20200506123125.449dbf42.cohuck@redhat.com>
In-Reply-To: <1588632293-18932-17-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-17-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 04:14:51 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> With vIOMMU, IO virtual address range can get unmapped while in pre-copy
> phase of migration. In that case, unmap ioctl should return pages pinned
> in that range and QEMU should find its correcponding guest physical
> addresses and report those dirty.
> 
> Note: This patch is not yet tested. I'm trying to see how I can test this
> code path.

This remark should go beneath the '---' line, so that it does not end
up in the final commit.

> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4277b275ca21..b94e2bcb1178 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -311,11 +311,77 @@ static bool vfio_devices_are_stopped_and_saving(void)
>      return true;
>  }
>  
> +static bool vfio_devices_are_running_and_saving(void)

Maybe s/are/all/ to make it sure that the scope is *all* vfio devices
here?

Is there any global state for this which we could use to check this in
a simpler way?

> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +static int vfio_dma_unmap_bitmap(VFIOContainer *container,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb)
> +{
> +    struct vfio_iommu_type1_dma_unmap *unmap;
> +    struct vfio_bitmap *bitmap;
> +    uint64_t pages = TARGET_PAGE_ALIGN(size) >> TARGET_PAGE_BITS;
> +    int ret;
> +
> +    unmap = g_malloc0(sizeof(*unmap) + sizeof(*bitmap));

g_malloc0 cannot fail (it will abort). If you want to be able to
tolerate memory allocation failure, you should use g_try_malloc0().

> +    if (!unmap) {
> +        return -ENOMEM;
> +    }
> +
> +    unmap->argsz = sizeof(*unmap) + sizeof(*bitmap);
> +    unmap->flags |= VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP;
> +    bitmap = (struct vfio_bitmap *)&unmap->data;
> +
> +    /*
> +     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
> +     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap_pgsize to
> +     * TARGET_PAGE_SIZE.
> +     */
> +
> +    bitmap->pgsize = TARGET_PAGE_SIZE;
> +    bitmap->size = ROUND_UP(pages / 8, sizeof(uint64_t));
> +    bitmap->data = g_malloc0(bitmap->size);
> +    if (!bitmap->data) {
> +        error_report("UNMAP: Error allocating bitmap of size 0x%llx",
> +                     bitmap->size);
> +        g_free(unmap);
> +        return -ENOMEM;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +    if (!ret) {
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
> +                iotlb->translated_addr, pages);
> +    } else {
> +        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %d", -errno);
> +    }
> +
> +    g_free(bitmap->data);
> +    g_free(unmap);
> +    return ret;
> +}
> +


