Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA9DC2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1423A20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoHIVVjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1423A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJINK-0004ry-5K
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKH-0008BE-Td
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKG-00056J-O3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKG-000551-J5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnDNbYeUvmpDorhgokm/1iNeL5qLJps3iYBTT93GLig=;
 b=WoHIVVjj93phhO1A0q5uQqcsiDZerWRrkcbxkDUwh93LF2Xyf5NLTLoJfuKVZgXVp11i/3
 17b/fzPsxOuXRiV2gAC4KJ7xfyhORoMu0zTeL7nRe/ufvzVk/3MZ8cdg6Zq3BM50cCideF
 dASu7eokz0j9s6w28TeGNi3glXohEFg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-ScQylzUfM1ih5NAbtI1Xlw-1; Tue, 31 Mar 2020 10:57:10 -0400
X-MC-Unique: ScQylzUfM1ih5NAbtI1Xlw-1
Received: by mail-wr1-f70.google.com with SMTP id b2so12615775wrq.8
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X/uo4ffLJZzLWVp0KxSsnKk6uH/r18lUhk47tb/+9jM=;
 b=Fq9Uc75S4X7sfGDZp6hS865nhA5+zoz7yx7OHa6FiZ2iY3XDQV6C0mZXd8CNwyphjm
 6WHHR1FeeJeoUfEZQDGAzbyAj10A9//qZeGeKuwmdlcYhWZJ+wKA8FVwFwyBmMst+eW+
 IGCkFRbkEDfBo7R4u0gIjuNyKFgsgLrnTOQ87HG8ZE6FmSwPgIn+4bilDxNtsKdWiYqt
 rK2UkLtp5dSVeh9rs28kgGgZqauTF2DNCf72A5MVGo/9d5aM4tJEmh10939yEGcLIe3R
 19mvIPzYdbP+xkYz9LcCa1tDkX2q+PhqkmNV6tnWu6Y3WYDDlhlxd+2Fj+EhAXhiJwuj
 pTNA==
X-Gm-Message-State: ANhLgQ1qyVG12ituFssfEaFNRlWrVQW+Oh+VUMMolEUzHtHqMG9jiLab
 Og5YsO6p4G953VI7uDP5tZstUrcQFDKh0Vv5I5rRtPzn37dFuV6JbVhzPSwWiDHJfhvEstgoB2C
 BNYcadIX0q2Rm8ps=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr3770216wml.71.1585666628369; 
 Tue, 31 Mar 2020 07:57:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuDqCqN3lZmsXFPEvI8nPGtdCcxPYSXyacNae6nHkhz14vPjvmtDSGFjllINaww41O1BvaBg==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr3770198wml.71.1585666628170; 
 Tue, 31 Mar 2020 07:57:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id b15sm26679526wru.70.2020.03.31.07.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:07 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] virtio-serial-bus: Plug memory leak on realize() error
 paths
Message-ID: <20200331145631.135630-4-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Amit Shah <amit@kernel.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

We neglect to free port->bh on the error paths.  Fix that.
Reproducer:
    {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0', 'dr=
iver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVkZcGgV=
'}
    {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': 'virts=
erialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_serial_p=
ci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
    {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virts=
erialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_p=
ci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
    {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virts=
erialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_p=
ci0.0', 'nr': 2}, 'id': 'qLzcCkob'}

The leak stack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:125
    #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-loop.c:=
532
    #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/qemu/h=
w/char/virtio-serial-bus.c:946
    #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/core/q=
dev.c:891
    #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/object.=
c:2238
    #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/objec=
t.c:1324
    #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/qemu/q=
om/qom-qobject.c:26
    #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu/qom/=
object.c:1390
    #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-monitor=
.c:680
    #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-monitor.=
c:805

Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Amit Shah <amit@kernel.org>
Message-Id: <20200309021738.30072-1-pannengyuan@huawei.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/char/virtio-serial-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 941ed5aca9..99a65bab7f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -943,7 +943,6 @@ static void virtser_port_device_realize(DeviceState *de=
v, Error **errp)
     Error *err =3D NULL;
=20
     port->vser =3D bus->vser;
-    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
=20
     assert(vsc->have_data);
=20
@@ -992,6 +991,7 @@ static void virtser_port_device_realize(DeviceState *de=
v, Error **errp)
         return;
     }
=20
+    port->bh =3D qemu_bh_new(flush_queued_data_bh, port);
     port->elem =3D NULL;
 }
=20
--=20
MST


