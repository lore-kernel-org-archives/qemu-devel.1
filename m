Received: from eggs.gnu.org ([2001:4830:134:3::10]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ5-0007Nq-1v
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIp-0003ug-HT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:12 +0200
Message-Id: <1502117160-24655-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/56] dump: Make sizes and addresses
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes, virtual and physical addresses should use QAPI type 'size'
(uint64_t).  dump-guest-memory parameters @begin, @length are 'int'
(int64_t).  They get implicitly converted to unsigned types somewhere
down in the bowels of the dump machinery.  DumpQueryResult members
@completed and @total are also 'int', and also implicitly converted.

Change these dump-guest-memory parameters and DumpQueryResult members
to 'size'.

dump-guest-memory now accepts size and address values between 2^63 and
2^64-1.  They accept negative values as before, because that's how the
QObject input visitor works for backward compatibility.

query-dump and DUMP_COMPLETED now report sizes above 2^63-1 correctly
instead of their (negative) two's complement.

So does HMP's "info dump".

Drop a few redundant initializers and an incorrect, disabled debug
print while there.

Parameters of HMP's dump-guest-memory remain uint32_t, as HMP
args_type strings can't do uint64_t byte counts: 'l' is signed, and
'o' multiplies by 2^20.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump.c                          | 26 ++++++++++++--------------
 hmp.c                           |  2 +-
 include/sysemu/dump.h           |  8 ++++----
 include/sysemu/memory_mapping.h |  4 ++--
 memory_mapping.c                |  4 ++--
 qapi-schema.json                |  6 +++---
 6 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/dump.c b/dump.c
index d9090a2..452f20f 100644
--- a/dump.c
+++ b/dump.c
@@ -331,7 +331,7 @@ static void write_elf_section(DumpState *s, int type, Error **errp)
     }
 }
 
-static void write_data(DumpState *s, void *buf, int length, Error **errp)
+static void write_data(DumpState *s, void *buf, size_t length, Error **errp)
 {
     int ret;
 
@@ -345,9 +345,9 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
 
 /* write the memory to vmcore. 1 page per I/O. */
 static void write_memory(DumpState *s, GuestPhysBlock *block, ram_addr_t start,
-                         int64_t size, Error **errp)
+                         uint64_t size, Error **errp)
 {
-    int64_t i;
+    uint64_t i;
     Error *local_err = NULL;
 
     for (i = 0; i < size / s->dump_info.page_size; i++) {
@@ -378,7 +378,7 @@ static void get_offset_range(hwaddr phys_addr,
 {
     GuestPhysBlock *block;
     hwaddr offset = s->memory_offset;
-    int64_t size_in_block, start;
+    uint64_t size_in_block, start;
 
     /* When the memory is not stored into vmcore, offset will be -1 */
     *p_offset = -1;
@@ -602,7 +602,7 @@ static int get_next_block(DumpState *s, GuestPhysBlock *block)
 static void dump_iterate(DumpState *s, Error **errp)
 {
     GuestPhysBlock *block;
-    int64_t size;
+    uint64_t size;
     Error *local_err = NULL;
 
     do {
@@ -1466,10 +1466,10 @@ bool dump_in_progress(void)
 
 /* calculate total size of memory to be dumped (taking filter into
  * acoount.) */
-static int64_t dump_calculate_size(DumpState *s)
+static uint64_t dump_calculate_size(DumpState *s)
 {
     GuestPhysBlock *block;
-    int64_t size = 0, total = 0, left = 0, right = 0;
+    uint64_t total = 0, size, left, right;
 
     QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
         if (s->has_filter) {
@@ -1490,7 +1490,7 @@ static int64_t dump_calculate_size(DumpState *s)
 
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool has_filter,
-                      int64_t begin, int64_t length, Error **errp)
+                      uint64_t begin, uint64_t length, Error **errp)
 {
     CPUState *cpu;
     int nr_cpus;
@@ -1532,9 +1532,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     guest_phys_blocks_init(&s->guest_phys_blocks);
     guest_phys_blocks_append(&s->guest_phys_blocks);
     s->total_size = dump_calculate_size(s);
-#ifdef DEBUG_DUMP_GUEST_MEMORY
-    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
-#endif
 
     s->start = get_start_block(s);
     if (s->start == -1) {
@@ -1667,7 +1664,7 @@ cleanup:
 static void dump_process(DumpState *s, Error **errp)
 {
     Error *local_err = NULL;
-    DumpQueryResult *result = NULL;
+    DumpQueryResult *result;
 
     if (s->has_format && s->format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
         create_kdump_vmcore(s, &local_err);
@@ -1706,6 +1703,7 @@ DumpQueryResult *qmp_query_dump(Error **errp)
 {
     DumpQueryResult *result = g_new(DumpQueryResult, 1);
     DumpState *state = &dump_state_global;
+
     result->status = atomic_read(&state->status);
     /* make sure we are reading status and written_size in order */
     smp_rmb();
@@ -1716,8 +1714,8 @@ DumpQueryResult *qmp_query_dump(Error **errp)
 
 void qmp_dump_guest_memory(bool paging, const char *file,
                            bool has_detach, bool detach,
-                           bool has_begin, int64_t begin, bool has_length,
-                           int64_t length, bool has_format,
+                           bool has_begin, uint64_t begin, bool has_length,
+                           uint64_t length, bool has_format,
                            DumpGuestMemoryFormat format, Error **errp)
 {
     const char *p;
diff --git a/hmp.c b/hmp.c
index fd80dce..8257dd0 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2797,12 +2797,12 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict)
 void hmp_info_dump(Monitor *mon, const QDict *qdict)
 {
     DumpQueryResult *result = qmp_query_dump(NULL);
+    double percent;
 
     assert(result && result->status < DUMP_STATUS__MAX);
     monitor_printf(mon, "Status: %s\n", DumpStatus_lookup[result->status]);
 
     if (result->status == DUMP_STATUS_ACTIVE) {
-        float percent = 0;
         assert(result->total != 0);
         percent = 100.0 * result->completed / result->total;
         monitor_printf(mon, "Finished: %.2f %%\n", percent);
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 2672a15..52024d6 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -165,8 +165,8 @@ typedef struct DumpState {
     GuestPhysBlock *next_block;
     ram_addr_t start;
     bool has_filter;
-    int64_t begin;
-    int64_t length;
+    uint64_t begin;
+    uint64_t length;
 
     uint8_t *note_buf;          /* buffer for notes */
     size_t note_buf_offset;     /* the writing place in note_buf */
@@ -184,11 +184,11 @@ typedef struct DumpState {
     DumpGuestMemoryFormat format; /* valid only if has_format == true */
     QemuThread dump_thread;       /* thread for detached dump */
 
-    int64_t total_size;          /* total memory size (in bytes) to
+    uint64_t total_size;         /* total memory size (in bytes) to
                                   * be dumped. When filter is
                                   * enabled, this will only count
                                   * those to be written. */
-    int64_t written_size;        /* written memory size (in bytes),
+    uint64_t written_size;       /* written memory size (in bytes),
                                   * this could be used to calculate
                                   * how much work we have
                                   * finished. */
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapping.h
index 706152d..47d6252 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -79,7 +79,7 @@ void qemu_get_guest_memory_mapping(MemoryMappingList *list,
 void qemu_get_guest_simple_memory_mapping(MemoryMappingList *list,
                                   const GuestPhysBlockList *guest_phys_blocks);
 
-void memory_mapping_filter(MemoryMappingList *list, int64_t begin,
-                           int64_t length);
+void memory_mapping_filter(MemoryMappingList *list, uint64_t begin,
+                           uint64_t length);
 
 #endif
diff --git a/memory_mapping.c b/memory_mapping.c
index a5d3855..a4fbdca 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -328,8 +328,8 @@ void qemu_get_guest_simple_memory_mapping(MemoryMappingList *list,
     }
 }
 
-void memory_mapping_filter(MemoryMappingList *list, int64_t begin,
-                           int64_t length)
+void memory_mapping_filter(MemoryMappingList *list, uint64_t begin,
+                           uint64_t length)
 {
     MemoryMapping *cur, *next;
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 80458fa..3ad2bc0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3439,7 +3439,7 @@
 ##
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
-            '*begin': 'int', '*length': 'int',
+            '*begin': 'size', '*length': 'size',
             '*format': 'DumpGuestMemoryFormat'} }
 
 ##
@@ -3475,8 +3475,8 @@
 ##
 { 'struct': 'DumpQueryResult',
   'data': { 'status': 'DumpStatus',
-            'completed': 'int',
-            'total': 'int' } }
+            'completed': 'size',
+            'total': 'size' } }
 
 ##
 # @query-dump:
-- 
2.7.5
