Received: from eggs.gnu.org ([2001:4830:134:3::10]:52084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnQ-0001uN-7M
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnN-0004IB-2i
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxnM-0004GU-Sz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:01 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:02 +0100
Message-Id: <20170824192730.8440-5-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 04/32] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility to give the offset of a host pointer within a RAMBlock
(assuming we already know it's in that RAMBlock)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 10 ++++++++++
 include/exec/cpu-common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/exec.c b/exec.c
index 67df2909ce..35b4cea2ed 100644
--- a/exec.c
+++ b/exec.c
@@ -2231,6 +2231,16 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/* Return the offset of a hostpointer within a ramblock */
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+{
+    ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;
+    assert((uint8_t *)host >= (uint8_t *)rb->host);
+    assert(res < rb->max_length);
+
+    return res;
+}
+
 /*
  * Translates a host ptr back to a RAMBlock, a ram_addr and an offset
  * in that RAMBlock.
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74341b19d2..0d861a6289 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -68,6 +68,7 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr);
 RAMBlock *qemu_ram_block_by_name(const char *name);
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
-- 
2.13.5
