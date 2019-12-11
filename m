Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99525C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE5D20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEj8FUwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE5D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4PI-00064d-EU
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1if4O5-0004xe-Ns
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1if4O3-0004Jo-Pu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:58:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1if4O3-0004IF-KH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576079930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LF1dOPkkuTUY5WR7kOVA1ZNEZ5JHPt+fMBamAfWIrSg=;
 b=PEj8FUwmD0Dveu/4ew7lZGNTxxA0UifcdNDe2w9w1pHnif+fHwyZYoFobvxEkVhjdVx19e
 uIxHrsDsnu1pyLIsnMylOfPM/N2oYdDKoUVf8cv1IaP2NwZj8lz8CAiGJbwAR3aeWEEALI
 zXjP9cf7HNkqk0LvctOoQP2uLiM7J6M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-_XS8jHSkPGKI9Ba8rIfW5g-1; Wed, 11 Dec 2019 10:58:49 -0500
Received: by mail-qt1-f200.google.com with SMTP id l4so4627830qte.18
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 07:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KwCuLFWJsKQ6wKycOKyImtLIXvkiiq6BW4T0+BojfLE=;
 b=BGT64qg9FquEdkWz4AGGuIItQ8oa+wIeYgc5d3Vs1BF5ju+zvSFLlkyUk1rxCKzvdb
 4AW8zgBA1NsQFa8hqGW7Pmhl29USMHJPtt3bL0eBS45MSxNpBQ+hYcR7P56gHUZYGFe0
 zU7kDOXnyQPQfWyxS9y33I0XhMErgWtQFzi1EUc4RPuw/m+4r0hbrDRT9KkM4K978O2E
 OUfApuS/HnnBZPNiUMZodAo6YL0fDNS1ApVtPzTAyTZq4Qkd+9MqtfDAZazp3kIWT4JO
 hJU//UmGg0nhQKCqVJ0dhFcSr0nG9+AWrIJVGlenx/0CZpUJ6QAxPsBWOitCoQKc/06u
 PVPQ==
X-Gm-Message-State: APjAAAU98rfBvlXKFSpGHm+deQOd1vuX1+0w6MqLxyBZfuywUjHQO2jW
 Md0C26uslhK2QZgZIbEktyuI7D1a9HEjCdvqrZ/sLBGRg1wDF7kUYd+REuszUUzz1loYs131i2m
 VzyQL/H9uqmvelS8=
X-Received: by 2002:a0c:ad35:: with SMTP id u50mr3781570qvc.158.1576079928833; 
 Wed, 11 Dec 2019 07:58:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfmDlKyetk+xQcaztQVA4F2qBN65e3FW7N9W2pqhI60L9kBCRjYK46vLDuqZPI0BJA/mmCmg==
X-Received: by 2002:a0c:ad35:: with SMTP id u50mr3781543qvc.158.1576079928521; 
 Wed, 11 Dec 2019 07:58:48 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id k184sm793573qke.2.2019.12.11.07.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 07:58:47 -0800 (PST)
Date: Wed, 11 Dec 2019 10:58:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: don't enable notifications during polling
Message-ID: <20191211105755-mutt-send-email-mst@kernel.org>
References: <20191209210957.65087-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209210957.65087-1-stefanha@redhat.com>
X-MC-Unique: _XS8jHSkPGKI9Ba8rIfW5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


Thanks! I'll queue it for merge after the release. If possible please ping =
me
after the release to help make sure it didn't get dropped.


> ---
>  hw/block/virtio-blk.c      |  9 +++++++--
>  hw/scsi/virtio-scsi.c      |  9 +++++++--
>  hw/virtio/virtio.c         | 12 ++++++------
>  include/hw/virtio/virtio.h |  1 +
>  4 files changed, 21 insertions(+), 10 deletions(-)
>=20
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


