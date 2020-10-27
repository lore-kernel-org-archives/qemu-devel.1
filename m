Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77652C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B919920756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPb+IBGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B919920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUPk-0000of-GR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIg-0000qm-Ob
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIe-0001IR-Ii
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0XR/4o4qTngLot4S7dyPq/9b1QLApg4R7DOcp/mYcA=;
 b=MPb+IBGocUsM6zDoy6Ro5f1fq6xgR8rKsr11A7Zk8hACJG6aCVV1RZ6b8WKXWAUBu1JMsf
 CySl/aCKGRolf336FGosNVw3TTIeqRphcKFyNIUFnoyzcRpdhA/HogcYm64zIdG5gV3rrz
 DedQ/oE9Av2F6NUBv74YDVD3abAfk0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-xakDI3a9NpKiifpYCFcQlg-1; Tue, 27 Oct 2020 15:06:25 -0400
X-MC-Unique: xakDI3a9NpKiifpYCFcQlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB4C1107ACF5;
 Tue, 27 Oct 2020 19:06:23 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD4F55760;
 Tue, 27 Oct 2020 19:06:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 04/20] fuse: Allow growable exports
Date: Tue, 27 Oct 2020 20:05:44 +0100
Message-Id: <20201027190600.192171-5-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will behave more like normal files in that writes beyond the EOF
will automatically grow the export size.

As an optimization, keep the RESIZE permission for growable exports so
we do not have to take it for every post-EOF write.  (This permission is
not released when the export is destroyed, because at that point the
BlockBackend is destroyed altogether anyway.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json |  6 +++++-
 block/export/fuse.c    | 44 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index aecf052c07..140ba0d221 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -112,10 +112,14 @@
 # @mountpoint: Path on which to export the block device via FUSE.
 #              This must point to an existing regular file.
 #
+# @growable: Whether writes beyond the EOF should grow the block node
+#            accordingly. (default: false)
+#
 # Since: 6.0
 ##
 { 'struct': 'BlockExportOptionsFuse',
-  'data': { 'mountpoint': 'str' },
+  'data': { 'mountpoint': 'str',
+            '*growable': 'bool' },
   'if': 'defined(CONFIG_FUSE)' }
 
 ##
diff --git a/block/export/fuse.c b/block/export/fuse.c
index d995829ab7..92d2f50bcc 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,6 +45,7 @@ typedef struct FuseExport {
 
     char *mountpoint;
     bool writable;
+    bool growable;
 } FuseExport;
 
 static GHashTable *exports;
@@ -72,6 +73,19 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
 
+    /* For growable exports, take the RESIZE permission */
+    if (args->growable) {
+        uint64_t blk_perm, blk_shared_perm;
+
+        blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
+
+        ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
+                           blk_shared_perm, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     init_exports_table();
 
     /*
@@ -102,6 +116,7 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     exp->mountpoint = g_strdup(args->mountpoint);
     exp->writable = blk_exp_args->writable;
+    exp->growable = args->growable;
 
     ret = setup_fuse_export(exp, args->mountpoint, errp);
     if (ret < 0) {
@@ -349,19 +364,24 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
         truncate_flags |= BDRV_REQ_ZERO_WRITE;
     }
 
-    blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
+    /* Growable exports have a permanent RESIZE permission */
+    if (!exp->growable) {
+        blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
 
-    ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
-                       blk_shared_perm, NULL);
-    if (ret < 0) {
-        return ret;
+        ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
+                           blk_shared_perm, NULL);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     ret = blk_truncate(exp->common.blk, size, true, prealloc,
                        truncate_flags, NULL);
 
-    /* Must succeed, because we are only giving up the RESIZE permission */
-    blk_set_perm(exp->common.blk, blk_perm, blk_shared_perm, &error_abort);
+    if (!exp->growable) {
+        /* Must succeed, because we are only giving up the RESIZE permission */
+        blk_set_perm(exp->common.blk, blk_perm, blk_shared_perm, &error_abort);
+    }
 
     return ret;
 }
@@ -482,7 +502,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
     }
 
     if (offset + size > length) {
-        size = length - offset;
+        if (exp->growable) {
+            ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        } else {
+            size = length - offset;
+        }
     }
 
     ret = blk_pwrite(exp->common.blk, offset, buf, size, 0);
-- 
2.26.2


