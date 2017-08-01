Received: from eggs.gnu.org ([2001:4830:134:3::10]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGw-0003D8-F7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGt-0008Hu-Bg
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:22 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:44525
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dcSGt-0008HF-62
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:19 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Tue,  1 Aug 2017 10:10:47 +0200
Message-Id: <1501575048-13485-2-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
References: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/2] mmio-execution: warn the
 potential developer about migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, alistair.francis@xilinx.com, dgilbert@redhat.com, quintela@redhat.com, frederic.konrad@adacore.com

There are two potential corner cases with mmio-execution:
 * It adds a mmio-interface device which will be migrated.
 * It modifies the RAMBlock list during live migration which odd
   side effects.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 include/exec/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 400dd44..4ded02c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -154,6 +154,10 @@ struct MemoryRegionOps {
      * @offset is the location of the pointer inside @mr.
      *
      * Returns a pointer to a location which contains guest code.
+     *
+     * Warning: This breaks migration if used before or during migration
+     *          because mmio-interface device will be migrated and because
+     *          RAMBlock list _must_ be static during migration.
      */
     void *(*request_ptr)(void *opaque, hwaddr addr, unsigned *size,
                          unsigned *offset);
-- 
1.8.3.1
