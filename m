Received: from eggs.gnu.org ([2001:4830:134:3::10]:49699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fv5Fh-00058N-8z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 14:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fv5Fa-00037E-DR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 14:31:37 -0400
Received: from mail-eopbgr60119.outbound.protection.outlook.com
	([40.107.6.119]:29434
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fv5FZ-00036U-SF
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 14:31:30 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Wed, 29 Aug 2018 21:30:56 +0300
Message-Id: <1535567456-6904-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] dump: fix Windows dump memory run mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

We should map and use guest memory run by parts if it can't be mapped as
a whole.
After this patch, continuos guest physical memory blocks which are not
continuos in host virtual address space will be processed correctly.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 win_dump.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/win_dump.c b/win_dump.c
index b15c191..aa39d9c 100644
--- a/win_dump.c
+++ b/win_dump.c
@@ -30,28 +30,32 @@ static size_t write_run(WinDumpPhyMemRun64 *run, int fd, Error **errp)
     void *buf;
     uint64_t addr = run->BasePage << TARGET_PAGE_BITS;
     uint64_t size = run->PageCount << TARGET_PAGE_BITS;
-    uint64_t len = size;
+    uint64_t len, l;
+    size_t total = 0;
 
-    buf = cpu_physical_memory_map(addr, &len, false);
-    if (!buf) {
-        error_setg(errp, "win-dump: failed to map run");
-        return 0;
-    }
-    if (len != size) {
-        error_setg(errp, "win-dump: failed to map entire run");
-        len = 0;
-        goto out_unmap;
-    }
+    while (size) {
+        len = size;
 
-    len = qemu_write_full(fd, buf, len);
-    if (len != size) {
-        error_setg(errp, QERR_IO_ERROR);
-    }
+        buf = cpu_physical_memory_map(addr, &len, false);
+        if (!buf) {
+            error_setg(errp, "win-dump: failed to map physical range"
+                             " 0x%016lx-0x%016lx", addr, addr + size - 1);
+            return 0;
+        }
+
+        l = qemu_write_full(fd, buf, len);
+        cpu_physical_memory_unmap(buf, addr, false, len);
+        if (l != len) {
+            error_setg(errp, QERR_IO_ERROR);
+            return 0;
+        }
 
-out_unmap:
-    cpu_physical_memory_unmap(buf, addr, false, len);
+        addr += l;
+        size -= l;
+        total += l;
+    }
 
-    return len;
+    return total;
 }
 
 static void write_runs(DumpState *s, WinDumpHeader64 *h, Error **errp)
-- 
2.7.4
