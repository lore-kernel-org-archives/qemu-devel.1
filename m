Received: from eggs.gnu.org ([2001:4830:134:3::10]:54308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ay-0003VE-8U
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4aw-0002z2-TW
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:27 +1000
Message-Id: <20170606025135.2685-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/17] spapr_nvram: Check return value from
 blk_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

The blk_getlength() function can return an error value if the
image size cannot be determined. Check for this rather than
ploughing on and trying to g_malloc0() a negative number.
(Spotted by Coverity, CID 1288484.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/nvram/spapr_nvram.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index aa5d2c1..bc355a4 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -144,7 +144,15 @@ static void spapr_nvram_realize(VIOsPAPRDevice *dev, Error **errp)
     int ret;
 
     if (nvram->blk) {
-        nvram->size = blk_getlength(nvram->blk);
+        int64_t len = blk_getlength(nvram->blk);
+
+        if (len < 0) {
+            error_setg_errno(errp, -len,
+                             "could not get length of backing image");
+            return;
+        }
+
+        nvram->size = len;
 
         ret = blk_set_perm(nvram->blk,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
-- 
2.9.4
