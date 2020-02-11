Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91653C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E10020842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBWPO27M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E10020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TAB-00047q-JC
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1T88-0002ZU-OV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1T87-0001O0-5z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:51:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1T86-0001Nc-Sx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581418258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuNd+xVkOmanjXwHsmsthOqLlSTajm7KcAjF5bFiNow=;
 b=VBWPO27M7LuXqPetPRo19xHMNrg43AjCzOoICeOgwMTbaa+AINmGbdV1uRgq6lMMlof9HP
 pU9o6v6/vC8wjglP6jugams3UlJu1YWVctz+6cXb8qoIzW5VNUaTTh8rcgLxTRcBRQIYBo
 /6E9xez5XTFSDw1uG1KWh6N7NXrLb74=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-EIp5ilrWObiZiJSoO2r7qQ-1; Tue, 11 Feb 2020 05:50:54 -0500
Received: by mail-qv1-f72.google.com with SMTP id dc2so6890615qvb.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/iLP8nxdeVUUa3yiebMO4DQs1+XlpJFvaeRCJgzXnAQ=;
 b=hN0m+Xv/9WwaWiHZzLv7UKGvE288QgNBWr/6Fv+omw2SZ5LFbZPaQiw08QHI4IBXCw
 Kh3gL++mIltuASTXEsG5tEQ3Vm1QgOFrmu5rye4Z9bDm7HeeVgb8j4M6ShrAFN2snCrr
 szsbt/ldcadrXUxQ6aD8eMtjWrcLSZhgLzcfKByOkDux1j0g1x6Du+upJaaDLbhzsF51
 GJthI4aG3fTmtx6V6d8WzFp+Tng4W3K8FpAMeO5pulj/dB0PVFZOIXzt0tj3qdGPEElV
 qpwL5w4Vq3Zgz3nyrwbEw4NuWZi7sU26en9RUlLs1xNY2eT4pZiLISLmn4C1pMZWlxgW
 q5Dg==
X-Gm-Message-State: APjAAAXZf2HCvZY2a1npwy73BpTAAztsxeuZE18iTGqoqfrTU+PWHi8o
 A+fwCjsaxgUKu88VMhwRg8ZDtq2aGU1b7rubGSv0/ekKaLT+DPIXvgypFTFsCC9q+TGFIYoTPY4
 tqiM/UOlUzG579z0=
X-Received: by 2002:ac8:550a:: with SMTP id j10mr1819792qtq.354.1581418253802; 
 Tue, 11 Feb 2020 02:50:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkgcXnwef+vhl2XRhORS0wKZ4ojU5xtH4JsCht8mQ+VoGfbP5I4GLMangUp9jnNLyc+Yf1hw==
X-Received: by 2002:ac8:550a:: with SMTP id j10mr1819774qtq.354.1581418253474; 
 Tue, 11 Feb 2020 02:50:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id r1sm1921438qtu.83.2020.02.11.02.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 02:50:52 -0800 (PST)
Date: Tue, 11 Feb 2020 05:50:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200211055005-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: EIp5ilrWObiZiJSoO2r7qQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jasowang@redhat.com,
 jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>=20
> The standard virtio-mmio devices use notification register to signal
> backend. This will cause vmexits and slow down the performance when we
> passthrough the virtio-mmio devices to guest virtual machines.
> We proposed to update virtio over MMIO spec to add the per-queue
> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> configure notify location for each queue.
>=20
> [1] https://lkml.org/lkml/2020/1/21/31
>=20
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

So this is for pass-through for nested virt?
OK but let's split this out please, and benchmark separately.


> ---
>  drivers/virtio/virtio_mmio.c       | 37 ++++++++++++++++++++++++++++++++=
+++--
>  include/uapi/linux/virtio_config.h |  8 +++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..1733ab97 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -90,6 +90,9 @@ struct virtio_mmio_device {
>  =09/* a list of queues so we can dispatch IRQs */
>  =09spinlock_t lock;
>  =09struct list_head virtqueues;
> +
> +=09unsigned short notify_base;
> +=09unsigned short notify_multiplier;
>  };
> =20
>  struct virtio_mmio_vq_info {
> @@ -98,6 +101,9 @@ struct virtio_mmio_vq_info {
> =20
>  =09/* the list node for the virtqueues list */
>  =09struct list_head node;
> +
> +=09/* Notify Address*/
> +=09unsigned int notify_addr;
>  };
> =20
> =20
> @@ -119,13 +125,23 @@ static u64 vm_get_features(struct virtio_device *vd=
ev)
>  =09return features;
>  }
> =20
> +static void vm_transport_features(struct virtio_device *vdev, u64 featur=
es)
> +{
> +=09if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
> +=09=09__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
> +}
> +
>  static int vm_finalize_features(struct virtio_device *vdev)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +=09u64 features =3D vdev->features;
> =20
>  =09/* Give virtio_ring a chance to accept features. */
>  =09vring_transport_features(vdev);
> =20
> +=09/* Give virtio_mmio a chance to accept features. */
> +=09vm_transport_features(vdev, features);
> +
>  =09/* Make sure there is are no mixed devices */
>  =09if (vm_dev->version =3D=3D 2 &&
>  =09=09=09!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> @@ -272,10 +288,13 @@ static void vm_reset(struct virtio_device *vdev)
>  static bool vm_notify(struct virtqueue *vq)
>  {
>  =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vdev)=
;
> +=09struct virtio_mmio_vq_info *info =3D vq->priv;
> =20
> -=09/* We write the queue's selector into the notification register to
> +=09/* We write the queue's selector into the Notify Address to
>  =09 * signal the other end */
> -=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +=09if (info)
> +=09=09writel(vq->index, vm_dev->base + info->notify_addr);
> +
>  =09return true;
>  }
> =20
> @@ -434,6 +453,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_d=
evice *vdev, unsigned index,
>  =09vq->priv =3D info;
>  =09info->vq =3D vq;
> =20
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION))
> +=09=09info->notify_addr =3D vm_dev->notify_base +
> +=09=09=09=09vm_dev->notify_multiplier * vq->index;
> +=09else
> +=09=09info->notify_addr =3D VIRTIO_MMIO_QUEUE_NOTIFY;
> +
>  =09spin_lock_irqsave(&vm_dev->lock, flags);
>  =09list_add(&info->node, &vm_dev->virtqueues);
>  =09spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -471,6 +496,14 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned nvqs,
>  =09=09return irq;
>  =09}
> =20
> +=09if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
> +=09=09unsigned int notify =3D readl(vm_dev->base +
> +=09=09=09=09VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +=09=09vm_dev->notify_base =3D notify & 0xffff;
> +=09=09vm_dev->notify_multiplier =3D (notify >> 16) & 0xffff;
> +=09}
> +
>  =09err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>  =09=09=09dev_name(&vdev->dev), vm_dev);
>  =09if (err)
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virt=
io_config.h
> index ff8e7dc..5d93c01 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START=0928
> -#define VIRTIO_TRANSPORT_F_END=09=0938
> +#define VIRTIO_TRANSPORT_F_END=09=0940
> =20
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -88,4 +88,10 @@
>   * Does the device support Single Root I/O Virtualization?
>   */
>  #define VIRTIO_F_SR_IOV=09=09=0937
> +
> +/*
> + * This feature indicates the enhanced notification support on MMIO tran=
sport
> + * layer.
> + */
> +#define VIRTIO_F_MMIO_NOTIFICATION=0939
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> --=20
> 1.8.3.1


