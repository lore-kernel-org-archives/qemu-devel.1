Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778CCC3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507DB20726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507DB20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3V77-00031N-Fs
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6M-0001t3-AZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6L-0006Tm-6C
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2785 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j3V6K-0006O0-RC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:33 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 93C645199E0090C9D488;
 Mon, 17 Feb 2020 09:21:29 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 09:21:18 +0800
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 3/3] COLO: Optimize memory back-up process
Date: Mon, 17 Feb 2020 09:20:49 +0800
Message-ID: <20200217012049.22988-4-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: danielcho@qnap.com, chen.zhang@intel.com,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, dgilbert@redhat.com,
 quintela@redhat.com
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

Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c |  3 +++
 migration/ram.c  | 35 +++++++++++++++++++++++++++--------
 migration/ram.h  |  1 +
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index d30c6bc4ad..febf010571 100644
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
@@ -906,6 +907,8 @@ void *colo_process_incoming_thread(void *opaque)
      */
     qemu_file_set_blocking(mis->from_src_file, true);
=20
+    colo_incoming_start_dirty_log();
+
     bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
     fb =3D qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
diff --git a/migration/ram.c b/migration/ram.c
index ed23ed1c7c..24a8aa3527 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2986,7 +2986,6 @@ int colo_init_ram_cache(void)
                 }
                 return -errno;
             }
-            memcpy(block->colo_cache, block->host, block->used_length);
         }
     }
=20
@@ -3005,12 +3004,16 @@ int colo_init_ram_cache(void)
             bitmap_set(block->bmap, 0, pages);
         }
     }
+
+    return 0;
+}
+
+void colo_incoming_start_dirty_log(void)
+{
     ram_state =3D g_new0(RAMState, 1);
     ram_state->migration_dirty_pages =3D 0;
     qemu_mutex_init(&ram_state->bitmap_mutex);
     memory_global_dirty_log_start();
-
-    return 0;
 }
=20
 /* It is need to hold the global lock to call this helper */
@@ -3348,7 +3351,7 @@ static int ram_load_precopy(QEMUFile *f)
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
-        void *host =3D NULL;
+        void *host =3D NULL, *host_bak =3D NULL;
         uint8_t ch;
=20
         /*
@@ -3378,13 +3381,26 @@ static int ram_load_precopy(QEMUFile *f)
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)=
) {
             RAMBlock *block =3D ram_block_from_stream(f, flags);
-
             /*
-             * After going into COLO, we should load the Page into colo_=
cache.
+             * After going into COLO, we should load the Page into colo_=
cache
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
+            if (migration_incoming_colo_enabled()) {
                 host =3D colo_cache_from_block_offset(block, addr);
-            } else {
+                /*
+                 * After going into COLO, load the Page into colo_cache.
+                 */
+                if (!migration_incoming_in_colo_state()) {
+                    host_bak =3D host;
+                }
+            }
+            if (!migration_incoming_in_colo_state()) {
                 host =3D host_from_ram_block_offset(block, addr);
             }
             if (!host) {
@@ -3506,6 +3522,9 @@ static int ram_load_precopy(QEMUFile *f)
         if (!ret) {
             ret =3D qemu_file_get_error(f);
         }
+        if (!ret && host_bak && host) {
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



