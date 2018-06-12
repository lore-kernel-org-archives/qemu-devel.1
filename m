Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3f-0002c5-6c
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3e-0001hz-4k
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:33 +1000
Message-Id: <20180612064503.14282-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/33] uninorth: remove token register from
 uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

>From observation of various OS sources it can be seen that the token reg=
ister
introduced in 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" is =
not
required, since the only register currently implemented is the uninorth h=
ardware
version which is read-only.

Remove the token register implementation and instead return the uninorth
version corresponding to the hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c         | 11 +++++------
 include/hw/pci-host/uninorth.h |  4 +++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index ba76b84dbc..a843aa7b36 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -524,19 +524,18 @@ static void unin_write(void *opaque, hwaddr addr, u=
int64_t value,
                        unsigned size)
 {
     trace_unin_write(addr, value);
-    if (addr =3D=3D 0x0) {
-        *(int *)opaque =3D value;
-    }
 }
=20
 static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
 {
     uint32_t value;
=20
-    value =3D 0;
     switch (addr) {
     case 0:
-        value =3D *(int *)opaque;
+        value =3D UNINORTH_VERSION_10A;
+        break;
+    default:
+        value =3D 0;
     }
=20
     trace_unin_read(addr, value);
@@ -555,7 +554,7 @@ static void unin_init(Object *obj)
     UNINState *s =3D UNI_NORTH(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
=20
-    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin", 0x=
1000);
+    memory_region_init_io(&s->mem, obj, &unin_ops, s, "unin", 0x1000);
=20
     sysbus_init_mmio(sbd, &s->mem);
 }
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index f6654bad9b..2a1cf9f284 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -29,6 +29,9 @@
=20
 #include "hw/ppc/openpic.h"
=20
+/* UniNorth version */
+#define UNINORTH_VERSION_10A    0x7
+
 #define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
 #define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
 #define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
@@ -57,7 +60,6 @@ typedef struct UNINState {
     SysBusDevice parent_obj;
=20
     MemoryRegion mem;
-    int token[1];
 } UNINState;
=20
 #define TYPE_UNI_NORTH "uni-north"
--=20
2.17.1
