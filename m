Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846E32080C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="TfqU/QpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846E32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5q5e-00031m-OW
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dd8151f4fed6ee078a33cff4caa9ac5c558940ef@lizzy.crudebyte.com>)
 id 1k5q4j-0001em-FH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:41:50 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:32807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <dd8151f4fed6ee078a33cff4caa9ac5c558940ef@lizzy.crudebyte.com>)
 id 1k5q4i-00058D-26
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=T2J09mvUFLK9pfie0B4k4vjsxQngaipbuBkNxzJ0X1s=; b=TfqU/
 QpGgsPzQ0uyYVpv7BW4VdRHZIN4jCvRDFkrTVyZOA8mqUpuSEDoanDgfWRVL69xcDEOzluhBHDNwk
 De/m1f4xNvCsf7EPhCgHPhu4Hr80J8bRgX8r8prHV82RovzderNVZ1HAT4UUiBIgrsoJFZURmJlXA
 bG2q3ee0Db707R2a+cH0KzUUTb89TmxlAVS6IpebjSA2x5VPLrt+H3WxjbHYqVkRnBt1yOqPj82k2
 OyUJ8Kun57o22BztzP7LhCf9MpExTqh91leKpy7R5sfj1NbZLjEHf7M4SOwLvbgMB1g7hLx/cmSE+
 o0049fS2SotP6FPNAW2yYnDXvE5pQ==;
Message-Id: <dd8151f4fed6ee078a33cff4caa9ac5c558940ef.1597226797.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1597226797.git.qemu_oss@crudebyte.com>
References: <cover.1597226797.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 29 Jul 2020 10:11:54 +0200
Subject: [PULL 3/7] 9pfs: split out fs driver core of v9fs_co_readdir()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=dd8151f4fed6ee078a33cff4caa9ac5c558940ef@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 08:16:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The implementation of v9fs_co_readdir() has two parts: the outer
part is executed by main I/O thread, whereas the inner part is
executed by fs driver on a background I/O thread.

Move the inner part to its own new, private function do_readdir(),
so it can be shared by another upcoming new function.

This is just a preparatory patch for the subsequent patch, with the
purpose to avoid the next patch to clutter the overall diff.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4.1596012787.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/codir.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 73f9a751e1..24e1955ab2 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -18,28 +18,38 @@
 #include "qemu/main-loop.h"
 #include "coth.h"
 
+/*
+ * Intended to be called from bottom-half (e.g. background I/O thread)
+ * context.
+ */
+static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent **dent)
+{
+    int err = 0;
+    V9fsState *s = pdu->s;
+    struct dirent *entry;
+
+    errno = 0;
+    entry = s->ops->readdir(&s->ctx, &fidp->fs);
+    if (!entry && errno) {
+        *dent = NULL;
+        err = -errno;
+    } else {
+        *dent = entry;
+    }
+    return err;
+}
+
 int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
                                  struct dirent **dent)
 {
     int err;
-    V9fsState *s = pdu->s;
 
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
-    v9fs_co_run_in_worker(
-        {
-            struct dirent *entry;
-
-            errno = 0;
-            entry = s->ops->readdir(&s->ctx, &fidp->fs);
-            if (!entry && errno) {
-                err = -errno;
-            } else {
-                *dent = entry;
-                err = 0;
-            }
-        });
+    v9fs_co_run_in_worker({
+        err = do_readdir(pdu, fidp, dent);
+    });
     return err;
 }
 
-- 
2.20.1


