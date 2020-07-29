Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38872C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D22206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PypMtBZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D22206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0imy-0006O2-A6
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4@lizzy.crudebyte.com>)
 id 1k0imC-0005my-2d
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:53:32 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4@lizzy.crudebyte.com>)
 id 1k0imA-0005XD-Fy
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7YfBaX+4mZIaB/1KGeVpeZ5wEcuMfcWwYHidz6lYcoU=; b=PypMt
 BZVlA48zbxiit1W8HI/R8ejsFU+1+8JnKYJOggcND1eroxKdTvpFiGsqtExMFTSvTdIoLAaXNaM4P
 qj6x6xbV4Z3xs4OGgWwR7pGXmwvvapigjfIoELoo+Bvrv27mXYJu5QwywK7ctA5OfolIomtaba/7N
 EZmK6PJKF4BaDiF9kJSbA3ayNHRiLDKZx//E5T4CHS6RFykz7zSim5QNNmYgeuH0URl2IBZNbnhyL
 G1KawCLL8FjNpJYXsTVhtBUE5AEMHqOztuyJ5zYcBgKnUlhtlTzNjUxFMhsUkXAnPo390+1mrZbcC
 kg9SjsNNW/mWAM5HYFLAjumgfeZzg==;
Message-Id: <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4.1596012787.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1596012787.git.qemu_oss@crudebyte.com>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 29 Jul 2020 10:11:54 +0200
Subject: [PATCH v8 3/7] 9pfs: split out fs driver core of v9fs_co_readdir()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=a426ee06e77584fa2d8253ce5d8bea519eb3ffd4@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 05:20:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
---
 hw/9pfs/codir.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 73f9a751e1..ff57fb8619 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -18,28 +18,37 @@
 #include "qemu/main-loop.h"
 #include "coth.h"
 
+/*
+ * This must solely be executed on a background IO thread.
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


