Received: from eggs.gnu.org ([2001:4830:134:3::10]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQM-0007ro-Vk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQL-0001Mw-FC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:23 +1100
Message-Id: <20180117022525.31767-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/22] ppc/pnv: change initrd address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When skiboot starts, it first clears the CPU structs for all possible
CPUs on a system :

	for (i =3D 0; i <=3D cpu_max_pir; i++)
		memset(&cpu_stacks[i].cpu, 0, sizeof(struct cpu_thread));

On POWER9, cpu_max_pir is quite big, 0x7fff, and the skiboot cpu_stacks
array overlaps with the memory region in which QEMU maps the initramfs
file. Move it upwards in memory to keep it safe.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80245f57f1..98ee3c607a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -53,7 +53,7 @@
 #define FW_MAX_SIZE             0x00400000
=20
 #define KERNEL_LOAD_ADDR        0x20000000
-#define INITRD_LOAD_ADDR        0x40000000
+#define INITRD_LOAD_ADDR        0x60000000
=20
 static const char *pnv_chip_core_typename(const PnvChip *o)
 {
--=20
2.14.3
