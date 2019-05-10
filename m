Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF03DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538E221479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q0C7xZDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538E221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8Vq-0006XK-JC
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:36:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hP8JA-0003TE-Jd
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hP8J9-0007J5-GI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:23:40 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:46149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hP8J8-0006yM-Tq; Fri, 10 May 2019 12:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Message-Id:Date:Subject:Cc:To:From;
	bh=91sFCodM9pLXbNdaRNQnNcfrAYNV5Ra/NXos9gA7MJE=; 
	b=q0C7xZDt2tMX7nyt/CAEGL50fysltZxnDz7DLJkNailv4sxtr8AxleZpNDMISS7qf3uNsH6DNEoUWgypbP7F+7kzTBvJNX+IbQZOizBcUvGmNtE4wTKcTMnBsMdIZqkELIWQB0RSR58vWWAEnNVbpAHeXYVhA6hyFEG/XjaFWrECMLZb+s4dXzTwiYgGIh/aulRbqK6N4jl7u+2xfAragVkgtrB0j4spb4ovL+VZCgitLeQej50wTjkeY5kf3VVYFvt8zqYdyV5pTPXSl8voIN//RsupOUOQEYMd3gyxkcHjfGO4V+W5rf8P3mMFLHR8tCLIREaz5k7/fPD/fTJ1DA==;
Received: from 87-92-6-174.bb.dnainternet.fi ([87.92.6.174] helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hP8Ip-0001p6-Kk; Fri, 10 May 2019 18:23:19 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hP8Ia-00028G-T9; Fri, 10 May 2019 19:23:04 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 19:22:54 +0300
Message-Id: <20190510162254.8152-1-berto@igalia.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH] qcow2: Define and use
 QCOW2_COMPRESSED_SECTOR_SIZE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When an L2 table entry points to a compressed cluster the space used
by the data is specified in 512-byte sectors. This size is independent
from BDRV_SECTOR_SIZE and is specific to the qcow2 file format.

The QCOW2_COMPRESSED_SECTOR_SIZE constant defined in this patch makes
this explicit.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c  |  5 +++--
 block/qcow2-refcount.c | 25 ++++++++++++++-----------
 block/qcow2.c          |  3 ++-
 block/qcow2.h          |  4 ++++
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 974a4e8656..b36f4aa84a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -796,8 +796,9 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
         return cluster_offset;
     }
 
-    nb_csectors = ((cluster_offset + compressed_size - 1) >> 9) -
-                  (cluster_offset >> 9);
+    nb_csectors =
+        (cluster_offset + compressed_size - 1) / QCOW2_COMPRESSED_SECTOR_SIZE -
+        (cluster_offset / QCOW2_COMPRESSED_SECTOR_SIZE);
 
     cluster_offset |= QCOW_OFLAG_COMPRESSED |
                       ((uint64_t)nb_csectors << s->csize_shift);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index fa7ac1f7cb..780bd49a00 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1172,12 +1172,11 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
     switch (ctype) {
     case QCOW2_CLUSTER_COMPRESSED:
         {
-            int nb_csectors;
-            nb_csectors = ((l2_entry >> s->csize_shift) &
-                           s->csize_mask) + 1;
-            qcow2_free_clusters(bs,
-                (l2_entry & s->cluster_offset_mask) & ~511,
-                nb_csectors * 512, type);
+            int64_t offset = (l2_entry & s->cluster_offset_mask)
+                & QCOW2_COMPRESSED_SECTOR_MASK;
+            int size = QCOW2_COMPRESSED_SECTOR_SIZE *
+                (((l2_entry >> s->csize_shift) & s->csize_mask) + 1);
+            qcow2_free_clusters(bs, offset, size, type);
         }
         break;
     case QCOW2_CLUSTER_NORMAL:
@@ -1317,9 +1316,12 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                         nb_csectors = ((entry >> s->csize_shift) &
                                        s->csize_mask) + 1;
                         if (addend != 0) {
+                            uint64_t coffset = (entry & s->cluster_offset_mask)
+                                & QCOW2_COMPRESSED_SECTOR_MASK;
                             ret = update_refcount(
-                                bs, (entry & s->cluster_offset_mask) & ~511,
-                                nb_csectors * 512, abs(addend), addend < 0,
+                                bs, coffset,
+                                nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE,
+                                abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
                             if (ret < 0) {
                                 goto fail;
@@ -1635,9 +1637,10 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             nb_csectors = ((l2_entry >> s->csize_shift) &
                            s->csize_mask) + 1;
             l2_entry &= s->cluster_offset_mask;
-            ret = qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_table_size,
-                                           l2_entry & ~511, nb_csectors * 512);
+            ret = qcow2_inc_refcounts_imrt(
+                bs, res, refcount_table, refcount_table_size,
+                l2_entry & QCOW2_COMPRESSED_SECTOR_MASK,
+                nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE);
             if (ret < 0) {
                 goto fail;
             }
diff --git a/block/qcow2.c b/block/qcow2.c
index a520d116ef..80679a84d2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4188,7 +4188,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
 
     coffset = file_cluster_offset & s->cluster_offset_mask;
     nb_csectors = ((file_cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
-    csize = nb_csectors * 512 - (coffset & 511);
+    csize = nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE -
+        (coffset & ~QCOW2_COMPRESSED_SECTOR_MASK);
 
     buf = g_try_malloc(csize);
     if (!buf) {
diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..7e796877d6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,6 +74,10 @@
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
+/* Defined in the qcow2 spec (compressed cluster descriptor) */
+#define QCOW2_COMPRESSED_SECTOR_SIZE 512U
+#define QCOW2_COMPRESSED_SECTOR_MASK (~(QCOW2_COMPRESSED_SECTOR_SIZE - 1))
+
 /* Must be at least 2 to cover COW */
 #define MIN_L2_CACHE_SIZE 2 /* cache entries */
 
-- 
2.11.0


