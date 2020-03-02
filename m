Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9037AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 03:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F282468D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 03:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F282468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8cAl-0006N8-H1
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 22:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j8cAB-0005vp-Dx
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 22:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j8cA9-0002Jk-4e
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 22:54:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3254 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j8cA7-0002Ez-Dx
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 22:54:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4532CAC7F1DBEE73E268;
 Mon,  2 Mar 2020 11:54:00 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 11:53:53 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <lvivier@redhat.com>, <amit@kernel.org>, <mst@redhat.com>,
 <marcandre.lureau@redhat.com>, <pbonzini@redhat.com>
Subject: [PATCH] virtio-serial-bus: do cleanup on the error path in realize()
 to avoid memleaks
Date: Mon, 2 Mar 2020 12:09:33 +0800
Message-ID: <20200302040933.21789-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

port->bh forgot to delete on the error path, this patch add it to fix memleaks. It's easy to reproduce as follow(add a same nr port):
    {'execute': 'device_add', 'arguments': {'id': 'virtio_serial_pci0', 'driver': 'virtio-serial-pci', 'bus': 'pci.0', 'addr': '0x5'}, 'id': 'yVkZcGgV'}
    {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver': 'virtserialport', 'name': 'port1', 'chardev': 'channel1', 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
    {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
    {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus': 'virtio_serial_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}

The leak stack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f04a8008ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x56273eaee484 in aio_bh_new /mnt/sdb/backup/qemu/util/async.c:125
    #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-loop.c:532
    #4 0x56273d52e62e in virtser_port_device_realize /mnt/sdb/backup/qemu/hw/char/virtio-serial-bus.c:946
    #5 0x56273dcc5040 in device_set_realized /mnt/sdb/backup/qemu/hw/core/qdev.c:891
    #6 0x56273e5ebbce in property_set_bool /mnt/sdb/backup/qemu/qom/object.c:2238
    #7 0x56273e5e5a9c in object_property_set /mnt/sdb/backup/qemu/qom/object.c:1324
    #8 0x56273e5ef5f8 in object_property_set_qobject /mnt/sdb/backup/qemu/qom/qom-qobject.c:26
    #9 0x56273e5e5e6a in object_property_set_bool /mnt/sdb/backup/qemu/qom/object.c:1390
    #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-monitor.c:680
    #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-monitor.c:805

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/char/virtio-serial-bus.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 941ed5aca9..563b845f71 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -957,13 +957,13 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
     if (find_port_by_id(port->vser, port->id)) {
         error_setg(errp, "virtio-serial-bus: A port already exists at id %u",
                    port->id);
-        return;
+        goto fail;
     }
 
     if (port->name != NULL && find_port_by_name(port->name)) {
         error_setg(errp, "virtio-serial-bus: A port already exists by name %s",
                    port->name);
-        return;
+        goto fail;
     }
 
     if (port->id == VIRTIO_CONSOLE_BAD_ID) {
@@ -974,7 +974,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
             if (port->id == VIRTIO_CONSOLE_BAD_ID) {
                 error_setg(errp, "virtio-serial-bus: Maximum port limit for "
                                  "this device reached");
-                return;
+                goto fail;
             }
         }
     }
@@ -983,16 +983,20 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
     if (port->id >= max_nr_ports) {
         error_setg(errp, "virtio-serial-bus: Out-of-range port id specified, "
                          "max. allowed: %u", max_nr_ports - 1);
-        return;
+        goto fail;
     }
 
     vsc->realize(dev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        goto fail;
     }
 
     port->elem = NULL;
+    return;
+
+fail:
+    qemu_bh_delete(port->bh);
 }
 
 static void virtser_port_device_plug(HotplugHandler *hotplug_dev,
-- 
2.18.2


