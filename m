Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B19BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145802251F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3U+UzV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145802251F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPHv-0007qA-75
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXPGg-0006B8-9W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXPGf-0007oS-0U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:39:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXPGe-0007jl-SC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574253565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O68YboFL7OC0oAHnknV/Yz+MbI+Ba7Xe0xGXIchRuUo=;
 b=F3U+UzV5uae5uooXOWwxaAolU6T0BBufzurUjZlHy7utnxK703tLIGZmB1epucxVZ0kR6H
 kxvBIoMAWIx4P8oFUBP4bkekbI38vQg3qtagEVMtO2oLyWHKj3L2aEMSJtYat03ksgdfcS
 yzuvq6dYsp6WeMWkwJvMjK7AUyx5MxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-wO9cnzEFPS2-RIv-ecK1eA-1; Wed, 20 Nov 2019 07:39:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694AD85EE86;
 Wed, 20 Nov 2019 12:39:18 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB0719E97;
 Wed, 20 Nov 2019 12:39:16 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:39:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 7/8] vfio-ccw: Refactor ccw irq handler
Message-ID: <20191120133914.554210c1.cohuck@redhat.com>
In-Reply-To: <20191115033437.37926-8-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-8-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: wO9cnzEFPS2-RIv-ecK1eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 04:34:36 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Make it easier to add new ones in the future.
>=20
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/vfio/ccw.c | 55 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2b1a83b94c..b16526d5de 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -334,22 +334,35 @@ read_err:
>      css_inject_io_interrupt(sch);
>  }
> =20
> -static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **=
errp)
> +static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev, int irq=
,

Maybe make this unsigned?

> +                                           Error **errp)
>  {
>      VFIODevice *vdev =3D &vcdev->vdev;
>      struct vfio_irq_info *irq_info;
>      size_t argsz;
>      int fd;
> +    EventNotifier *notifier;
> +    IOHandler *fd_read;
> +
> +    switch (irq) {
> +    case VFIO_CCW_IO_IRQ_INDEX:
> +        notifier =3D &vcdev->io_notifier;
> +        fd_read =3D vfio_ccw_io_notifier_handler;
> +        break;
> +    default:
> +        error_setg(errp, "vfio: Unsupported device irq(%d) fd: %m", irq)=
;

Hm, which errno is this supposed to print?

> +        return;
> +    }
> =20
> -    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
> -        error_setg(errp, "vfio: unexpected number of io irqs %u",
> +    if (vdev->num_irqs < irq + 1) {
> +        error_setg(errp, "vfio: unexpected number of irqs %u",
>                     vdev->num_irqs);
>          return;
>      }
> =20
>      argsz =3D sizeof(*irq_info);
>      irq_info =3D g_malloc0(argsz);
> -    irq_info->index =3D VFIO_CCW_IO_IRQ_INDEX;
> +    irq_info->index =3D irq;
>      irq_info->argsz =3D argsz;
>      if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>                irq_info) < 0 || irq_info->count < 1) {
> @@ -357,37 +370,47 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDe=
vice *vcdev, Error **errp)
>          goto out_free_info;
>      }
> =20
> -    if (event_notifier_init(&vcdev->io_notifier, 0)) {
> +    if (event_notifier_init(notifier, 0)) {
>          error_setg_errno(errp, errno,
> -                         "vfio: Unable to init event notifier for IO");
> +                         "vfio: Unable to init event notifier for irq (%=
d)", irq);
>          goto out_free_info;
>      }
> =20
> -    fd =3D event_notifier_get_fd(&vcdev->io_notifier);
> -    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> +    fd =3D event_notifier_get_fd(notifier);
> +    qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
> =20
> -    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +    if (vfio_set_irq_signaling(vdev, irq, 0,
>                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>          qemu_set_fd_handler(fd, NULL, NULL, vcdev);
> -        event_notifier_cleanup(&vcdev->io_notifier);
> +        event_notifier_cleanup(notifier);
>      }
> =20
>  out_free_info:
>      g_free(irq_info);
>  }
> =20
> -static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
> +static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev, int i=
rq)

Also unsigned here?

>  {
>      Error *err =3D NULL;
> +    EventNotifier *notifier;
> +
> +    switch (irq) {
> +    case VFIO_CCW_IO_IRQ_INDEX:
> +        notifier =3D &vcdev->io_notifier;
> +        break;
> +    default:
> +        error_report("vfio: Unsupported device irq(%d) fd: %m", irq);

Same comment for the %m.

> +        return;
> +    }
> =20
> -    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
>                                 VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>          error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>      }
> =20
> -    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
> +    qemu_set_fd_handler(event_notifier_get_fd(notifier),
>                          NULL, NULL, vcdev);
> -    event_notifier_cleanup(&vcdev->io_notifier);
> +    event_notifier_cleanup(notifier);
>  }
> =20
>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> @@ -590,7 +613,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error =
**errp)
>          goto out_region_err;
>      }
> =20
> -    vfio_ccw_register_io_notifier(vcdev, &err);
> +    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
>      if (err) {
>          goto out_notifier_err;
>      }
> @@ -619,7 +642,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Erro=
r **errp)
>      S390CCWDeviceClass *cdc =3D S390_CCW_DEVICE_GET_CLASS(cdev);
>      VFIOGroup *group =3D vcdev->vdev.group;
> =20
> -    vfio_ccw_unregister_io_notifier(vcdev);
> +    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>      vfio_ccw_put_region(vcdev);
>      vfio_ccw_put_device(vcdev);
>      vfio_put_group(group);

Otherwise, looks good.


