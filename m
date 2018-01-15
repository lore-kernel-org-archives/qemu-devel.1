Received: from eggs.gnu.org ([2001:4830:134:3::10]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97f-0002Fy-Dm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97c-0007Iw-9b
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:39 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:42820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97c-0007HV-2x
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:36 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 9FFD7A27D3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:34 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:05 +0100
Message-Id: <20180115180406.28489-6-clg@kaod.org>
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] ppc/pnv: change initrd address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When skiboot starts, it first clears the CPU structs for all possible
CPUs on a system :

	for (i =3D 0; i <=3D cpu_max_pir; i++)
		memset(&cpu_stacks[i].cpu, 0, sizeof(struct cpu_thread));

On POWER9, cpu_max_pir is quite big, 0x7fff, and the skiboot cpu_stacks
array overlaps with the memory region in which QEMU maps the initramfs
file. Move it upwards in memory to keep it safe.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80245f57f1ae..98ee3c607ae7 100644
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
2.13.6
