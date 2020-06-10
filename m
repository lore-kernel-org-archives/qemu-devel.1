Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6276C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC7320760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsvX6kCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC7320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu7X-0001Di-KT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiu5y-0008CR-7o
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:20:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiu5w-0004Yz-8x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591770014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OH+FfLY8GgHm7Qs6E2iNG6iXGvc4eRlX6qCRAoGgo5k=;
 b=GsvX6kCkO78v2T7W+9KQl2cik1UUQQbn84hBJzMcPkcy1k0OlXyB7xPZBbKZ69yB6hrzWQ
 M9V/f6fc0AoS35nkY3+FttXKXIpzbcv+3lOCB3Yj1wjdgSWVAquMaaCw/ULRoIDkIXqx9d
 D60/BeBf4htU16IAngEVCeG2cKDV8GU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-CB9Rb9XkN12jhYXQXb2SYQ-1; Wed, 10 Jun 2020 02:20:13 -0400
X-MC-Unique: CB9Rb9XkN12jhYXQXb2SYQ-1
Received: by mail-wm1-f72.google.com with SMTP id h6so99206wmb.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 23:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OH+FfLY8GgHm7Qs6E2iNG6iXGvc4eRlX6qCRAoGgo5k=;
 b=rNL39uFG3p2rABOe5OABmGoUapnXungEx7quPQ3RK0e6zKef65VlYl5d0Rw6YZMSCi
 qriemVP0Kix1NzIj9QRgztRV8Y/rSx1qUMnPjozOYsARp6zI5XeSHal8LLo4YdCIcHH2
 zkDH4sKBI9pAH7bX4txGBKGVkUtOeeo24Iur9UNcE2AjpctIPLoBq2WOIDx8fSrVa6eo
 Y/mticz7PlHmJvHp4T3Or1g4WC45CniiiIPAvZlxJIkLW3LUxWOv4+0/QcbozxSexwb3
 7RrwrNiEP2mrUrjfAn32c/dXPLE9sUC/K3JItJkYzO55u4+Wc4Yn0VH18gYOYrbUvwLD
 D1lw==
X-Gm-Message-State: AOAM532IYpxqvCvEQH3ztfSH3b0Z6mozwEOkH9qiQY8QsgP4FL7Fa0uA
 PmSPOMOk7/cLZkjcsXTbf1v/CbHAMobl7PN39/Wrjx6pdPJGKMOpJjR3QblLjABp+Wmp4m9GZS2
 h8vVeEyBXRmpHpFQ=
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr1830365wru.188.1591770011623; 
 Tue, 09 Jun 2020 23:20:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKzCBeqxahrof8af9lUI+7ARWtWfdpRyXpOwWDhVGjuYcG6UH0Ved9Ayev2QducXr+Rlnuyw==
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr1830304wru.188.1591770011115; 
 Tue, 09 Jun 2020 23:20:11 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u13sm6479847wrp.53.2020.06.09.23.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 23:20:10 -0700 (PDT)
Date: Wed, 10 Jun 2020 02:20:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 4/7] vhost: involve device backends in feature
 negotiation
Message-ID: <20200610021308-mutt-send-email-mst@kernel.org>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-5-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200609170218.246468-5-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 06:02:15PM +0100, Stefan Hajnoczi wrote:
> Many vhost devices in QEMU currently do not involve the device backend
> in feature negotiation. This seems fine at first glance when no
> device-specific feature bits are defined (virtio-net has many but some
> devices have none).
> 
> Unfortunately this causes problems when QEMU's virtqueue implementation
> and the device backend's implementation support different features.
> QEMU must not report features to the guest that aren't supported by the
> device backend.
> 
> For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> existing vhost device backends do not. The device backend breaks when
> the user sets packed=on. This should have been handled gracefully by
> feature negotiation instead of resulting in a cryptic failure when the
> device backend cannot parse the vring.
> 
> Introduce the vhost_old_default_feature_bits[] array so existing
> devices can involve the device backend in feature negotiation.
> libvhost-user does not report VIRTIO_RING_F_INDIRECT_DESC and other core
> feature bits even though it implements them. Therefore
> vhost_old_default_feature_bits[] only includes feature bits that can be
> explicitly negotiated without breaking existing libvhost-user device
> backends.
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
>  backends/cryptodev-vhost.c       | 21 +++++++++++++++++++++
>  hw/display/vhost-user-gpu.c      | 18 ++++++++++++++++++
>  hw/display/virtio-gpu-base.c     |  2 +-
>  hw/input/vhost-user-input.c      | 11 +++++++++++
>  hw/virtio/vhost-user-fs.c        |  6 ++++--
>  hw/virtio/vhost-vsock.c          |  7 +++++--
>  hw/virtio/vhost.c                | 24 ++++++++++++++++++++++++
>  hw/virtio/virtio-crypto.c        |  3 ++-
>  11 files changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..4cd278a395 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -110,6 +110,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
>   */
>  void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>                            bool mask);
> +extern const int vhost_old_default_feature_bits[];
>  uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>                              uint64_t features);
>  void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
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
> index 8337c9a495..945004c536 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -266,6 +266,22 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
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
> +    return vhost_get_features(&vhost_crypto->dev,
> +                              vhost_old_default_feature_bits,
> +                              features);
> +}
> +
>  void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
>                                             int queue,
>                                             int idx, bool mask)
> @@ -333,6 +349,11 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
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
> index 4cdaee1bde..eeb000bcbe 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -466,6 +466,23 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
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
> +    return vhost_get_features(&g->vhost->dev, vhost_old_default_feature_bits,
> +                              features);
> +}
> +
>  static void
>  vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
>  {
> @@ -582,6 +599,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, void *data)
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
> index 63984a8ba7..c9ec675c49 100644
> --- a/hw/input/vhost-user-input.c
> +++ b/hw/input/vhost-user-input.c
> @@ -45,6 +45,16 @@ static void vhost_input_change_active(VirtIOInput *vinput)
>      }
>  }
>  
> +static uint64_t vhost_input_get_features(VirtIODevice *vdev, uint64_t features,
> +                                         Error **errp)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vdev);
> +
> +    return vhost_get_features(&vhi->vhost->dev,
> +                              vhost_old_default_feature_bits,
> +                              features);
> +}
> +
>  static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  {
>      VirtIOInput *vinput = VIRTIO_INPUT(vdev);
> @@ -89,6 +99,7 @@ static void vhost_input_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->vmsd = &vmstate_vhost_input;
> +    vdc->get_features = vhost_input_get_features;
>      vdc->get_config = vhost_input_get_config;
>      vdc->set_config = vhost_input_set_config;
>      vic->realize = vhost_input_realize;
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 1bc5d03a00..9ca9f9d3d8 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -130,8 +130,10 @@ static uint64_t vuf_get_features(VirtIODevice *vdev,
>                                        uint64_t requested_features,
>                                        Error **errp)
>  {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +
> +    return vhost_get_features(&fs->vhost_dev, vhost_old_default_feature_bits,
> +                              requested_features);
>  }
>  
>  static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 4a228f5168..b96b03cb06 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -180,8 +180,11 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>                                           uint64_t requested_features,
>                                           Error **errp)
>  {
> -    /* No feature bits used yet */
> -    return requested_features;
> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
> +
> +    return vhost_get_features(&vsock->vhost_dev,
> +                              vhost_old_default_feature_bits,
> +                              requested_features);
>  }
>  
>  static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede..56d671852b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1454,6 +1454,30 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
>      }
>  }
>  
> +/*
> + * Default vhost_get_features() feature bits for existing device types that do
> + * not define their own.
> + *
> + * This is a workaround for existing device types, do not use this in new vhost
> + * device types. Explicitly define a list of feature bits instead.
> + *
> + * The following feature bits are excluded because libvhost-user device
> + * backends did not advertise them for a long time. Therefore we cannot detect
> + * their presence. Instead we assume they are always supported by the device
> + * backend:
> + * VIRTIO_F_NOTIFY_ON_EMPTY
> + * VIRTIO_F_ANY_LAYOUT
> + * VIRTIO_F_VERSION_1
> + * VIRTIO_RING_F_INDIRECT_DESC
> + * VIRTIO_RING_F_EVENT_IDX


So the affected devices are all exclusively modern.

Some points:
- VIRTIO_F_NOTIFY_ON_EMPTY and VIRTIO_F_ANY_LAYOUT are not supposed to
  be exposed by modern devices at all. Do we even set them? If we do
  we might need to be careful with migration compat as features
  are guest visible.
- VIRTIO_F_VERSION_1 must be set by modern devices. Probably OK to just
  force it on.

This leaves just two:
 VIRTIO_RING_F_INDIRECT_DESC
 VIRTIO_RING_F_EVENT_IDX

I guess we could (ab)use VIRTIO_F_VERSION_1 to detect a broken client
and ignore these two.

-- 
MST


