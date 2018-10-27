Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL5-00068A-LI
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gGLL4-0003Vr-OA
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 05:57:03 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 28 Oct 2018 02:07:27 +0800
Message-Id: <1540663650-106694-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540663650-106694-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V5 2/5]  hw/misc/pvpanic: Cosmetic renaming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

To ease the MMIO device addition in the next patch, rename:
- ISA=5FPVPANIC=5FDEVICE -> PVPANIC (this just returns a generic Object),
- ISADevice parent=5Fobj -> isadev,
- MemoryRegion io -> mr.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/pvpanic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 9d8961b..dd3aef2 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -25,7 +25,7 @@
 /* The pv event value */
 #define PVPANIC=5FPANICKED        (1 << PVPANIC=5FF=5FPANICKED)
=20
-#define ISA=5FPVPANIC=5FDEVICE(obj)    \
+#define PVPANIC(obj)    \
     OBJECT=5FCHECK(PVPanicState, (obj), TYPE=5FPVPANIC)
=20
 static void handle=5Fevent(int event)
@@ -46,9 +46,11 @@ static void handle=5Fevent(int event)
 #include "hw/isa/isa.h"
=20
 typedef struct PVPanicState {
-    ISADevice parent=5Fobj;
+    /* private */
+    ISADevice isadev;
=20
-    MemoryRegion io;
+    /* public */
+    MemoryRegion mr;
     uint16=5Ft ioport;
 } PVPanicState;
=20
@@ -75,15 +77,15 @@ static const MemoryRegionOps pvpanic=5Fops =3D {
=20
 static void pvpanic=5Fisa=5Finitfn(Object *obj)
 {
-    PVPanicState *s =3D ISA=5FPVPANIC=5FDEVICE(obj);
+    PVPanicState *s =3D PVPANIC(obj);
=20
-    memory=5Fregion=5Finit=5Fio(&s->io, OBJECT(s), &pvpanic=5Fops, s, "pvp=
anic", 1);
+    memory=5Fregion=5Finit=5Fio(&s->mr, OBJECT(s), &pvpanic=5Fops, s, "pvp=
anic", 1);
 }
=20
 static void pvpanic=5Fisa=5Frealizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *d =3D ISA=5FDEVICE(dev);
-    PVPanicState *s =3D ISA=5FPVPANIC=5FDEVICE(dev);
+    PVPanicState *s =3D PVPANIC(dev);
     FWCfgState *fw=5Fcfg =3D fw=5Fcfg=5Ffind();
     uint16=5Ft *pvpanic=5Fport;
=20
@@ -96,7 +98,7 @@ static void pvpanic=5Fisa=5Frealizefn(DeviceState *dev, E=
rror **errp)
     fw=5Fcfg=5Fadd=5Ffile(fw=5Fcfg, "etc/pvpanic-port", pvpanic=5Fport,
                     sizeof(*pvpanic=5Fport));
=20
-    isa=5Fregister=5Fioport(d, &s->io, s->ioport);
+    isa=5Fregister=5Fioport(d, &s->mr, s->ioport);
 }
=20
 static Property pvpanic=5Fisa=5Fproperties[] =3D {
--=20
1.8.3.1
