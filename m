Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D28C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F311823B6F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311823B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70a3-00089F-Ak
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VH-0000qh-9S
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57322 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VE-0007DW-KY
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0BE1E4B46BF3E1E7C17E;
 Sat, 15 Aug 2020 10:11:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 10:11:09 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v2 08/10] migration/dirtyrate: Implement
 get_sample_page_period() and block_sample_page_period()
Date: Sat, 15 Aug 2020 10:22:58 +0800
Message-ID: <1597458180-16945-9-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
References: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 14:01:48
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Chuan <zhengchuan@huawei.com>

Implement get_sample_page_period() and set_sample_page_period() to
sleep specific time between sample actions.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
---
 migration/dirtyrate.c | 23 +++++++++++++++++++++++
 migration/dirtyrate.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 3dc9feb..54b832a 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -28,6 +28,29 @@ CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
 static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;
 static struct DirtyRateStat dirty_stat;
 
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
+static int64_t get_sample_page_period(int64_t sec)
+{
+    if (sec <= MIN_FETCH_DIRTYRATE_TIME_SEC || sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
+        sec = DEFAULT_FETCH_DIRTYRATE_TIME_SEC;
+    }
+
+    return sec;
+}
+
 static int dirty_rate_set_state(int new_state)
 {
     int old_state = CalculatingState;
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index fce2e3b..86d8fa0 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -38,6 +38,8 @@
 
 /* Take 1s as default for calculation duration */
 #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
+#define MIN_FETCH_DIRTYRATE_TIME_SEC              0
+#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
 
 struct DirtyRateConfig {
     uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
-- 
1.8.3.1


