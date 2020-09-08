Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E80C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3E3221EB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kOTxDxGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3E3221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeJg-0003b9-Ev
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ2-0002dN-AH; Tue, 08 Sep 2020 10:09:08 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:33999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ0-0004GO-2r; Tue, 08 Sep 2020 10:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=u1m/mSOLdg7HxpcPkRNiNHp4pI0tAcGiOy1arYe4X8I=; 
 b=kOTxDxGJ/GR3kt8PxyaEAVmCmQwcbr1P9EjzEDJyhjVkmCudZ0Gb9tY8jbyFfcH8rSdCVsjxTHRbhY9IumXStv1vSKX5YhbH4uV48HjJFi5rZbpf970ATssFMIsYmS0ZKjz+W5kUGPPlC2ALLTq6vi3phJ9zRLawcQugBLdlaek6bdSKmGnZ7hDrlHl3VCk0MGk6adTASG/mJ5vDuaXIoC4wzf6PSh+BJUmsukTPGfIQvOFZI4mWpjt38Ws6oIxblncI3SaQutAt31tzOmIFwO5cmRP3MgMriIkIFd+mHLUpk2BMBNZXcMD/5OzZMhS90lmIeq3RDZvezNqg07QmyQ==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kFeId-0007AL-Gj; Tue, 08 Sep 2020 16:08:43 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kFeIQ-0001zO-RK; Tue, 08 Sep 2020 16:08:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qcow2: Handle QCowL2Meta on error in preallocate_co()
Date: Tue,  8 Sep 2020 16:08:27 +0200
Message-Id: <cd3a6b9abd43f9c0b60be413d760f0cacc67eb66.1599573989.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599573989.git.berto@igalia.com>
References: <cover.1599573989.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 10:08:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If qcow2_alloc_cluster_offset() or qcow2_alloc_cluster_link_l2() fail
then this function simply returns the error code, potentially leaking
the QCowL2Meta structure and leaving stale items in s->cluster_allocs.

A second problem is that this function calls qcow2_free_any_clusters()
on failure but passing a host cluster offset instead of an L2 entry.
Luckily for normal uncompressed clusters a raw offset also works like
a valid L2 entry so it works just the same, but we should be using
qcow2_free_clusters() instead.

This patch fixes both problems by using qcow2_handle_l2meta().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index da56b1a4df..eeb125c697 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2102,7 +2102,6 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
         QCowL2Meta *next;
 
         if (link_l2) {
-            assert(!l2meta->prealloc);
             ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
@@ -3126,7 +3125,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
     int64_t file_length;
     unsigned int cur_bytes;
     int ret;
-    QCowL2Meta *meta;
+    QCowL2Meta *meta = NULL, *m;
 
     assert(offset <= new_length);
     bytes = new_length - offset;
@@ -3137,27 +3136,17 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
                                          &host_offset, &meta);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Allocating clusters failed");
-            return ret;
+            goto out;
         }
 
-        while (meta) {
-            QCowL2Meta *next = meta->next;
-            meta->prealloc = true;
-
-            ret = qcow2_alloc_cluster_link_l2(bs, meta);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret, "Mapping clusters failed");
-                qcow2_free_any_clusters(bs, meta->alloc_offset,
-                                        meta->nb_clusters, QCOW2_DISCARD_NEVER);
-                return ret;
-            }
-
-            /* There are no dependent requests, but we need to remove our
-             * request from the list of in-flight requests */
-            QLIST_REMOVE(meta, next_in_flight);
+        for (m = meta; m != NULL; m = m->next) {
+            m->prealloc = true;
+        }
 
-            g_free(meta);
-            meta = next;
+        ret = qcow2_handle_l2meta(bs, &meta, true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Mapping clusters failed");
+            goto out;
         }
 
         /* TODO Preallocate data if requested */
@@ -3174,7 +3163,8 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
     file_length = bdrv_getlength(s->data_file->bs);
     if (file_length < 0) {
         error_setg_errno(errp, -file_length, "Could not get file size");
-        return file_length;
+        ret = file_length;
+        goto out;
     }
 
     if (host_offset + cur_bytes > file_length) {
@@ -3184,11 +3174,15 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
         ret = bdrv_co_truncate(s->data_file, host_offset + cur_bytes, false,
                                mode, 0, errp);
         if (ret < 0) {
-            return ret;
+            goto out;
         }
     }
 
-    return 0;
+    ret = 0;
+
+out:
+    qcow2_handle_l2meta(bs, &meta, false);
+    return ret;
 }
 
 /* qcow2_refcount_metadata_size:
-- 
2.20.1


