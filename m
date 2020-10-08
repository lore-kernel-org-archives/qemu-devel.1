Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF0C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA39021789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCiQzGr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA39021789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbNJ-00074l-M4
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQbJy-0002Uu-Ph
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQbJw-0005BC-Sn
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602184280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0f7a6Fc7A+7mZcGUG5Hm7ANHiCXaOvgGvgfUjI3+ow=;
 b=HCiQzGr3vdGdwa8HEhjPMbcpB4pHncFO1lOW0y8AJXVsl1B40oeqP4xCrlzLbaT5cqvg9o
 2rtgymWiJuTTJBdNLbQH/DZyHTBC8AZmiY3I5ZGRbLJHMgSt9GaTzlN7BkfllNnyXB7MEm
 RoPmbc7tALgmlJUF2vAEPj+qlYzDA6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-RIDE__bcNpmKMJLUVYvlzw-1; Thu, 08 Oct 2020 15:11:18 -0400
X-MC-Unique: RIDE__bcNpmKMJLUVYvlzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FCBAE823;
 Thu,  8 Oct 2020 19:11:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-212.ams2.redhat.com
 [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8F065C1BD;
 Thu,  8 Oct 2020 19:11:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 09/10] migration/dirtyrate: record start_time and calc_time
 while at the measuring state
Date: Thu,  8 Oct 2020 20:10:45 +0100
Message-Id: <20201008191046.272549-10-dgilbert@redhat.com>
In-Reply-To: <20201008191046.272549-1-dgilbert@redhat.com>
References: <20201008191046.272549-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Querying could include both the start-time and the calc-time while at the measuring
state, allowing a caller to determine when they should expect to come back looking
for a result.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Message-Id: <1601350938-128320-2-git-send-email-zhengchuan@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 68577ef250..40e41e793e 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -83,14 +83,14 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     return info;
 }
 
-static void reset_dirtyrate_stat(void)
+static void init_dirtyrate_stat(int64_t start_time, int64_t calc_time)
 {
     DirtyStat.total_dirty_samples = 0;
     DirtyStat.total_sample_count = 0;
     DirtyStat.total_block_mem_MB = 0;
     DirtyStat.dirty_rate = -1;
-    DirtyStat.start_time = 0;
-    DirtyStat.calc_time = 0;
+    DirtyStat.start_time = start_time;
+    DirtyStat.calc_time = calc_time;
 }
 
 static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
@@ -335,7 +335,6 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
     int64_t initial_time;
 
     rcu_register_thread();
-    reset_dirtyrate_stat();
     rcu_read_lock();
     initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
@@ -365,6 +364,8 @@ void *get_dirtyrate_thread(void *arg)
 {
     struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
     int ret;
+    int64_t start_time;
+    int64_t calc_time;
 
     ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
                               DIRTY_RATE_STATUS_MEASURING);
@@ -373,6 +374,10 @@ void *get_dirtyrate_thread(void *arg)
         return NULL;
     }
 
+    start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    calc_time = config.sample_period_seconds;
+    init_dirtyrate_stat(start_time, calc_time);
+
     calculate_dirtyrate(config);
 
     ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
-- 
2.28.0


