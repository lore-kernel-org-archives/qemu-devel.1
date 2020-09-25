Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D0BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931D0238E2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931D0238E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrkt-0001hE-JI
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kLrjD-0000qS-Mz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:41:51 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:48049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kLrjB-0000VT-El
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:41:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.108])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id EAB355EF1E38;
 Fri, 25 Sep 2020 19:41:45 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 25 Sep
 2020 19:41:45 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002ff5d742e-d449-4c19-85fc-b9fa9d7f2c49,
 A5F0BA03093B57E977C960A2BE809674B2E579B9) smtp.auth=groug@kaod.org
Date: Fri, 25 Sep 2020 19:41:44 +0200
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: Ignore vrings in dirty log when using a vIOMMU
Message-ID: <20200925194144.73f9ee49@bahia.lan>
In-Reply-To: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
References: <160105498386.68108.2145229309875282336.stgit@bahia.lan>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 9d445f42-81a3-414a-92ac-8a1c79bc294b
X-Ovh-Tracer-Id: 3159556617512196515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpedvfefgtdegleduudejjeelfffghfehtdeigefggfduvdfgkeevgfeftedtjeehveenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 13:41:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, David
 Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Jason since this was detected using vhost-net.

On Fri, 25 Sep 2020 19:29:43 +0200
Greg Kurz <groug@kaod.org> wrote:

> When a vIOMMU is present, any address comming from the guest is an IO
> virtual address, including those of the vrings. The backend's accesses
> to the vrings happen through vIOMMU translation : the backend hence
> only logs the final guest physical address, not the IO virtual one.
> It thus doesn't make sense to make room for the vring addresses in the
> dirty log in this case.
> 
> This fixes a crash of the source when migrating a guest using in-kernel
> vhost-net and iommu_platform=on on POWER, because DMA regions are put
> at very high addresses and the resulting log size is likely to cause
> g_malloc0() to abort.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/virtio/vhost.c |   38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a642..0b83d6b8e65e 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -106,6 +106,20 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
>      }
>  }
>  
> +static int vhost_dev_has_iommu(struct vhost_dev *dev)
> +{
> +    VirtIODevice *vdev = dev->vdev;
> +
> +    /*
> +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> +     * incremental memory mapping API via IOTLB API. For platform that
> +     * does not have IOMMU, there's no need to enable this feature
> +     * which may cause unnecessary IOTLB miss/update trnasactions.
> +     */
> +    return vdev->dma_as != &address_space_memory &&
> +           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> +}
> +
>  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                     MemoryRegionSection *section,
>                                     hwaddr first,
> @@ -130,6 +144,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                range_get_last(reg->guest_phys_addr,
>                                               reg->memory_size));
>      }
> +
> +    if (vhost_dev_has_iommu(dev)) {
> +        return 0;
> +    }
> +
>      for (i = 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq = dev->vqs + i;
>  
> @@ -172,6 +191,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
>                                         reg->memory_size);
>          log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
>      }
> +
> +    if (vhost_dev_has_iommu(dev)) {
> +        return log_size;
> +    }
> +
>      for (i = 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq = dev->vqs + i;
>  
> @@ -287,20 +311,6 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
>      dev->log_size = size;
>  }
>  
> -static int vhost_dev_has_iommu(struct vhost_dev *dev)
> -{
> -    VirtIODevice *vdev = dev->vdev;
> -
> -    /*
> -     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
> -     * incremental memory mapping API via IOTLB API. For platform that
> -     * does not have IOMMU, there's no need to enable this feature
> -     * which may cause unnecessary IOTLB miss/update trnasactions.
> -     */
> -    return vdev->dma_as != &address_space_memory &&
> -           virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> -}
> -
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>                                hwaddr *plen, bool is_write)
>  {
> 
> 
> 


