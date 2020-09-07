Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22194C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A724A206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHf8jFRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A724A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFIu-0004rq-OB
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2o-0003MC-3R
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2l-00087S-GJ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aomdJkI3iNBSOHLuc6nXrw+y3YhAzv1KhORYIK1TjdM=;
 b=HHf8jFRlGORrgxV3/IZqKB68EzANd+tXRG3xrEyK0p+pPyDYMHl9afQ+tIa7mnIydyN4zH
 +WtzlFGDPSRQHhC6VIZfV5p8yaD9fEcEirdcMTUjJBrd6repc/H4zDfLU9kSySX6fn1wMM
 LK/mtmHswobP5/YPGPEkr1ho86lvLO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ZxSbiomyO4Owykt-WltaRA-1; Mon, 07 Sep 2020 07:10:36 -0400
X-MC-Unique: ZxSbiomyO4Owykt-WltaRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B96080EDA6;
 Mon,  7 Sep 2020 11:10:35 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 668FA9CBA;
 Mon,  7 Sep 2020 11:10:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 39/64] block: Improve get_allocated_file_size's default
Date: Mon,  7 Sep 2020 13:09:11 +0200
Message-Id: <20200907110936.261684-40-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

There are two practical problems with bdrv_get_allocated_file_size()'s
default right now:
(1) For drivers with children, we should generally sum all their sizes
    instead of just passing the request through to bs->file.  The latter
    is good for filters, but not so much for format drivers.

(2) Filters need not have bs->file, so we should actually go to the
    filtered child instead of hard-coding bs->file.

Fix this by splitting the default implementation into three branches:
(1) For filter drivers: Return the size of the filtered child
(2) For protocol drivers: Return -ENOTSUP, because the default
    implementation cannot make a guess
(3) For other drivers: Sum all data-bearing children's sizes

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index ac4ab07f07..63c7d9b1a7 100644
--- a/block.c
+++ b/block.c
@@ -5005,6 +5005,31 @@ exit:
     return ret;
 }
 
+/**
+ * Implementation of BlockDriver.bdrv_get_allocated_file_size() that
+ * sums the size of all data-bearing children.  (This excludes backing
+ * children.)
+ */
+static int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs)
+{
+    BdrvChild *child;
+    int64_t child_size, sum = 0;
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
+                           BDRV_CHILD_FILTERED))
+        {
+            child_size = bdrv_get_allocated_file_size(child->bs);
+            if (child_size < 0) {
+                return child_size;
+            }
+            sum += child_size;
+        }
+    }
+
+    return sum;
+}
+
 /**
  * Length of a allocated file in bytes. Sparse files are counted by actual
  * allocated space. Return < 0 if error or unknown.
@@ -5018,10 +5043,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
     if (drv->bdrv_get_allocated_file_size) {
         return drv->bdrv_get_allocated_file_size(bs);
     }
-    if (bs->file) {
-        return bdrv_get_allocated_file_size(bs->file->bs);
+
+    if (drv->bdrv_file_open) {
+        /*
+         * Protocol drivers default to -ENOTSUP (most of their data is
+         * not stored in any of their children (if they even have any),
+         * so there is no generic way to figure it out).
+         */
+        return -ENOTSUP;
+    } else if (drv->is_filter) {
+        /* Filter drivers default to the size of their filtered child */
+        return bdrv_get_allocated_file_size(bdrv_filter_bs(bs));
+    } else {
+        /* Other drivers default to summing their children's sizes */
+        return bdrv_sum_allocated_file_size(bs);
     }
-    return -ENOTSUP;
 }
 
 /*
-- 
2.25.4


