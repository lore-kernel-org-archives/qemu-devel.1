Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D82C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E1220684
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG308-0000Vg-Mz
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:54:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vo-0005Uf-V5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vj-0005Rn-OO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:49:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2vg-0005QG-PW; Mon, 15 Apr 2019 10:49:53 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2ve-0002By-Eb; Mon, 15 Apr 2019 17:49:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:49:46 +0300
Message-Id: <20190415144948.78568-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415144948.78568-1-vsementsov@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 3/5] block/backup: refactor and tolerate
 unallocated cluster skipping
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
	jsnow@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415144946.arsRueuABRyW1F8LMb9Eg79hulwYXyOMrN-EcS2lSVA@z>

Split allocation checking to separate function and reduce nesting.
Consider bdrv_is_allocated() fail as allocated area, as copying more
than needed is not wrong (and we do it anyway) and seems better than
fail the whole job. And, most probably we will fail on the next read,
if there are real problem with source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 60 +++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 510fc54f98..298e85f1a9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -377,6 +377,22 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
     return false;
 }
 
+static bool bdrv_is_unallocated_range(BlockDriverState *bs,
+                                      int64_t offset, int64_t bytes)
+{
+    int64_t end = offset + bytes;
+
+    while (offset < end && !bdrv_is_allocated(bs, offset, bytes, &bytes)) {
+        if (bytes == 0) {
+            return true;
+        }
+        offset += bytes;
+        bytes = end - offset;
+    }
+
+    return offset >= end;
+}
+
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
@@ -462,49 +478,19 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         for (offset = 0; offset < s->len;
              offset += s->cluster_size) {
             bool error_is_read;
-            int alloced = 0;
 
             if (yield_and_check(s)) {
                 break;
             }
 
-            if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
-                int i;
-                int64_t n;
-
-                /* Check to see if these blocks are already in the
-                 * backing file. */
-
-                for (i = 0; i < s->cluster_size;) {
-                    /* bdrv_is_allocated() only returns true/false based
-                     * on the first set of sectors it comes across that
-                     * are are all in the same state.
-                     * For that reason we must verify each sector in the
-                     * backup cluster length.  We end up copying more than
-                     * needed but at some point that is always the case. */
-                    alloced =
-                        bdrv_is_allocated(bs, offset + i,
-                                          s->cluster_size - i, &n);
-                    i += n;
-
-                    if (alloced || n == 0) {
-                        break;
-                    }
-                }
-
-                /* If the above loop never found any sectors that are in
-                 * the topmost image, skip this backup. */
-                if (alloced == 0) {
-                    continue;
-                }
-            }
-            /* FULL sync mode we copy the whole drive. */
-            if (alloced < 0) {
-                ret = alloced;
-            } else {
-                ret = backup_do_cow(s, offset, s->cluster_size,
-                                    &error_is_read, false);
+            if (s->sync_mode == MIRROR_SYNC_MODE_TOP &&
+                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
+            {
+                continue;
             }
+
+            ret = backup_do_cow(s, offset, s->cluster_size,
+                                &error_is_read, false);
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
                 BlockErrorAction action =
-- 
2.18.0


