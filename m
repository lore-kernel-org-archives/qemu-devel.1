Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFBF2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFBF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39LX-0005dS-BL
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k39Kx-00058M-BT; Tue, 04 Aug 2020 22:39:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38428 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k39Ku-0004Jl-2x; Tue, 04 Aug 2020 22:39:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9D0F57869BB57C9B5EE2;
 Wed,  5 Aug 2020 10:39:09 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 5 Aug 2020
 10:38:59 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH] qcow2: flush qcow2 l2 meta for new allocated clusters
Date: Wed, 5 Aug 2020 10:38:26 +0800
Message-ID: <20200805023826.184-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 22:39:10
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
Cc: alex.chen@huawei.com, fangying <fangying1@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fangying <fangying1@huawei.com>

When qemu or qemu-nbd process uses a qcow2 image and configured with
'cache = none', it will write to the qcow2 image with a cache to cache
L2 tables, however the process will not use L2 tables without explicitly
calling the flush command or closing the mirror flash into the disk.
Which may cause the disk data inconsistent with the written data for
a long time. If an abnormal process exit occurs here, the issued written
data will be lost.

Therefore, in order to keep data consistency we need to flush the changes
to the L2 entry to the disk in time for the newly allocated cluster.

Signed-off-by: Ying Fang <fangying1@huawei.com>

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 7444b9c..ab6e812 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -266,6 +266,22 @@ int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c)
     return result;
 }
 
+#define L2_ENTRIES_PER_SECTOR 64
+int qcow2_cache_l2_write_entry(BlockDriverState *bs, Qcow2Cache *c,
+                               void *table, int index, int num)
+{
+    int ret;
+    int i = qcow2_cache_get_table_idx(c, table);
+    int start_sector = index / L2_ENTRIES_PER_SECTOR;
+    int end_sector = (index + num - 1) / L2_ENTRIES_PER_SECTOR;
+    int nr_sectors = end_sector - start_sector + 1;
+    ret = bdrv_pwrite(bs->file,
+                      c->entries[i].offset + start_sector * BDRV_SECTOR_SIZE,
+                      table + start_sector * BDRV_SECTOR_SIZE,
+                      nr_sectors * BDRV_SECTOR_SIZE);
+    return ret;
+}
+
 int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency)
 {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a677ba9..ae49a83 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -998,6 +998,9 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      }
 
 
+    ret = qcow2_cache_l2_write_entry(bs, s->l2_table_cache, l2_slice,
+                                     l2_index, m->nb_clusters);
+
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /*
diff --git a/block/qcow2.h b/block/qcow2.h
index 7ce2c23..168ab59 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -748,6 +748,8 @@ int qcow2_cache_destroy(Qcow2Cache *c);
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
+int qcow2_cache_l2_write_entry(BlockDriverState *bs, Qcow2Cache *c,
+                               void *table, int index, int num);
 int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
-- 
1.8.3.1


