Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDB-0004B9-JQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQID6-0007rA-PF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQID6-0007pF-Fq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:08 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:19 +0100
Message-Id: <20170628190047.26159-2-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 01/29] RAMBlock/migration: Add migration flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a migration flags field to each RAMBlock so that the migration
code can hold a set of private flags on the RAMBlock.
Add accessors.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 10 ++++++++++
 include/exec/cpu-common.h |  2 ++
 include/exec/ram_addr.h   |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/exec.c b/exec.c
index 42ad1eaedd..69fc5c9b07 100644
--- a/exec.c
+++ b/exec.c
@@ -1741,6 +1741,16 @@ size_t qemu_ram_pagesize_largest(void)
     return largest;
 }
 
+uint32_t qemu_ram_get_migration_flags(const RAMBlock *rb)
+{
+    return rb->migration_flags;
+}
+
+void qemu_ram_set_migration_flags(RAMBlock *rb, uint32_t flags)
+{
+    rb->migration_flags = flags;
+}
+
 static int memory_try_enable_merging(void *addr, size_t len)
 {
     if (!machine_mem_merge(current_machine)) {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 4d45a72ea9..4af179b543 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -72,6 +72,8 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
+void qemu_ram_set_migration_flags(RAMBlock *rb, uint32_t flags);
+uint32_t qemu_ram_get_migration_flags(const RAMBlock *rb);
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index af5bf26080..0cb6c5cb73 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -32,6 +32,8 @@ struct RAMBlock {
     ram_addr_t max_length;
     void (*resized)(const char*, uint64_t length, void *host);
     uint32_t flags;
+    /* These flags are owned by migration, initialised to 0 */
+    uint32_t migration_flags;
     /* Protected by iothread lock.  */
     char idstr[256];
     /* RCU-enabled, writes protected by the ramlist lock */
-- 
2.13.0
