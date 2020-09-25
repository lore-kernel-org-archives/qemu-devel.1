Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3FEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C15621D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDeWKlcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C15621D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmee-0006iG-EY
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW6-0003Ao-7a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW4-0004G7-2p
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+y4m8qUcZG9LZ6I4e9KlcqtI4wRE4aoiam6lpucP0c8=;
 b=QDeWKlcRi2nLJu2OnsEuKtSKkC/nm7G/TImKhdEn5oWNvnHN5Oc+Tvr3xNgTTy/bw+xhr3
 D75OyT3YUB1t0h7K3dMcR0HozKXBN+fR2gUjZ907xly8IHSGuTi3BqEhhYq7kRUD+AoXyf
 oNk6eLeHpWjh0akuA9pGNgX0/xgjWGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-65kStykoNQGQXuz2eDe1yQ-1; Fri, 25 Sep 2020 08:07:52 -0400
X-MC-Unique: 65kStykoNQGQXuz2eDe1yQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB9F1007482;
 Fri, 25 Sep 2020 12:07:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E993473695;
 Fri, 25 Sep 2020 12:07:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 13/26] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Date: Fri, 25 Sep 2020 13:06:42 +0100
Message-Id: <20200925120655.295142-14-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Message-Id: <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  atomic function fixup
  Wording fixup in migration.json based on Eric's review
---
 migration/dirtyrate.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json   | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 419b0e30ba..2ffd88d48e 100644
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
+    if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
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
+    if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURING) {
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
index 76a59b4f92..ce2216cfea 100644
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
+#          If this field returns '-1', it means querying has not
+#          yet started or completed.
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
2.26.2


