Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mO-0006jr-6I
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mM-0008EL-Kv
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mM-0008E5-Fw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:38 -0400
Date: Tue, 20 Mar 2018 05:17:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-24-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/50] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility to give the offset of a host pointer within a RAMBlock
(assuming we already know it's in that RAMBlock)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/cpu-common.h |  1 +
 exec.c                    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74341b1..0d861a6 100644
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
diff --git a/exec.c b/exec.c
index 34fdfd9..2199b09 100644
--- a/exec.c
+++ b/exec.c
@@ -2297,6 +2297,16 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
     return ramblock_ptr(block, addr);
 }
 
+/* Return the offset of a hostpointer within a ramblock */
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+{
+    ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;
+    assert((uintptr_t)host >= (uintptr_t)rb->host);
+    assert(res < rb->max_length);
+
+    return res;
+}
+
 /*
  * Translates a host ptr back to a RAMBlock, a ram_addr and an offset
  * in that RAMBlock.
-- 
MST
