Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C4C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852F520637
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJaykBzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852F520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6GO-0001j7-Hv
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iY6FV-00014T-5H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iY6FT-0004pf-Q7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:33:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38616
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iY6FT-0004pR-Li
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmyyR35Erfx+rUx1Ex9/H8QMSGpMz4DWfESxCFz6qlg=;
 b=VJaykBzMusXLmPiQBPvdhI9cweGtzmllcTzO5XR00qodBfWGsjZypwYxpLan50yeDskdsh
 HEetIDOXgI/EGVTEHDSotEZQ1Fu3aDHzKzcSVsw4t2x2yHnKcIEa8WW4KHq7L3noSitBRg
 j9fTExERuaU4olerQP3fM1qh4+2nONg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-HvSMTxBJMySY7QBXNM_B9A-1; Fri, 22 Nov 2019 05:33:07 -0500
X-MC-Unique: HvSMTxBJMySY7QBXNM_B9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE4E107ACC4;
 Fri, 22 Nov 2019 10:33:05 +0000 (UTC)
Received: from localhost (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20D1B5DDB2;
 Fri, 22 Nov 2019 10:33:00 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:33:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/4] virtiofsd: Specify size of notification buffer using
 config space
Message-ID: <20191122103300.GD464656@stefanha-x1.localdomain>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-4-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205543.1816-4-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:55:42PM -0500, Vivek Goyal wrote:
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
> index 411114c9b3..982b6ad0bd 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -109,7 +109,8 @@ static uint64_t fv_get_features(VuDev *dev)
>      uint64_t features;
> =20
>      features =3D 1ull << VIRTIO_F_VERSION_1 |
> -               1ull << VIRTIO_FS_F_NOTIFICATION;
> +               1ull << VIRTIO_FS_F_NOTIFICATION |
> +               1ull << VHOST_USER_F_PROTOCOL_FEATURES;

This is not needed since VHOST_USER_F_PROTOCOL_FEATURES is already added
by vu_get_features_exec():

  vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
  {
      vmsg->payload.u64 =3D
          1ULL << VHOST_F_LOG_ALL |
          1ULL << VHOST_USER_F_PROTOCOL_FEATURES;

      if (dev->iface->get_features) {
          vmsg->payload.u64 |=3D dev->iface->get_features(dev);
      }

> =20
>      return features;
>  }
> @@ -927,6 +928,27 @@ static bool fv_queue_order(VuDev *dev, int qidx)
>      return false;
>  }
> =20
> +static uint64_t fv_get_protocol_features(VuDev *dev)
> +{
> +=09return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
> +}

Please change vu_get_protocol_features_exec() in a separate patch so
that devices don't need this boilerplate .get_protocol_features() code:

  static bool
  vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
  {
      ...
 -    if (dev->iface->get_config && dev->iface->set_config) {
 +    if (dev->iface->get_config || dev->iface->set_config) {
          features |=3D 1ULL << VHOST_USER_PROTOCOL_F_CONFIG;
      }

> +
> +static int fv_get_config(VuDev *dev, uint8_t *config, uint32_t len)
> +{
> +=09struct virtio_fs_config fscfg =3D {};
> +
> +=09fuse_log(FUSE_LOG_DEBUG, "%s:Setting notify_buf_size=3D%d\n", __func_=
_,
> +                 sizeof(struct fuse_notify_lock_out));
> +=09/*
> +=09 * As of now only notification related to lock is supported. As more
> +=09 * notification types are supported, bump up the size accordingly.
> +=09 */
> +=09fscfg.notify_buf_size =3D sizeof(struct fuse_notify_lock_out);

Missing cpu_to_le32().

I'm not sure about specifying the size precisely down to the last byte
because any change to guest-visible aspects of the device (like VIRTIO
Configuration Space) are not compatible across live migration.  It will
be necessary to introduce a device version command-line option for live
migration compatibility so that existing guests can be migrated to a new
virtiofsd without the device changing underneath them.

How about rounding this up to 4 KB?

>  static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VHostUserFS *fs =3D VHOST_USER_FS(vdev);
>      struct virtio_fs_config fscfg =3D {};
> +    int ret;
> +
> +    /*
> +     * As of now we only get notification buffer size from device. And t=
hat's
> +     * needed only if notification queue is enabled.
> +     */
> +    if (fs->notify_enabled) {
> +        ret =3D vhost_dev_get_config(&fs->vhost_dev, (uint8_t *)&fs->fsc=
fg,
> +                                   sizeof(struct virtio_fs_config));
> +=09if (ret < 0) {

Indentation.

> +            error_report("vhost-user-fs: get device config space failed.=
"
> +                         " ret=3D%d\n", ret);
> +            return;
> +        }

Missing le32_to_cpu() for notify_buf_size.

> +    }
> =20
>      memcpy((char *)fscfg.tag, fs->conf.tag,
>             MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
> =20
>      virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_q=
ueues);
> +    virtio_stl_p(vdev, &fscfg.notify_buf_size, fs->fscfg.notify_buf_size=
);
> =20
>      memcpy(config, &fscfg, sizeof(fscfg));
>  }
> @@ -545,6 +569,8 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
>      fs->vhost_dev.nvqs =3D 2 + fs->conf.num_request_queues;
> =20
>      fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev.n=
vqs);
> +
> +    vhost_dev_set_config_notifier(&fs->vhost_dev, &fs_ops);

Is this really needed since vhost_user_fs_handle_config_change() ignores
it?

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3XuVsACgkQnKSrs4Gr
c8j4VggAi4w8EWBDE1nc8SdYJWXqXT0eFyXBrX9mIEcJ6pWiISozM5q8hpaUfwuu
yNM9kc1LNMHjbMULZRDncuQnJFmNyWnveseerrFktRyu+CnZs2dVtGcc/yMmRQhf
PlnCfInyMVwC7gP7MMqyrVYVW7ut0ROue2IggeCYw163pz9/zjWoTDGQTY7IzC3j
8zYw4WxCeF296HS/KOOcgoYzqAg80s6lU019SLmkHRtaZ6N/Gec6NiDlwYpacxRU
2YGhbbEUVuRo+q1fSHayH3ADUbPEel/rgNtH45Csxk+4xmpT8hXGWS0VhwP/eNA+
zDkAE33WTkLyXCHFh0STAWxFpqfT0w==
=OEYD
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--


