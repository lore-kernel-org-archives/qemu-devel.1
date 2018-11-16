Received: from eggs.gnu.org ([2001:4830:134:3::10]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gNTrk-0003G7-Bm
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gNTrg-0008Sz-0Y
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 21:28:16 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 16 Nov 2018 18:50:04 +0800
Message-Id: <1542365406-81310-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V7 4/6]  hw/arm/virt: Use the pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

 Add pvpanic device in arm virt machine.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |  1 +
 hw/arm/virt.c                   | 21 +++++++++++++++++++++
 include/hw/arm/virt.h           |  1 +
 3 files changed, 23 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 2420491..50345df 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -159,3 +159,4 @@ CONFIG=5FPCI=5FDESIGNWARE=3Dy
 CONFIG=5FSTRONGARM=3Dy
 CONFIG=5FHIGHBANK=3Dy
 CONFIG=5FMUSICPAL=3Dy
+CONFIG=5FPVPANIC=3Dy
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f67782..c4f29c8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/misc/pvpanic.h"
=20
 #define DEFINE=5FVIRT=5FMACHINE=5FLATEST(major, minor, latest) \
     static void virt=5F##major##=5F##minor##=5Fclass=5Finit(ObjectClass *o=
c, \
@@ -143,6 +144,7 @@ static const MemMapEntry a15memmap[] =3D {
     [VIRT=5FGPIO] =3D               { 0x09030000, 0x00001000 },
     [VIRT=5FSECURE=5FUART] =3D        { 0x09040000, 0x00001000 },
     [VIRT=5FSMMU] =3D               { 0x09050000, 0x00020000 },
+    [VIRT=5FPVPANIC] =3D            { 0x09070000, 0x00000002 },
     [VIRT=5FMMIO] =3D               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM=5FVIRTIO=5FTRANSPORTS, each of that=
 size */
     [VIRT=5FPLATFORM=5FBUS] =3D       { 0x0c000000, 0x02000000 },
@@ -190,6 +192,23 @@ static bool cpu=5Ftype=5Fvalid(const char *cpu)
     return false;
 }
=20
+static void create=5Fpvpanic=5Fdevice(const VirtMachineState *vms)
+{
+    char *nodename;
+    hwaddr base =3D vms->memmap[VIRT=5FPVPANIC].base;
+    hwaddr size =3D vms->memmap[VIRT=5FPVPANIC].size;
+
+    sysbus=5Fcreate=5Fsimple(TYPE=5FPVPANIC=5FMMIO, base, NULL);
+
+    nodename =3D g=5Fstrdup=5Fprintf("/pvpanic-mmio@%" PRIx64, base);
+    qemu=5Ffdt=5Fadd=5Fsubnode(vms->fdt, nodename);
+    qemu=5Ffdt=5Fsetprop=5Fstring(vms->fdt, nodename,
+                            "compatible", "qemu,pvpanic-mmio");
+    qemu=5Ffdt=5Fsetprop=5Fsized=5Fcells(vms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g=5Ffree(nodename);
+}
+
 static void create=5Ffdt(VirtMachineState *vms)
 {
     void *fdt =3D create=5Fdevice=5Ftree(&vms->fdt=5Fsize);
@@ -1531,6 +1550,8 @@ static void machvirt=5Finit(MachineState *machine)
=20
     create=5Fflash(vms, sysmem, secure=5Fsysmem ? secure=5Fsysmem : sysmem=
);
=20
+    create=5Fpvpanic=5Fdevice(vms);
+
     create=5Fgic(vms, pic);
=20
     fdt=5Fadd=5Fpmu=5Fnodes(vms);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7..937c124 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -66,6 +66,7 @@ enum {
     VIRT=5FGIC=5FREDIST,
     VIRT=5FGIC=5FREDIST2,
     VIRT=5FSMMU,
+    VIRT=5FPVPANIC,
     VIRT=5FUART,
     VIRT=5FMMIO,
     VIRT=5FRTC,
--=20
1.8.3.1
