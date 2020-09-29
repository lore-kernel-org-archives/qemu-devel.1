Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE6DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC7C208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC7C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6P0-0006Ee-5g
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kN6N9-0004S9-ML
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:32:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5153 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kN6N7-0001gz-C9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:32:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0A41F46028A857E4E8CB;
 Tue, 29 Sep 2020 11:32:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:31:57 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v2 2/2] migration/dirtyrate: present dirty rate only when
 querying the rate has completed
Date: Tue, 29 Sep 2020 11:42:18 +0800
Message-ID: <1601350938-128320-3-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
References: <1601350938-128320-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:32:05
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, david.edmondson@oracle.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make dirty_rate field optional, present dirty rate only when querying
the rate has completed.
The qmp results is shown as follow:
@unstarted:
{"return":{"status":"unstarted","start-time":0,"calc-time":0},"id":"libvirt-12"}
@measuring:
{"return":{"status":"measuring","start-time":102931,"calc-time":1},"id":"libvirt-85"}
@measured:
{"return":{"status":"measured","dirty-rate":4,"start-time":150146,"calc-time":1},"id":"libvirt-15"}

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 migration/dirtyrate.c | 3 +--
 qapi/migration.json   | 8 +++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 40e41e7..ab9e130 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -69,9 +69,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
 
     if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
+        info->has_dirty_rate = true;
         info->dirty_rate = dirty_rate;
-    } else {
-        info->dirty_rate = -1;
     }
 
     info->status = CalculatingState;
diff --git a/qapi/migration.json b/qapi/migration.json
index ce2216c..715c210 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1743,10 +1743,8 @@
 #
 # Information about current dirty page rate of vm.
 #
-# @dirty-rate: @dirtyrate describing the dirty page rate of vm
-#          in units of MB/s.
-#          If this field returns '-1', it means querying has not
-#          yet started or completed.
+# @dirty-rate: an estimate of the dirty page rate of the VM in units of
+#              MB/s, present only when estimating the rate has completed.
 #
 # @status: status containing dirtyrate query status includes
 #          'unstarted' or 'measuring' or 'measured'
@@ -1759,7 +1757,7 @@
 #
 ##
 { 'struct': 'DirtyRateInfo',
-  'data': {'dirty-rate': 'int64',
+  'data': {'*dirty-rate': 'int64',
            'status': 'DirtyRateStatus',
            'start-time': 'int64',
            'calc-time': 'int64'} }
-- 
1.8.3.1


