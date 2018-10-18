Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7z3-0006qv-L5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yy-0003Jx-Td
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD7yy-0003Gv-Kf
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:56 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 18 Oct 2018 15:04:33 +0200
Message-Id: <20181018130434.23237-4-philmd@redhat.com>
In-Reply-To: <20181018130434.23237-1-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/4] hw/misc/pvpanic: Add the MMIO interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Use TYPE_PVPANIC definition, split in 2 patches]
---
Peng: I hope this is now more obvious how you could reuse the pvpanic dev=
ice.

 hw/misc/pvpanic.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 4f552e1533..b81c5fa633 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -2,10 +2,12 @@
  * QEMU simulated pvpanic device.
  *
  * Copyright Fujitsu, Corp. 2013
+ * Copyright (c) 2018 ZTE Ltd.
  *
  * Authors:
  *     Wen Congyang <wency@cn.fujitsu.com>
  *     Hu Tao <hutao@cn.fujitsu.com>
+ *     Peng Hao <peng.hao2@zte.com.cn>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -47,7 +49,10 @@ static void handle_event(int event)
=20
 typedef struct PVPanicState {
     /*< private >*/
-    ISADevice isadev;
+    union {
+        ISADevice isadev;
+        SysBusDevice busdev;
+    };
=20
     /*< public >*/
     MemoryRegion mr;
@@ -123,9 +128,54 @@ static TypeInfo pvpanic_isa_info =3D {
     .class_init    =3D pvpanic_isa_class_init,
 };
=20
+static uint64_t pvpanic_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
+{
+    return -1;
+}
+
+static void pvpanic_mmio_write(void *opaque, hwaddr addr, uint64_t value=
,
+                                 unsigned size)
+{
+   handle_event(value);
+}
+
+static const MemoryRegionOps pvpanic_mmio_ops =3D {
+    .read =3D pvpanic_mmio_read,
+    .write =3D pvpanic_mmio_write,
+    .impl =3D {
+        .max_access_size =3D 1,
+    },
+};
+
+static void pvpanic_mmio_initfn(Object *obj)
+{
+    PVPanicState *s =3D PVPANIC(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_mmio_ops, s,
+                          TYPE_PVPANIC, 2);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static TypeInfo pvpanic_mmio_info =3D {
+    .name          =3D TYPE_PVPANIC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(PVPanicState),
+    .instance_init =3D pvpanic_mmio_initfn,
+    .class_init    =3D pvpanic_mmio_class_init,
+};
+
 static void pvpanic_register_types(void)
 {
     type_register_static(&pvpanic_isa_info);
+    type_register_static(&pvpanic_mmio_info);
 }
=20
 type_init(pvpanic_register_types)
--=20
2.17.2
