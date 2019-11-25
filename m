Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2ABC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB21D20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmO1/bIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB21D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFpd-0006Tt-U1
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iZFof-0005d6-TD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iZFod-0007ga-TT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:58:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iZFob-0007f0-Tj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574693890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKXFqvkj5+JwZVFKNWrRNW2qgzjNrkOYaEYnRGZbMFE=;
 b=FmO1/bIp8IJrZbcHPasQPBzLdTkiXKVQ33007ZVmhM/sZn+C0Dn0z6ZHzTgVH4jDh1HWzR
 KEIRYYXTit3QruHR6t7Etc1vjByVa+CaQ31QZvNmjXr+1gXxRb13GRViZNWAGHLw0vOB4h
 dRlvs7qEvhkf0OCm+kFaB2qAvxm3IEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-JMDPy9BQN4alLX-iIls4Ew-1; Mon, 25 Nov 2019 09:58:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E13B8107ACE3;
 Mon, 25 Nov 2019 14:58:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D42A610016E8;
 Mon, 25 Nov 2019 14:57:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5DA3122062B; Mon, 25 Nov 2019 09:57:59 -0500 (EST)
Date: Mon, 25 Nov 2019 09:57:59 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/4] virtiofsd: Specify size of notification buffer using
 config space
Message-ID: <20191125145759.GA13247@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-4-vgoyal@redhat.com>
 <20191122103300.GD464656@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191122103300.GD464656@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: JMDPy9BQN4alLX-iIls4Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 10:33:00AM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 15, 2019 at 03:55:42PM -0500, Vivek Goyal wrote:
> > diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_v=
irtio.c
> > index 411114c9b3..982b6ad0bd 100644
> > --- a/contrib/virtiofsd/fuse_virtio.c
> > +++ b/contrib/virtiofsd/fuse_virtio.c
> > @@ -109,7 +109,8 @@ static uint64_t fv_get_features(VuDev *dev)
> >      uint64_t features;
> > =20
> >      features =3D 1ull << VIRTIO_F_VERSION_1 |
> > -               1ull << VIRTIO_FS_F_NOTIFICATION;
> > +               1ull << VIRTIO_FS_F_NOTIFICATION |
> > +               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
>=20
> This is not needed since VHOST_USER_F_PROTOCOL_FEATURES is already added
> by vu_get_features_exec():

Will do.

>=20
>   vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>   {
>       vmsg->payload.u64 =3D
>           1ULL << VHOST_F_LOG_ALL |
>           1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>=20
>       if (dev->iface->get_features) {
>           vmsg->payload.u64 |=3D dev->iface->get_features(dev);
>       }
>=20
> > =20
> >      return features;
> >  }
> > @@ -927,6 +928,27 @@ static bool fv_queue_order(VuDev *dev, int qidx)
> >      return false;
> >  }
> > =20
> > +static uint64_t fv_get_protocol_features(VuDev *dev)
> > +{
> > +=09return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
> > +}
>=20
> Please change vu_get_protocol_features_exec() in a separate patch so
> that devices don't need this boilerplate .get_protocol_features() code:
>=20
>   static bool
>   vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>   {
>       ...
>  -    if (dev->iface->get_config && dev->iface->set_config) {
>  +    if (dev->iface->get_config || dev->iface->set_config) {
>           features |=3D 1ULL << VHOST_USER_PROTOCOL_F_CONFIG;

This seems more like a nice to have thing. Can we leave it for sometime
later.

>       }
>=20
> > +
> > +static int fv_get_config(VuDev *dev, uint8_t *config, uint32_t len)
> > +{
> > +=09struct virtio_fs_config fscfg =3D {};
> > +
> > +=09fuse_log(FUSE_LOG_DEBUG, "%s:Setting notify_buf_size=3D%d\n", __fun=
c__,
> > +                 sizeof(struct fuse_notify_lock_out));
> > +=09/*
> > +=09 * As of now only notification related to lock is supported. As mor=
e
> > +=09 * notification types are supported, bump up the size accordingly.
> > +=09 */
> > +=09fscfg.notify_buf_size =3D sizeof(struct fuse_notify_lock_out);
>=20
> Missing cpu_to_le32().

Not sure. Deivce converts to le32 when guests asks for it. So there should
not be any need to do this conversion between vhost-user daemon and
device. I am assuming that both daemon and qemu are using same endianess
and if that's the case, first converting it to le32 and undoing this
operation on other end (if we are running on an architecture with big
endian), seems unnecessary and confusing.

static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
{
    ...
    ...
    virtio_stl_p(vdev, &fscfg.notify_buf_size, fs->fscfg.notify_buf_size);
}

>=20
> I'm not sure about specifying the size precisely down to the last byte
> because any change to guest-visible aspects of the device (like VIRTIO
> Configuration Space) are not compatible across live migration.  It will
> be necessary to introduce a device version command-line option for live
> migration compatibility so that existing guests can be migrated to a new
> virtiofsd without the device changing underneath them.

I am not sure I understand this point. If we were to support live
migration, will we not have to reset the queue and regoniate with
device again on destination host.
>=20
> How about rounding this up to 4 KB?

Not sure how will that help. Right now it feels just wasteful of memory.

>=20
> >  static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
> >  {
> >      VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> >      struct virtio_fs_config fscfg =3D {};
> > +    int ret;
> > +
> > +    /*
> > +     * As of now we only get notification buffer size from device. And=
 that's
> > +     * needed only if notification queue is enabled.
> > +     */
> > +    if (fs->notify_enabled) {
> > +        ret =3D vhost_dev_get_config(&fs->vhost_dev, (uint8_t *)&fs->f=
scfg,
> > +                                   sizeof(struct virtio_fs_config));
> > +=09if (ret < 0) {
>=20
> Indentation.

Will fix.

>=20
> > +            error_report("vhost-user-fs: get device config space faile=
d."
> > +                         " ret=3D%d\n", ret);
> > +            return;
> > +        }
>=20
> Missing le32_to_cpu() for notify_buf_size.

See above.

[..]
> > @@ -545,6 +569,8 @@ static void vuf_device_realize(DeviceState *dev, Er=
ror **errp)
> >      fs->vhost_dev.nvqs =3D 2 + fs->conf.num_request_queues;
> > =20
> >      fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev=
.nvqs);
> > +
> > +    vhost_dev_set_config_notifier(&fs->vhost_dev, &fs_ops);
>=20
> Is this really needed since vhost_user_fs_handle_config_change() ignores
> it?

Initially I did not introduce it but code did not work. Looked little
closer and noticed following code in vhost_user_backend_init().

        if (!dev->config_ops || !dev->config_ops->vhost_dev_config_notifier=
) {
            /* Don't acknowledge CONFIG feature if device doesn't support i=
t */
            dev->protocol_features &=3D ~(1ULL << VHOST_USER_PROTOCOL_F_CON=
FIG);

So if dev->config_ops->vhost_dev_config_notifier is not provided,=20
feature VHOST_USER_PROTOCOL_F_CONFIG will be reset.

Its kind of odd that its a hard requirement. Anyway, that's the reason
I added it so that VHOST_USER_PROTOCOL_F_CONFIG continues to work.

Thanks
Vivek


