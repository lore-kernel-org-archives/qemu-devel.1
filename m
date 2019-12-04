Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533AC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0A820659
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0A820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icPD8-0003Hz-Oe
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 02:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icPAE-0001jz-FM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icPAD-0001C2-49
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60716 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icPAB-00016h-4h
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:33:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CA939451D192BFAF0622;
 Wed,  4 Dec 2019 15:33:25 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Dec 2019 15:33:16 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH v2 3/3] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
Date: Wed, 4 Dec 2019 15:31:56 +0800
Message-ID: <1575444716-17632-3-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: liyiting@huawei.com, Laurent Vivier <lvivier@redhat.com>,
 zhang.zhanghailiang@huawei.com, Amit Shah <amit@kernel.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
virtio_serial_device_unrealize, the memory leak stack is as bellow:

Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
    #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x5650e02b83e7 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x5650e02847b5 in virtio_serial_device_realize hw/char/virtio-seri=
al-bus.c:1089
    #4 0x5650e02b56a7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x5650e03bf031 in device_set_realized hw/core/qdev.c:876
    #6 0x5650e0531efd in property_set_bool qom/object.c:2080
    #7 0x5650e053650e in object_property_set_qobject qom/qom-qobject.c:26
    #8 0x5650e0533e14 in object_property_set_bool qom/object.c:1338
    #9 0x5650e04c0e37 in virtio_pci_realize hw/virtio/virtio-pci.c:1801

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
Changes v2 to v1:
- use virtio_delete_queue to cleanup vq through a vq pointer (suggested b=
y
  Michael S. Tsirkin)
---
 hw/char/virtio-serial-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 3325904..e1cbce3 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1126,9 +1126,17 @@ static void virtio_serial_device_unrealize(DeviceS=
tate *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOSerial *vser =3D VIRTIO_SERIAL(dev);
+    int i;
=20
     QLIST_REMOVE(vser, next);
=20
+    virtio_delete_queue(vser->c_ivq);
+    virtio_delete_queue(vser->c_ovq);
+    for (i =3D 0; i < vser->bus.max_nr_ports; i++) {
+        virtio_delete_queue(vser->ivqs[i]);
+        virtio_delete_queue(vser->ovqs[i]);
+    }
+
     g_free(vser->ivqs);
     g_free(vser->ovqs);
     g_free(vser->ports_map);
--=20
2.7.2.windows.1



