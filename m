Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A81320663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vZQ6Jlmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A81320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6QA-0007Ng-9H
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NR-0002Qh-MT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NM-0005dB-Og
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:25 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NI-0005TM-Uj; Wed, 25 Mar 2020 09:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQpSdPbeKKliNkOt8D8ivK61/uZLnJQVl6tuSqJ/Rl0RDXRn+L2iEU/QLgw69XTx2lLCRbgpVDeyCimd5YtC7bA7/4RN+MmpiQCL3duL+K1YxF2ESa2GAqXWZzzUF/6Q1sVuBFRmddJ1AHudfR1oZNC8nsb1AIudG9BZE4hFmJv4mJAyhiaOqarFeSmIXpoJ2+svLXpEjl8OK4LsU04+F1Gf8C/1fAJy7PgYqMj3Z+1LSRkUYrPQfsR0wNRl51/ruu+oK27A2aXjwLRiC51jo10nEJMpfXqTeSIXOhccUuZFZ9V3nfShYb2j6I2hli6zPr4vrAxxz+8jqZk5RKrPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g86jk0Mj0v+O5l23CkT7aZhghC0m2hX7utns/EGlHnw=;
 b=dQuTuqqbN7j5t3BKcXDQk28+KqC6hPF0NFe9NeMnWa53+WoNeiB4jybiHyG+2sBYJwGE1IHZP1P3nLhz55RGUKZC0BN52/1bkUEJON/0+S8E97ovS8RxPdGIlySO4cTM9EcX1kR9Cn3vJTWNMGl77GuPRFg/o4Am0IZZr8kbnFk2iR5nZqAgqDk7D9abRSco6shmevVsp9GLIjUXCtXB8zgqLkIpSBWuKkIe1XUzt1BOIw3sIcO/krda6QZu6ZmCJF2db74zvIcpx1WOTIGTulPF27jG437UiCIBHM/MR/gtuAhHKB4K2H+s+UCkfjSDrm/YfcwfIJ+6BTPrq9UszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g86jk0Mj0v+O5l23CkT7aZhghC0m2hX7utns/EGlHnw=;
 b=vZQ6JlmrDxoNO4/w/CpjAe94sT81WQZVIrkEo146MRrxH8Zno9G1r2uKC3x7t21AoHBZiAphnWy8cNzR24NS4l3kANlxzjJhCaGnEZU/Y8qqX4H9DCikXuquPtu978yLmAN2GsZIZ4q87al6eI08zLG7pHeCwgaus3YAFhh/N9k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/6] block/block-copy: use aio-task-pool API
Date: Wed, 25 Mar 2020 16:46:39 +0300
Message-ID: <20200325134639.16337-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.35) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 13:47:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3fdeb99-166b-4097-c9dd-08d7d0c305fc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54803D8148D2FE2AFB965472C1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5i8pTjhNWRYbF/cVf6nW8Lxmahl1/4uD0rl6nY0A06wjjmFyvrj5A0jogM8qtnsGJvKj3eUKQg3Nz990m9jysbNPEFyfaukharwsTNu3zKHMHhiHZx6gyPE7nWpstaovdWopwkiMrtEmhD7QxtFBsrVZNbB2vRm9/FRfYFiI0cLEnBV5ziV5tS/dXJF4F2DRLmjA+kcQEfzeDT5e8xO3lhReXH/YhtMysbydmuxM9a/uuqi5xZVtq1GvS2gwrQgbi7UHlCgPgczMvW2+o/lxYA20GENIo+XQ5X7yLEBLVz3bHtsS5GJPhfYK7aWaC2xYTpwXPo9DsjXGjYoqIS0gY4QxI5GGlRqmzAgIGxg7XukAzu0yFoL+YEEFROStW492g6yalTdTKoQxvrjmNPpnG2xlpmgdf4duVRKb2BXC9DZ8dfZlHFnLzTbnXojFCuC29tYFhqaJSTYcoQOfoPi0m9O2gPDIGUaimwZRhBkk59soIlaqEwiHed3oLOkwhwv
X-MS-Exchange-AntiSpam-MessageData: jJG53N1TZssPX6fHDmuzl1EhZddnA0d7c9DheDN61BAtu6LayeoNPTrwOSnbNVJUlNsFUka7PLmg8/r2ni4k7UV6/221t6XO3A9wtaPqm/vGKDk4/p/RCL6p4nmEFB5u/vzV6nqRh96Mlyhwegxrkg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fdeb99-166b-4097-c9dd-08d7d0c305fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:13.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6pPCOnGGrlOvVotqzmmJPqF9T4TxG2o2jf9uhdN2Cpo2SXcXYxTIyda4zN5RZDm21jaemKBEBwbKtRMTUZRL4gxwxDfh1kawvCbnMtojW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run block_copy iterations in parallel in aio tasks.

Changes:
  - BlockCopyTask becomes aio task structure. Add zeroes field to pass
    it to block_copy_do_copy
  - add call state - it's a state of one call of block_copy(), shared
    between parallel tasks. For now used only to keep information about
    first error: is it read or not.
  - convert block_copy_dirty_clusters to aio-task loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 104 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 910947cb43..9994598eb7 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -19,15 +19,27 @@
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
 #include "qemu/units.h"
+#include "qemu/coroutine.h"
+#include "block/aio_task.h"
=20
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
+#define BLOCK_COPY_MAX_WORKERS 64
+
+typedef struct BlockCopyCallState {
+    bool failed;
+    bool error_is_read;
+} BlockCopyCallState;
=20
 typedef struct BlockCopyTask {
+    AioTask task;
+
     BlockCopyState *s;
+    BlockCopyCallState *call_state;
     int64_t offset;
     int64_t bytes;
+    bool zeroes;
     QLIST_ENTRY(BlockCopyTask) list;
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
@@ -225,6 +237,30 @@ void block_copy_set_progress_meter(BlockCopyState *s, =
ProgressMeter *pm)
     s->progress =3D pm;
 }
=20
+/* Takes ownership on @task */
+static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
+                                            BlockCopyTask *task)
+{
+    if (!pool) {
+        int ret =3D task->task.func(&task->task);
+
+        g_free(task);
+        return ret;
+    }
+
+    aio_task_pool_wait_slot(pool);
+    if (aio_task_pool_status(pool) < 0) {
+        co_put_to_shres(task->s->mem, task->bytes);
+        block_copy_task_end(task, -EAGAIN);
+        g_free(task);
+        return aio_task_pool_status(pool);
+    }
+
+    aio_task_pool_start_task(pool, &task->task);
+
+    return 0;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -328,8 +364,32 @@ out:
     return ret;
 }
=20
+static coroutine_fn int block_copy_task_entry(AioTask *task)
+{
+    BlockCopyTask *t =3D container_of(task, BlockCopyTask, task);
+    bool error_is_read;
+    int ret;
+
+    ret =3D block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
+                             &error_is_read);
+    if (ret < 0 && !t->call_state->failed) {
+        t->call_state->failed =3D true;
+        t->call_state->error_is_read =3D error_is_read;
+    } else {
+        progress_work_done(t->s->progress, t->bytes);
+        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+    }
+    co_put_to_shres(t->s->mem, t->bytes);
+    block_copy_task_end(t, ret);
+
+    return ret;
+}
+
+/* Called only on full-dirty region */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
-                                             int64_t offset, int64_t bytes=
)
+                                             BlockCopyCallState *call_stat=
e,
+                                             int64_t offset,
+                                             int64_t bytes)
 {
     int64_t next_zero;
     BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
@@ -351,7 +411,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyS=
tate *s,
     s->in_flight_bytes +=3D bytes;
=20
     *task =3D (BlockCopyTask) {
+        .task.func =3D block_copy_task_entry,
         .s =3D s,
+        .call_state =3D call_state,
         .offset =3D offset,
         .bytes =3D bytes,
     };
@@ -478,6 +540,8 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
 {
     int ret =3D 0;
     bool found_dirty =3D false;
+    AioTaskPool *aio =3D NULL;
+    BlockCopyCallState call_state =3D {false, false};
=20
     /*
      * block_copy() user is responsible for keeping source and target in s=
ame
@@ -489,8 +553,8 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
=20
-    while (bytes) {
-        g_autofree BlockCopyTask *task =3D NULL;
+    while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
+        BlockCopyTask *task;
         int64_t status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -502,7 +566,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
=20
         found_dirty =3D true;
=20
-        task =3D block_copy_task_create(s, offset, bytes);
+        task =3D block_copy_task_create(s, &call_state, offset, bytes);
=20
         ret =3D block_copy_block_status(s, offset, task->bytes, &status_by=
tes);
         assert(ret >=3D 0); /* never fail */
@@ -511,6 +575,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
         }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
+            g_free(task);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -519,25 +584,38 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
             bytes -=3D status_bytes;
             continue;
         }
+        task->zeroes =3D ret & BDRV_BLOCK_ZERO;
=20
         trace_block_copy_process(s, offset);
=20
         co_get_from_shres(s->mem, task->bytes);
-        ret =3D block_copy_do_copy(s, offset, task->bytes, ret & BDRV_BLOC=
K_ZERO,
-                                 error_is_read);
-        co_put_to_shres(s->mem, task->bytes);
-        block_copy_task_end(task, ret);
-        if (ret < 0) {
-            return ret;
+
+        if (!aio && task->bytes !=3D bytes) {
+            aio =3D aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
         }
=20
-        progress_work_done(s->progress, task->bytes);
-        s->progress_bytes_callback(task->bytes, s->progress_opaque);
         offset +=3D task->bytes;
         bytes -=3D task->bytes;
+
+        ret =3D block_copy_task_run(aio, task);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+out:
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret =3D=3D 0) {
+            ret =3D aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+    if (error_is_read && ret < 0) {
+        *error_is_read =3D call_state.error_is_read;
     }
=20
-    return found_dirty;
+    return ret < 0 ? ret : found_dirty;
 }
=20
 /*
--=20
2.21.0


