Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMNir-0005w4-U9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 20:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMNim-0002Zo-RJ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 20:42:32 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gMNim-0002ZW-KO
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 20:42:28 -0500
Received: by mail-pf1-x444.google.com with SMTP id e22-v6so5178777pfn.8
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 17:42:28 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 12 Nov 2018 17:42:21 -0800
Message-Id: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] memory: check write/read_with_attrs in memory
 dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@gmail.com, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This can avoid the NULL-deref if the rm doesn't has a
read/write nor write/read_with_attrs callback.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index d14c6dec1d..3baf5857b9 100644
--- a/memory.c
+++ b/memory.c
@@ -1377,13 +1377,15 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_accessor,
                                          mr, attrs);
-    } else {
+    } else if (mr->ops->read_with_attrs) {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
                                          mr->ops->impl.max_access_size,
                                          memory_region_read_with_attrs_accessor,
                                          mr, attrs);
     }
+
+    return MEMTX_DECODE_ERROR;
 }
 
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
@@ -1454,7 +1456,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          mr->ops->impl.max_access_size,
                                          memory_region_write_accessor, mr,
                                          attrs);
-    } else {
+    } else if (mr->ops->write_with_attrs) {
         return
             access_with_adjusted_size(addr, &data, size,
                                       mr->ops->impl.min_access_size,
@@ -1462,6 +1464,8 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                       memory_region_write_with_attrs_accessor,
                                       mr, attrs);
     }
+
+    return MEMTX_DECODE_ERROR;
 }
 
 void memory_region_init_io(MemoryRegion *mr,
-- 
2.11.0
