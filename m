Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A8C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61BE222C8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 14:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61BE222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHUC3-0007MR-S9
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 10:08:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHU8A-0003ld-Mh
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHTvg-000751-9D
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:51:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:33720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTvg-0006z6-1Z; Fri, 19 Apr 2019 09:51:48 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hHTvb-0008V2-2j; Fri, 19 Apr 2019 16:51:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 19 Apr 2019 16:51:40 +0300
Message-Id: <20190419135142.91810-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190419135142.91810-1-vsementsov@virtuozzo.com>
References: <20190419135142.91810-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 1/3] block/qcow2-refcount: add trace-point
 to qcow2_process_discards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419135140.lcWbOZwLbaQILsQkVKjm90JiG9YCiMgWmWlKzB3NfYs@z>

Let's at least trace ignored failure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 7 ++++++-
 block/trace-events     | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e0fe322500..60284bcaac 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -30,6 +30,7 @@
 #include "qemu/range.h"
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
                                     uint64_t max);
@@ -738,7 +739,11 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
 
         /* Discard is optional, ignore the return value */
         if (ret >= 0) {
-            bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            int r2 = bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            if (r2 < 0) {
+                trace_qcow2_process_discards_failed_region(d->offset, d->bytes,
+                                                           r2);
+            }
         }
 
         g_free(d);
diff --git a/block/trace-events b/block/trace-events
index 7335a42540..ea508f637e 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -91,6 +91,9 @@ qcow2_cache_get_done(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_flush(void *co, int c) "co %p is_l2_cache %d"
 qcow2_cache_entry_flush(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 
+# qcow2-refcount.c
+qcow2_process_discards_failed_region(uint64_t offset, uint64_t bytes, int ret) "offset 0x%" PRIx64 " bytes 0x%" PRIx64 " ret %d"
+
 # qed-l2-cache.c
 qed_alloc_l2_cache_entry(void *l2_cache, void *entry) "l2_cache %p entry %p"
 qed_unref_l2_cache_entry(void *entry, int ref) "entry %p ref %d"
-- 
2.18.0


