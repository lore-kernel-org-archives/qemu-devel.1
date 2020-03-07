Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ADC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 16:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1253120674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 16:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkGD3PPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1253120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAcSj-000868-4L
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 11:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAcRv-0007PV-O9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 11:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAcRu-0005vk-3i
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 11:37:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAcRt-0005pk-Nu
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 11:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583599032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMYHOgMG08bUCWgai+ffisVNVaSYfRzltJdQKr9nkTo=;
 b=DkGD3PPWFto/EAjQ7n8RGmLl65iNkgX799XBw0eUAdP6GKKdbqD2TF7euudzS7hwYTobyQ
 etqvECVcP9o7Og0rVtZbevX9iQJuiyWCU5/eXfJm2UToO/WW7PhW7Mu5w5xo89O405gj+y
 S2fYxDJCfALh5/Ll/2UToi+PyQZOMxw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-HeFf8pPvO7OJadcsuRQLOg-1; Sat, 07 Mar 2020 11:37:11 -0500
X-MC-Unique: HeFf8pPvO7OJadcsuRQLOg-1
Received: by mail-qv1-f71.google.com with SMTP id k16so3738037qvj.7
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 08:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FuqTgUN0Ws0A4Sb15+4fdE4PCER/0ZFklzhZfir+m9I=;
 b=TCDP6sm9yH8BOptFCGRyz+JLneHmas/V6yHcW85LVyK5XK7CN4NAhj4WJHzp+bxMPb
 JChE2w6oKnL/h++1CZdIZFmnI0MTDEkWY2jN1f3R8srv6Y6mEbfbuCtRQvgZj3C5bpq5
 DICBiK3C7nqC2j8nEu6Z37bbjW+AnX3WIK5LKZNNZjH0tiLLNpLZzmJeb7AiK0W4D8xJ
 3gSrdMSpkaegyFnpwLbsyiATjKYWwF1JodIWMyHs2LUG/NdIeSwwdg/bLKUi7nRSTdUH
 gbRtes5URy7qPS6aR9dYAw8himh1HsjTKSssUpEjetVuseAQLMNMynGEcd8DMDaVFOtO
 E3vg==
X-Gm-Message-State: ANhLgQ2LCa6c53jAtSrikD7eRl6OdS1y369kXRA9Isb4uM420x3Gjm+a
 c5oLvOufpYBrKtzS6RzcfO6FHQUWjOpJ4deYeUGLIto43aFE+w/PbaItPBRlqGtK2XasXSM7nPA
 kjirUKHXsshKjsqY=
X-Received: by 2002:a37:664d:: with SMTP id a74mr7789232qkc.256.1583599029612; 
 Sat, 07 Mar 2020 08:37:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtKjeRRn27UatMH/ZcBPCF0lnvQ1ul7Owd1hNmVDUUOHJ0uxsvLhF08+bvkjSaFAuJ9d3ip1A==
X-Received: by 2002:a37:664d:: with SMTP id a74mr7789206qkc.256.1583599029325; 
 Sat, 07 Mar 2020 08:37:09 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id z20sm4337304qkj.26.2020.03.07.08.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 08:37:08 -0800 (PST)
Date: Sat, 7 Mar 2020 11:37:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2] virtio-serial-bus: do cleanup on the error path in
 realize() to avoid memleaks
Message-ID: <20200307113649-mutt-send-email-mst@kernel.org>
References: <20200306025030.28824-1-pannengyuan@huawei.com>
 <871rq57tor.fsf@dusky.pond.sub.org>
 <65938c80-07b0-d1fa-1261-0801a29269d9@huawei.com>
MIME-Version: 1.0
In-Reply-To: <65938c80-07b0-d1fa-1261-0801a29269d9@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, amit@kernel.org,
 euler.robot@huawei.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 06, 2020 at 05:35:06PM +0800, Pan Nengyuan wrote:
>=20
>=20
> On 3/6/2020 4:51 PM, Markus Armbruster wrote:
> > Pan Nengyuan <pannengyuan@huawei.com> writes:
> >=20
> >> port->bh forgot to delete on the error path, this patch add it to fix =
memleaks. It's easy to reproduce as follow(add a same nr port):
> >=20
> > Long line.  Suggest:
> >=20
> >     virtio-serial-bus: Plug memory leak on realize() error paths
> >=20
> >     We neglect to free port->bh on the error paths.  Fix that.
> >     Reproducer:
> Good suggestion. Looks simple and clear.
>=20
> Thanks.


OK pls repost with acks and fixed commit log.

> >=20
> > Perhaps the maintainer can tweak this for you without a respin.
> >=20
> >>     {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0'=
, 'driver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVk=
ZcGgV'}
> >>     {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': '=
virtserialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_ser=
ial_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
> >>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': '=
virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_ser=
ial_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
> >>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': '=
virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_ser=
ial_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
> >>
> >> The leak stack:
> >> Direct leak of 40 byte(s) in 1 object(s) allocated from:
> >>     #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xe=
fae8)
> >>     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
> >>     #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:=
125
> >>     #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-lo=
op.c:532
> >>     #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/q=
emu/hw/char/virtio-serial-bus.c:946
> >>     #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/c=
ore/qdev.c:891
> >>     #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/ob=
ject.c:2238
> >>     #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/=
object.c:1324
> >>     #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/q=
emu/qom/qom-qobject.c:26
> >>     #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu=
/qom/object.c:1390
> >>     #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-mo=
nitor.c:680
> >>     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-mon=
itor.c:805
> >>
> >> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >> ---
> >> v1->v2:
> >> - simply create port->bh last in virtser_port_device_realize() to fix =
memleaks.(Suggested by Markus Armbruster)
> >> ---
> >>  hw/char/virtio-serial-bus.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> >> index 941ed5aca9..99a65bab7f 100644
> >> --- a/hw/char/virtio-serial-bus.c
> >> +++ b/hw/char/virtio-serial-bus.c
> >> @@ -943,7 +943,6 @@ static void virtser_port_device_realize(DeviceStat=
e *dev, Error **errp)
> >>      Error *err =3D NULL;
> >> =20
> >>      port->vser =3D bus->vser;
> >> -    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
> >> =20
> >>      assert(vsc->have_data);
> >> =20
> >> @@ -992,6 +991,7 @@ static void virtser_port_device_realize(DeviceStat=
e *dev, Error **errp)
> >>          return;
> >>      }
> >> =20
> >> +    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
> >>      port->elem =3D NULL;
> >>  }
> >=20
> > Preferably with a tidied up commit message:
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >=20
> > .
> >=20


