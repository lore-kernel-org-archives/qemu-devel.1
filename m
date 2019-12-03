Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71AC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A840206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4lkBY3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A840206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic0tN-0003Fo-AM
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 00:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ic0s6-000264-3E
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ic0s4-0000Kw-P8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:37:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ic0s1-0000Jc-0A
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575351427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdK08FZMfV08Cpe9fOWCZFkQjq1SkLe+mKFakSXhwvs=;
 b=X4lkBY3qVOkumodc/CFqkRzSG/vo9+YNDReYuds/6Fx8rtZxRTHLoCbObkXLmeYYdBKwj+
 iCdinzjK+PSg5exFYgLGYlUR3PcEQ62nPPLL16+aAlMTEtrBvrrScC5Y2m2cpYLw4hoaRA
 E5gP/gQJfzVulAyr2nbHqmD2XYOR470=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-AIIyWgUVMpyo2V1yT2wVng-1; Tue, 03 Dec 2019 00:37:06 -0500
Received: by mail-qt1-f197.google.com with SMTP id m8so1628271qta.20
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 21:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WzymI8ZCi06Ex4qrfn/OwvwMIRW+rCahgBr6N6YJpxw=;
 b=aa7H0CHVEEJbYVMwtSdHCeKG68iQqKTumkSv+BVYq0xGkVgSr8fHk730ysM5MKUaj1
 9Qa2Iiu/HhFK1NQJUAyOJOhgo+brSNo4EIW16In2+TXnM/gXpxdHsWEF3fYL0H+4T/sa
 1z6lltMgrWKXhDfuZVuAK0yT4es0qwbkPZ4+VSlJvrdgnuoiNVvsBV6xBtIbhk7Uk9Ws
 7AMi7982N0m2BBi7SnDjxtM7pOccYgP4cI0JRiJ61B2MSjkOnjvdEkWnn9btE3VGJku4
 ciyN6vuszZwMFaGvvg9Yx4skALg+4iPh0xAp9ZkWa6Ymli2mdPYeZHAsbdbc70aG84+D
 h5Gw==
X-Gm-Message-State: APjAAAUvWHReJ89VLurtaK6UcK+pgP5EYqUEbLoucJicPuSJ43TdoOho
 IeTRYCmBLVm0sje1iwn1/a2DTaET4Hs4bPGM6Hc5UDPUDlAdMbUUVrTAnf85O3YKOROVLrdV9lv
 S1fMKrgFw0L3yIWE=
X-Received: by 2002:ae9:e710:: with SMTP id m16mr3157159qka.242.1575351426093; 
 Mon, 02 Dec 2019 21:37:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTb+grFoBQECFWue+D0YsI4gZPXsbtWf+Sp/wGuWY+4POFc7EL7AtSnAKrztjlqnnMvbD1+A==
X-Received: by 2002:ae9:e710:: with SMTP id m16mr3157140qka.242.1575351425824; 
 Mon, 02 Dec 2019 21:37:05 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id x1sm1081675qtf.81.2019.12.02.21.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 21:37:05 -0800 (PST)
Date: Tue, 3 Dec 2019 00:37:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
Message-ID: <20191203003549-mutt-send-email-mst@kernel.org>
References: <1575285343-21864-1-git-send-email-pannengyuan@huawei.com>
 <dad28876-1850-32f3-fe47-9e4ec2c68f20@redhat.com>
 <4e9efebf-1862-8879-ed01-60f8777d4a65@huawei.com>
MIME-Version: 1.0
In-Reply-To: <4e9efebf-1862-8879-ed01-60f8777d4a65@huawei.com>
X-MC-Unique: AIIyWgUVMpyo2V1yT2wVng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, liyiting@huawei.com,
 zhang.zhanghailiang@huawei.com, kuhn.chenqun@huawei.com, amit@kernel.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 08:53:42AM +0800, pannengyuan wrote:
>=20
>=20
> On 2019/12/2 21:58, Laurent Vivier wrote:
> > On 02/12/2019 12:15, pannengyuan@huawei.com wrote:
> >> From: PanNengyuan <pannengyuan@huawei.com>
> >>
> >> ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
> >> virtio_serial_device_unrealize, the memory leak stack is as bellow:
> >>
> >> Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
> >>     #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
> >>     #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x5001=
5)
> >>     #2 0x5650e02b83e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/v=
irtio/virtio.c:2327
> >>     #3 0x5650e02847b5 in virtio_serial_device_realize /mnt/sdb/qemu-4.=
2.0-rc0/hw/char/virtio-serial-bus.c:1089
> >>     #4 0x5650e02b56a7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0=
/hw/virtio/virtio.c:3504
> >>     #5 0x5650e03bf031 in device_set_realized /mnt/sdb/qemu-4.2.0-rc0/h=
w/core/qdev.c:876
> >>     #6 0x5650e0531efd in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom=
/object.c:2080
> >>     #7 0x5650e053650e in object_property_set_qobject /mnt/sdb/qemu-4.2=
.0-rc0/qom/qom-qobject.c:26
> >>     #8 0x5650e0533e14 in object_property_set_bool /mnt/sdb/qemu-4.2.0-=
rc0/qom/object.c:1338
> >>     #9 0x5650e04c0e37 in virtio_pci_realize /mnt/sdb/qemu-4.2.0-rc0/hw=
/virtio/virtio-pci.c:1801
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> >> ---
> >>  hw/char/virtio-serial-bus.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> >> index 3325904..da9019a 100644
> >> --- a/hw/char/virtio-serial-bus.c
> >> +++ b/hw/char/virtio-serial-bus.c
> >> @@ -1126,9 +1126,15 @@ static void virtio_serial_device_unrealize(Devi=
ceState *dev, Error **errp)
> >>  {
> >>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>      VirtIOSerial *vser =3D VIRTIO_SERIAL(dev);
> >> +    int i;
> >> =20
> >>      QLIST_REMOVE(vser, next);
> >> =20
> >> +    for (i =3D 0; i <=3D vser->bus.max_nr_ports; i++) {
> >> +        virtio_del_queue(vdev, 2 * i);
> >> +        virtio_del_queue(vdev, 2 * i + 1);
> >> +    }
> >> +
> >=20
> > According to virtio_serial_device_realize() and the number of
> > virtio_add_queue(), I think you have more queues to delete:
> >=20
> >   4 + 2 * vser->bus.max_nr_ports
> >=20
> > (for vser->ivqs[0], vser->ovqs[0], vser->c_ivq, vser->c_ovq,
> > vser->ivqs[i], vser->ovqs[i]).
> >=20
> > Thanks,
> > Laurent
> >=20
> >=20
> Thanks, but I think the queues is correct, the queues in
> virtio_serial_device_realize is as follow:
>=20
> // here is 2
> vser->ivqs[0] =3D virtio_add_queue(vdev, 128, handle_input);
> vser->ovqs[0] =3D virtio_add_queue(vdev, 128, handle_output);
>=20
> // here is 2
> vser->c_ivq =3D virtio_add_queue(vdev, 32, control_in);
> vser->c_ovq =3D virtio_add_queue(vdev, 32, control_out);
>=20
> // here 2 * (max_nr_ports - 1)  ----- i is from 1 to max_nr_ports - 1
> for (i =3D 1; i < vser->bus.max_nr_ports; i++) {
>     vser->ivqs[i] =3D virtio_add_queue(vdev, 128, handle_input);
>     vser->ovqs[i] =3D virtio_add_queue(vdev, 128, handle_output);
> }
>=20
> so the total queues number is:  2 * (vser->bus.max_nr_ports + 1)

Rather than worry about this, I posted a patch adding virtio_delete_queue.
How about reusing that, and just using ivqs/ovqs pointers?

--=20
MST


