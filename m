Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHti4-0005aW-EN
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHti3-0006Wp-PU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:14:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dHti3-0006ST-Hr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:14:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Jun 2017 16:14:17 +0100
Message-Id: <1496675657-11599-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] spapr_nvram: Check return value from
 blk_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

The blk_getlength() function can return an error value if the
image size cannot be determined. Check for this rather than
ploughing on and trying to g_malloc0() a negative number.
(Spotted by Coverity, CID 1288484.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
