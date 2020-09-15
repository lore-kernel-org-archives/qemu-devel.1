Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E2FC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE1A21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SS637634"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE1A21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8m4-00089X-Cn
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UO-0000tA-O0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UM-0004dB-VL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSgvq6swWaOeoMm7noo48t3BlK9H+HlOXThylQ/P9wg=;
 b=SS637634MTSgrxtT/07G2mNuM6vjZTMKmQZEW7aEJXtncdq8vl3YxmeoLzz0cKpm8beViL
 BpVtkDzNkEVkDMnEoc+Tct3pe+gza3Lz7IN6XNIitZ13FRcNEiIOV1PrfqOrK8TBXpbu/C
 9OBP1NaLI5ZB+TZ8msm6YTSQCxEraBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-k3N2VNm1NEyosckPjGS5BA-1; Tue, 15 Sep 2020 06:47:04 -0400
X-MC-Unique: k3N2VNm1NEyosckPjGS5BA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F0AB801AC2;
 Tue, 15 Sep 2020 10:47:03 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF0610021AA;
 Tue, 15 Sep 2020 10:47:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/22] qcow2: Handle QCowL2Meta on error in preallocate_co()
Date: Tue, 15 Sep 2020 12:46:20 +0200
Message-Id: <20200915104627.699552-16-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Message-Id: <cd3a6b9abd43f9c0b60be413d760f0cacc67eb66.1599573989.git.berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3e8114dcf8..d241fb734c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2101,7 +2101,6 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
         QCowL2Meta *next;
 
         if (link_l2) {
-            assert(!l2meta->prealloc);
             ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
@@ -3123,7 +3122,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
     int64_t file_length;
     unsigned int cur_bytes;
     int ret;
-    QCowL2Meta *meta;
+    QCowL2Meta *meta = NULL, *m;
 
     assert(offset <= new_length);
     bytes = new_length - offset;
@@ -3134,27 +3133,17 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
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
@@ -3171,7 +3160,8 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
     file_length = bdrv_getlength(s->data_file->bs);
     if (file_length < 0) {
         error_setg_errno(errp, -file_length, "Could not get file size");
-        return file_length;
+        ret = file_length;
+        goto out;
     }
 
     if (host_offset + cur_bytes > file_length) {
@@ -3181,11 +3171,15 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
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
2.26.2


