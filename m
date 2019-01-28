Received: from eggs.gnu.org ([209.51.188.92]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNA-0002gd-Oo
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN9-0008Rf-RI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:04 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN9-0008Pf-JS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id z5so19119239wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:31 +0000
Message-Id: <20190128181047.20781-11-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/26] memory: add
 memory_region_flush_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

ROM devices go via MemoryRegionOps->write() callbacks for write
operations and do not dirty/invalidate that memory.  Device emulation
must be able to mark memory ranges that have been modified internally
(e.g. using memory_region_get_ram_ptr()).

Introduce the memory_region_flush_rom_device() API for this purpose.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190123212234.32068-2-stefanha@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fix block comment style]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++++++++
 exec.c                | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cd2f209b64e..abe9cc79c0d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1344,6 +1344,24 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                                hwaddr size, unsigned client);
 
+/**
+ * memory_region_flush_rom_device: Mark a range of pages dirty and invalidate
+ *                                 TBs (for self-modifying code).
+ *
+ * The MemoryRegionOps->write() callback of a ROM device must use this function
+ * to mark byte ranges that have been modified internally, such as by directly
+ * accessing the memory returned by memory_region_get_ram_ptr().
+ *
+ * This function marks the range dirty and invalidates TBs so that TCG can
+ * detect self-modifying code.
+ *
+ * @mr: the region being flushed.
+ * @addr: the start, relative to the start of the region, of the range being
+ *        flushed.
+ * @size: the size, in bytes, of the range being flushed.
+ */
+void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size);
+
 /**
  * memory_region_set_readonly: Turn a memory region read-only (or read-write)
  *
diff --git a/exec.c b/exec.c
index 9557a4e523c..da3e635f91b 100644
--- a/exec.c
+++ b/exec.c
@@ -3162,6 +3162,19 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
 }
 
+void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
+{
+    /*
+     * In principle this function would work on other memory region types too,
+     * but the ROM device use case is the only one where this operation is
+     * necessary.  Other memory regions should use the
+     * address_space_read/write() APIs.
+     */
+    assert(memory_region_is_romd(mr));
+
+    invalidate_and_set_dirty(mr, addr, size);
+}
+
 static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 {
     unsigned access_size_max = mr->ops->valid.max_access_size;
-- 
2.20.1
