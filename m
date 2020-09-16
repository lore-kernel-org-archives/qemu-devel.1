Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE106C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6355C2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6355C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQop-0001mX-GT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfN-0006qy-HE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52396 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kIQfH-0005Xt-EH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:11:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 20F517D44014809C9DC5;
 Wed, 16 Sep 2020 14:11:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 14:11:21 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v10 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Date: Wed, 16 Sep 2020 14:22:06 +0800
Message-ID: <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:11:31
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/dirtyrate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 2a1a7fa..06f455d 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -61,6 +61,24 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+static struct DirtyRateInfo *query_dirty_rate_info(void)
+{
+    int64_t dirty_rate = DirtyStat.dirty_rate;
+    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
+
+    if (atomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
+        info->dirty_rate = dirty_rate;
+    } else {
+        info->dirty_rate = -1;
+    }
+
+    info->status = CalculatingState;
+    info->start_time = DirtyStat.start_time;
+    info->calc_time = DirtyStat.calc_time;
+
+    return info;
+}
+
 static void reset_dirtyrate_stat(void)
 {
     DirtyStat.total_dirty_samples = 0;
@@ -318,6 +336,8 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
 
     msec = config.sample_period_seconds * 1000;
     msec = set_sample_page_period(msec, initial_time);
+    DirtyStat.start_time = initial_time / 1000;
+    DirtyStat.calc_time = msec / 1000;
 
     rcu_read_lock();
     if (!compare_page_hash_info(block_dinfo, block_count)) {
@@ -353,3 +373,45 @@ void *get_dirtyrate_thread(void *arg)
     }
     return NULL;
 }
+
+void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
+{
+    static struct DirtyRateConfig config;
+    QemuThread thread;
+    int ret;
+
+    /*
+     * If the dirty rate is already being measured, don't attempt to start.
+     */
+    if (atomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURING) {
+        error_setg(errp, "the dirty rate is already being measured.");
+        return;
+    }
+
+    if (!is_sample_period_valid(calc_time)) {
+        error_setg(errp, "calc-time is out of range[%d, %d].",
+                         MIN_FETCH_DIRTYRATE_TIME_SEC,
+                         MAX_FETCH_DIRTYRATE_TIME_SEC);
+        return;
+    }
+
+    /*
+     * Init calculation state as unstarted.
+     */
+    ret = dirtyrate_set_state(&CalculatingState, CalculatingState,
+                              DIRTY_RATE_STATUS_UNSTARTED);
+    if (ret == -1) {
+        error_setg(errp, "init dirty rate calculation state failed.");
+        return;
+    }
+
+    config.sample_period_seconds = calc_time;
+    config.sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
+    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
+                       (void *)&config, QEMU_THREAD_DETACHED);
+}
+
+struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
+{
+    return query_dirty_rate_info();
+}
diff --git a/qapi/migration.json b/qapi/migration.json
index 061ff25..4b980a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1737,3 +1737,53 @@
 ##
 { 'enum': 'DirtyRateStatus',
   'data': [ 'unstarted', 'measuring', 'measured'] }
+
+##
+# @DirtyRateInfo:
+#
+# Information about current dirty page rate of vm.
+#
+# @dirty-rate: @dirtyrate describing the dirty page rate of vm
+#          in units of MB/s.
+#          If this field return '-1', it means querying is not
+#          start or not complete.
+#
+# @status: status containing dirtyrate query status includes
+#          'unstarted' or 'measuring' or 'measured'
+#
+# @start-time: start time in units of second for calculation
+#
+# @calc-time: time in units of second for sample dirty pages
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'DirtyRateInfo',
+  'data': {'dirty-rate': 'int64',
+           'status': 'DirtyRateStatus',
+           'start-time': 'int64',
+           'calc-time': 'int64'} }
+
+##
+# @calc-dirty-rate:
+#
+# start calculating dirty page rate for vm
+#
+# @calc-time: time in units of second for sample dirty pages
+#
+# Since: 5.2
+#
+# Example:
+#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
+#
+##
+{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
+
+##
+# @query-dirty-rate:
+#
+# query dirty page rate in units of MB/s for vm
+#
+# Since: 5.2
+##
+{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
-- 
1.8.3.1


