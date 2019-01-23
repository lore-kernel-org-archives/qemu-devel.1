Received: from eggs.gnu.org ([209.51.188.92]:38557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzU-0006I1-PI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzT-0001rf-W5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 21:22:30 +0000
Message-Id: <20190123212234.32068-2-stefanha@redhat.com>
In-Reply-To: <20190123212234.32068-1-stefanha@redhat.com>
References: <20190123212234.32068-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] memory: add
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, jusual@mail.ru, Laurent Vivier <lvivier@redhat.com>, jim@groklearning.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

ROM devices go via MemoryRegionOps->write() callbacks for write
operations and do not dirty/invalidate that memory.  Device emulation
must be able to mark memory ranges that have been modified internally
(e.g. using memory_region_get_ram_ptr()).

Introduce the memory_region_flush_rom_device() API for this purpose.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/exec/memory.h | 18 ++++++++++++++++++
 exec.c                | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cd2f209b64..abe9cc79c0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1344,6 +1344,24 @@ bool memory_region_snapshot_get_dirty(MemoryRegion=
 *mr,
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                                hwaddr size, unsigned client);
=20
+/**
+ * memory_region_flush_rom_device: Mark a range of pages dirty and inval=
idate
+ *                                 TBs (for self-modifying code).
+ *
+ * The MemoryRegionOps->write() callback of a ROM device must use this f=
unction
+ * to mark byte ranges that have been modified internally, such as by di=
rectly
+ * accessing the memory returned by memory_region_get_ram_ptr().
+ *
+ * This function marks the range dirty and invalidates TBs so that TCG c=
an
+ * detect self-modifying code.
+ *
+ * @mr: the region being flushed.
+ * @addr: the start, relative to the start of the region, of the range b=
eing
+ *        flushed.
+ * @size: the size, in bytes, of the range being flushed.
+ */
+void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwadd=
r size);
+
 /**
  * memory_region_set_readonly: Turn a memory region read-only (or read-w=
rite)
  *
diff --git a/exec.c b/exec.c
index 895449f926..105ff21e74 100644
--- a/exec.c
+++ b/exec.c
@@ -3162,6 +3162,18 @@ static void invalidate_and_set_dirty(MemoryRegion =
*mr, hwaddr addr,
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
 }
=20
+void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwadd=
r size)
+{
+    /* In principle this function would work on other memory region type=
s too,
+     * but the ROM device use case is the only one where this operation =
is
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
     unsigned access_size_max =3D mr->ops->valid.max_access_size;
--=20
2.20.1
