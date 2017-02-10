Received: from eggs.gnu.org ([2001:4830:134:3::10]:49651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcA-00022q-FY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc9-0003zQ-CL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc9-0003sU-4n
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-0007df-9R
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:59 +0000
Message-Id: <1486750082-12324-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/12] aspeed: check for negative values
 returned by blk_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

write_boot_rom() does not check for negative values. This is more a
problem for coverity than the actual code as the size of the flash
device is checked when the m25p80 object is created. If there is
anything wrong with the backing file, we should not even reach that
path.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1486648058-520-2-git-send-email-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a92c2f1..ac9cbd6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -113,9 +113,19 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
 {
     BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
     uint8_t *storage;
+    int64_t size;
 
-    if (rom_size > blk_getlength(blk)) {
-        rom_size = blk_getlength(blk);
+    /* The block backend size should have already been 'validated' by
+     * the creation of the m25p80 object.
+     */
+    size = blk_getlength(blk);
+    if (size <= 0) {
+        error_setg(errp, "failed to get flash size");
+        return;
+    }
+
+    if (rom_size > size) {
+        rom_size = size;
     }
 
     storage = g_new0(uint8_t, rom_size);
-- 
2.7.4
