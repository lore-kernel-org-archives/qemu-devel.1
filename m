Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C651C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 07:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F920206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwNPk8BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F920206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBCRS-0002JX-Ca
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 03:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBCQe-0001v4-66
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 03:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBCQc-0003xr-Jy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 03:02:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBCQc-0003tw-8q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 03:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583737337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58ahjNX1JCT9k4MvYwBdGgtQ7CUADVj7CUBYwK0bZ2Y=;
 b=FwNPk8BOu5564FoJkSl7UTY4PadQStsnvpQ7bVCcVCr2S6UlZeIycyM4DzfnnYnBmhWMWj
 4A7Iw7OUe599HsNDxLVNjFA2ApaZqsVGp18+oWU/4gkH2n9PIKCmwrw9DHKWEY9fppOeb1
 fIK1znTbLH+S2Ua2wJljv8gcLUIl8/w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-IScfo4d4ND6cZ8pBs59ccA-1; Mon, 09 Mar 2020 03:02:15 -0400
X-MC-Unique: IScfo4d4ND6cZ8pBs59ccA-1
Received: by mail-qt1-f198.google.com with SMTP id z5so1859632qtd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 00:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ljtRaHlk8RAzgPFQB1WyiePw7BeIpD0C/Q3QC2pnuQ=;
 b=qG0V1knShgcdrKlykN/3XLXxgQ+RYFZ6TuWnDiLD83M0/rNjykuayQvkX2bqd3OYGf
 iBNBZtV4jVkZSZ5WqYo9mMPvyafK7VAKoZmYpZfDgN2YVuGNA5rmskNy6x09JZqdbfGi
 276FdxvpWoHbfzsaLO/Ga7X0PfcuMIYYAkrzazGO9PrPoH/LGnrnQUwHjKXbo/cLPUGr
 kdWwybufCDN3UqSlrF+tBPJq/eLuPPDihR4tEHFn3D3AkJ6XmnepF+GcN0QN61/TRsE2
 kPPwf82HYNQqIuhkoRr/MYmGANJGDDNxLycjlLJz9Gebjwm/P0iGw3B+a4doC/t9uc/X
 j9Lw==
X-Gm-Message-State: ANhLgQ17WKGrRqWCzyUhTnXDxv0DPRGJRJ4H9/acIybZ8GbjhGBVl3x7
 Hpb3xZmxbnHJYZFSeyfFRDK7h2OQf1gU/+bW2YcdC4Dinps99KvqrLm7RPZvYvDlTLnJcDejtTq
 FDFfHl1zu+h2blxg=
X-Received: by 2002:aed:2266:: with SMTP id o35mr13381641qtc.392.1583737334002; 
 Mon, 09 Mar 2020 00:02:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu39SPSS8AxI0ac3iYx9KnKfL1lSCPZf7HuITekbJxln4v9gLpfmISdyTABPJZbLsevbbje8A==
X-Received: by 2002:aed:2266:: with SMTP id o35mr13381621qtc.392.1583737333744; 
 Mon, 09 Mar 2020 00:02:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id f3sm5284408qkk.48.2020.03.09.00.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 00:02:12 -0700 (PDT)
Date: Mon, 9 Mar 2020 03:02:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v3] virtio-serial-bus: Plug memory leak on realize()
 error paths
Message-ID: <20200309030140-mutt-send-email-mst@kernel.org>
References: <20200309021738.30072-1-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200309021738.30072-1-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, amit@kernel.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, euler.robot@huawei.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:17:38AM +0800, Pan Nengyuan wrote:
> We neglect to free port->bh on the error paths.  Fix that.
> Reproducer:
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
>=20
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
>=20
> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Amit Shah <amit@kernel.org>
> ---
> v1->v2:
> - simply create port->bh last in virtser_port_device_realize() to fix mem=
leaks.(Suggested by Markus Armbruster)


Markus, Amit do your Reviewed-by tags still stand?

> v3->v2:
> - tidy up commit message
> ---
>  hw/char/virtio-serial-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
> =20
> --=20
> 2.18.2


