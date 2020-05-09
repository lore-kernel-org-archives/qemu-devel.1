Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12732C38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D712A218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUjydXdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D712A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXFmg-0005ZN-47
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 23:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFlV-0004cu-80
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:03:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFlU-0000pi-C3
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588993379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1d2cl5fOBnupjH2szvsNOlLiQmSU01TVIdiz+YXBNsU=;
 b=MUjydXdiuVSTaBsOhBGozH4O5caKenMtMXcmPLuQbvkEU6lIzDy7vFBT/1CQqwRr+ZlF19
 QaB8y372VlamzDNxrSczhs74/0GcZ36Tw/TUO1hpIPbckxrAyF8OrWyhQSAP5gS3SaroRu
 L6mkFkAAUROA/16NYdD7yNw0gYrGfgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-asHHVjxxPsGeDqe641NLaw-1; Fri, 08 May 2020 23:02:57 -0400
X-MC-Unique: asHHVjxxPsGeDqe641NLaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47642464;
 Sat,  9 May 2020 03:02:55 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77E842E186;
 Sat,  9 May 2020 03:02:35 +0000 (UTC)
Subject: Re: [RFC v2 7/9] virito-pci: implement queue_enabled method
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f479fdd3-22f8-31a6-2f21-3ad8970b0b05@redhat.com>
Date: Sat, 9 May 2020 11:02:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-8-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 22:25:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/9 上午12:32, Cindy Lu wrote:
> From: Jason Wang <jasowang@redhat.com>
>
> With version 1, we can detect whether a queue is enabled via
> queue_enabled.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


This patch should come before any vhost-vdpa patch.

Thanks


> ---
>   hw/virtio/virtio-pci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..4aaf5d953e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
>       return pci_get_address_space(dev);
>   }
>   
> +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> +{
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        return proxy->vqs[vdev->queue_sel].enabled;
> +    }
> +
> +    return virtio_queue_get_desc_addr(vdev, n) != 0;
> +}
> +
>   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>                                      struct virtio_pci_cap *cap)
>   {
> @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>       k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
>       k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
>       k->get_dma_as = virtio_pci_get_dma_as;
> +    k->queue_enabled = virtio_pci_queue_enabled;
>   }
>   
>   static const TypeInfo virtio_pci_bus_info = {


