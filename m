Received: from eggs.gnu.org ([2001:4830:134:3::10]:58661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPw-0001wk-QW
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehtPv-0000WR-JH
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehtPv-0000VS-9v
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 03:43:23 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  3 Feb 2018 09:43:09 +0100
Message-Id: <20180203084315.20497-9-armbru@redhat.com>
In-Reply-To: <20180203084315.20497-1-armbru@redhat.com>
References: <20180203084315.20497-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/14] hw/pci*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, eblake@redhat.com, f4bug@amsat.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +

Some lines where then manually tweaked to pass checkpatch.

A trailing '.' was removed in hw/pci/pci.c

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 6 +++---
 hw/pci/pci.c         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 0d8cacb884..2d25e9bf7c 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -38,7 +38,7 @@
  */
=20
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
@@ -449,8 +449,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, =
hwaddr addr)
     regno =3D (cfgaddr & BONITO_PCICONF_REG_MASK) >> BONITO_PCICONF_REG_=
OFFSET;
=20
     if (idsel =3D=3D 0) {
-        fprintf(stderr, "error in bonito pci config address " TARGET_FMT=
_plx
-            ",pcimap_cfg=3D%x\n", addr, s->regs[BONITO_PCIMAP_CFG]);
+        error_report("error in bonito pci config address " TARGET_FMT_pl=
x
+                     ",pcimap_cfg=3D%x", addr, s->regs[BONITO_PCIMAP_CFG=
]);
         exit(1);
     }
     pciaddr =3D PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e8f9fc1c27..fc25cdecba 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1115,8 +1115,8 @@ void pci_register_bar(PCIDevice *pci_dev, int regio=
n_num,
     assert(region_num >=3D 0);
     assert(region_num < PCI_NUM_REGIONS);
     if (size & (size-1)) {
-        fprintf(stderr, "ERROR: PCI region size must be pow2 "
-                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"\n", type, size)=
;
+        error_report("ERROR: PCI region size must be pow2 "
+                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"", type, size);
         exit(1);
     }
=20
--=20
2.13.6
