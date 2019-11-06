Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E04C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8675621882
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW1oTQyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8675621882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSH5V-0001Lr-O6
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSH4r-0000iM-EN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSH4o-0006DZ-Su
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:54:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSH4o-0006DF-Mc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573030445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9p3o9ys2XcUigXvL0nvaBZ5arsEs/o4himDduX6JKKg=;
 b=cW1oTQyrMzotmC4uASxyzMAaqdCZiRiUK5kKrQNIgUF5DYjMpnDO2CFO5fEhjV0HQ+GYan
 Bdq+vdSwapdGoQy+88R2EjdCrtehKelVzqfAysa2Xlzv0GI+UIAC65DGsyYVTd/khncZtE
 UyAdl58hWsCw+vADssMTb99APr745NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-_wdTstc1N1OnBGq_PEkAdA-1; Wed, 06 Nov 2019 03:54:02 -0500
X-MC-Unique: _wdTstc1N1OnBGq_PEkAdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426F01005500;
 Wed,  6 Nov 2019 08:54:01 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72F64608B6;
 Wed,  6 Nov 2019 08:53:54 +0000 (UTC)
Date: Wed, 6 Nov 2019 09:53:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio: notify virtqueue via host notifier when
 available
Message-ID: <20191106085353.GC189998@stefanha-x1.localdomain>
References: <20191105140946.165584-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191105140946.165584-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
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
Cc: Yongji Xie <elohimes@gmail.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, felipe@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 03:09:46PM +0100, Stefan Hajnoczi wrote:
> Host notifiers are used in several cases:
> 1. Traditional ioeventfd where virtqueue notifications are handled in
>    the main loop thread.
> 2. IOThreads (aio_handle_output) where virtqueue notifications are
>    handled in an IOThread AioContext.
> 3. vhost where virtqueue notifications are handled by kernel vhost or
>    a vhost-user device backend.
>=20
> Most virtqueue notifications from the guest use the ioeventfd mechanism,
> but there are corner cases where QEMU code calls virtio_queue_notify().
> This currently honors the host notifier for the IOThreads
> aio_handle_output case, but not for the vhost case.  The result is that
> vhost does not receive virtqueue notifications from QEMU when
> virtio_queue_notify() is called.
>=20
> This patch extends virtio_queue_notify() to set the host notifier
> whenever it is enabled instead of calling the vq->(aio_)handle_output()
> function directly.  We track the host notifier state for each virtqueue
> separately since some devices may use it only for certain virtqueues.
>=20
> This fixes the vhost case although it does add a trip through the
> eventfd for the traditional ioeventfd case.  I don't think it's worth
> adding a fast path for the traditional ioeventfd case because calling
> virtio_queue_notify() is rare when ioeventfd is enabled.
>=20
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Track host notifier enabled/disabled state per virtqueue [Yongji Xie]
>  * Tested with contrib/vhost-user-blk and contrib/vhost-user-scsi

Hi Michael,
Please consider this for QEMU 4.2 so that SeaBIOS works even when it
selects the VP_ACCESS_PCICFG access mode.

Felipe tested this successfully yesterday.

Stefan

>  hw/virtio/virtio-bus.c     | 4 ++++
>  hw/virtio/virtio.c         | 9 ++++++++-
>  include/hw/virtio/virtio.h | 1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index b2c804292e..d6332d45c3 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -288,6 +288,10 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus=
, int n, bool assign)
>          k->ioeventfd_assign(proxy, notifier, n, false);
>      }
> =20
> +    if (r =3D=3D 0) {
> +        virtio_queue_set_host_notifier_enabled(vq, assign);
> +    }
> +
>      return r;
>  }
> =20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 762df12f4c..04716b5f6c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -128,6 +128,7 @@ struct VirtQueue
>      VirtIODevice *vdev;
>      EventNotifier guest_notifier;
>      EventNotifier host_notifier;
> +    bool host_notifier_enabled;
>      QLIST_ENTRY(VirtQueue) node;
>  };
> =20
> @@ -2271,7 +2272,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>      }
> =20
>      trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> -    if (vq->handle_aio_output) {
> +    if (vq->host_notifier_enabled) {
>          event_notifier_set(&vq->host_notifier);
>      } else if (vq->handle_output) {
>          vq->handle_output(vdev, vq);
> @@ -3145,6 +3146,7 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
>          vdev->vq[i].vector =3D VIRTIO_NO_VECTOR;
>          vdev->vq[i].vdev =3D vdev;
>          vdev->vq[i].queue_index =3D i;
> +        vdev->vq[i].host_notifier_enabled =3D false;
>      }
> =20
>      vdev->name =3D name;
> @@ -3436,6 +3438,11 @@ EventNotifier *virtio_queue_get_host_notifier(Virt=
Queue *vq)
>      return &vq->host_notifier;
>  }
> =20
> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)
> +{
> +    vq->host_notifier_enabled =3D enabled;
> +}
> +
>  int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
>                                        MemoryRegion *mr, bool assign)
>  {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 3448d67d2a..c32a815303 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -312,6 +312,7 @@ int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)=
;
>  void virtio_queue_host_notifier_read(EventNotifier *n);
>  void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContex=
t *ctx,
>                                                  VirtIOHandleAIOOutput ha=
ndle_output);
> --=20
> 2.23.0
>=20
>=20

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3CiiEACgkQnKSrs4Gr
c8jJYAf+NG0G6HfKRFAAte2ryK+cMnN7xSgWD6D26x35waWpluAc0qZDiS/bnLJr
Yhy4wlQduXZbDZ7fC3wvrKYRPfzVWIXIY8uOea9v6TVAxpVj4R5nIiE0CnkLKDSi
Tux5rvxuwKUMe/nfLi3GuaECjioRwst/j8ncmmENOS9xPAcTRSOzTptt/HyQGMr7
ONcV+EU2YHNKJGlAwxubIeLmmwiY4Kf1qlZ7vPgxOzyWDysyl9Xy3g8K9Gz0Pfcr
xSOV+dVGapmWD8VkpTIa/8vtJ0G6Y+xIcsSHYs0ubwq8Xi5AAcVtTvduZv5KQWxk
ZURivmazfmmXO73FaDcjvfZmS2brKQ==
=jolD
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--


