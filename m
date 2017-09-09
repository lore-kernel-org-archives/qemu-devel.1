Received: from eggs.gnu.org ([2001:4830:134:3::10]:50803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKt-0007kp-AU
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhKo-00062T-KF
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:19 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:60202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqhKo-00061G-A1
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:14 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 02768716A6
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 17:06:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 09 Sep 2017 17:06:10 +0200
Message-ID: <150496957019.9654.12729412560336508445.stgit@bahia>
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/5] spapr_pci: drop useless check in
 spapr_populate_pci_child_dt()
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

spapr_phb_get_loc_code() either returns a non-null pointer, either
aborts if g_strdup_printf() failed to allocate memory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ef982f2ef370..cd8efb181223 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1282,12 +1282,8 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
                             pci_find_device_name((ccode >> 16) & 0xff,
                                                  (ccode >> 8) & 0xff,
                                                  ccode & 0xff)));
-    buf = spapr_phb_get_loc_code(sphb, dev);
-    if (!buf) {
-        error_report("Failed setting the ibm,loc-code");
-        return -1;
-    }
 
+    buf = spapr_phb_get_loc_code(sphb, dev);
     err = fdt_setprop_string(fdt, offset, "ibm,loc-code", buf);
     g_free(buf);
     if (err < 0) {
