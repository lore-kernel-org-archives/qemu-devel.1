Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F45C742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6C4206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6C4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwcc-0001Da-Kc
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwbb-0006Ho-Tq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwbZ-00020w-TG
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwbZ-00020V-Kt
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED8803086205;
 Fri, 12 Jul 2019 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA6EF6092E;
 Fri, 12 Jul 2019 14:32:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:32:06 +0200
Message-Id: <20190712143207.4214-19-quintela@redhat.com>
In-Reply-To: <20190712143207.4214-1-quintela@redhat.com>
References: <20190712143207.4214-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 12 Jul 2019 14:32:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/19] migration: Split log_clear() into smaller
 chunks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Currently we are doing log_clear() right after log_sync() which mostly
keeps the old behavior when log_clear() was still part of log_sync().

This patch tries to further optimize the migration log_clear() code
path to split huge log_clear()s into smaller chunks.

We do this by spliting the whole guest memory region into memory
chunks, whose size is decided by MigrationState.clear_bitmap_shift (an
example will be given below).  With that, we don't do the dirty bitmap
clear operation on the remote node (e.g., KVM) when we fetch the dirty
bitmap, instead we explicitly clear the dirty bitmap for the memory
chunk for each of the first time we send a page in that chunk.

Here comes an example.

Assuming the guest has 64G memory, then before this patch the KVM
ioctl KVM_CLEAR_DIRTY_LOG will be a single one covering 64G memory.
If after the patch, let's assume when the clear bitmap shift is 18,
then the memory chunk size on x86_64 will be 1UL<<18 * 4K =3D 1GB.  Then
instead of sending a big 64G ioctl, we'll send 64 small ioctls, each
of the ioctl will cover 1G of the guest memory.  For each of the 64
small ioctls, we'll only send if any of the page in that small chunk
was going to be sent right away.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190603065056.25211-12-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/exec/ram_addr.h | 76 +++++++++++++++++++++++++++++++++++++++--
 migration/migration.c   |  4 +++
 migration/migration.h   | 27 +++++++++++++++
 migration/ram.c         | 44 ++++++++++++++++++++++++
 migration/trace-events  |  1 +
 5 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 222b4338fb..b7b2e60ff6 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -51,8 +51,70 @@ struct RAMBlock {
     unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
+
+    /*
+     * bitmap to track already cleared dirty bitmap.  When the bit is
+     * set, it means the corresponding memory chunk needs a log-clear.
+     * Set this up to non-NULL to enable the capability to postpone
+     * and split clearing of dirty bitmap on the remote node (e.g.,
+     * KVM).  The bitmap will be set only when doing global sync.
+     *
+     * NOTE: this bitmap is different comparing to the other bitmaps
+     * in that one bit can represent multiple guest pages (which is
+     * decided by the `clear_bmap_shift' variable below).  On
+     * destination side, this should always be NULL, and the variable
+     * `clear_bmap_shift' is meaningless.
+     */
+    unsigned long *clear_bmap;
+    uint8_t clear_bmap_shift;
 };
=20
+/**
+ * clear_bmap_size: calculate clear bitmap size
+ *
+ * @pages: number of guest pages
+ * @shift: guest page number shift
+ *
+ * Returns: number of bits for the clear bitmap
+ */
+static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
+{
+    return DIV_ROUND_UP(pages, 1UL << shift);
+}
+
+/**
+ * clear_bmap_set: set clear bitmap for the page range
+ *
+ * @rb: the ramblock to operate on
+ * @start: the start page number
+ * @size: number of pages to set in the bitmap
+ *
+ * Returns: None
+ */
+static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
+                                  uint64_t npages)
+{
+    uint8_t shift =3D rb->clear_bmap_shift;
+
+    bitmap_set_atomic(rb->clear_bmap, start >> shift,
+                      clear_bmap_size(npages, shift));
+}
+
+/**
+ * clear_bmap_test_and_clear: test clear bitmap for the page, clear if s=
et
+ *
+ * @rb: the ramblock to operate on
+ * @page: the page number to check
+ *
+ * Returns: true if the bit was set, false otherwise
+ */
+static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page=
)
+{
+    uint8_t shift =3D rb->clear_bmap_shift;
+
+    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1=
);
+}
+
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
 {
     return (b && b->host && offset < b->used_length) ? true : false;
@@ -463,8 +525,18 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBl=
ock *rb,
             }
         }
=20
-        /* TODO: split the huge bitmap into smaller chunks */
-        memory_region_clear_dirty_bitmap(rb->mr, start, length);
+        if (rb->clear_bmap) {
+            /*
+             * Postpone the dirty bitmap clear to the point before we
+             * really send the pages, also we will split the clear
+             * dirty procedure into smaller chunks.
+             */
+            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
+                           length >> TARGET_PAGE_BITS);
+        } else {
+            /* Slow path - still do that in a huge chunk */
+            memory_region_clear_dirty_bitmap(rb->mr, start, length);
+        }
     } else {
         ram_addr_t offset =3D rb->offset;
=20
diff --git a/migration/migration.c b/migration/migration.c
index 2865ae3fa9..8a607fe1e2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3362,6 +3362,8 @@ void migration_global_dump(Monitor *mon)
                    ms->send_section_footer ? "on" : "off");
     monitor_printf(mon, "decompress-error-check: %s\n",
                    ms->decompress_error_check ? "on" : "off");
+    monitor_printf(mon, "clear-bitmap-shift: %u\n",
+                   ms->clear_bitmap_shift);
 }
=20
 #define DEFINE_PROP_MIG_CAP(name, x)             \
@@ -3376,6 +3378,8 @@ static Property migration_properties[] =3D {
                      send_section_footer, true),
     DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
                       decompress_error_check, true),
+    DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
+                      clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
=20
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-compress-level", MigrationState,
diff --git a/migration/migration.h b/migration/migration.h
index 5e8f09c6db..1fdd7b21fd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -26,6 +26,23 @@ struct PostcopyBlocktimeContext;
=20
 #define  MIGRATION_RESUME_ACK_VALUE  (1)
=20
+/*
+ * 1<<6=3D64 pages -> 256K chunk when page size is 4K.  This gives us
+ * the benefit that all the chunks are 64 pages aligned then the
+ * bitmaps are always aligned to LONG.
+ */
+#define CLEAR_BITMAP_SHIFT_MIN             6
+/*
+ * 1<<18=3D256K pages -> 1G chunk when page size is 4K.  This is the
+ * default value to use if no one specified.
+ */
+#define CLEAR_BITMAP_SHIFT_DEFAULT        18
+/*
+ * 1<<31=3D2G pages -> 8T chunk when page size is 4K.  This should be
+ * big enough and make sure we won't overflow easily.
+ */
+#define CLEAR_BITMAP_SHIFT_MAX            31
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -232,6 +249,16 @@ struct MigrationState
      * do not trigger spurious decompression errors.
      */
     bool decompress_error_check;
+
+    /*
+     * This decides the size of guest memory chunk that will be used
+     * to track dirty bitmap clearing.  The size of memory chunk will
+     * be GUEST_PAGE_SIZE << N.  Say, N=3D0 means we will clear dirty
+     * bitmap for each page to send (1<<0=3D1); N=3D10 means we will cle=
ar
+     * dirty bitmap only once for 1<<10=3D1K continuous guest pages
+     * (which is in 4M chunk).
+     */
+    uint8_t clear_bitmap_shift;
 };
=20
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/ram.c b/migration/ram.c
index 48969db84b..8a6ad61d3d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1664,6 +1664,33 @@ static inline bool migration_bitmap_clear_dirty(RA=
MState *rs,
     bool ret;
=20
     qemu_mutex_lock(&rs->bitmap_mutex);
+
+    /*
+     * Clear dirty bitmap if needed.  This _must_ be called before we
+     * send any of the page in the chunk because we need to make sure
+     * we can capture further page content changes when we sync dirty
+     * log the next time.  So as long as we are going to send any of
+     * the page in the chunk we clear the remote dirty bitmap for all.
+     * Clearing it earlier won't be a problem, but too late will.
+     */
+    if (rb->clear_bmap && clear_bmap_test_and_clear(rb, page)) {
+        uint8_t shift =3D rb->clear_bmap_shift;
+        hwaddr size =3D 1ULL << (TARGET_PAGE_BITS + shift);
+        hwaddr start =3D (page << TARGET_PAGE_BITS) & (-size);
+
+        /*
+         * CLEAR_BITMAP_SHIFT_MIN should always guarantee this... this
+         * can make things easier sometimes since then start address
+         * of the small chunk will always be 64 pages aligned so the
+         * bitmap will always be aligned to unsigned long.  We should
+         * even be able to remove this restriction but I'm simply
+         * keeping it.
+         */
+        assert(shift >=3D 6);
+        trace_migration_bitmap_clear_dirty(rb->idstr, start, size, page)=
;
+        memory_region_clear_dirty_bitmap(rb->mr, start, size);
+    }
+
     ret =3D test_and_clear_bit(page, rb->bmap);
=20
     if (ret) {
@@ -2687,6 +2714,8 @@ static void ram_save_cleanup(void *opaque)
     memory_global_dirty_log_stop();
=20
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        g_free(block->clear_bmap);
+        block->clear_bmap =3D NULL;
         g_free(block->bmap);
         block->bmap =3D NULL;
         g_free(block->unsentmap);
@@ -3197,11 +3226,24 @@ static int ram_state_init(RAMState **rsp)
=20
 static void ram_list_init_bitmaps(void)
 {
+    MigrationState *ms =3D migrate_get_current();
     RAMBlock *block;
     unsigned long pages;
+    uint8_t shift;
=20
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
+        shift =3D ms->clear_bitmap_shift;
+        if (shift > CLEAR_BITMAP_SHIFT_MAX) {
+            error_report("clear_bitmap_shift (%u) too big, using "
+                         "max value (%u)", shift, CLEAR_BITMAP_SHIFT_MAX=
);
+            shift =3D CLEAR_BITMAP_SHIFT_MAX;
+        } else if (shift < CLEAR_BITMAP_SHIFT_MIN) {
+            error_report("clear_bitmap_shift (%u) too small, using "
+                         "min value (%u)", shift, CLEAR_BITMAP_SHIFT_MIN=
);
+            shift =3D CLEAR_BITMAP_SHIFT_MIN;
+        }
+
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages =3D block->max_length >> TARGET_PAGE_BITS;
             /*
@@ -3214,6 +3256,8 @@ static void ram_list_init_bitmaps(void)
              * Here setting RAMBlock.bmap would be fine too but not nece=
ssary.
              */
             block->bmap =3D bitmap_new(pages);
+            block->clear_bmap_shift =3D shift;
+            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shif=
t));
             if (migrate_postcopy_ram()) {
                 block->unsentmap =3D bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
diff --git a/migration/trace-events b/migration/trace-events
index cd50a1e659..d8e54c367a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -79,6 +79,7 @@ get_queued_page(const char *block_name, uint64_t tmp_of=
fset, unsigned long page_
 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, u=
nsigned long page_abs, int sent) "%s/0x%" PRIx64 " page_abs=3D0x%lx (sent=
=3D%d)"
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
+migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, u=
nsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
 migration_throttle(void) ""
 multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
--=20
2.21.0


