Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79AD21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF2KDv31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79AD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifj0q-0006uW-MB
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifj07-0006PJ-NJ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifj05-0007vF-FD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44274
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifj04-0007tg-VD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576236048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=85BsN3hcho5aOm2jFT958KOgCaKK0VGtvcO3s0ZtxsY=;
 b=OF2KDv31nMIIlskHOr4HutnTdko1ZViY65lu02CYkIJ81pIg+c2tz2Slb6LSMf2nBZMbAz
 W8ubMRK/RMeeXpDiGpDJVHaYduE3nivt9cow0xCzGZQ/Zzvt/319jKl49CJ+8oOJQ4OPHo
 Qac79/47C+/HxzDv6tydRehDOXq/qHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-O-pKwGUgNxuZAv0o8x55nw-1; Fri, 13 Dec 2019 06:20:44 -0500
X-MC-Unique: O-pKwGUgNxuZAv0o8x55nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C00DB63;
 Fri, 13 Dec 2019 11:20:43 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E0C6013D;
 Fri, 13 Dec 2019 11:20:40 +0000 (UTC)
Date: Fri, 13 Dec 2019 11:20:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: don't enable notifications during polling
Message-ID: <20191213112039.GH1180977@stefanha-x1.localdomain>
References: <20191209210957.65087-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209210957.65087-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="D6IIOQQv2Iwyp54J"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--D6IIOQQv2Iwyp54J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 09:09:57PM +0000, Stefan Hajnoczi wrote:
> Virtqueue notifications are not necessary during polling, so we disable
> them.  This allows the guest driver to avoid MMIO vmexits.
> Unfortunately the virtio-blk and virtio-scsi handler functions re-enable
> notifications, defeating this optimization.
>=20
> Fix virtio-blk and virtio-scsi emulation so they leave notifications
> disabled.  The key thing to remember for correctness is that polling
> always checks one last time after ending its loop, therefore it's safe
> to lose the race when re-enabling notifications at the end of polling.
>=20
> There is a measurable performance improvement of 5-10% with the null-co
> block driver.  Real-life storage configurations will see a smaller
> improvement because the MMIO vmexit overhead contributes less to
> latency.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c      |  9 +++++++--
>  hw/scsi/virtio-scsi.c      |  9 +++++++--
>  hw/virtio/virtio.c         | 12 ++++++------
>  include/hw/virtio/virtio.h |  1 +
>  4 files changed, 21 insertions(+), 10 deletions(-)

Post-release ping :)

> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 4c357d2928..c4e55fb3de 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -764,13 +764,16 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue=
 *vq)
>  {
>      VirtIOBlockReq *req;
>      MultiReqBuffer mrb =3D {};
> +    bool suppress_notifications =3D virtio_queue_get_notification(vq);
>      bool progress =3D false;
> =20
>      aio_context_acquire(blk_get_aio_context(s->blk));
>      blk_io_plug(s->blk);
> =20
>      do {
> -        virtio_queue_set_notification(vq, 0);
> +        if (suppress_notifications) {
> +            virtio_queue_set_notification(vq, 0);
> +        }
> =20
>          while ((req =3D virtio_blk_get_request(s, vq))) {
>              progress =3D true;
> @@ -781,7 +784,9 @@ bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *=
vq)
>              }
>          }
> =20
> -        virtio_queue_set_notification(vq, 1);
> +        if (suppress_notifications) {
> +            virtio_queue_set_notification(vq, 1);
> +        }
>      } while (!virtio_queue_empty(vq));
> =20
>      if (mrb.num_reqs) {
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index e8b2b64d09..f080545f48 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -597,12 +597,15 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQ=
ueue *vq)
>  {
>      VirtIOSCSIReq *req, *next;
>      int ret =3D 0;
> +    bool suppress_notifications =3D virtio_queue_get_notification(vq);
>      bool progress =3D false;
> =20
>      QTAILQ_HEAD(, VirtIOSCSIReq) reqs =3D QTAILQ_HEAD_INITIALIZER(reqs);
> =20
>      do {
> -        virtio_queue_set_notification(vq, 0);
> +        if (suppress_notifications) {
> +            virtio_queue_set_notification(vq, 0);
> +        }
> =20
>          while ((req =3D virtio_scsi_pop_req(s, vq))) {
>              progress =3D true;
> @@ -622,7 +625,9 @@ bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQue=
ue *vq)
>              }
>          }
> =20
> -        virtio_queue_set_notification(vq, 1);
> +        if (suppress_notifications) {
> +            virtio_queue_set_notification(vq, 1);
> +        }
>      } while (ret !=3D -EINVAL && !virtio_queue_empty(vq));
> =20
>      QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 762df12f4c..78e5852296 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -431,6 +431,11 @@ static void virtio_queue_packed_set_notification(Vir=
tQueue *vq, int enable)
>      }
>  }
> =20
> +bool virtio_queue_get_notification(VirtQueue *vq)
> +{
> +    return vq->notification;
> +}
> +
>  void virtio_queue_set_notification(VirtQueue *vq, int enable)
>  {
>      vq->notification =3D enable;
> @@ -3382,17 +3387,12 @@ static bool virtio_queue_host_notifier_aio_poll(v=
oid *opaque)
>  {
>      EventNotifier *n =3D opaque;
>      VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> -    bool progress;
> =20
>      if (!vq->vring.desc || virtio_queue_empty(vq)) {
>          return false;
>      }
> =20
> -    progress =3D virtio_queue_notify_aio_vq(vq);
> -
> -    /* In case the handler function re-enabled notifications */
> -    virtio_queue_set_notification(vq, 0);
> -    return progress;
> +    return virtio_queue_notify_aio_vq(vq);
>  }
> =20
>  static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 3448d67d2a..8ee93873a4 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -224,6 +224,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id);
> =20
>  void virtio_notify_config(VirtIODevice *vdev);
> =20
> +bool virtio_queue_get_notification(VirtQueue *vq);
>  void virtio_queue_set_notification(VirtQueue *vq, int enable);
> =20
>  int virtio_queue_ready(VirtQueue *vq);
> --=20
> 2.23.0
>=20

--D6IIOQQv2Iwyp54J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zdAcACgkQnKSrs4Gr
c8g9IAf+PHGuNGH3XQxUFrFazr4Fqtr+2S+NbYPxstmWksn5OPsFCrgkI1VMAXdz
Z11Q/GZP+FecZ5lQgdyq+yPmZgKPdS2sHcgv2boZWTvnzkzqorlu7ccQaxLFIUX/
YfoVdDxhY44Cq4dEFs0BhrXmpLTRtmZBAz9zYA3Eo5EzAhKtQwPvhAHCQsGYsL2q
t0niBFF4C6Rm9pCGE/X/eHRAkBtEiyzQb6unfhOlNhShUDRgGOZmLHkEswwBRnBY
j6ww77XEiAReE+R7WQ1J+n2EUa7Rpctd0oa4qv5EBx3T9E2YkDWXM8q8/ZSrRF4R
qYNBT8ipunF6xS6b9olqOqfBsyWm3Q==
=PGMw
-----END PGP SIGNATURE-----

--D6IIOQQv2Iwyp54J--


