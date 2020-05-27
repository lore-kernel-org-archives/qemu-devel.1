Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4533E2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ29v854"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4533E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdx4B-0006zc-Dl
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jdx3D-0005Mm-6j
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:28:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jdx3B-0005Vj-Lv
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590589736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUT4qj/C1wYm2zMW0J+7BYWitQbnk0CWyrvQcfxYAcg=;
 b=NZ29v854ycr/mYzLDIfuLF6O9aiAz/Gf8cIf224y9/Q9rw6gKL59ZSr9LLfR5hTt/ig74Q
 NHVhOguB5yi2fPyQja3h3MhFWMZPkjRJBERmz486kJkqW/jHCdi5cYre+YcRfCVRmnxTiN
 HEj+v/RL59h5rYpoMLFHXmhu0nhnews=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-MlqJusljPSiY6R6pwOrt8A-1; Wed, 27 May 2020 10:28:54 -0400
X-MC-Unique: MlqJusljPSiY6R6pwOrt8A-1
Received: by mail-io1-f72.google.com with SMTP id v23so17137701ioj.14
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KUT4qj/C1wYm2zMW0J+7BYWitQbnk0CWyrvQcfxYAcg=;
 b=ojhEtgqvre+K2xJ8DYFd0mkhpn+VMITMBb/fN8e4DoJMlX/WrBesPcNcoPSXLYLnTr
 S5adGPoBwjHDHWfirCqSiwNU5zgUVQvP8GDvjq1pmUQNvc4gGrsRn2jKowyPokqSlPit
 FbGFbwtRJ9+fy1QF/4cNhwCvNoBPfW4twXPsLRrQ/3lqN+MaPdnW1xk9O2C3t2Ko9C1h
 z322BIWWz9W7IkrqdL+lXttFBxt3RjcVOHzleng1G6nag/2hdvfguWZkJb32yetcTzpZ
 Oat6sUv0eS4ArDwvJOBx+g6JsvBNsTRi55Zwak48DEs8WRiqDNnjj6ynx6nkMGckFOfC
 bcrg==
X-Gm-Message-State: AOAM531KivBnHKx/oEqu8eYdw4HjhgFBQ/k8auaksLQKrXhpatOTrKMk
 3c2FDO66WqvgBC6su5XquM9NHN1Lb2DNMYBNkv64YC8SdMs9MtdaBVO7oNmqvxQw6JL9TxtZ9jQ
 fe2hp4fUB6zmY152c9nJYRFjAci3pVZg=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id
 k3mr5805506ils.11.1590589733370; 
 Wed, 27 May 2020 07:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7VsWbQDEC1hrmDH5UXAJB9s7yxzJrLA2FuH9wUvYkR/SGOQbehoPXU1q2TT5XyBPMD2VYpUTBFh/xOT3fsFw=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id
 k3mr5805471ils.11.1590589732960; 
 Wed, 27 May 2020 07:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-3-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 27 May 2020 16:28:41 +0200
Message-ID: <CAMxuvaxZRG7cS0_QhVad9nd=SOvTNnMYz7zdQACrL8FxdJhxRw@mail.gmail.com>
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan

On Fri, May 22, 2020 at 7:18 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
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
>   $ x86_64-softmmu/qemu-system-x86_64 \
>       -drive if=virtio,file=test.img,format=raw \
>       -chardev socket,path=/tmp/vhost-user-blk.sock,id=char0 \
>       -device vhost-user-blk-pci,chardev=char0,packed=on \
>       -object memory-backend-memfd,size=1G,share=on,id=ram0 \
>       -M accel=kvm,memory-backend=ram0
>   qemu-system-x86_64: Failed to set msg fds.
>   qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
>
> The vhost-user-blk backend failed as follows:
>
>   $ ./vhost-user-blk --socket-path=/tmp/vhost-user-blk.sock -b test2.img
>   vu_panic: virtio: zero sized buffers are not allowed
>   virtio-blk request missing headers
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/vhost.h        |  1 +
>  include/hw/virtio/virtio-gpu.h   |  2 ++
>  include/sysemu/cryptodev-vhost.h | 11 +++++++++++
>  backends/cryptodev-vhost.c       | 19 +++++++++++++++++++
>  hw/display/vhost-user-gpu.c      | 17 +++++++++++++++++
>  hw/display/virtio-gpu-base.c     |  2 +-
>  hw/input/vhost-user-input.c      |  9 +++++++++
>  hw/virtio/vhost-user-fs.c        |  5 +++--
>  hw/virtio/vhost-vsock.c          |  5 +++--
>  hw/virtio/vhost.c                | 22 ++++++++++++++++++++++
>  hw/virtio/virtio-crypto.c        |  3 ++-
>  11 files changed, 90 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..d2e54dd4a8 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -112,6 +112,7 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                            bool mask);
>  uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>                              uint64_t features);
> +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t features);
>  void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                          uint64_t features);
>  bool vhost_has_free_slot(void);
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 6dd57f2025..41d270d80e 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -192,6 +192,8 @@ bool virtio_gpu_base_device_realize(DeviceState *qdev,
>  void virtio_gpu_base_reset(VirtIOGPUBase *g);
>  void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
>                          struct virtio_gpu_resp_display_info *dpy_info);
> +uint64_t virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
> +                                      Error **errp);
>
>  /* virtio-gpu.c */
>  void virtio_gpu_ctrl_response(VirtIOGPU *g,
> diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
> index f42824fbde..e629446bfb 100644
> --- a/include/sysemu/cryptodev-vhost.h
> +++ b/include/sysemu/cryptodev-vhost.h
> @@ -122,6 +122,17 @@ int cryptodev_vhost_start(VirtIODevice *dev, int total_queues);
>   */
>  void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues);
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
>  /**
>   * cryptodev_vhost_virtqueue_mask:
>   * @dev: the virtio crypto object
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 8337c9a495..5f5a4fda7b 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -266,6 +266,20 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
>      assert(r >= 0);
>  }
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
>  void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
>                                             int queue,
>                                             int idx, bool mask)
> @@ -333,6 +347,11 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
>  {
>  }
>
> +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t features)
> +{
> +    return features;
> +}
> +
>  void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
>                                      int queue,
>                                      int idx, bool mask)
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 4cdaee1bde..e483df2a9e 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -466,6 +466,22 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
>      }
>  }
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
>  static void
>  vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
>  {
> @@ -582,6 +598,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, void *data)
>
>      vdc->realize = vhost_user_gpu_device_realize;
>      vdc->reset = vhost_user_gpu_reset;
> +    vdc->get_features = vhost_user_gpu_get_features;
>      vdc->set_status   = vhost_user_gpu_set_status;
>      vdc->guest_notifier_mask = vhost_user_gpu_guest_notifier_mask;
>      vdc->guest_notifier_pending = vhost_user_gpu_guest_notifier_pending;
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index c159351be3..05d1ff2db2 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -176,7 +176,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      return true;
>  }
>
> -static uint64_t
> +uint64_t
>  virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>                               Error **errp)
>  {
> diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> index 63984a8ba7..1371fb32cc 100644
> --- a/hw/input/vhost-user-input.c
> +++ b/hw/input/vhost-user-input.c
> @@ -45,6 +45,14 @@ static void vhost_input_change_active(VirtIOInput *vinput)
>      }
>  }
>
> +static uint64_t vhost_input_get_features(VirtIODevice *vdev, uint64_t features,
> +                                         Error **errp)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
> +
> +    return vhost_get_default_features(&vhi->vhost->dev, features);
> +}
> +
>  static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  {
>      VirtIOInput *vinput = VIRTIO_INPUT(vdev);
> @@ -89,6 +97,7 @@ static void vhost_input_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
>      dc->vmsd = &vmstate_vhost_input;
> +    vdc->get_features = vhost_input_get_features;
>      vdc->get_config = vhost_input_get_config;
>      vdc->set_config = vhost_input_set_config;
>      vic->realize = vhost_input_realize;
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 1bc5d03a00..56015ca3d4 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -130,8 +130,9 @@ static uint64_t vuf_get_features(VirtIODevice *vdev,
>                                        uint64_t requested_features,
>                                        Error **errp)
>  {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +
> +    return vhost_get_default_features(&fs->vhost_dev, requested_features);
>  }
>
>  static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 4a228f5168..7276587be6 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -180,8 +180,9 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>                                           uint64_t requested_features,
>                                           Error **errp)
>  {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
> +
> +    return vhost_get_default_features(&vsock->vhost_dev, requested_features);
>  }
>
>  static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede..f8a144dcd0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -48,6 +48,23 @@ static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>
> +/*
> + * Feature bits that device backends must explicitly report. Feature bits not
> + * listed here maybe set by QEMU without checking with the device backend.
> + * Ideally all feature bits would be listed here but existing vhost device
> + * implementations do not explicitly report bits like VIRTIO_F_VERSION_1, so we
> + * can only assume they are supported.
> + *
> + * New feature bits added to the VIRTIO spec should usually be included here
> + * so that existing vhost device backends that do not support them yet continue
> + * to work.
> + */
> +static const int vhost_default_feature_bits[] = {
> +    VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_RING_PACKED,

So effectively, we don't care about backend features except for those
2 bits, and an extra F_LOG_ALL check in vhost.c, right?

It's not entirely clear to me how the feature flags of device and
backend should combine tbh.

> +    VHOST_INVALID_FEATURE_BIT
> +};
> +
>  bool vhost_has_free_slot(void)
>  {
>      unsigned int slots_limit = ~0U;
> @@ -1468,6 +1485,11 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>      return features;
>  }
>
> +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t features)
> +{
> +    return vhost_get_features(hdev, vhost_default_feature_bits, features);
> +}
> +
>  void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
>                          uint64_t features)
>  {
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index bd9165c565..ef711b56f4 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -739,7 +739,8 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
>                                             uint64_t features,
>                                             Error **errp)
>  {
> -    return features;
> +    /* Just returns features when vhost is disabled */
> +    return cryptodev_vhost_get_features(vdev, features);
>  }
>
>  static void virtio_crypto_reset(VirtIODevice *vdev)
> --
> 2.25.3
>


