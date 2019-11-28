Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8509C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0EC21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8+LhT3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0EC21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaP4L-0007Me-Kd
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iaNJm-0005P9-IE
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iaNCF-0007kI-Ta
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:03:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iaNCC-0007dp-8H
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574960589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bQIwbEI20fAZjznsj0+8Bd272sprVzfBXUoEjBgKkU=;
 b=Q8+LhT3ku4G80DknD0GQeRyaQTSy82qOkAPLwd+o7wUdBUxctozvxyjHlLfOXUYzFlcoJ3
 46iScyRawL+51EXRJR3TlJHwZ9+LgIHluqBq5lUHTgY/HRPh3r+q+bBG2Ko4uUaNRJtgMH
 tY2MOQfHerr/aWY08xRsZw291YUONJ0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-kwUxxOT6OpeCsy5iWdM88A-1; Thu, 28 Nov 2019 12:03:07 -0500
Received: by mail-qt1-f200.google.com with SMTP id e37so2971735qtk.7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J1rWe+koydqVDwGxNtZI3ABYIVF/u593BoVS7LpgStY=;
 b=dfhXq9m4trJwpi9UUpwReMHUrXyScvJtB5A8Eae5HjrpkoHhGz0gZYwPZopcxl/WFT
 l4wjFSWJAMII7hqvLNTVk22LJLwWr3W+LxDxqpVaZWMDYtV8c0k+QWi5Q1/ZBpU6RQ5C
 UltWZdKf9jMUEHwZV6Aj/6PI+7dhzbBTf/SiA0ztcPez1nKmZ3bV3Yqq2oeMDuCkr9/l
 kAmKV1kOXTCRXPVnUqCuinZxhg3h/Fo46zPJDzmHeLJiIYMyhn10edNtMi4JM7GWEorO
 raleqMVoLwjNo5XLoEwYix/42UshXYFKPSIC6cn0laqP7kPRP6vfx7eFHyZnpICgOqeC
 HXKA==
X-Gm-Message-State: APjAAAUjC30AQgEj/ZNpeO+0S57PU6lUlCZxcaLvV4L1gYrASWNAUK7Q
 jbtGioBP4ZDHRRayj+cwhd7YELEi6P7lR89zi3vhbDg9ATWwbtJKflllgMCMBIr0xRYPHLEulhE
 YC3Ar5+VbzDpO1m0=
X-Received: by 2002:a37:4782:: with SMTP id u124mr2342307qka.8.1574960587211; 
 Thu, 28 Nov 2019 09:03:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6ALny5alMin3D4cba7Y/YXReCyvXIoQrVPnK5W+rBvUiaXIMSr59wKbP3PkIGKnufCnvSCA==
X-Received: by 2002:a37:4782:: with SMTP id u124mr2342283qka.8.1574960586915; 
 Thu, 28 Nov 2019 09:03:06 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 206sm948987qkf.132.2019.11.28.09.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 09:03:06 -0800 (PST)
Date: Thu, 28 Nov 2019 12:03:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] virtio-pci: disable vring processing when
 bus-mastering is disabled
Message-ID: <20191128120223-mutt-send-email-mst@kernel.org>
References: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
 <20191128174800.2d4a2cc2.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191128174800.2d4a2cc2.pasic@linux.ibm.com>
X-MC-Unique: kwUxxOT6OpeCsy5iWdM88A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: Janosch Frank <frankja@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 05:48:00PM +0100, Halil Pasic wrote:
> On Tue, 19 Nov 2019 18:50:03 -0600
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> [..]
> > I.e. the calling code is only scheduling a one-shot BH for
> > virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
> > an additional virtqueue entry before we get there. This is likely due
> > to the following check in virtio_queue_host_notifier_aio_poll:
> >=20
> >   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
> >   {
> >       EventNotifier *n =3D opaque;
> >       VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> >       bool progress;
> >=20
> >       if (!vq->vring.desc || virtio_queue_empty(vq)) {
> >           return false;
> >       }
> >=20
> >       progress =3D virtio_queue_notify_aio_vq(vq);
> >=20
> > namely the call to virtio_queue_empty(). In this case, since no new
> > requests have actually been issued, shadow_avail_idx =3D=3D last_avail_=
idx,
> > so we actually try to access the vring via vring_avail_idx() to get
> > the latest non-shadowed idx:
> >=20
> >   int virtio_queue_empty(VirtQueue *vq)
> >   {
> >       bool empty;
> >       ...
> >=20
> >       if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
> >           return 0;
> >       }
> >=20
> >       rcu_read_lock();
> >       empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> >       rcu_read_unlock();
> >       return empty;
> >=20
> > but since the IOMMU region has been disabled we get a bogus value (0
> > usually), which causes virtio_queue_empty() to falsely report that
> > there are entries to be processed, which causes errors such as:
> >=20
> >   "virtio: zero sized buffers are not allowed"
> >=20
> > or
> >=20
> >   "virtio-blk missing headers"
> >=20
> > and puts the device in an error state.
> >=20
>=20
> I've seen something similar on s390x with virtio-ccw-blk under
> protected virtualization, that made me wonder about how virtio-blk in
> particular but also virtio in general handles shutdown and reset.
>=20
> This makes me wonder if bus-mastering disabled is the only scenario when
> a something like vdev->disabled should be used.
>=20
> In particular I have the following mechanism in mind=20
>=20
> qemu_system_reset() --> ... --> qemu_devices_reset() --> ... -->=20
> --> virtio_[transport]_reset() --> ... --> virtio_bus_stop_ioeventfd()
> --> virtio_blk_data_plane_stop()
>=20
> which in turn triggesrs the following cascade:
> virtio_blk_data_plane_stop_bh --> virtio_queue_aio_set_host_notifier_hand=
ler() -->
> --> virtio_queue_host_notifier_aio_read()=20
> which however calls=20
> virtio_queue_notify_aio_vq() if the notifier tests as
> positive.=20
>=20
> Since we still have vq->handle_aio_output that means we may
> call virtqueue_pop() during the reset procedure.
>=20
> This was a problem for us, because (due to a bug) the shared pages that
> constitute the virtio ring weren't shared any more. And thus we got
> the infamous =20
> virtio_error(vdev, "virtio: zero sized buffers are not allowed").
>=20
> Now the bug is no more, and we can tolerate that somewhat late access
> to the virtio ring.
>=20
> But it keeps nagging me, is it really OK for the device to access the
> virtio ring during reset? My intuition tells me that the device should
> not look for new requests after it has been told to reset.


Well it's after it was told to reset but it's not after
it completed reset. So I think it's fine ...

> Opinions? (Michael, Connie)
>=20
> Regards,
> Halil
>=20
> > This patch works around the issue by introducing virtio_set_disabled(),
> > which sets a 'disabled' flag to bypass checks like virtio_queue_empty()
> > when bus-mastering is disabled. Since we'd check this flag at all the
> > same sites as vdev->broken, we replace those checks with an inline
> > function which checks for either vdev->broken or vdev->disabled.
> >=20
> > The 'disabled' flag is only migrated when set, which should be fairly
> > rare, but to maintain migration compatibility we disable it's use for
> > older machine types. Users requiring the use of the flag in conjunction
> > with older machine types can set it explicitly as a virtio-device
> > option.
> >=20


