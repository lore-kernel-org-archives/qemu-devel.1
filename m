Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D90C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3121320675
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3121320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67gr-000874-Cv
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 01:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dl-0003G6-FY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j67dk-0006D2-4G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2728 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j67dj-00064o-Ew
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:54:52 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 36AD710ACAAA30F9F5F0;
 Mon, 24 Feb 2020 14:54:46 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 14:54:39 +0800
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH V2 4/8] COLO: Optimize memory back-up process
Date: Mon, 24 Feb 2020 14:54:10 +0800
Message-ID: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: danielcho@qnap.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch will reduce the downtime of VM for the initial process,
Privously, we copied all these memory in preparing stage of COLO
while we need to stop VM, which is a time-consuming process.
Here we optimize it by a trick, back-up every page while in migration
process while COLO is enabled, though it affects the speed of the
migration, but it obviously reduce the downtime of back-up all SVM'S
memory in COLO preparing stage.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c |  3 +++
 migration/ram.c  | 68 +++++++++++++++++++++++++++++++++++-------------
 migration/ram.h  |  1 +
 3 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 93c5a452fb..44942c4e23 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -26,6 +26,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
 #include "migration/failover.h"
+#include "migration/ram.h"
 #ifdef CONFIG_REPLICATION
 #include "replication.h"
 #endif
@@ -845,6 +846,8 @@ void *colo_process_incoming_thread(void *opaque)
      */
     qemu_file_set_blocking(mis->from_src_file, true);
=20
+    colo_incoming_start_dirty_log();
+
     bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
     fb =3D qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
diff --git a/migration/ram.c b/migration/ram.c
index ed23ed1c7c..ebf9e6ba51 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2277,6 +2277,7 @@ static void ram_list_init_bitmaps(void)
              * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the wh=
ole
              * guest memory.
              */
+
             block->bmap =3D bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
             block->clear_bmap_shift =3D shift;
@@ -2986,7 +2987,6 @@ int colo_init_ram_cache(void)
                 }
                 return -errno;
             }
-            memcpy(block->colo_cache, block->host, block->used_length);
         }
     }
=20
@@ -3000,19 +3000,36 @@ int colo_init_ram_cache(void)
=20
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             unsigned long pages =3D block->max_length >> TARGET_PAGE_BIT=
S;
-
             block->bmap =3D bitmap_new(pages);
-            bitmap_set(block->bmap, 0, pages);
         }
     }
-    ram_state =3D g_new0(RAMState, 1);
-    ram_state->migration_dirty_pages =3D 0;
-    qemu_mutex_init(&ram_state->bitmap_mutex);
-    memory_global_dirty_log_start();
=20
+    ram_state_init(&ram_state);
     return 0;
 }
=20
+/* TODO: duplicated with ram_init_bitmaps */
+void colo_incoming_start_dirty_log(void)
+{
+    RAMBlock *block =3D NULL;
+    /* For memory_global_dirty_log_start below. */
+    qemu_mutex_lock_iothread();
+    qemu_mutex_lock_ramlist();
+
+    memory_global_dirty_log_sync();
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            ramblock_sync_dirty_bitmap(ram_state, block);
+            /* Discard this dirty bitmap record */
+            bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BI=
TS);
+        }
+        memory_global_dirty_log_start();
+    }
+    ram_state->migration_dirty_pages =3D 0;
+    qemu_mutex_unlock_ramlist();
+    qemu_mutex_unlock_iothread();
+}
+
 /* It is need to hold the global lock to call this helper */
 void colo_release_ram_cache(void)
 {
@@ -3032,9 +3049,7 @@ void colo_release_ram_cache(void)
             }
         }
     }
-    qemu_mutex_destroy(&ram_state->bitmap_mutex);
-    g_free(ram_state);
-    ram_state =3D NULL;
+    ram_state_cleanup(&ram_state);
 }
=20
 /**
@@ -3302,7 +3317,6 @@ static void colo_flush_ram_cache(void)
             ramblock_sync_dirty_bitmap(ram_state, block);
         }
     }
-
     trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
     WITH_RCU_READ_LOCK_GUARD() {
         block =3D QLIST_FIRST_RCU(&ram_list.blocks);
@@ -3348,7 +3362,7 @@ static int ram_load_precopy(QEMUFile *f)
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
-        void *host =3D NULL;
+        void *host =3D NULL, *host_bak =3D NULL;
         uint8_t ch;
=20
         /*
@@ -3379,20 +3393,35 @@ static int ram_load_precopy(QEMUFile *f)
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)=
) {
             RAMBlock *block =3D ram_block_from_stream(f, flags);
=20
+            host =3D host_from_ram_block_offset(block, addr);
             /*
-             * After going into COLO, we should load the Page into colo_=
cache.
+             * After going into COLO stage, we should not load the page
+             * into SVM's memory diretly, we put them into colo_cache fi=
rstly.
+             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
+             * Privously, we copied all these memory in preparing stage =
of COLO
+             * while we need to stop VM, which is a time-consuming proce=
ss.
+             * Here we optimize it by a trick, back-up every page while =
in
+             * migration process while COLO is enabled, though it affect=
s the
+             * speed of the migration, but it obviously reduce the downt=
ime of
+             * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_in_colo_state()) {
-                host =3D colo_cache_from_block_offset(block, addr);
-            } else {
-                host =3D host_from_ram_block_offset(block, addr);
+            if (migration_incoming_colo_enabled()) {
+                if (migration_incoming_in_colo_state()) {
+                    /* In COLO stage, put all pages into cache temporari=
ly */
+                    host =3D colo_cache_from_block_offset(block, addr);
+                } else {
+                   /*
+                    * In migration stage but before COLO stage,
+                    * Put all pages into both cache and SVM's memory.
+                    */
+                    host_bak =3D colo_cache_from_block_offset(block, add=
r);
+                }
             }
             if (!host) {
                 error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
                 ret =3D -EINVAL;
                 break;
             }
-
             if (!migration_incoming_in_colo_state()) {
                 ramblock_recv_bitmap_set(block, host);
             }
@@ -3506,6 +3535,9 @@ static int ram_load_precopy(QEMUFile *f)
         if (!ret) {
             ret =3D qemu_file_get_error(f);
         }
+        if (!ret && host_bak) {
+            memcpy(host_bak, host, TARGET_PAGE_SIZE);
+        }
     }
=20
     ret |=3D wait_for_decompress_done();
diff --git a/migration/ram.h b/migration/ram.h
index a553d40751..5ceaff7cb4 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -66,5 +66,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock=
 *rb);
 /* ram cache */
 int colo_init_ram_cache(void);
 void colo_release_ram_cache(void);
+void colo_incoming_start_dirty_log(void);
=20
 #endif
--=20
2.21.0



