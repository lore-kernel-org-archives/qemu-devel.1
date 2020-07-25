Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3FC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496CC206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496CC206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAS8-000734-HM
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPX-0002Ai-AE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4156 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPR-0000l8-4R
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 44B8CA8698CC032E273A;
 Sat, 25 Jul 2020 10:59:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:24 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 8/8] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Date: Sat, 25 Jul 2020 11:11:09 +0800
Message-ID: <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:59:33
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
by libvirt api.

Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
---
 migration/Makefile.objs |  1 +
 migration/dirtyrate.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json     | 24 ++++++++++++++++++++++++
 qapi/pragma.json        |  3 ++-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 0fc619e..12ae98c 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
 common-obj-y += qemu-file-channel.o
 common-obj-y += xbzrle.o postcopy-ram.o
 common-obj-y += qjson.o
+common-obj-y += dirtyrate.o
 common-obj-y += block-dirty-bitmap.o
 common-obj-y += multifd.o
 common-obj-y += multifd-zlib.o
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index d87e16d..5717521 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -31,6 +31,21 @@ CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
         INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
 
+static int64_t get_dirty_rate_info(void)
+{
+    int64_t dirty_rate = dirty_stat.dirty_rate;
+    /*
+     *    Return dirty_rate only when we get CAL_DIRTY_RATE_END.
+     *    And we must initial calculating_dirty_rate_stage.
+     */
+    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_END) {
+        calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
+        return dirty_rate;
+    }  else {
+        return -1;
+    }
+}
+
 static void reset_dirtyrate_stat(void)
 {
     dirty_stat.total_dirty_samples = 0;
@@ -377,3 +392,33 @@ void *get_dirtyrate_thread(void *arg)
 
     return NULL;
 }
+
+void qmp_cal_dirty_rate(int64_t value, Error **errp)
+{
+    static struct dirtyrate_config dirtyrate_config;
+    QemuThread thread;
+
+    /*
+     * We don't begin calculating thread only when it's in calculating status.
+     */
+    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_ING) {
+        return;
+    }
+
+    /*
+     * If we get CAL_DIRTY_RATE_END here, libvirtd may be restarted at last round,
+     * we need to initial it.
+     */
+    if (calculating_dirty_rate_stage == CAL_DIRTY_RATE_END)
+        calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
+
+    dirtyrate_config.sample_period_seconds = value;
+    dirtyrate_config.sample_pages_per_gigabytes = sample_pages_per_gigabytes;
+    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
+                       (void *)&dirtyrate_config, QEMU_THREAD_DETACHED);
+}
+
+int64_t qmp_get_dirty_rate(Error **errp)
+{
+    return get_dirty_rate_info();
+}
diff --git a/qapi/migration.json b/qapi/migration.json
index d500055..59f35bb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1621,3 +1621,27 @@
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
+
+##
+# @cal_dirty_rate:
+#
+# start calculating dirty rate for vm
+#
+# @value: time for sample dirty pages
+#
+# Since: 5.1
+#
+# Example:
+#   {"command": "cal_dirty_rate", "data": {"value": 1} }
+#
+##
+{ 'command': 'cal_dirty_rate', 'data': {'value': 'int64'} }
+
+##
+# @get_dirty_rate:
+#
+# get dirty rate for vm
+#
+# Since: 5.1
+##
+{ 'command': 'get_dirty_rate', 'returns': 'int64' }
diff --git a/qapi/pragma.json b/qapi/pragma.json
index cffae27..ecd294b 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -10,7 +10,8 @@
         'query-migrate-cache-size',
         'query-tpm-models',
         'query-tpm-types',
-        'ringbuf-read' ],
+        'ringbuf-read',
+        'get_dirty_rate' ],
     'name-case-whitelist': [
         'ACPISlotType',             # DIMM, visible through query-acpi-ospm-status
         'CpuInfoMIPS',              # PC, visible through query-cpu
-- 
1.8.3.1


