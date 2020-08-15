Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB6CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC1123B6F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC1123B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70Yo-0005pI-VT
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VF-0000pN-BO
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57328 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k70VD-0007DU-6y
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:02:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 102351BFD4E5DDCEF8C1;
 Sat, 15 Aug 2020 10:11:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 10:11:10 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v2 10/10] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Date: Sat, 15 Aug 2020 10:23:00 +0800
Message-ID: <1597458180-16945-11-git-send-email-zhengchuan@huawei.com>
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

Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
---
 migration/dirtyrate.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index d487030..bf8fe9e 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -66,6 +66,39 @@ static int dirty_rate_set_state(int new_state)
     return 0;
 }
 
+static struct DirtyRateInfo *query_dirty_rate_info(void)
+{
+    int64_t dirty_rate = dirty_stat.dirty_rate;
+    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
+
+    switch(CalculatingState) {
+    case CAL_DIRTY_RATE_INIT:
+        info->dirty_rate = -1;
+        info->status = g_strdup("Not start measuring");
+        break;
+    case CAL_DIRTY_RATE_ACTIVE:
+        info->dirty_rate = -1;
+        info->status = g_strdup("Still measuring");
+        break;
+    case CAL_DIRTY_RATE_END:
+        info->dirty_rate = dirty_rate;
+        info->status = g_strdup("Measured");
+        break;
+    default:
+        info->dirty_rate = -1;
+        info->status = g_strdup("Unknown status");
+        break;
+    }
+
+    /*
+     * Only support query once for each calculation,
+     * reset as CAL_DIRTY_RATE_INIT after query
+     */
+    (void)dirty_rate_set_state(CAL_DIRTY_RATE_INIT);
+
+    return info;
+}
+
 static void reset_dirtyrate_stat(void)
 {
     dirty_stat.total_dirty_samples = 0;
@@ -390,3 +423,26 @@ void *get_dirtyrate_thread(void *arg)
 
     return NULL;
 }
+
+void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
+{
+    static struct DirtyRateConfig config;
+    QemuThread thread;
+
+    /*
+     * We don't begin calculating thread only when it's in calculating status.
+     */
+    if (CalculatingState == CAL_DIRTY_RATE_ACTIVE) {
+        return;
+    }
+
+    config.sample_period_seconds = get_sample_page_period(calc_time);
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
index d500055..ccc7a4e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1621,3 +1621,45 @@
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
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
+# @status: @status containing dirtyrate query status includes
+#       status with 'not start measuring' or
+#       'Still measuring' or 'measured'(since 5.2)
+##
+{ 'struct': 'DirtyRateInfo',
+  'data': {'dirty-rate': 'int64',
+           'status': 'str'} }
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
+#   {"command": "cal-dirty-rate", "data": {"calc-time": 1} }
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


