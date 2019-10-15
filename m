Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F9ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E4120640
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MfEfjXlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4120640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOir-0005Em-MX
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOgy-0002kr-6c
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOgw-0003fg-RR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:24:55 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOgw-0003Z6-5D; Tue, 15 Oct 2019 11:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=a2mTbc627t9UKAi10n490pisgpIRFjrG/m1w0Nm1L2I=; 
 b=MfEfjXlk7SUEXfgQX2te6J+ZkpdLniViBoDUFRzqQonB0r8i4ukvk/n6M6pkp/yKdtHS5oahVcLwRZRHAH1vGVDDuxlyaJdAxthVrfLOJD3sGrvtJjTy4V1f1zGFMnNZtGjTP22kknFHx9SB3mYQiCtgiEf13oi4qUtWjb9K5tyfPHBr30NryQzeBh2Zhu3hNT4yBSDCulSQ7onEB0oE9V+q1PyYFrH6YSZxMU25Mq30ap6l5HUz3lpsLfpDA6UDlPJ3RoRYyM4Q5kJc4HCtvle/mQNEGOYD3HBNpjrpmORfqtGuOG/EgM6hWn2VS+vkPOVW+jrM6ShMhIhS0wNPkg==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003aZ-2Q; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfm-00061X-Sl; Tue, 15 Oct 2019 18:23:42 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/23] qcow2: Handle QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
Date: Tue, 15 Oct 2019 18:23:23 +0300
Message-Id: <29a81b7a903d90e3a2f1a2758514fa7b2723fcf2.1571152571.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1571152571.git.berto@igalia.com>
References: <cover.1571152571.git.berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the previous patch we added a new QCow2ClusterType named
QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER. There is a couple of places
where this new value needs to be handled, and that is what this patch
does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 131711d6fa..c222cd261d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1922,8 +1922,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     *pnum = bytes;
 
-    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
-        !s->crypto) {
+    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC ||
+         ret == QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER) && !s->crypto) {
         index_in_cluster = offset & (s->cluster_size - 1);
         *map = cluster_offset | index_in_cluster;
         *file = s->data_file->bs;
@@ -1931,7 +1931,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
     if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
+    } else if (ret != QCOW2_CLUSTER_UNALLOCATED &&
+               ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2009,6 +2010,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
 
             if (bs->backing) {
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -3542,6 +3544,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
+            ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER &&
             ret != QCOW2_CLUSTER_ZERO_PLAIN &&
             ret != QCOW2_CLUSTER_ZERO_ALLOC) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3612,6 +3615,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


