Received: from eggs.gnu.org ([2001:4830:134:3::10]:45383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAE-0003vD-Li
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAA-0006PL-AB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAA-0006P6-1k
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D3AA369C3
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:54 +0000
Message-Id: <20170206173306.20603-5-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/16] exec: ram_block_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Create ram_block_discard_range in exec.c to replace
postcopy_ram_discard_range and most of ram_discard_range.

Those two routines are a bit of a weird combination, and
ram_discard_range is about to get more complex for hugepages.
It's OS dependent code (so shouldn't be in migration/ram.c) but
it needs quite a bit of the innards of RAMBlock so doesn't belong in
the os*.c.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/exec.c b/exec.c
index 8b9ed73..e040cdf 100644
--- a/exec.c
+++ b/exec.c
@@ -45,6 +45,12 @@
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace-root.h"
+
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+#include <fcntl.h>
+#include <linux/falloc.h>
+#endif
+
 #endif
 #include "exec/cpu-all.h"
 #include "qemu/rcu_queue.h"
@@ -3286,4 +3292,57 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
     rcu_read_unlock();
     return ret;
 }
+
+/*
+ * Unmap pages of memory from start to start+length such that
+ * they a) read as 0, b) Trigger whatever fault mechanism
+ * the OS provides for postcopy.
+ * The pages must be unmapped by the end of the function.
+ * Returns: 0 on success, none-0 on failure
+ *
+ */
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+{
+    int ret = -1;
+
+    rcu_read_lock();
+    uint8_t *host_startaddr = rb->host + start;
+
+    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
+        error_report("ram_block_discard_range: Unaligned start address: %p",
+                     host_startaddr);
+        goto err;
+    }
+
+    if ((start + length) <= rb->used_length) {
+        uint8_t *host_endaddr = host_startaddr + length;
+        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
+            error_report("ram_block_discard_range: Unaligned end address: %p",
+                         host_endaddr);
+            goto err;
+        }
+
+        errno = ENOTSUP; /* If we are missing MADVISE etc */
+
+#if defined(CONFIG_MADVISE)
+        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
+#endif
+        if (ret) {
+            ret = -errno;
+            error_report("ram_block_discard_range: Failed to discard range "
+                         "%s:%" PRIx64 " +%zx (%d)",
+                         rb->idstr, start, length, ret);
+        }
+    } else {
+        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
+                     "/%zx/" RAM_ADDR_FMT")",
+                     rb->idstr, start, length, rb->used_length);
+    }
+
+err:
+    rcu_read_unlock();
+
+    return ret;
+}
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index bd15853..1350c2e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -105,6 +105,7 @@ typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
     ram_addr_t offset, ram_addr_t length, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 
 #endif
 
-- 
2.9.3
