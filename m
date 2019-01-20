Received: from eggs.gnu.org ([209.51.188.92]:58729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECI-0002pf-70
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECG-0002To-9u
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1glECC-0002Pf-2V
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun, 20 Jan 2019 14:34:49 +0000
Message-Id: <20190120143452.21683-2-stefanha@redhat.com>
In-Reply-To: <20190120143452.21683-1-stefanha@redhat.com>
References: <20190120143452.21683-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] memory: add
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim@groklearning.com, jusual@mail.ru, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

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
