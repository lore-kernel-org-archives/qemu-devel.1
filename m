Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE67DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8961C207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYBteqlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8961C207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZ8t-0002lZ-P8
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZ51-0004Vs-QZ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:05:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZ4z-0001Iq-5V
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590735919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLQXlROipldaRYVPe/2ZLrtzt6Y82fSWi4h5M7h8trs=;
 b=RYBteqlq7bnwOzR33Sf7v/9whtZ5Jocu23bjt4wxq+Dt5KgUYcPzjtDbf8/PSvogR1CHbs
 ulURJTrN/CKMIS7iaBbBi3jIdqpOclp8MyMhu7znoR0Iz3+p1MpLg6neTvIQQoTw++Q91/
 MyjF/eiQdHTk9vm9aO14vdq3Ts6ak6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-gGAQSgjSO0a3tmnUxADb7w-1; Fri, 29 May 2020 03:05:17 -0400
X-MC-Unique: gGAQSgjSO0a3tmnUxADb7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A6411855A0E;
 Fri, 29 May 2020 07:05:16 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A773919930;
 Fri, 29 May 2020 07:04:56 +0000 (UTC)
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
Date: Fri, 29 May 2020 15:04:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522171726.648279-3-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/23 上午1:17, Stefan Hajnoczi wrote:
> Many vhost devices in QEMU currently do not involve the device backend
> in feature negotiation. This seems fine at first glance for device types
> without their own feature bits (virtio-net has many but other device
> types have none).
>
> This overlooks the fact that QEMU's virtqueue implementation and the
> device backend's implementation may support different features.  QEMU
> must not report features to the guest that the the device backend
> doesn't support.
>
> For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> existing vhost device backends do not. When the user sets packed=on the
> device backend breaks. This should have been handled gracefully by
> feature negotiation instead.
>
> Introduce vhost_get_default_features() and update all vhost devices in
> QEMU to involve the device backend in feature negotiation.
>
> This patch fixes the following error:
>
>    $ x86_64-softmmu/qemu-system-x86_64 \
>        -drive if=virtio,file=test.img,format=raw \
>        -chardev socket,path=/tmp/vhost-user-blk.sock,id=char0 \
>        -device vhost-user-blk-pci,chardev=char0,packed=on \
>        -object memory-backend-memfd,size=1G,share=on,id=ram0 \
>        -M accel=kvm,memory-backend=ram0
>    qemu-system-x86_64: Failed to set msg fds.
>    qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)


It looks to me this could be fixed simply by adding VIRTIO_F_RING_PACKED 
into user_feature_bits in vhost-user-blk.c.

And for the rest, we need require them to call vhost_get_features() with 
the proper feature bits that needs to be acked by the backend.


>
> The vhost-user-blk backend failed as follows:
>
>    $ ./vhost-user-blk --socket-path=/tmp/vhost-user-blk.sock -b test2.img
>    vu_panic: virtio: zero sized buffers are not allowed
>    virtio-blk request missing headers
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/vhost.h        |  1 +
>   include/hw/virtio/virtio-gpu.h   |  2 ++
>   include/sysemu/cryptodev-vhost.h | 11 +++++++++++
>   backends/cryptodev-vhost.c       | 19 +++++++++++++++++++
>   hw/display/vhost-user-gpu.c      | 17 +++++++++++++++++
>   hw/display/virtio-gpu-base.c     |  2 +-
>   hw/input/vhost-user-input.c      |  9 +++++++++
>   hw/virtio/vhost-user-fs.c        |  5 +++--
>   hw/virtio/vhost-vsock.c          |  5 +++--
>   hw/virtio/vhost.c                | 22 ++++++++++++++++++++++
>   hw/virtio/virtio-crypto.c        |  3 ++-
>   11 files changed, 90 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..d2e54dd4a8 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -112,6 +112,7 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                             bool mask);
>   uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>                               uint64_t features);
> +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t features);
>   void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                           uint64_t features);
>   bool vhost_has_free_slot(void);
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 6dd57f2025..41d270d80e 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -192,6 +192,8 @@ bool virtio_gpu_base_device_realize(DeviceState *qdev,
>   void virtio_gpu_base_reset(VirtIOGPUBase *g);
>   void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
>                           struct virtio_gpu_resp_display_info *dpy_info);
> +uint64_t virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
> +                                      Error **errp);
>   
>   /* virtio-gpu.c */
>   void virtio_gpu_ctrl_response(VirtIOGPU *g,
> diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
> index f42824fbde..e629446bfb 100644
> --- a/include/sysemu/cryptodev-vhost.h
> +++ b/include/sysemu/cryptodev-vhost.h
> @@ -122,6 +122,17 @@ int cryptodev_vhost_start(VirtIODevice *dev, int total_queues);
>    */
>   void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues);
>   
> +/**
> + * cryptodev_vhost_get_features:
> + * @dev: the virtio crypto object
> + * @requested_features: the features being offered
> + *
> + * Returns: the requested features bits that are supported by the vhost device,
> + * or the original request feature bits if vhost is disabled
> + *
> + */
> +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t features);
> +
>   /**
>    * cryptodev_vhost_virtqueue_mask:
>    * @dev: the virtio crypto object
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 8337c9a495..5f5a4fda7b 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -266,6 +266,20 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
>       assert(r >= 0);
>   }
>   
> +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t features)
> +{
> +    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
> +    CryptoDevBackend *b = vcrypto->cryptodev;
> +    CryptoDevBackendClient *cc = b->conf.peers.ccs[0];
> +    CryptoDevBackendVhost *vhost_crypto = cryptodev_get_vhost(cc, b, 0);
> +
> +    if (!vhost_crypto) {
> +        return features; /* vhost disabled */
> +    }
> +
> +    return vhost_get_default_features(&vhost_crypto->dev, features);
> +}
> +
>   void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
>                                              int queue,
>                                              int idx, bool mask)
> @@ -333,6 +347,11 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
>   {
>   }
>   
> +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t features)
> +{
> +    return features;
> +}
> +
>   void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
>                                       int queue,
>                                       int idx, bool mask)
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 4cdaee1bde..e483df2a9e 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -466,6 +466,22 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
>       }
>   }
>   
> +static uint64_t
> +vhost_user_gpu_get_features(VirtIODevice *vdev, uint64_t features,
> +                            Error **errp)
> +{
> +    VhostUserGPU *g = VHOST_USER_GPU(vdev);
> +    Error *local_err = NULL;
> +
> +    features = virtio_gpu_base_get_features(vdev, features, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return 0;
> +    }
> +
> +    return vhost_get_default_features(&g->vhost->dev, features);
> +}
> +
>   static void
>   vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
>   {
> @@ -582,6 +598,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, void *data)
>   
>       vdc->realize = vhost_user_gpu_device_realize;
>       vdc->reset = vhost_user_gpu_reset;
> +    vdc->get_features = vhost_user_gpu_get_features;
>       vdc->set_status   = vhost_user_gpu_set_status;
>       vdc->guest_notifier_mask = vhost_user_gpu_guest_notifier_mask;
>       vdc->guest_notifier_pending = vhost_user_gpu_guest_notifier_pending;
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index c159351be3..05d1ff2db2 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -176,7 +176,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>       return true;
>   }
>   
> -static uint64_t
> +uint64_t
>   virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>                                Error **errp)
>   {
> diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> index 63984a8ba7..1371fb32cc 100644
> --- a/hw/input/vhost-user-input.c
> +++ b/hw/input/vhost-user-input.c
> @@ -45,6 +45,14 @@ static void vhost_input_change_active(VirtIOInput *vinput)
>       }
>   }
>   
> +static uint64_t vhost_input_get_features(VirtIODevice *vdev, uint64_t features,
> +                                         Error **errp)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
> +
> +    return vhost_get_default_features(&vhi->vhost->dev, features);
> +}
> +
>   static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
>   {
>       VirtIOInput *vinput = VIRTIO_INPUT(vdev);
> @@ -89,6 +97,7 @@ static void vhost_input_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->vmsd = &vmstate_vhost_input;
> +    vdc->get_features = vhost_input_get_features;
>       vdc->get_config = vhost_input_get_config;
>       vdc->set_config = vhost_input_set_config;
>       vic->realize = vhost_input_realize;
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 1bc5d03a00..56015ca3d4 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -130,8 +130,9 @@ static uint64_t vuf_get_features(VirtIODevice *vdev,
>                                         uint64_t requested_features,
>                                         Error **errp)
>   {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +
> +    return vhost_get_default_features(&fs->vhost_dev, requested_features);
>   }
>   
>   static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 4a228f5168..7276587be6 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -180,8 +180,9 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>                                            uint64_t requested_features,
>                                            Error **errp)
>   {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
> +
> +    return vhost_get_default_features(&vsock->vhost_dev, requested_features);
>   }
>   
>   static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede..f8a144dcd0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -48,6 +48,23 @@ static unsigned int used_memslots;
>   static QLIST_HEAD(, vhost_dev) vhost_devices =
>       QLIST_HEAD_INITIALIZER(vhost_devices);
>   
> +/*
> + * Feature bits that device backends must explicitly report. Feature bits not
> + * listed here maybe set by QEMU without checking with the device backend.
> + * Ideally all feature bits would be listed here but existing vhost device
> + * implementations do not explicitly report bits like VIRTIO_F_VERSION_1, so we
> + * can only assume they are supported.


For most backends, we care about the features for datapath. So this is 
not true at least for networking device, since VIRTIO_F_VERSION_1 have 
impact on the length of vnet header length.


> + *
> + * New feature bits added to the VIRTIO spec should usually be included here
> + * so that existing vhost device backends that do not support them yet continue
> + * to work.


It actually depends on the type of backend.

Kernel vhost-net does not validate GSO features since qemu can talk 
directly to TAP and vhost doesn't report those features. But for 
vhost-user GSO features must be validated by qemu since qemu can't see 
what is behind vhost-user.


> + */
> +static const int vhost_default_feature_bits[] = {
> +    VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_RING_PACKED,
> +    VHOST_INVALID_FEATURE_BIT
> +};
> +
>   bool vhost_has_free_slot(void)
>   {
>       unsigned int slots_limit = ~0U;
> @@ -1468,6 +1485,11 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>       return features;
>   }
>   
> +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t features)
> +{
> +    return vhost_get_features(hdev, vhost_default_feature_bits, features);
> +}


There's probably no need for a new helper, we can do all these inside 
vhost_get_features().

Thanks


> +
>   void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                           uint64_t features)
>   {
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index bd9165c565..ef711b56f4 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -739,7 +739,8 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
>                                              uint64_t features,
>                                              Error **errp)
>   {
> -    return features;
> +    /* Just returns features when vhost is disabled */
> +    return cryptodev_vhost_get_features(vdev, features);
>   }
>   
>   static void virtio_crypto_reset(VirtIODevice *vdev)


