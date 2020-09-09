Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780EC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456772075A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456772075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0sk-0003zW-Al
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kG0lj-000162-Ki
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:08:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4734 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kG0la-0001jO-7o
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:08:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A5455501D8AF6EBCBEE6;
 Wed,  9 Sep 2020 22:07:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 22:07:30 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>, <dme@dme.org>
Subject: [PATCH v7 09/12] migration/dirtyrate: Implement
 set_sample_page_period() and get_sample_page_period()
Date: Wed, 9 Sep 2020 22:18:13 +0800
Message-ID: <1599661096-127913-10-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 10:07:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement set_sample_page_period()/get_sample_page_period() to sleep
specific time between sample actions.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 migration/dirtyrate.c | 24 ++++++++++++++++++++++++
 migration/dirtyrate.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index ae1959b..8a30261 100644
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
+static bool get_sample_page_period(int64_t sec)
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


