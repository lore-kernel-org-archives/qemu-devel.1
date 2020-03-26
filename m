Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDA420737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzQySB5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUoD-0006CK-KM
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHUnZ-0005mH-Pv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHUnY-0000qs-Jw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:52:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHUnY-0000qY-G8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585237919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=be3ips6eGXoWwpTGAhWL/bVeP/QLHCVGDOD9oN5okII=;
 b=YzQySB5V7YZ/weWhXTvIA5NOFIrv4oVCIQBv398YAYtRzMduMb1TLtEMvKrfd01kiXvJaf
 ontlb5o15/ts9JeixLFFKMExT94pyvg60ABXyQNv5jCc7gk0jaDbP+DSJwjrwg7in5O/c4
 dE9a7+P4ybWU+C2zSecJaQOc4wFwp+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-URj52xGsM-uMBnTjjUqD2Q-1; Thu, 26 Mar 2020 11:51:58 -0400
X-MC-Unique: URj52xGsM-uMBnTjjUqD2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0503800D50;
 Thu, 26 Mar 2020 15:51:56 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB79560C18;
 Thu, 26 Mar 2020 15:51:45 +0000 (UTC)
Subject: Re: [PATCH v9 4/9] virtio-iommu: set supported page size mask
To: Bharat Bhushan <bbhushan2@marvell.com>, peter.maydell@linaro.org,
 peterx@redhat.com, eric.auger.pro@gmail.com, alex.williamson@redhat.com,
 kevin.tian@intel.com, mst@redhat.com, tnowicki@marvell.com,
 drjones@redhat.com, linuc.decode@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, bharatb.linux@gmail.com, jean-philippe@linaro.org,
 yang.zhong@intel.com
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-5-bbhushan2@marvell.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <994d9a4f-b8a8-7bda-f5a2-81d65711f580@redhat.com>
Date: Thu, 26 Mar 2020 16:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200323084617.1782-5-bbhushan2@marvell.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 3/23/20 9:46 AM, Bharat Bhushan wrote:
> Add optional interface to set page size mask.
> Currently this is set global configuration and not
> per endpoint.
This allows to override the page size mask per end-point?
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  include/hw/virtio/virtio-iommu.h | 1 +
>  hw/virtio/virtio-iommu.c         | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 6f67f1020a..4efa09610a 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -35,6 +35,7 @@ typedef struct IOMMUDevice {
>      void         *viommu;
>      PCIBus       *bus;
>      int           devfn;
> +    uint64_t      page_size_mask;
>      IOMMUMemoryRegion  iommu_mr;
>      AddressSpace  as;
>  } IOMMUDevice;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..a28818202c 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -650,6 +650,14 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>      return (ua > ub) - (ua < ub);
>  }
>  
> +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> +                                            uint64_t page_size_mask)
> +{
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +
> +    sdev->page_size_mask = page_size_mask;
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -865,6 +873,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = virtio_iommu_translate;
> +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> 
Thanks

Eric


