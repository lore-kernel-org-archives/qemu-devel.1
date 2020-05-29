Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0171C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C883206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqfBqe7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C883206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegpa-0001gH-Mz
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jegoB-0000pO-M1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:20:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jego8-0002Q8-Er
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590765627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zfLwm3DlTnM7Db/ymipJCXFRl7GC90rWc+Loo4yzJg=;
 b=eqfBqe7Na8Wp+WyLoD3rlFczYyWaoJGLMCB0BphexDQPKfuaq2lqMYSzavD/eA/kD6Yznl
 VWaEyIKBIfyMiIbwpDamllJsgupuyKgo93ZGX7SbJ1CND3BltHHSLmIciWxSJ1zYidrzM8
 H0apmVMOI/s9U4rNJmTjf5bFcXQnLgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-lXD-0ES_MFGuH4VIl4JVXQ-1; Fri, 29 May 2020 11:20:23 -0400
X-MC-Unique: lXD-0ES_MFGuH4VIl4JVXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD1C5464;
 Fri, 29 May 2020 15:20:21 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7747319723;
 Fri, 29 May 2020 15:20:11 +0000 (UTC)
Date: Fri, 29 May 2020 16:20:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
Message-ID: <20200529152010.GD367530@stefanha-x1.localdomain>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
 <CAMxuvaxZRG7cS0_QhVad9nd=SOvTNnMYz7zdQACrL8FxdJhxRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxZRG7cS0_QhVad9nd=SOvTNnMYz7zdQACrL8FxdJhxRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
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

--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 04:28:41PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi Stefan
>=20
> On Fri, May 22, 2020 at 7:18 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > Many vhost devices in QEMU currently do not involve the device backend
> > in feature negotiation. This seems fine at first glance for device type=
s
> > without their own feature bits (virtio-net has many but other device
> > types have none).
> >
> > This overlooks the fact that QEMU's virtqueue implementation and the
> > device backend's implementation may support different features.  QEMU
> > must not report features to the guest that the the device backend
> > doesn't support.
> >
> > For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> > existing vhost device backends do not. When the user sets packed=3Don t=
he
> > device backend breaks. This should have been handled gracefully by
> > feature negotiation instead.
> >
> > Introduce vhost_get_default_features() and update all vhost devices in
> > QEMU to involve the device backend in feature negotiation.
> >
> > This patch fixes the following error:
> >
> >   $ x86_64-softmmu/qemu-system-x86_64 \
> >       -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> >       -chardev socket,path=3D/tmp/vhost-user-blk.sock,id=3Dchar0 \
> >       -device vhost-user-blk-pci,chardev=3Dchar0,packed=3Don \
> >       -object memory-backend-memfd,size=3D1G,share=3Don,id=3Dram0 \
> >       -M accel=3Dkvm,memory-backend=3Dram0
> >   qemu-system-x86_64: Failed to set msg fds.
> >   qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
> >
> > The vhost-user-blk backend failed as follows:
> >
> >   $ ./vhost-user-blk --socket-path=3D/tmp/vhost-user-blk.sock -b test2.=
img
> >   vu_panic: virtio: zero sized buffers are not allowed
> >   virtio-blk request missing headers
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/virtio/vhost.h        |  1 +
> >  include/hw/virtio/virtio-gpu.h   |  2 ++
> >  include/sysemu/cryptodev-vhost.h | 11 +++++++++++
> >  backends/cryptodev-vhost.c       | 19 +++++++++++++++++++
> >  hw/display/vhost-user-gpu.c      | 17 +++++++++++++++++
> >  hw/display/virtio-gpu-base.c     |  2 +-
> >  hw/input/vhost-user-input.c      |  9 +++++++++
> >  hw/virtio/vhost-user-fs.c        |  5 +++--
> >  hw/virtio/vhost-vsock.c          |  5 +++--
> >  hw/virtio/vhost.c                | 22 ++++++++++++++++++++++
> >  hw/virtio/virtio-crypto.c        |  3 ++-
> >  11 files changed, 90 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 085450c6f8..d2e54dd4a8 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -112,6 +112,7 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, V=
irtIODevice *vdev, int n,
> >                            bool mask);
> >  uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature=
_bits,
> >                              uint64_t features);
> > +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t f=
eatures);
> >  void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bit=
s,
> >                          uint64_t features);
> >  bool vhost_has_free_slot(void);
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 6dd57f2025..41d270d80e 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -192,6 +192,8 @@ bool virtio_gpu_base_device_realize(DeviceState *qd=
ev,
> >  void virtio_gpu_base_reset(VirtIOGPUBase *g);
> >  void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
> >                          struct virtio_gpu_resp_display_info *dpy_info)=
;
> > +uint64_t virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t fea=
tures,
> > +                                      Error **errp);
> >
> >  /* virtio-gpu.c */
> >  void virtio_gpu_ctrl_response(VirtIOGPU *g,
> > diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptode=
v-vhost.h
> > index f42824fbde..e629446bfb 100644
> > --- a/include/sysemu/cryptodev-vhost.h
> > +++ b/include/sysemu/cryptodev-vhost.h
> > @@ -122,6 +122,17 @@ int cryptodev_vhost_start(VirtIODevice *dev, int t=
otal_queues);
> >   */
> >  void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues);
> >
> > +/**
> > + * cryptodev_vhost_get_features:
> > + * @dev: the virtio crypto object
> > + * @requested_features: the features being offered
> > + *
> > + * Returns: the requested features bits that are supported by the vhos=
t device,
> > + * or the original request feature bits if vhost is disabled
> > + *
> > + */
> > +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t feat=
ures);
> > +
> >  /**
> >   * cryptodev_vhost_virtqueue_mask:
> >   * @dev: the virtio crypto object
> > diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> > index 8337c9a495..5f5a4fda7b 100644
> > --- a/backends/cryptodev-vhost.c
> > +++ b/backends/cryptodev-vhost.c
> > @@ -266,6 +266,20 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int t=
otal_queues)
> >      assert(r >=3D 0);
> >  }
> >
> > +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t feat=
ures)
> > +{
> > +    VirtIOCrypto *vcrypto =3D VIRTIO_CRYPTO(dev);
> > +    CryptoDevBackend *b =3D vcrypto->cryptodev;
> > +    CryptoDevBackendClient *cc =3D b->conf.peers.ccs[0];
> > +    CryptoDevBackendVhost *vhost_crypto =3D cryptodev_get_vhost(cc, b,=
 0);
> > +
> > +    if (!vhost_crypto) {
> > +        return features; /* vhost disabled */
> > +    }
> > +
> > +    return vhost_get_default_features(&vhost_crypto->dev, features);
> > +}
> > +
> >  void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
> >                                             int queue,
> >                                             int idx, bool mask)
> > @@ -333,6 +347,11 @@ void cryptodev_vhost_stop(VirtIODevice *dev, int t=
otal_queues)
> >  {
> >  }
> >
> > +uint64_t cryptodev_vhost_get_features(VirtIODevice *dev, uint64_t feat=
ures)
> > +{
> > +    return features;
> > +}
> > +
> >  void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
> >                                      int queue,
> >                                      int idx, bool mask)
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index 4cdaee1bde..e483df2a9e 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -466,6 +466,22 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
> >      }
> >  }
> >
> > +static uint64_t
> > +vhost_user_gpu_get_features(VirtIODevice *vdev, uint64_t features,
> > +                            Error **errp)
> > +{
> > +    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
> > +    Error *local_err =3D NULL;
> > +
> > +    features =3D virtio_gpu_base_get_features(vdev, features, &local_e=
rr);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return 0;
> > +    }
> > +
> > +    return vhost_get_default_features(&g->vhost->dev, features);
> > +}
> > +
> >  static void
> >  vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
> >  {
> > @@ -582,6 +598,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, void =
*data)
> >
> >      vdc->realize =3D vhost_user_gpu_device_realize;
> >      vdc->reset =3D vhost_user_gpu_reset;
> > +    vdc->get_features =3D vhost_user_gpu_get_features;
> >      vdc->set_status   =3D vhost_user_gpu_set_status;
> >      vdc->guest_notifier_mask =3D vhost_user_gpu_guest_notifier_mask;
> >      vdc->guest_notifier_pending =3D vhost_user_gpu_guest_notifier_pend=
ing;
> > diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.=
c
> > index c159351be3..05d1ff2db2 100644
> > --- a/hw/display/virtio-gpu-base.c
> > +++ b/hw/display/virtio-gpu-base.c
> > @@ -176,7 +176,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
> >      return true;
> >  }
> >
> > -static uint64_t
> > +uint64_t
> >  virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
> >                               Error **errp)
> >  {
> > diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> > index 63984a8ba7..1371fb32cc 100644
> > --- a/hw/input/vhost-user-input.c
> > +++ b/hw/input/vhost-user-input.c
> > @@ -45,6 +45,14 @@ static void vhost_input_change_active(VirtIOInput *v=
input)
> >      }
> >  }
> >
> > +static uint64_t vhost_input_get_features(VirtIODevice *vdev, uint64_t =
features,
> > +                                         Error **errp)
> > +{
> > +    VHostUserInput *vhi =3D VHOST_USER_INPUT(vdev);
> > +
> > +    return vhost_get_default_features(&vhi->vhost->dev, features);
> > +}
> > +
> >  static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config=
_data)
> >  {
> >      VirtIOInput *vinput =3D VIRTIO_INPUT(vdev);
> > @@ -89,6 +97,7 @@ static void vhost_input_class_init(ObjectClass *klass=
, void *data)
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> >      dc->vmsd =3D &vmstate_vhost_input;
> > +    vdc->get_features =3D vhost_input_get_features;
> >      vdc->get_config =3D vhost_input_get_config;
> >      vdc->set_config =3D vhost_input_set_config;
> >      vic->realize =3D vhost_input_realize;
> > diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> > index 1bc5d03a00..56015ca3d4 100644
> > --- a/hw/virtio/vhost-user-fs.c
> > +++ b/hw/virtio/vhost-user-fs.c
> > @@ -130,8 +130,9 @@ static uint64_t vuf_get_features(VirtIODevice *vdev=
,
> >                                        uint64_t requested_features,
> >                                        Error **errp)
> >  {
> > -    /* No feature bits used yet */
> > -    return requested_features;
> > +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> > +
> > +    return vhost_get_default_features(&fs->vhost_dev, requested_featur=
es);
> >  }
> >
> >  static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> > index 4a228f5168..7276587be6 100644
> > --- a/hw/virtio/vhost-vsock.c
> > +++ b/hw/virtio/vhost-vsock.c
> > @@ -180,8 +180,9 @@ static uint64_t vhost_vsock_get_features(VirtIODevi=
ce *vdev,
> >                                           uint64_t requested_features,
> >                                           Error **errp)
> >  {
> > -    /* No feature bits used yet */
> > -    return requested_features;
> > +    VHostVSock *vsock =3D VHOST_VSOCK(vdev);
> > +
> > +    return vhost_get_default_features(&vsock->vhost_dev, requested_fea=
tures);
> >  }
> >
> >  static void vhost_vsock_handle_output(VirtIODevice *vdev, VirtQueue *v=
q)
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index aff98a0ede..f8a144dcd0 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -48,6 +48,23 @@ static unsigned int used_memslots;
> >  static QLIST_HEAD(, vhost_dev) vhost_devices =3D
> >      QLIST_HEAD_INITIALIZER(vhost_devices);
> >
> > +/*
> > + * Feature bits that device backends must explicitly report. Feature b=
its not
> > + * listed here maybe set by QEMU without checking with the device back=
end.
> > + * Ideally all feature bits would be listed here but existing vhost de=
vice
> > + * implementations do not explicitly report bits like VIRTIO_F_VERSION=
_1, so we
> > + * can only assume they are supported.
> > + *
> > + * New feature bits added to the VIRTIO spec should usually be include=
d here
> > + * so that existing vhost device backends that do not support them yet=
 continue
> > + * to work.
> > + */
> > +static const int vhost_default_feature_bits[] =3D {
> > +    VIRTIO_F_IOMMU_PLATFORM,
> > +    VIRTIO_F_RING_PACKED,
>=20
> So effectively, we don't care about backend features except for those
> 2 bits, and an extra F_LOG_ALL check in vhost.c, right?
>=20
> It's not entirely clear to me how the feature flags of device and
> backend should combine tbh.

I've always found this confusing too. Maybe a vhost-user spec
clarification would help improve the situation at least for future
vhost-user backend implementors.

libvhost-user only advertises VHOST_F_LOG_ALL and
VHOST_USER_F_PROTOCOL_FEATURES. Everything else is left up to the device
backend implementation. This is a problem because libvhost-user handles
virtqueues and needs to be aware of VIRTIO_RING_F_EVENT_IDX, etc. I'll
send a separate patch to advertise the necessary feature bits in
libvhost-user.

QEMU calculates the VIRTIO device's feature bit masks as follows:

1. -device vhost-foo initializes the device features with whatever QEMU
   supports. Either the QEMU vhost-foo code itself sets features or the
   user overrides them on the command-line.

2. Some vhost devices in QEMU call vhost_get_features() to mask out
   features missing from the VHOST_USER_GET_FEATURES response. This is
   how the vhost-user backend participates in feature negotiation.

This patch series changes moves us one step in the direction of always
involving the vhost-user backend in feature negotiation. It's only a
step because to do so fully would break existing vhost-user backends
that don't advertise features properly :(.

Stefan

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7RKCoACgkQnKSrs4Gr
c8hLqwgAv/p2x0qAXjdz4oBu/TABT2hB4v9gdVV4pg9HzNdtvKnRhacZxbmWwJln
yKNGbJibWLE2vj9uu6GOyhwAxSRyAV62/uqqjteChG3iAns2MJAEBaf5gN/iOOXl
pDC2RFDocwmXpxonZ1iHMQ+IfaiRS8xDcsVryLl0BkIeSx4003rBAUSixYLo49H8
nrO63CcBnObU89qsVaoH0wlmLmUC24/3WcMe40Cr0EFvFAZ3oLBG+eOiQ9tynjq2
U510cjVd3ggt0KVCjZMQuPF19GEz4db43Q90MeLITfMYLVC6t/xFpkvxQohxG4KF
L/kmHK7gVkVhvUH4OZjhBLStQK+bRg==
=H19S
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--


