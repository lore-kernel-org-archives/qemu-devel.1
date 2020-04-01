Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69AC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD172054F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD172054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJTuY-0005iR-DO
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 23:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangxinxin.wang@huawei.com>) id 1jJRsb-0001xP-Q0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 21:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangxinxin.wang@huawei.com>) id 1jJRsa-0007Rl-CF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 21:09:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59218 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1jJRsa-0006qZ-0c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 21:09:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6636A36059DBB26BE6A4;
 Wed,  1 Apr 2020 09:09:08 +0800 (CST)
Received: from localhost (10.173.228.84) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 09:09:00 +0800
From: Wang Xin <wangxinxin.wang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] migration/throttle: use the xfer pages as threshold
Date: Wed, 1 Apr 2020 09:08:58 +0800
Message-ID: <20200401010858.799-1-wangxinxin.wang@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.84]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Tue, 31 Mar 2020 23:18:42 -0400
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
Cc: Wang Xin <wangxinxin.wang@huawei.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If VM migration with lots of zero page or enable data compress, the peroi=
d
tansfer bytes may be much less than the available bandwidth, which trigge=
r
unnecessary guest throttle down. Use the raw transfer pages as the
threshold instead.

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>

diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..e53333bc6a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -323,6 +323,8 @@ struct RAMState {
     int64_t time_last_bitmap_sync;
     /* bytes transferred at start_time */
     uint64_t bytes_xfer_prev;
+    /* pages transferred at start_time */
+    uint64_t pages_xfer_prev;
     /* number of dirty pages since start_time */
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
@@ -901,9 +903,9 @@ static void migration_trigger_throttle(RAMState *rs)
     MigrationState *s =3D migrate_get_current();
     uint64_t threshold =3D s->parameters.throttle_trigger_threshold;
=20
-    uint64_t bytes_xfer_period =3D ram_counters.transferred - rs->bytes_=
xfer_prev;
-    uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period * TARGET_=
PAGE_SIZE;
-    uint64_t bytes_dirty_threshold =3D bytes_xfer_period * threshold / 1=
00;
+    uint64_t pages_xfer_period =3D ram_get_total_transferred_pages() -
+                                 rs->pages_xfer_prev;
+    uint64_t pages_dirty_threshold =3D pages_xfer_period * threshold / 1=
00;
=20
     /* During block migration the auto-converge logic incorrectly detect=
s
      * that ram migration makes no progress. Avoid this by disabling the
@@ -915,7 +917,7 @@ static void migration_trigger_throttle(RAMState *rs)
            we were in this routine reaches the threshold. If that happen=
s
            twice, start or increase throttling. */
=20
-        if ((bytes_dirty_period > bytes_dirty_threshold) &&
+        if ((rs->num_dirty_pages_period > pages_dirty_threshold) &&
             (++rs->dirty_rate_high_cnt >=3D 2)) {
             trace_migration_throttle();
             rs->dirty_rate_high_cnt =3D 0;
@@ -964,6 +966,7 @@ static void migration_bitmap_sync(RAMState *rs)
         rs->time_last_bitmap_sync =3D end_time;
         rs->num_dirty_pages_period =3D 0;
         rs->bytes_xfer_prev =3D ram_counters.transferred;
+        rs->pages_xfer_prev =3D ram_get_total_transferred_pages();
     }
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
--=20
2.26.0.windows.1



