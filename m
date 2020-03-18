Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0058DC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDD020768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CguFjonL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDD020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWt4-0005Kw-Tz
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jEWsN-0004ex-Fp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jEWsM-0004tR-DL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:28:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jEWsM-0004rb-9y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584530920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYiaxdq3GEr+yhR53QOC0XmBA5A6a1ROVCQOdPstx74=;
 b=CguFjonLq472WdUc+n8On7EEw8Fcovbe+fq3A0SMCsZA6xm62fxu4/j0y/o0fio9FStv2U
 UCvXUkFHmwyvNwC+nR9PNtFxV40bBFeKv06SfBTKn8GGgIbn3Qyisqa2x8IE9UNNeyilYt
 o3GudXve9P/IXt4b1pQyAB1GsKLXyK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-TA-jQDoOMR2v3KxjV4ThSg-1; Wed, 18 Mar 2020 07:28:37 -0400
X-MC-Unique: TA-jQDoOMR2v3KxjV4ThSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B3341005512;
 Wed, 18 Mar 2020 11:28:35 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16A725D9C5;
 Wed, 18 Mar 2020 11:28:23 +0000 (UTC)
Subject: Re: [PATCH v8 4/8] virtio-iommu: set supported page size mask
To: Bharat Bhushan <bbhushan2@marvell.com>, peter.maydell@linaro.org,
 peterx@redhat.com, eric.auger.pro@gmail.com, alex.williamson@redhat.com,
 kevin.tian@intel.com, mst@redhat.com, tnowicki@marvell.com,
 drjones@redhat.com, linuc.decode@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, bharatb.linux@gmail.com, jean-philippe@linaro.org,
 yang.zhong@intel.com
References: <20200318101159.8767-1-bbhushan2@marvell.com>
 <20200318101159.8767-5-bbhushan2@marvell.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3da60c1b-6897-7ab1-3a67-bec44fa00a54@redhat.com>
Date: Wed, 18 Mar 2020 12:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200318101159.8767-5-bbhushan2@marvell.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 3/18/20 11:11 AM, Bharat Bhushan wrote:
> Add optional interface to set page size mask.
> Currently this is set global configuration and not
> per endpoint.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v7->v8:
>  - new patch
> 
>  hw/virtio/virtio-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..c00a55348d 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -650,6 +650,15 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>      return (ua > ub) - (ua < ub);
>  }
>  
> +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> +                                            uint64_t page_size_mask)
> +{
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s = sdev->viommu;
> +
> +    s->config.page_size_mask = page_size_mask;
The problem is page_size_mask is global to the VIRTIO-IOMMU.

- Can't different VFIO containers impose different/inconsistent settings?
- VFIO devices can be hotplugged. So we may start with some default
page_size_mask which is latter overriden by a host imposed one. Assume
you first launch the VM with a virtio NIC. This uses 64K. Then you
hotplug a VFIO device behind a physical IOMMU which only supports 4K
pages. Isn't it a valid scenario?

Thanks

Eric

> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -865,6 +874,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = virtio_iommu_translate;
> +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> 


