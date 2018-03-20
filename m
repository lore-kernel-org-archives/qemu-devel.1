Received: from eggs.gnu.org ([2001:4830:134:3::10]:54329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@artemis.re>) id 1eyFY5-0004ba-0U
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@artemis.re>) id 1eyFY1-0005O5-HC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:35:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lists@artemis.re>) id 1eyFY1-0005C0-8l
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:35:21 -0400
Message-Id: <1521545718.1125216.1309456936.3F023B51@webmail.messagingengine.com>
From: Artemis Tosini <lists@artemis.re>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
Date: Tue, 20 Mar 2018 07:35:18 -0400
Subject: [Qemu-devel] [PATCH] nvdimm: ensure that dsm memory is read in
 nvdimm_dsm_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

This patch ensures that the client OS does not cause the host to read invalid memory from the NVDIMM DSM. It is not tested, since the Linux NVDIMM driver will not cause an invalid memory read.

This patch is for my outreachy assignment, and is my first open source patch.

>From bcb717b761ac62adeda145e895f92e4bde1003af Mon Sep 17 00:00:00 2001
From: Artemis Tosini <me@artemis.re>
Date: Sat, 10 Mar 2018 20:38:07 +0000
Subject: [PATCH] nvdimm: ensure that dsm memory is read in nvdimm_dsm_write

Signed-off-by: Artemis Tosini <me@artemis.re>
---
 hw/acpi/nvdimm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 59d6e4254c..67dda723a7 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -838,7 +838,12 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
      * this by copying DSM memory to QEMU local memory.
      */
     in = g_new(NvdimmDsmIn, 1);
-    cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
+    if (address_space_read(&address_space_memory, dsm_mem_addr,
+                          MEMTXATTRS_UNSPECIFIED, in,
+                          sizeof(*in)) != MEMTX_OK) {
+                            nvdimm_debug("Failed to read DSM memory");
+                            goto exit;
+                          }
 
     le32_to_cpus(&in->revision);
     le32_to_cpus(&in->function);
-- 
2.16.2
