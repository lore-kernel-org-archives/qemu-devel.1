Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F5020732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUPoq9oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F5020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QGS-0006hl-Uj
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9QFk-000638-Hl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9QFi-0008Ss-Lo
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:23:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9QFi-0008Ra-78
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583313821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oza3g3kLbrDPsZ6mKvmzK3KKYpXASs3lQGkG9XoLi80=;
 b=jUPoq9ojNU0Tf3j0c0ZP6GKSp7PmHrAi34ZgyP9ZPnrU+Qv0dCqFZMV0h8gG9gMk3QvXiF
 y1pq7mqIE/GuxsgcEDXETTHBgd3Vw+gFsxhtmC4wXG0Bpf5jf7cI9AZ2qQpi2aWTre9ai7
 /1SoUjV/QMTP12p47rInGrYWWT1U/h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-UtEish5eN4uF-d6jnF_2Vw-1; Wed, 04 Mar 2020 04:23:39 -0500
X-MC-Unique: UtEish5eN4uF-d6jnF_2Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A37C9107ACCC;
 Wed,  4 Mar 2020 09:23:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63EB11001B34;
 Wed,  4 Mar 2020 09:23:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B245511386A6; Wed,  4 Mar 2020 10:23:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] virtio-serial-bus: do cleanup on the error path in
 realize() to avoid memleaks
References: <20200302040933.21789-1-pannengyuan@huawei.com>
Date: Wed, 04 Mar 2020 10:23:26 +0100
In-Reply-To: <20200302040933.21789-1-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Mon, 2 Mar 2020 12:09:33 +0800")
Message-ID: <874kv4o4mp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 amit@kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> writes:

> port->bh forgot to delete on the error path, this patch add it to fix mem=
leaks. It's easy to reproduce as follow(add a same nr port):
>     {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0', '=
driver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVkZcG=
gV'}
>     {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': 'vir=
tserialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_serial=
_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'vir=
tserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial=
_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'vir=
tserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial=
_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
>
> The leak stack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae=
8)
>     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:125
>     #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-loop.=
c:532
>     #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/qemu=
/hw/char/virtio-serial-bus.c:946
>     #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/core=
/qdev.c:891
>     #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/objec=
t.c:2238
>     #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/obj=
ect.c:1324
>     #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/qemu=
/qom/qom-qobject.c:26
>     #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu/qo=
m/object.c:1390
>     #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-monit=
or.c:680
>     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-monito=
r.c:805
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93

> ---
>  hw/char/virtio-serial-bus.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 941ed5aca9..563b845f71 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -957,13 +957,13 @@ static void virtser_port_device_realize(DeviceState=
 *dev, Error **errp)
>      if (find_port_by_id(port->vser, port->id)) {
>          error_setg(errp, "virtio-serial-bus: A port already exists at id=
 %u",
>                     port->id);
> -        return;
> +        goto fail;
>      }
> =20
>      if (port->name !=3D NULL && find_port_by_name(port->name)) {
>          error_setg(errp, "virtio-serial-bus: A port already exists by na=
me %s",
>                     port->name);
> -        return;
> +        goto fail;
>      }
> =20
>      if (port->id =3D=3D VIRTIO_CONSOLE_BAD_ID) {
> @@ -974,7 +974,7 @@ static void virtser_port_device_realize(DeviceState *=
dev, Error **errp)
>              if (port->id =3D=3D VIRTIO_CONSOLE_BAD_ID) {
>                  error_setg(errp, "virtio-serial-bus: Maximum port limit =
for "
>                                   "this device reached");
> -                return;
> +                goto fail;
>              }
>          }
>      }
> @@ -983,16 +983,20 @@ static void virtser_port_device_realize(DeviceState=
 *dev, Error **errp)
>      if (port->id >=3D max_nr_ports) {
>          error_setg(errp, "virtio-serial-bus: Out-of-range port id specif=
ied, "
>                           "max. allowed: %u", max_nr_ports - 1);
> -        return;
> +        goto fail;
>      }
> =20
>      vsc->realize(dev, &err);
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
> -        return;
> +        goto fail;
>      }
> =20
>      port->elem =3D NULL;
> +    return;
> +
> +fail:
> +    qemu_bh_delete(port->bh);
>  }
> =20
>  static void virtser_port_device_plug(HotplugHandler *hotplug_dev,

Looks correct to me.

However, I wonder whether we could simply create port->bh later.  It's
for use by virtio_serial_throttle_port(), called on incoming migration
via virtio_serial_load_device(), virtio_load(), virtio_device_get().  It
runs flush_queued_data(), which does nothing unless
virtio_queue_ready(port->ovq).

Note that virtio_queue_ready() dereferences its argument.  It's safe
only after virtser_port_device_plug() set port->ovq.  I'd expect that to
be possible only while the device is realized.  If that's correct, we
could simply create port->bh last in virtser_port_device_realize().


