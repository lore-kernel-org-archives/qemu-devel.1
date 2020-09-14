Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1DC2D0E3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B3420756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B3420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkI2-0005uf-3x
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHkE1-00063Q-Ni
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:52:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32888 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHkDz-0005lc-Tx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:52:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 687CE133575316146C63;
 Mon, 14 Sep 2020 16:52:31 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 16:52:21 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v8 09/12] migration/dirtyrate: Implement
 set_sample_page_period() and is_sample_period_valid()
Date: Mon, 14 Sep 2020 17:03:02 +0800
Message-ID: <1600074185-91624-10-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 04:52:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, yuxiating@huawei.com,
 liq3ea@gmail.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement is_sample_period_valid() to check if the sample period is vaild and
do set_sample_page_period() to sleep specific time between sample actions.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 migration/dirtyrate.c | 24 ++++++++++++++++++++++++
 migration/dirtyrate.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index e68af6f..6add846 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -27,6 +27,30 @@
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
 static struct DirtyRateStat DirtyStat;
 
+static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
+{
+    int64_t current_time;
+
+    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if ((current_time - initial_time) >= msec) {
+        msec = current_time - initial_time;
+    } else {
+        g_usleep((msec + initial_time - current_time) * 1000);
+    }
+
+    return msec;
+}
+
+static bool is_sample_period_valid(int64_t sec)
+{
+    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
+        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
+        return false;
+    }
+
+    return true;
+}
+
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
     assert(new_state < DIRTY_RATE_STATUS__MAX);
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index faaf9da..8f9bc80 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -29,6 +29,12 @@
  */
 #define MIN_RAMBLOCK_SIZE                         128
 
+/*
+ * Take 1s as minimum time for calculation duration
+ */
+#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
+#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
+
 struct DirtyRateConfig {
     uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
     int64_t sample_period_seconds; /* time duration between two sampling */
-- 
1.8.3.1


