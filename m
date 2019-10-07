Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6DECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663592084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663592084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45583 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUA3-00062h-1c
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iHU84-0003yi-CL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iHU82-0005S3-9I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iHU81-0005Rd-Vv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B83318C8921
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 14:36:49 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-145.ams2.redhat.com
 [10.36.117.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 386F060C05;
 Mon,  7 Oct 2019 14:36:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v4 3/5] migration: Use automatic rcu_read unlock in ram.c
Date: Mon,  7 Oct 2019 15:36:39 +0100
Message-Id: <20191007143642.301445-4-dgilbert@redhat.com>
In-Reply-To: <20191007143642.301445-1-dgilbert@redhat.com>
References: <20191007143642.301445-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 07 Oct 2019 14:36:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use the automatic read unlocker in migration/ram.c

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 migration/ram.c | 259 ++++++++++++++++++++++--------------------------
 1 file changed, 121 insertions(+), 138 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 484d66379a..e29c8b3408 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -181,14 +181,14 @@ int foreach_not_ignored_block(RAMBlockIterFunc func=
, void *opaque)
     RAMBlock *block;
     int ret =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         ret =3D func(block, opaque);
         if (ret) {
             break;
         }
     }
-    rcu_read_unlock();
     return ret;
 }
=20
@@ -1848,12 +1848,12 @@ static void migration_bitmap_sync(RAMState *rs)
     memory_global_dirty_log_sync();
=20
     qemu_mutex_lock(&rs->bitmap_mutex);
-    rcu_read_lock();
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        ramblock_sync_dirty_bitmap(rs, block);
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            ramblock_sync_dirty_bitmap(rs, block);
+        }
+        ram_counters.remaining =3D ram_bytes_remaining();
     }
-    ram_counters.remaining =3D ram_bytes_remaining();
-    rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
=20
     memory_global_after_dirty_log_sync();
@@ -2397,13 +2397,12 @@ static void migration_page_queue_free(RAMState *r=
s)
     /* This queue generally should be empty - but in the case of a faile=
d
      * migration might have some droppings in.
      */
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_m=
spr) {
         memory_region_unref(mspr->rb->mr);
         QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
         g_free(mspr);
     }
-    rcu_read_unlock();
 }
=20
 /**
@@ -2424,7 +2423,8 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
     RAMState *rs =3D ram_state;
=20
     ram_counters.postcopy_requests++;
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     if (!rbname) {
         /* Reuse last RAMBlock */
         ramblock =3D rs->last_req_rb;
@@ -2466,12 +2466,10 @@ int ram_save_queue_pages(const char *rbname, ram_=
addr_t start, ram_addr_t len)
     QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
     migration_make_urgent_request();
     qemu_mutex_unlock(&rs->src_page_req_mutex);
-    rcu_read_unlock();
=20
     return 0;
=20
 err:
-    rcu_read_unlock();
     return -1;
 }
=20
@@ -2700,7 +2698,8 @@ static uint64_t ram_bytes_total_common(bool count_i=
gnored)
     RAMBlock *block;
     uint64_t total =3D 0;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     if (count_ignored) {
         RAMBLOCK_FOREACH_MIGRATABLE(block) {
             total +=3D block->used_length;
@@ -2710,7 +2709,6 @@ static uint64_t ram_bytes_total_common(bool count_i=
gnored)
             total +=3D block->used_length;
         }
     }
-    rcu_read_unlock();
     return total;
 }
=20
@@ -3034,7 +3032,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     RAMBlock *block;
     int ret;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
=20
     /* This should be our last sync, the src is now paused */
     migration_bitmap_sync(rs);
@@ -3048,7 +3046,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
         /* Deal with TPS !=3D HPS and huge pages */
         ret =3D postcopy_chunk_hostpages(ms, block);
         if (ret) {
-            rcu_read_unlock();
             return ret;
         }
=20
@@ -3060,7 +3057,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
     trace_ram_postcopy_send_discard_bitmap();
=20
     ret =3D postcopy_each_ram_send_discard(ms);
-    rcu_read_unlock();
=20
     return ret;
 }
@@ -3081,7 +3077,7 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
=20
     trace_ram_discard_range(rbname, start, length);
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     RAMBlock *rb =3D qemu_ram_block_by_name(rbname);
=20
     if (!rb) {
@@ -3101,8 +3097,6 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
     ret =3D ram_block_discard_range(rb, start, length);
=20
 err:
-    rcu_read_unlock();
-
     return ret;
 }
=20
@@ -3231,13 +3225,12 @@ static void ram_init_bitmaps(RAMState *rs)
     /* For memory_global_dirty_log_start below.  */
     qemu_mutex_lock_iothread();
     qemu_mutex_lock_ramlist();
-    rcu_read_lock();
=20
-    ram_list_init_bitmaps();
-    memory_global_dirty_log_start();
-    migration_bitmap_sync_precopy(rs);
-
-    rcu_read_unlock();
+    WITH_RCU_READ_LOCK_GUARD() {
+        ram_list_init_bitmaps();
+        memory_global_dirty_log_start();
+        migration_bitmap_sync_precopy(rs);
+    }
     qemu_mutex_unlock_ramlist();
     qemu_mutex_unlock_iothread();
 }
@@ -3424,55 +3417,57 @@ static int ram_save_iterate(QEMUFile *f, void *op=
aque)
         goto out;
     }
=20
-    rcu_read_lock();
-    if (ram_list.version !=3D rs->last_version) {
-        ram_state_reset(rs);
-    }
-
-    /* Read version before ram_list.blocks */
-    smp_rmb();
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (ram_list.version !=3D rs->last_version) {
+            ram_state_reset(rs);
+        }
=20
-    ram_control_before_iterate(f, RAM_CONTROL_ROUND);
+        /* Read version before ram_list.blocks */
+        smp_rmb();
=20
-    t0 =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    i =3D 0;
-    while ((ret =3D qemu_file_rate_limit(f)) =3D=3D 0 ||
-            !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
-        int pages;
+        ram_control_before_iterate(f, RAM_CONTROL_ROUND);
=20
-        if (qemu_file_get_error(f)) {
-            break;
-        }
+        t0 =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+        i =3D 0;
+        while ((ret =3D qemu_file_rate_limit(f)) =3D=3D 0 ||
+                !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
+            int pages;
=20
-        pages =3D ram_find_and_save_block(rs, false);
-        /* no more pages to sent */
-        if (pages =3D=3D 0) {
-            done =3D 1;
-            break;
-        }
+            if (qemu_file_get_error(f)) {
+                break;
+            }
=20
-        if (pages < 0) {
-            qemu_file_set_error(f, pages);
-            break;
-        }
+            pages =3D ram_find_and_save_block(rs, false);
+            /* no more pages to sent */
+            if (pages =3D=3D 0) {
+                done =3D 1;
+                break;
+            }
=20
-        rs->target_page_count +=3D pages;
-
-        /* we want to check in the 1st loop, just in case it was the 1st=
 time
-           and we had to sync the dirty bitmap.
-           qemu_clock_get_ns() is a bit expensive, so we only check each=
 some
-           iterations
-        */
-        if ((i & 63) =3D=3D 0) {
-            uint64_t t1 =3D (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - t0=
) / 1000000;
-            if (t1 > MAX_WAIT) {
-                trace_ram_save_iterate_big_wait(t1, i);
+            if (pages < 0) {
+                qemu_file_set_error(f, pages);
                 break;
             }
+
+            rs->target_page_count +=3D pages;
+
+            /*
+             * we want to check in the 1st loop, just in case it was the=
 1st
+             * time and we had to sync the dirty bitmap.
+             * qemu_clock_get_ns() is a bit expensive, so we only check =
each
+             * some iterations
+             */
+            if ((i & 63) =3D=3D 0) {
+                uint64_t t1 =3D (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) =
- t0) /
+                              1000000;
+                if (t1 > MAX_WAIT) {
+                    trace_ram_save_iterate_big_wait(t1, i);
+                    break;
+                }
+            }
+            i++;
         }
-        i++;
     }
-    rcu_read_unlock();
=20
     /*
      * Must occur before EOS (or any QEMUFile operation)
@@ -3510,35 +3505,33 @@ static int ram_save_complete(QEMUFile *f, void *o=
paque)
     RAMState *rs =3D *temp;
     int ret =3D 0;
=20
-    rcu_read_lock();
-
-    if (!migration_in_postcopy()) {
-        migration_bitmap_sync_precopy(rs);
-    }
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (!migration_in_postcopy()) {
+            migration_bitmap_sync_precopy(rs);
+        }
=20
-    ram_control_before_iterate(f, RAM_CONTROL_FINISH);
+        ram_control_before_iterate(f, RAM_CONTROL_FINISH);
=20
-    /* try transferring iterative blocks of memory */
+        /* try transferring iterative blocks of memory */
=20
-    /* flush all remaining blocks regardless of rate limiting */
-    while (true) {
-        int pages;
+        /* flush all remaining blocks regardless of rate limiting */
+        while (true) {
+            int pages;
=20
-        pages =3D ram_find_and_save_block(rs, !migration_in_colo_state()=
);
-        /* no more blocks to sent */
-        if (pages =3D=3D 0) {
-            break;
-        }
-        if (pages < 0) {
-            ret =3D pages;
-            break;
+            pages =3D ram_find_and_save_block(rs, !migration_in_colo_sta=
te());
+            /* no more blocks to sent */
+            if (pages =3D=3D 0) {
+                break;
+            }
+            if (pages < 0) {
+                ret =3D pages;
+                break;
+            }
         }
-    }
-
-    flush_compressed_data(rs);
-    ram_control_after_iterate(f, RAM_CONTROL_FINISH);
=20
-    rcu_read_unlock();
+        flush_compressed_data(rs);
+        ram_control_after_iterate(f, RAM_CONTROL_FINISH);
+    }
=20
     multifd_send_sync_main(rs);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -3561,9 +3554,9 @@ static void ram_save_pending(QEMUFile *f, void *opa=
que, uint64_t max_size,
     if (!migration_in_postcopy() &&
         remaining_size < max_size) {
         qemu_mutex_lock_iothread();
-        rcu_read_lock();
-        migration_bitmap_sync_precopy(rs);
-        rcu_read_unlock();
+        WITH_RCU_READ_LOCK_GUARD() {
+            migration_bitmap_sync_precopy(rs);
+        }
         qemu_mutex_unlock_iothread();
         remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
     }
@@ -3907,7 +3900,13 @@ int colo_init_ram_cache(void)
             error_report("%s: Can't alloc memory for COLO cache of block=
 %s,"
                          "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
                          block->used_length);
-            goto out_locked;
+            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+                if (block->colo_cache) {
+                    qemu_anon_ram_free(block->colo_cache, block->used_le=
ngth);
+                    block->colo_cache =3D NULL;
+                }
+            }
+            return -errno;
         }
         memcpy(block->colo_cache, block->host, block->used_length);
     }
@@ -3933,18 +3932,6 @@ int colo_init_ram_cache(void)
     memory_global_dirty_log_start();
=20
     return 0;
-
-out_locked:
-
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        if (block->colo_cache) {
-            qemu_anon_ram_free(block->colo_cache, block->used_length);
-            block->colo_cache =3D NULL;
-        }
-    }
-
-    rcu_read_unlock();
-    return -errno;
 }
=20
 /* It is need to hold the global lock to call this helper */
@@ -3958,16 +3945,14 @@ void colo_release_ram_cache(void)
         block->bmap =3D NULL;
     }
=20
-    rcu_read_lock();
-
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        if (block->colo_cache) {
-            qemu_anon_ram_free(block->colo_cache, block->used_length);
-            block->colo_cache =3D NULL;
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            if (block->colo_cache) {
+                qemu_anon_ram_free(block->colo_cache, block->used_length=
);
+                block->colo_cache =3D NULL;
+            }
         }
     }
-
-    rcu_read_unlock();
     qemu_mutex_destroy(&ram_state->bitmap_mutex);
     g_free(ram_state);
     ram_state =3D NULL;
@@ -4205,31 +4190,30 @@ static void colo_flush_ram_cache(void)
     unsigned long offset =3D 0;
=20
     memory_global_dirty_log_sync();
-    rcu_read_lock();
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        ramblock_sync_dirty_bitmap(ram_state, block);
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            ramblock_sync_dirty_bitmap(ram_state, block);
+        }
     }
-    rcu_read_unlock();
=20
     trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
-    rcu_read_lock();
-    block =3D QLIST_FIRST_RCU(&ram_list.blocks);
+    WITH_RCU_READ_LOCK_GUARD() {
+        block =3D QLIST_FIRST_RCU(&ram_list.blocks);
=20
-    while (block) {
-        offset =3D migration_bitmap_find_dirty(ram_state, block, offset)=
;
+        while (block) {
+            offset =3D migration_bitmap_find_dirty(ram_state, block, off=
set);
=20
-        if (offset << TARGET_PAGE_BITS >=3D block->used_length) {
-            offset =3D 0;
-            block =3D QLIST_NEXT_RCU(block, next);
-        } else {
-            migration_bitmap_clear_dirty(ram_state, block, offset);
-            dst_host =3D block->host + (offset << TARGET_PAGE_BITS);
-            src_host =3D block->colo_cache + (offset << TARGET_PAGE_BITS=
);
-            memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
+            if (offset << TARGET_PAGE_BITS >=3D block->used_length) {
+                offset =3D 0;
+                block =3D QLIST_NEXT_RCU(block, next);
+            } else {
+                migration_bitmap_clear_dirty(ram_state, block, offset);
+                dst_host =3D block->host + (offset << TARGET_PAGE_BITS);
+                src_host =3D block->colo_cache + (offset << TARGET_PAGE_=
BITS);
+                memcpy(dst_host, src_host, TARGET_PAGE_SIZE);
+            }
         }
     }
-
-    rcu_read_unlock();
     trace_colo_flush_ram_cache_end();
 }
=20
@@ -4428,16 +4412,15 @@ static int ram_load(QEMUFile *f, void *opaque, in=
t version_id)
      * it will be necessary to reduce the granularity of this
      * critical section.
      */
-    rcu_read_lock();
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (postcopy_running) {
+            ret =3D ram_load_postcopy(f);
+        } else {
+            ret =3D ram_load_precopy(f);
+        }
=20
-    if (postcopy_running) {
-        ret =3D ram_load_postcopy(f);
-    } else {
-        ret =3D ram_load_precopy(f);
+        ret |=3D wait_for_decompress_done();
     }
-
-    ret |=3D wait_for_decompress_done();
-    rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
=20
     if (!ret  && migration_incoming_in_colo_state()) {
--=20
2.23.0


