Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4DC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983E208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2O3ubLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8iD-0008Q4-Ly
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jA8hO-0007Ar-3p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jA8hM-0000UN-Rb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:51:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jA8hL-0000Nl-RK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583484671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AsmXKMN4/qYicHDgzhWBIw8Ed2mUXKMMsDmBojI0Mw=;
 b=A2O3ubLz8ZRanlJlnHPZqk3LC/3ak1RcOe5xki4qDMxWbxsa2PzlpxOHxRnKphEdW1MNg2
 z4uUANh/0Bt7Xnh/e9nbrQdYx7St1FMVF4BP7JZk/Qb2tyLBbr+yWch+JDPSN6lGkMsKJ5
 niTmOihScxeoVi/iJresy2VJHXmXxpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-e65qGYGMNBaDnAxsa9OEOg-1; Fri, 06 Mar 2020 03:51:09 -0500
X-MC-Unique: e65qGYGMNBaDnAxsa9OEOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBFBBDBA5;
 Fri,  6 Mar 2020 08:51:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47AC5391;
 Fri,  6 Mar 2020 08:51:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD0AB11386A6; Fri,  6 Mar 2020 09:51:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2] virtio-serial-bus: do cleanup on the error path in
 realize() to avoid memleaks
References: <20200306025030.28824-1-pannengyuan@huawei.com>
Date: Fri, 06 Mar 2020 09:51:00 +0100
In-Reply-To: <20200306025030.28824-1-pannengyuan@huawei.com> (Pan Nengyuan's
 message of "Fri, 6 Mar 2020 10:50:30 +0800")
Message-ID: <871rq57tor.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 amit@kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> writes:

> port->bh forgot to delete on the error path, this patch add it to fix mem=
leaks. It's easy to reproduce as follow(add a same nr port):

Long line.  Suggest:

    virtio-serial-bus: Plug memory leak on realize() error paths

    We neglect to free port->bh on the error paths.  Fix that.
    Reproducer:

Perhaps the maintainer can tweak this for you without a respin.

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
> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> v1->v2:
> - simply create port->bh last in virtser_port_device_realize() to fix mem=
leaks.(Suggested by Markus Armbruster)
> ---
>  hw/char/virtio-serial-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 941ed5aca9..99a65bab7f 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -943,7 +943,6 @@ static void virtser_port_device_realize(DeviceState *=
dev, Error **errp)
>      Error *err =3D NULL;
> =20
>      port->vser =3D bus->vser;
> -    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
> =20
>      assert(vsc->have_data);
> =20
> @@ -992,6 +991,7 @@ static void virtser_port_device_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
> =20
> +    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
>      port->elem =3D NULL;
>  }

Preferably with a tidied up commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


