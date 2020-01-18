Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6DC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C6F2468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aQI480eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C6F2468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istVm-0003Ne-9s
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1istTs-0001SK-CZ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1istTr-0004OT-74
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:00 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:48325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1istTq-0004N3-J2; Sat, 18 Jan 2020 14:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=bb2ZOgFSlgK1sgntakipNlk6DfTQcGMMCLiGx3ZcCbM=; 
 b=aQI480eK1SD/LfIRjHtbIeLn89genUdPEO+1XHFdru9yY7J56vSdGNYPY2g1YGdrwXCDAwDr+E2RF3oKSSxJ3E9ZYyT5kqmeF1aQagZ0o89X8Q6PmOvT/CrI/It/kLxj3fsP3Ufu4anQtKXSOSp5yqlGQKpeWxeCTKIqRLHTLo8ZEiEqNyODr7OQpHxgt+PRdjSxmrALqdq5Ofyd+V1xscZvOKIbt7lqBl2c3ZqQNSOepR5dk3I3mZ2B73gZo8I/mose1w5UybuvdRbeBsUCIFkmhIbfXq40waRUOQ9CCaFG0o2CpFOdZZkmZQ8Em+oqdlqZBBLldi2OYtiI+TSeTQ==;
Received: from [80.30.177.7] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1istTn-00065B-CI; Sat, 18 Jan 2020 20:09:55 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1istTW-0002JZ-R2; Sat, 18 Jan 2020 20:09:38 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] qcow2: Use bs->bl.request_alignment when updating an
 L1 entry
Date: Sat, 18 Jan 2020 20:09:28 +0100
Message-Id: <71f34d4ae4b367b32fb36134acbf4f4f7ee681f4.1579374329.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1579374329.git.berto@igalia.com>
References: <cover.1579374329.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When updating an L1 entry the qcow2 driver writes a (512-byte) sector
worth of data to avoid a read-modify-write cycle. Instead of always
writing 512 bytes we should follow the alignment requirements of the
storage backend.

(the only exception is when the alignment is larger than the cluster
size because then we could be overwriting data after the L1 table)

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 932fc48919..f1b5535b04 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -216,26 +216,31 @@ static int l2_load(BlockDriverState *bs, uint64_t offset,
 }
 
 /*
- * Writes one sector of the L1 table to the disk (can't update single entries
- * and we really don't want bdrv_pread to perform a read-modify-write)
+ * Writes an L1 entry to disk (note that depending on the alignment
+ * requirements this function may write more that just one entry in
+ * order to prevent bdrv_pwrite from performing a read-modify-write)
  */
-#define L1_ENTRIES_PER_SECTOR (512 / 8)
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t buf[L1_ENTRIES_PER_SECTOR] = { 0 };
     int l1_start_index;
     int i, ret;
+    int bufsize = MAX(sizeof(uint64_t),
+                      MIN(bs->file->bs->bl.request_alignment, s->cluster_size));
+    int nentries = bufsize / sizeof(uint64_t);
+    g_autofree uint64_t *buf = g_try_new0(uint64_t, nentries);
 
-    l1_start_index = l1_index & ~(L1_ENTRIES_PER_SECTOR - 1);
-    for (i = 0; i < L1_ENTRIES_PER_SECTOR && l1_start_index + i < s->l1_size;
-         i++)
-    {
+    if (buf == NULL) {
+        return -ENOMEM;
+    }
+
+    l1_start_index = QEMU_ALIGN_DOWN(l1_index, nentries);
+    for (i = 0; i < MIN(nentries, s->l1_size - l1_start_index); i++) {
         buf[i] = cpu_to_be64(s->l1_table[l1_start_index + i]);
     }
 
     ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L1,
-            s->l1_table_offset + 8 * l1_start_index, sizeof(buf), false);
+            s->l1_table_offset + 8 * l1_start_index, bufsize, false);
     if (ret < 0) {
         return ret;
     }
@@ -243,7 +248,7 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
     BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
     ret = bdrv_pwrite_sync(bs->file,
                            s->l1_table_offset + 8 * l1_start_index,
-                           buf, sizeof(buf));
+                           buf, bufsize);
     if (ret < 0) {
         return ret;
     }
-- 
2.20.1


