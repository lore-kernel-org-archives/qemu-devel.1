Received: from eggs.gnu.org ([2001:4830:134:3::10]:49937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzNx3-0002m2-JA
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzNwy-0003bL-1c
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:13:37 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:59432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dzNwx-0003RZ-PU
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:13:31 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 39D7081E4B
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 16:13:23 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 03 Oct 2017 16:13:11 +0200
Message-ID: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] hw/ppc: use 0 instead of fdt_path_offset(fdt,
 "/")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>

The offset of the root node is guaranteed to be 0.

This doesn't fix anything, it's just trivial cleanup of the two
remaining places where this was done under hw/ppc.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c   |    3 +--
 hw/ppc/spapr.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d46d91c76f5c..84b2389ea60b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -92,8 +92,7 @@ static int get_cpus_node(void *fdt)
     int cpus_offset = fdt_path_offset(fdt, "/cpus");
 
     if (cpus_offset < 0) {
-        cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
-                                      "cpus");
+        cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
         if (cpus_offset) {
             _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
             _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff87f155d55e..352ff3d614e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -353,8 +353,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
 
         cpus_offset = fdt_path_offset(fdt, "/cpus");
         if (cpus_offset < 0) {
-            cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
-                                          "cpus");
+            cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
             if (cpus_offset < 0) {
                 return cpus_offset;
             }
