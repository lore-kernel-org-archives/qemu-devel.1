Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A26EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E58D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFCnccRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E58D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmZE-00082O-W6
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVg-0002J9-4v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVe-0004Dy-7p
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+p4cUwbZBePSB0cV+zQje3NVEUYNiC8OKPJnj/bUL4=;
 b=MFCnccRG2jI83Lwv7d2nDxFqMdslC2hG4tdoRE6wSl64Elo6YNXXkUnYKxocLQV6mxqp5J
 FMGy+jFpzqFQwWIbn/XXpEwgCZ6kMC4yI2QVlOwgKuUW52I7Jasd9QX5JJLIcy520deU8+
 J+dYN+jhYKSquO/QzGFHPx4zji3Y+7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-UpBs0oYDPgS2dZujpYroGw-1; Fri, 25 Sep 2020 08:07:27 -0400
X-MC-Unique: UpBs0oYDPgS2dZujpYroGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 701C6186DD3D;
 Fri, 25 Sep 2020 12:07:26 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6316A73692;
 Fri, 25 Sep 2020 12:07:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 06/26] migration/dirtyrate: Add dirtyrate statistics series
 functions
Date: Fri, 25 Sep 2020 13:06:35 +0100
Message-Id: <20200925120655.295142-7-dgilbert@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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

Add dirtyrate statistics functions to record/update dirtyrate info.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1600237327-33618-5-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 32 ++++++++++++++++++++++++++++++++
 migration/dirtyrate.h | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 3edf000f45..94c4e173bc 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -23,6 +23,7 @@
 #include "dirtyrate.h"
 
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
+static struct DirtyRateStat DirtyStat;
 
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
@@ -34,6 +35,37 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+static void reset_dirtyrate_stat(void)
+{
+    DirtyStat.total_dirty_samples = 0;
+    DirtyStat.total_sample_count = 0;
+    DirtyStat.total_block_mem_MB = 0;
+    DirtyStat.dirty_rate = -1;
+    DirtyStat.start_time = 0;
+    DirtyStat.calc_time = 0;
+}
+
+static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
+{
+    DirtyStat.total_dirty_samples += info->sample_dirty_count;
+    DirtyStat.total_sample_count += info->sample_pages_count;
+    /* size of total pages in MB */
+    DirtyStat.total_block_mem_MB += (info->ramblock_pages *
+                                     TARGET_PAGE_SIZE) >> 20;
+}
+
+static void update_dirtyrate(uint64_t msec)
+{
+    uint64_t dirtyrate;
+    uint64_t total_dirty_samples = DirtyStat.total_dirty_samples;
+    uint64_t total_sample_count = DirtyStat.total_sample_count;
+    uint64_t total_block_mem_MB = DirtyStat.total_block_mem_MB;
+
+    dirtyrate = total_dirty_samples * total_block_mem_MB *
+                1000 / (total_sample_count * msec);
+
+    DirtyStat.dirty_rate = dirtyrate;
+}
 
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
index 8707df852d..312debca6f 100644
--- a/migration/dirtyrate.h
+++ b/migration/dirtyrate.h
@@ -42,5 +42,17 @@ struct RamblockDirtyInfo {
     uint32_t *hash_result; /* array of hash result for sampled pages */
 };
 
+/*
+ * Store calculation statistics for each measure.
+ */
+struct DirtyRateStat {
+    uint64_t total_dirty_samples; /* total dirty sampled page */
+    uint64_t total_sample_count; /* total sampled pages */
+    uint64_t total_block_mem_MB; /* size of total sampled pages in MB */
+    int64_t dirty_rate; /* dirty rate in MB/s */
+    int64_t start_time; /* calculation start time in units of second */
+    int64_t calc_time; /* time duration of two sampling in units of second */
+};
+
 void *get_dirtyrate_thread(void *arg);
 #endif
-- 
2.26.2


