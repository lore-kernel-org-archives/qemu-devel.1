Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43FC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88F022B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhBjgfo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88F022B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmik-0002Gp-I5
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW2-00032R-Hn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW0-0004Fk-LU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYIPbhkmgu94Y8R7pvVnSSWLdcr7eX5vaM6ifZxTJmY=;
 b=AhBjgfo7PbOqFpQdiwBWfvWYultZhNf8iZA3XG4yURkGUPspuxJ3tGY6zzp9aMTpDM5dOY
 Nkd72+pxbGSLmjEW02vq2ysTvwpRpbPdqJuS0OAemKZMWyh52+o7Ig+hR0n2VdUW7WLq/o
 0L30Qf4kO9hBbsJjqpvpY24qyjhk2XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-1ncJuC8pMw2yiIX8SSf8KQ-1; Fri, 25 Sep 2020 08:07:50 -0400
X-MC-Unique: 1ncJuC8pMw2yiIX8SSf8KQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5B810BBECD;
 Fri, 25 Sep 2020 12:07:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45C3C73692;
 Fri, 25 Sep 2020 12:07:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 12/26] migration/dirtyrate: Implement calculate_dirtyrate()
 function
Date: Fri, 25 Sep 2020 13:06:41 +0100
Message-Id: <20200925120655.295142-13-dgilbert@redhat.com>
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

Implement calculate_dirtyrate() function.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1600237327-33618-11-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 20216c5f09..419b0e30ba 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
     strcpy(info->idstr, qemu_ram_get_idstr(block));
 }
 
+static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
+{
+    int i;
+
+    if (!infos) {
+        return;
+    }
+
+    for (i = 0; i < count; i++) {
+        g_free(infos[i].sample_page_vfn);
+        g_free(infos[i].hash_result);
+    }
+    g_free(infos);
+}
+
 static bool skip_sample_ramblock(RAMBlock *block)
 {
     /*
@@ -287,8 +302,34 @@ static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
 
 static void calculate_dirtyrate(struct DirtyRateConfig config)
 {
-    /* todo */
-    return;
+    struct RamblockDirtyInfo *block_dinfo = NULL;
+    int block_count = 0;
+    int64_t msec = 0;
+    int64_t initial_time;
+
+    rcu_register_thread();
+    reset_dirtyrate_stat();
+    rcu_read_lock();
+    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) {
+        goto out;
+    }
+    rcu_read_unlock();
+
+    msec = config.sample_period_seconds * 1000;
+    msec = set_sample_page_period(msec, initial_time);
+
+    rcu_read_lock();
+    if (!compare_page_hash_info(block_dinfo, block_count)) {
+        goto out;
+    }
+
+    update_dirtyrate(msec);
+
+out:
+    rcu_read_unlock();
+    free_ramblock_dirty_info(block_dinfo, block_count);
+    rcu_unregister_thread();
 }
 
 void *get_dirtyrate_thread(void *arg)
-- 
2.26.2


