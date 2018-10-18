Received: from eggs.gnu.org ([2001:4830:134:3::10]:39186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yx-0006oa-Np
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yw-0003C5-AX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD7yw-0003A2-0w
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:54 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 18 Oct 2018 15:04:32 +0200
Message-Id: <20181018130434.23237-3-philmd@redhat.com>
In-Reply-To: <20181018130434.23237-1-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/4] hw/misc/pvpanic: Cosmetic renaming
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

To ease the MMIO device addition in the next patch, rename:
- ISA_PVPANIC_DEVICE -> PVPANIC (this just returns a generic Object),
- ISADevice parent_obj -> isadev,
- MemoryRegion io -> mr.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/pvpanic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 9d8961ba0c..4f552e1533 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -25,7 +25,7 @@
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
=20
-#define ISA_PVPANIC_DEVICE(obj)    \
+#define PVPANIC(obj)    \
     OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
=20
 static void handle_event(int event)
@@ -46,9 +46,11 @@ static void handle_event(int event)
 #include "hw/isa/isa.h"
=20
 typedef struct PVPanicState {
-    ISADevice parent_obj;
+    /*< private >*/
+    ISADevice isadev;
=20
-    MemoryRegion io;
+    /*< public >*/
+    MemoryRegion mr;
     uint16_t ioport;
 } PVPanicState;
=20
@@ -75,15 +77,15 @@ static const MemoryRegionOps pvpanic_ops =3D {
=20
 static void pvpanic_isa_initfn(Object *obj)
 {
-    PVPanicState *s =3D ISA_PVPANIC_DEVICE(obj);
+    PVPanicState *s =3D PVPANIC(obj);
=20
-    memory_region_init_io(&s->io, OBJECT(s), &pvpanic_ops, s, "pvpanic",=
 1);
+    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s, "pvpanic",=
 1);
 }
=20
 static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *d =3D ISA_DEVICE(dev);
-    PVPanicState *s =3D ISA_PVPANIC_DEVICE(dev);
+    PVPanicState *s =3D PVPANIC(dev);
     FWCfgState *fw_cfg =3D fw_cfg_find();
     uint16_t *pvpanic_port;
=20
@@ -96,7 +98,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Err=
or **errp)
     fw_cfg_add_file(fw_cfg, "etc/pvpanic-port", pvpanic_port,
                     sizeof(*pvpanic_port));
=20
-    isa_register_ioport(d, &s->io, s->ioport);
+    isa_register_ioport(d, &s->mr, s->ioport);
 }
=20
 static Property pvpanic_isa_properties[] =3D {
--=20
2.17.2
