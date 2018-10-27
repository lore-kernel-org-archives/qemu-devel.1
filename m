Received: from eggs.gnu.org ([2001:4830:134:3::10]:50997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL6-00068E-4P
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL4-0003W6-Us
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:04 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 28 Oct 2018 02:07:28 +0800
Message-Id: <1540663650-106694-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V5 3/5] hw/misc/pvpanic: Add the MMIO interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/pvpanic.c         | 81 +++++++++++++++++++++++++++++++++++++------=
----
 include/hw/misc/pvpanic.h |  1 +
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index dd3aef2..5d0fbc6 100644
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
  * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
@@ -25,9 +27,6 @@
 /* The pv event value */
 #define PVPANIC=5FPANICKED        (1 << PVPANIC=5FF=5FPANICKED)
=20
-#define PVPANIC(obj)    \
-    OBJECT=5FCHECK(PVPanicState, (obj), TYPE=5FPVPANIC)
-
 static void handle=5Fevent(int event)
 {
     static bool logged;
@@ -45,30 +44,50 @@ static void handle=5Fevent(int event)
=20
 #include "hw/isa/isa.h"
=20
-typedef struct PVPanicState {
-    /* private */
-    ISADevice isadev;
+/* PVPanicISAState for ISA device and
+ * use ioport.
+ */
+typedef struct PVPanicISAState {
+     /* private */
+     ISADevice isadev;
+     uint16=5Ft ioport;
=20
     /* public */
     MemoryRegion mr;
-    uint16=5Ft ioport;
-} PVPanicState;
+} PVPanicISAState;
+
+/* PVPanicMMIOState for sysbus device and
+ * use mmio.
+ */
+typedef struct PVPanicMMIOState {
+    /* private */
+    SysBusDevice busdev;
+
+     /* public */
+    MemoryRegion mr;
+} PVPanicMMIOState;
+
+#define PVPANIC=5FISA(obj)    \
+    OBJECT=5FCHECK(PVPanicISAState, (obj), TYPE=5FPVPANIC)
+
+#define PVPANIC=5FMMIO(obj)    \
+    OBJECT=5FCHECK(PVPanicMMIOState, (obj), TYPE=5FPVPANIC=5FMMIO)
=20
 /* return supported events on read */
-static uint64=5Ft pvpanic=5Fioport=5Fread(void *opaque, hwaddr addr, unsig=
ned size)
+static uint64=5Ft pvpanic=5Fread(void *opaque, hwaddr addr, unsigned size)
 {
     return PVPANIC=5FPANICKED;
 }
=20
-static void pvpanic=5Fioport=5Fwrite(void *opaque, hwaddr addr, uint64=5Ft=
 val,
+static void pvpanic=5Fwrite(void *opaque, hwaddr addr, uint64=5Ft val,
                                  unsigned size)
 {
     handle=5Fevent(val);
 }
=20
 static const MemoryRegionOps pvpanic=5Fops =3D {
-    .read =3D pvpanic=5Fioport=5Fread,
-    .write =3D pvpanic=5Fioport=5Fwrite,
+    .read =3D pvpanic=5Fread,
+    .write =3D pvpanic=5Fwrite,
     .impl =3D {
         .min=5Faccess=5Fsize =3D 1,
         .max=5Faccess=5Fsize =3D 1,
@@ -77,15 +96,16 @@ static const MemoryRegionOps pvpanic=5Fops =3D {
=20
 static void pvpanic=5Fisa=5Finitfn(Object *obj)
 {
-    PVPanicState *s =3D PVPANIC(obj);
+    PVPanicISAState *s =3D PVPANIC=5FISA(obj);
=20
-    memory=5Fregion=5Finit=5Fio(&s->mr, OBJECT(s), &pvpanic=5Fops, s, "pvp=
anic", 1);
+    memory=5Fregion=5Finit=5Fio(&s->mr, OBJECT(s), &pvpanic=5Fops, s,
+                          TYPE=5FPVPANIC, 1);
 }
=20
 static void pvpanic=5Fisa=5Frealizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *d =3D ISA=5FDEVICE(dev);
-    PVPanicState *s =3D PVPANIC(dev);
+    PVPanicISAState *s =3D PVPANIC=5FISA(dev);
     FWCfgState *fw=5Fcfg =3D fw=5Fcfg=5Ffind();
     uint16=5Ft *pvpanic=5Fport;
=20
@@ -102,7 +122,7 @@ static void pvpanic=5Fisa=5Frealizefn(DeviceState *dev,=
 Error **errp)
 }
=20
 static Property pvpanic=5Fisa=5Fproperties[] =3D {
-    DEFINE=5FPROP=5FUINT16(PVPANIC=5FIOPORT=5FPROP, PVPanicState, ioport, =
0x505),
+    DEFINE=5FPROP=5FUINT16(PVPANIC=5FIOPORT=5FPROP, PVPanicISAState, iopor=
t, 0x505),
     DEFINE=5FPROP=5FEND=5FOF=5FLIST(),
 };
=20
@@ -118,14 +138,41 @@ static void pvpanic=5Fisa=5Fclass=5Finit(ObjectClass =
*klass, void *data)
 static TypeInfo pvpanic=5Fisa=5Finfo =3D {
     .name          =3D TYPE=5FPVPANIC,
     .parent        =3D TYPE=5FISA=5FDEVICE,
-    .instance=5Fsize =3D sizeof(PVPanicState),
+    .instance=5Fsize =3D sizeof(PVPanicISAState),
     .instance=5Finit =3D pvpanic=5Fisa=5Finitfn,
     .class=5Finit    =3D pvpanic=5Fisa=5Fclass=5Finit,
 };
=20
+
+static void pvpanic=5Fmmio=5Finitfn(Object *obj)
+{
+    PVPanicMMIOState *s =3D PVPANIC=5FMMIO(obj);
+    SysBusDevice *sbd =3D SYS=5FBUS=5FDEVICE(obj);
+
+    memory=5Fregion=5Finit=5Fio(&s->mr, OBJECT(s), &pvpanic=5Fops, s,
+                          TYPE=5FPVPANIC=5FMMIO, 2);
+    sysbus=5Finit=5Fmmio(sbd, &s->mr);
+}
+
+static void pvpanic=5Fmmio=5Fclass=5Finit(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE=5FCLASS(klass);
+
+    set=5Fbit(DEVICE=5FCATEGORY=5FMISC, dc->categories);
+}
+
+static TypeInfo pvpanic=5Fmmio=5Finfo =3D {
+    .name          =3D TYPE=5FPVPANIC=5FMMIO,
+    .parent        =3D TYPE=5FSYS=5FBUS=5FDEVICE,
+    .instance=5Fsize =3D sizeof(PVPanicMMIOState),
+    .instance=5Finit =3D pvpanic=5Fmmio=5Finitfn,
+    .class=5Finit    =3D pvpanic=5Fmmio=5Fclass=5Finit,
+};
+
 static void pvpanic=5Fregister=5Ftypes(void)
 {
     type=5Fregister=5Fstatic(&pvpanic=5Fisa=5Finfo);
+    type=5Fregister=5Fstatic(&pvpanic=5Fmmio=5Finfo);
 }
=20
 type=5Finit(pvpanic=5Fregister=5Ftypes)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1ee071a..19c0fbb 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -17,6 +17,7 @@
 #define TYPE=5FPVPANIC "pvpanic"
=20
 #define PVPANIC=5FIOPORT=5FPROP "ioport"
+#define TYPE=5FPVPANIC=5FMMIO "pvpanic-mmio"
=20
 static inline uint16=5Ft pvpanic=5Fport(void)
 {
--=20
1.8.3.1
