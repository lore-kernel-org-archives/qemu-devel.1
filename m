Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F331C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 03:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87497206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 03:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMZ2r2Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87497206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKmE-0001iO-6W
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 23:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kYKlT-000162-0z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 23:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kYKlR-0001bm-5s
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 23:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604027258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96EKGXICdvZUatC4qWQrSjIJRlwlmDPnX/b54TS9VlU=;
 b=LMZ2r2Sm/2izlsfN/b0PWX5APbacp3jfJWuvZwKewoW1dxVEUZQ/ySZyzOFSRt2g99Z9u6
 JXZ39K4KQ0XCtiQAsWMYEng38LROiqVIF19n7BTkP0v942pYqmEYmgWFr+0W2DjpuFzUP+
 FQuImNgw5XgD6Pnw5UdZLVwXjRkAMcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-i4cRAlRdMZaWtMsZjdbSuQ-1; Thu, 29 Oct 2020 23:07:37 -0400
X-MC-Unique: i4cRAlRdMZaWtMsZjdbSuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5BB80474A;
 Fri, 30 Oct 2020 03:07:35 +0000 (UTC)
Received: from x1.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6135F55767;
 Fri, 30 Oct 2020 03:07:35 +0000 (UTC)
Date: Thu, 29 Oct 2020 21:07:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Binfeng Wu <wubinfeng@huawei.com>
Subject: Re: [PATCH] vfio-pci: add Ascend devices passthrough quirks
Message-ID: <20201029210734.30cc5d4b@x1.home>
In-Reply-To: <20201029114048.700-1-wubinfeng@huawei.com>
References: <20201029114048.700-1-wubinfeng@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 23:04:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: xieyingtai@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 19:40:48 +0800
Binfeng Wu <wubinfeng@huawei.com> wrote:

> Ascend is a series of SoC processors developed by Huawei. Ascend310/910
> are highly efficient, flexible, and programmable AI processors in this
> series and support device passthrough via vfio-pci. Ascends device
> xloader update is only allowed in host, because update triggered by vm
> users may affect other users when Ascend devices passthrough to vm.
> Set a bar quirk is an effective method to keep vm users from updating
> xloader. In this patch, two bar quirks were proposed to cover
> Ascend310/910 respectively.


If you're trying to say that userspace, not just a VM, should not be
able to update this feature, then is QEMU the right place to implement
this quirk versus device specific protection within the host kernel?
Thanks,

Alex

> Signed-off-by: Binfeng Wu <wubinfeng@huawei.com>
> ---
>  hw/vfio/pci-quirks.c | 104 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 57150913b7..291a45d3ab 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1202,6 +1202,108 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>      return 0;
>  }
>  
> +#define PCI_VENDOR_ID_HUAWEI      0x19e5
> +#define PCI_DEVICE_ID_ASCEND910   0xd801
> +#define PCI_DEVICE_ID_ASCEND310   0xd100
> +#define ASCEND910_XLOADER_SIZE    4
> +#define ASCEND910_XLOADER_OFFSET  0x80400
> +#define ASCEND310_XLOADER_SIZE    4
> +#define ASCEND310_XLOADER_OFFSET  0x400
> +
> +typedef struct VFIOAscendBarQuirk {
> +    struct VFIOPCIDevice *vdev;
> +    pcibus_t offset;
> +    uint8_t bar;
> +    MemoryRegion *mem;
> +} VFIOAscendBarQuirk;
> +
> +static uint64_t vfio_ascend_quirk_read(void *opaque,
> +                                       hwaddr addr, unsigned size)
> +{
> +    VFIOAscendBarQuirk *quirk = opaque;
> +    VFIOPCIDevice *vdev = quirk->vdev;
> +
> +    return vfio_region_read(&vdev->bars[quirk->bar].region,
> +                            addr + quirk->offset, size);
> +}
> +
> +static void vfio_ascend_quirk_write(void *opaque, hwaddr addr,
> +                                    uint64_t data, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps vfio_ascend_intercept_regs_quirk = {
> +    .read = vfio_ascend_quirk_read,
> +    .write = vfio_ascend_quirk_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void vfio_probe_ascend_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOQuirk *quirk;
> +    VFIOAscendBarQuirk *bar0_quirk;
> +
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ASCEND910) ||
> +        nr != 0) {
> +        return;
> +    }
> +
> +    quirk = g_malloc0(sizeof(*quirk));
> +    quirk->nr_mem = 1;
> +    quirk->mem = g_new0(MemoryRegion, quirk->nr_mem);
> +    bar0_quirk = quirk->data = g_new0(typeof(*bar0_quirk), quirk->nr_mem);
> +    bar0_quirk[0].vdev = vdev;
> +    bar0_quirk[0].offset = ASCEND910_XLOADER_OFFSET;
> +    bar0_quirk[0].bar = nr;
> +
> +    /*
> +     * intercept w/r to the xloader-updating register,
> +     * so the vm can't enable xloader-updating
> +     */
> +    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
> +                          &vfio_ascend_intercept_regs_quirk,
> +                          &bar0_quirk[0],
> +                          "vfio-ascend-bar0-intercept-regs-quirk",
> +                          ASCEND910_XLOADER_SIZE);
> +    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                        bar0_quirk[0].offset,
> +                                        &quirk->mem[0], 1);
> +    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
> +}
> +
> +static void vfio_probe_ascend_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOQuirk *quirk;
> +    VFIOAscendBarQuirk *bar4_quirk;
> +
> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_ASCEND310) ||
> +        nr != 4) {
> +        return;
> +    }
> +
> +    quirk = g_malloc0(sizeof(*quirk));
> +    quirk->nr_mem = 1;
> +    quirk->mem = g_new0(MemoryRegion, quirk->nr_mem);
> +    bar4_quirk = quirk->data = g_new0(typeof(*bar4_quirk), quirk->nr_mem);
> +    bar4_quirk[0].vdev = vdev;
> +    bar4_quirk[0].offset = ASCEND310_XLOADER_OFFSET;
> +    bar4_quirk[0].bar = nr;
> +
> +    /*
> +     * intercept w/r to the xloader-updating register,
> +     * so the vm can't enable xloader-updating
> +     */
> +    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
> +                          &vfio_ascend_intercept_regs_quirk,
> +                          &bar4_quirk[0],
> +                          "vfio-ascend-bar4-intercept-regs-quirk",
> +                          ASCEND310_XLOADER_SIZE);
> +    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                        bar4_quirk[0].offset,
> +                                        &quirk->mem[0], 1);
> +    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
> +}
> +
>  /*
>   * Common quirk probe entry points.
>   */
> @@ -1251,6 +1353,8 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
>      vfio_probe_nvidia_bar5_quirk(vdev, nr);
>      vfio_probe_nvidia_bar0_quirk(vdev, nr);
>      vfio_probe_rtl8168_bar2_quirk(vdev, nr);
> +    vfio_probe_ascend_bar0_quirk(vdev, nr);
> +    vfio_probe_ascend_bar4_quirk(vdev, nr);
>  #ifdef CONFIG_VFIO_IGD
>      vfio_probe_igd_bar4_quirk(vdev, nr);
>  #endif


