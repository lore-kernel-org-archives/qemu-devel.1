Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGqUu-00030R-4C
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGqUp-0004d9-Qc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:08:44 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 18:08:27 +0000
Message-Id: <1511201308-23580-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
References: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.11 1/2] exec.c: Factor out
 before/after actions for notdirty memory writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

The function notdirty_mem_write() has a sequence of actions
it has to do before and after the actual business of writing
data to host RAM to ensure that dirty flags are correctly
updated and we flush any TCG translations for the region.
We need to do this also in other places that write directly
to host RAM, most notably the TCG atomic helper functions.
Pull out the before and after pieces into their own functions.

We use an API where the prepare function stashes the various
bits of information about the write into a struct for the
complete function to use, because in the calls for the atomic
helpers the place where the complete function will be called
doesn't have the information to hand.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Yes, memory-internal.h's header comment claims it's for
"obsolete" functions; but that was added in 2011 and in
practice the functions are still here. I think it's useful
as a header for functions that only need to be shared between
the memory subsystem and the accel/tcg code, which are always
going to be fairly tightly coupled. I'll send a separate
patch to fix up those comments, but I didn't want to put it
in with this for-stable bugfix.
---
 include/exec/memory-internal.h | 62 ++++++++++++++++++++++++++++++++++++++++
 exec.c                         | 65 ++++++++++++++++++++++++++++--------------
 2 files changed, 106 insertions(+), 21 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 647e9bd..98d8296 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -39,5 +39,67 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
                           struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
 
+/* Opaque struct for passing info from memory_notdirty_write_prepare()
+ * to memory_notdirty_write_complete(). Callers should treat all fields
+ * as private, with the exception of @active.
+ *
+ * @active is a field which is not touched by either the prepare or
+ * complete functions, but which the caller can use if it wishes to
+ * track whether it has called prepare for this struct and so needs
+ * to later call the complete function.
+ */
+typedef struct {
+    CPUState *cpu;
+    ram_addr_t ram_addr;
+    vaddr mem_vaddr;
+    unsigned size;
+    bool locked;
+    bool active;
+} NotDirtyInfo;
+
+/**
+ * memory_notdirty_write_prepare: call before writing to non-dirty memory
+ * @ndi: pointer to opaque NotDirtyInfo struct
+ * @cpu: CPU doing the write
+ * @mem_vaddr: virtual address of write
+ * @ram_addr: the ram address of the write
+ * @size: size of write in bytes
+ *
+ * Any code which writes to the host memory corresponding to
+ * guest RAM which has been marked as NOTDIRTY must wrap those
+ * writes in calls to memory_notdirty_write_prepare() and
+ * memory_notdirty_write_complete():
+ *
+ *  NotDirtyInfo ndi;
+ *  memory_notdirty_write_prepare(&ndi, ....);
+ *  ... perform write here ...
+ *  memory_notdirty_write_complete(&ndi);
+ *
+ * These calls will ensure that we flush any TCG translated code for
+ * the memory being written, update the dirty bits and (if possible)
+ * remove the slowpath callback for writing to the memory.
+ *
+ * This must only be called if we are using TCG; it will assert otherwise.
+ *
+ * We may take a lock in the prepare call, so callers must ensure that
+ * they don't exit (via longjump or otherwise) without calling complete.
+ *
+ * This call must only be made inside an RCU critical section.
+ * (Note that while we're executing a TCG TB we're always in an
+ * RCU critical section, which is likely to be the case for callers
+ * of these functions.)
+ */
+void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
+                                   CPUState *cpu,
+                                   vaddr mem_vaddr,
+                                   ram_addr_t ram_addr,
+                                   unsigned size);
+/**
+ * memory_notdirty_write_complete: finish write to non-dirty memory
+ * @ndi: pointer to the opaque NotDirtyInfo struct which was initialized
+ * by memory_not_dirty_write_prepare().
+ */
+void memory_notdirty_write_complete(NotDirtyInfo *ndi);
+
 #endif
 #endif
diff --git a/exec.c b/exec.c
index 2202f2d..03238a3 100644
--- a/exec.c
+++ b/exec.c
@@ -2354,18 +2354,55 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
     return block->offset + offset;
 }
 
-/* Called within RCU critical section.  */
-static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
-                               uint64_t val, unsigned size)
-{
-    bool locked = false;
+/* Called within RCU critical section. */
+void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
+                          CPUState *cpu,
+                          vaddr mem_vaddr,
+                          ram_addr_t ram_addr,
+                          unsigned size)
+{
+    ndi->cpu = cpu;
+    ndi->ram_addr = ram_addr;
+    ndi->mem_vaddr = mem_vaddr;
+    ndi->size = size;
+    ndi->locked = false;
 
     assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        locked = true;
+        ndi->locked = true;
         tb_lock();
         tb_invalidate_phys_page_fast(ram_addr, size);
     }
+}
+
+/* Called within RCU critical section. */
+void memory_notdirty_write_complete(NotDirtyInfo *ndi)
+{
+    if (ndi->locked) {
+        tb_unlock();
+    }
+
+    /* Set both VGA and migration bits for simplicity and to remove
+     * the notdirty callback faster.
+     */
+    cpu_physical_memory_set_dirty_range(ndi->ram_addr, ndi->size,
+                                        DIRTY_CLIENTS_NOCODE);
+    /* we remove the notdirty callback only if the code has been
+       flushed */
+    if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
+        tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
+    }
+}
+
+/* Called within RCU critical section.  */
+static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
+                               uint64_t val, unsigned size)
+{
+    NotDirtyInfo ndi;
+
+    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io_vaddr,
+                         ram_addr, size);
+
     switch (size) {
     case 1:
         stb_p(qemu_map_ram_ptr(NULL, ram_addr), val);
@@ -2382,21 +2419,7 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
     default:
         abort();
     }
-
-    if (locked) {
-        tb_unlock();
-    }
-
-    /* Set both VGA and migration bits for simplicity and to remove
-     * the notdirty callback faster.
-     */
-    cpu_physical_memory_set_dirty_range(ram_addr, size,
-                                        DIRTY_CLIENTS_NOCODE);
-    /* we remove the notdirty callback only if the code has been
-       flushed */
-    if (!cpu_physical_memory_is_clean(ram_addr)) {
-        tlb_set_dirty(current_cpu, current_cpu->mem_io_vaddr);
-    }
+    memory_notdirty_write_complete(&ndi);
 }
 
 static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
-- 
2.7.4
