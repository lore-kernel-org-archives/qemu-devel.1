Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C99C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1087F21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efaEfZ+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1087F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihMxo-0002ym-6X
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 19:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ihMx9-0002Xm-77
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ihMx4-0004zk-Tn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:12:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ihMx4-0004xc-Cw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576627949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vCgZ6l3/5Sjrv9LuCzhlpBJZrvN8esEHwannnnffZg=;
 b=efaEfZ+nbjJILOHWtPNNHPrzNytet35nGmUB2l6VpUtUNRLoxzNns8g5bZ6wP9FICS/xuA
 GPsD6YkQJhiAAHqsTFGwpZFYCH0bal6SGUWdX2wlb1QgFRVE5MxQm5S4lG2Iwpy9hqqraU
 +GhnuDgH61sOtQ3trAcSbdQbhK4oo+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-8vUHKMmBOwm-jc5M2YAb3Q-1; Tue, 17 Dec 2019 19:12:25 -0500
X-MC-Unique: 8vUHKMmBOwm-jc5M2YAb3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F3D71800D63;
 Wed, 18 Dec 2019 00:12:22 +0000 (UTC)
Received: from x1.home (ovpn-116-53.phx2.redhat.com [10.3.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 717AC6106B;
 Wed, 18 Dec 2019 00:12:20 +0000 (UTC)
Date: Tue, 17 Dec 2019 17:12:19 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v11 Kernel 6/6] vfio: Selective dirty page tracking if
 IOMMU backed device pins pages
Message-ID: <20191217171219.7cc3fc1d@x1.home>
In-Reply-To: <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 22:40:51 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Track dirty pages reporting capability for each vfio_device by setting the
> capability flag on calling vfio_pin_pages() for that device.
> 
> In vfio_iommu_type1 module, while creating dirty pages bitmap, check if
> IOMMU backed device is present in the container. If IOMMU backed device is
> present in container then check dirty pages reporting capability for each
> vfio device in the container. If all vfio devices are capable of reporing
> dirty pages tracking by pinning pages through external API, then report
> create bitmap of pinned pages only. If IOMMU backed device is present in
> the container and any one device is not able to report dirty pages, then
> marked all pages as dirty.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio.c             | 33 +++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c | 44 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/vfio.h            |  3 ++-
>  3 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c8482624ca34..9d2fbe09768a 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -96,6 +96,8 @@ struct vfio_device {
>  	struct vfio_group		*group;
>  	struct list_head		group_next;
>  	void				*device_data;
> +	/* dirty pages reporting capable */
> +	bool				dirty_pages_cap;
>  };
>  
>  #ifdef CONFIG_VFIO_NOIOMMU
> @@ -1866,6 +1868,29 @@ int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr, int num_irqs,
>  }
>  EXPORT_SYMBOL(vfio_set_irqs_validate_and_prepare);
>  
> +int vfio_device_is_dirty_reporting_capable(struct device *dev, bool *cap)
> +{
> +	struct vfio_device *device;
> +	struct vfio_group *group;
> +
> +	if (!dev || !cap)
> +		return -EINVAL;
> +
> +	group = vfio_group_get_from_dev(dev);
> +	if (!group)
> +		return -ENODEV;
> +
> +	device = vfio_group_get_device(group, dev);
> +	if (!device)
> +		return -ENODEV;
> +
> +	*cap = device->dirty_pages_cap;
> +	vfio_device_put(device);
> +	vfio_group_put(group);
> +	return 0;
> +}
> +EXPORT_SYMBOL(vfio_device_is_dirty_reporting_capable);

I'd suggest this just return true/false and any error condition simply
be part of the false case.

> +
>  /*
>   * Pin a set of guest PFNs and return their associated host PFNs for local
>   * domain only.
> @@ -1907,6 +1932,14 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
>  	else
>  		ret = -ENOTTY;
>  
> +	if (ret > 0) {
> +		struct vfio_device *device = vfio_group_get_device(group, dev);
> +
> +		if (device) {
> +			device->dirty_pages_cap = true;
> +			vfio_device_put(device);
> +		}
> +	}

I think we'd want to trivially rework vfio_pin_pages() to use
vfio_device_get_from_dev() instead of vfio_group_get_from_dev(), then
we have access to the group via device->group.  Then vfio_device_put()
would be common in the return path.

>  	vfio_group_try_dissolve_container(group);
>  
>  err_pin_pages:
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 68d8ed3b2665..ef56f31f4e73 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -891,6 +891,39 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>  	return bitmap;
>  }
>  
> +static int vfio_is_dirty_pages_reporting_capable(struct device *dev, void *data)
> +{
> +	bool new;
> +	int ret;
> +
> +	ret = vfio_device_is_dirty_reporting_capable(dev, &new);
> +	if (ret)
> +		return ret;
> +
> +	*(bool *)data = *(bool *)data && new;
> +
> +	return 0;
> +}
> +
> +static bool vfio_dirty_pages_reporting_capable(struct vfio_iommu *iommu)
> +{
> +	struct vfio_domain *d;
> +	struct vfio_group *g;
> +	bool capable = true;
> +	int ret;
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		list_for_each_entry(g, &d->group_list, next) {
> +			ret = iommu_group_for_each_dev(g->iommu_group, &capable,
> +					vfio_is_dirty_pages_reporting_capable);
> +			if (ret)
> +				return false;

This will fail when there are devices within the IOMMU group that are
not represented as vfio_devices.  My original suggestion was:

On Thu, 14 Nov 2019 14:06:25 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:
> I think it does so by pinning pages.  Is it acceptable that if the
> vendor driver pins any pages, then from that point forward we consider
> the IOMMU group dirty page scope to be limited to pinned pages?  There
> are complications around non-singleton IOMMU groups, but I think we're
> already leaning towards that being a non-worthwhile problem to solve.
> So if we require that only singleton IOMMU groups can pin pages and we

We could tag vfio_groups as singleton at vfio_add_group_dev() time with
an iommu_group_for_each_dev() walk so that we can cache the value on
the struct vfio_group.  vfio_group_nb_add_dev() could update this if
the IOMMU group composition changes.  vfio_pin_pages() could return
-EINVAL if (!group->is_singleton).

> pass the IOMMU group as a parameter to
> vfio_iommu_driver_ops.pin_pages(), then the type1 backend can set a
> flag on its local vfio_group struct to indicate dirty page scope is
> limited to pinned pages.

ie. vfio_iommu_type1_unpin_pages() calls find_iommu_group() on each
domain in domain_list and the external_domain using the struct
iommu_group pointer provided by vfio-core.  We set a new attribute on
the vfio_group to indicate that vfio_group has (at some point) pinned
pages.

>  We might want to keep a flag on the
> vfio_iommu struct to indicate if all of the vfio_groups for each
> vfio_domain in the vfio_iommu.domain_list dirty page scope limited to
> pinned pages as an optimization to avoid walking lists too often.  Then
> we could test if vfio_iommu.domain_list is not empty and this new flag
> does not limit the dirty page scope, then everything within each
> vfio_dma is considered dirty.

So at the point where we change vfio_group.has_pinned_pages from false
to true, or a group is added or removed, we walk all the groups in the
vfio_iommu and if they all have has_pinned_pages set, we can set a
vfio_iommu.pinned_page_dirty_scope flag to true.  If that flag is
already true on page pinning, we can skip the lookup.

I still like this approach better, it doesn't require a callback from
type1 to vfio-core and it doesn't require a heavy weight walking for
group devices and vfio data structures every time we fill a bitmap.
Did you run into issues trying to implement this approach?  Thanks,

Alex

> +		}
> +	}
> +
> +	return capable;
> +}
> +
>  /*
>   * start_iova is the reference from where bitmaping started. This is called
>   * from DMA_UNMAP where start_iova can be different than iova
> @@ -903,10 +936,17 @@ static void vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>  	struct vfio_dma *dma;
>  	dma_addr_t i = iova;
>  	unsigned long pgshift = __ffs(pgsize);
> +	bool dirty_report_cap = true;
> +
> +	if (IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> +		dirty_report_cap = vfio_dirty_pages_reporting_capable(iommu);
>  
>  	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
> -		/* mark all pages dirty if all pages are pinned and mapped. */
> -		if (dma->iommu_mapped) {
> +		/*
> +		 * mark all pages dirty if any IOMMU capable device is not able
> +		 * to report dirty pages and all pages are pinned and mapped.
> +		 */
> +		if (!dirty_report_cap && dma->iommu_mapped) {
>  			dma_addr_t iova_limit;
>  
>  			iova_limit = (dma->iova + dma->size) < (iova + size) ?
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e42a711a2800..ed3832ea10a1 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -148,7 +148,8 @@ extern int vfio_info_add_capability(struct vfio_info_cap *caps,
>  extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
>  					      int num_irqs, int max_irq_type,
>  					      size_t *data_size);
> -
> +extern int vfio_device_is_dirty_reporting_capable(struct device *dev,
> +						  bool *cap);
>  struct pci_dev;
>  #if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
>  extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);


