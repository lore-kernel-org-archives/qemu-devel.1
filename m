Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1707CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF00206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIzCsZye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF00206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChdC-00032D-8B
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChae-0008MD-R2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChad-0005wq-1f
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChac-0005ud-TP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fciT879zSkhcAGmUXRf98FMw7LxC/2yx1e2Pv/uU6aM=;
 b=CIzCsZyeWgDEiGJj8Ga1L4zfjWLg71uRI+WAkFd6rhlV6VEPrdCZA2OC2JIh/RQMZvSwdO
 jdiQRIcJV4vpGlCCGDGIbsPrVJT6+fI1tXFt4FL/yztDhuJg5dTWsR3gjKDfWY+ulcmAkP
 WSE+CPa6rdjbmkuysLS/yEODM35zjj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-gFIuVPbOMPacTUoVdhessQ-1; Fri, 13 Mar 2020 06:30:48 -0400
X-MC-Unique: gFIuVPbOMPacTUoVdhessQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BEB4107ACCA;
 Fri, 13 Mar 2020 10:30:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71F418FBE1;
 Fri, 13 Mar 2020 10:30:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 3/5] COLO: Optimize memory back-up process
Date: Fri, 13 Mar 2020 10:30:37 +0000
Message-Id: <20200313103039.150133-4-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
References: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

This patch will reduce the downtime of VM for the initial process,
Previously, we copied all these memory in preparing stage of COLO
while we need to stop VM, which is a time-consuming process.
Here we optimize it by a trick, back-up every page while in migration
process while COLO is enabled, though it affects the speed of the
migration, but it obviously reduce the downtime of back-up all SVM'S
memory in COLO preparing stage.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <20200224065414.36524-5-zhang.zhanghailiang@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  minor typo fixes
---
 migration/colo.c |  3 +++
 migration/ram.c  | 66 +++++++++++++++++++++++++++++++++++-------------
 migration/ram.h  |  1 +
 3 files changed, 53 insertions(+), 17 deletions(-)

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
index 02cfd76d19..31f4a9dc09 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2994,7 +2994,6 @@ int colo_init_ram_cache(void)
                 }
                 return -errno;
             }
-            memcpy(block->colo_cache, block->host, block->used_length);
         }
     }
=20
@@ -3008,19 +3007,36 @@ int colo_init_ram_cache(void)
=20
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             unsigned long pages =3D block->max_length >> TARGET_PAGE_BITS;
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
+            bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS=
);
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
@@ -3040,9 +3056,7 @@ void colo_release_ram_cache(void)
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
@@ -3356,7 +3370,7 @@ static int ram_load_precopy(QEMUFile *f)
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
-        void *host =3D NULL;
+        void *host =3D NULL, *host_bak =3D NULL;
         uint8_t ch;
=20
         /*
@@ -3387,20 +3401,35 @@ static int ram_load_precopy(QEMUFile *f)
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) =
{
             RAMBlock *block =3D ram_block_from_stream(f, flags);
=20
+            host =3D host_from_ram_block_offset(block, addr);
             /*
-             * After going into COLO, we should load the Page into colo_ca=
che.
+             * After going into COLO stage, we should not load the page
+             * into SVM's memory directly, we put them into colo_cache fir=
stly.
+             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
+             * Previously, we copied all these memory in preparing stage o=
f COLO
+             * while we need to stop VM, which is a time-consuming process=
.
+             * Here we optimize it by a trick, back-up every page while in
+             * migration process while COLO is enabled, though it affects =
the
+             * speed of the migration, but it obviously reduce the downtim=
e of
+             * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_in_colo_state()) {
-                host =3D colo_cache_from_block_offset(block, addr);
-            } else {
-                host =3D host_from_ram_block_offset(block, addr);
+            if (migration_incoming_colo_enabled()) {
+                if (migration_incoming_in_colo_state()) {
+                    /* In COLO stage, put all pages into cache temporarily=
 */
+                    host =3D colo_cache_from_block_offset(block, addr);
+                } else {
+                   /*
+                    * In migration stage but before COLO stage,
+                    * Put all pages into both cache and SVM's memory.
+                    */
+                    host_bak =3D colo_cache_from_block_offset(block, addr)=
;
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
@@ -3514,6 +3543,9 @@ static int ram_load_precopy(QEMUFile *f)
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
@@ -66,5 +66,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *=
rb);
 /* ram cache */
 int colo_init_ram_cache(void);
 void colo_release_ram_cache(void);
+void colo_incoming_start_dirty_log(void);
=20
 #endif
--=20
2.24.1


