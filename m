Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKh-0007cy-5q
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKg-0005ut-Ce
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:07 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:49645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqhKg-0005td-5v
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:06 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3297274BCE
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 17:06:05 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 09 Sep 2017 17:06:02 +0200
Message-ID: <150496956243.9654.5568893219758334324.stgit@bahia>
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/5] spapr_pci: drop useless check in
 spapr_phb_vfio_get_loc_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

g_strdup_printf() either returns a non-null pointer, either aborts
if it failed to allocate memory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d7880f257aa1..ef982f2ef370 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -766,7 +766,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
     /* Construct the path of the file that will give us the DT location */
     path = g_strdup_printf("/sys/bus/pci/devices/%s/devspec", host);
     g_free(host);
-    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
+    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
         goto err_out;
     }
     g_free(path);
@@ -774,7 +774,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
     /* Construct and read from host device tree the loc-code */
     path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
     g_free(buf);
-    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
+    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
         goto err_out;
     }
     return buf;
