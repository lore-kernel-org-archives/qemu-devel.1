Received: from eggs.gnu.org ([2001:4830:134:3::10]:45097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uP-0001Wd-H1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uO-0003RK-LU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:05 -0500
Received: from mail-db5eur01on0100.outbound.protection.outlook.com
	([104.47.2.100]:53152
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uO-0003QP-EB
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:04 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:45 +0300
Message-Id: <20180206203048.11096-32-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 31/34] hv-net: add .bootindex support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Add support for .bootindex property in hv-net.

This results in a corresponding entry appearing in fw_cfg "bootorder".

In order to actually boot off a hv-net device (via PXE) the firmware
needs also a driver for it (either built-in or supplied via ROM).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/net/hv-net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/hv-net.c b/hw/net/hv-net.c
index 614922c0fb..3d719458ea 100644
--- a/hw/net/hv-net.c
+++ b/hw/net/hv-net.c
@@ -1425,11 +1425,20 @@ static void hv_net_class_init(ObjectClass *klass, void *data)
     vdc->chan_notify_cb = hv_net_notify_cb;
 }
 
+static void hv_net_instance_init(Object *obj)
+{
+    HvNet *s = HV_NET(obj);
+    device_add_bootindex_property(obj, &s->conf.bootindex,
+                                  "bootindex", "/ethernet-phy@0",
+                                  DEVICE(obj), NULL);
+}
+
 static const TypeInfo hv_net_type_info = {
     .name = TYPE_HV_NET,
     .parent = TYPE_VMBUS_DEVICE,
     .instance_size = sizeof(HvNet),
     .class_init = hv_net_class_init,
+    .instance_init = hv_net_instance_init,
 };
 
 static void hv_net_register_types(void)
-- 
2.14.3
