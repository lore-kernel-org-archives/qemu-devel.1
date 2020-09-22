Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B959C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A875D2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMGn3XLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A875D2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfvY-0004iz-UE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs2-0000BB-Mo
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfrz-0000TE-Kl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhZVKFSwmuAzcH2/U49rQXlAOhCA8MgG3ekspSBU1Lw=;
 b=gMGn3XLIpw2JzJ+mD2QTXNNQqk3iD5nMp1/7ngwIBTXspH1e6jHaNY271nf+eSSfpAqOWZ
 jPlx1dk5baQMaBejyFa+39KmDu9wFKBuRDrDWSuydwHHZ4n3beDd6vcIMGRmmZv/4VwSUY
 U51Z8fnEQQZOFkq1DhK0f/i+yKhX6EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-obQtaXCZPXyv3nJPYBNaig-1; Tue, 22 Sep 2020 06:49:53 -0400
X-MC-Unique: obQtaXCZPXyv3nJPYBNaig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80AD580EF8B;
 Tue, 22 Sep 2020 10:49:52 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D6825C1DC;
 Tue, 22 Sep 2020 10:49:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 04/20] fuse: Allow growable exports
Date: Tue, 22 Sep 2020 12:49:16 +0200
Message-Id: <20200922104932.46384-5-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json |  6 +++++-
 block/export/fuse.c    | 12 +++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index cb5bd54cbf..cb26daa98b 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -183,10 +183,14 @@
 # @mountpoint: Path on which to export the block device via FUSE.
 #              This must point to an existing regular file.
 #
+# @growable: Whether writes beyond the EOF should grow the block node
+#            accordingly. (default: false)
+#
 # Since: 5.2
 ##
 { 'struct': 'BlockExportOptionsFuse',
-  'data': { 'mountpoint': 'str' },
+  'data': { 'mountpoint': 'str',
+            '*growable': 'bool' },
   'if': 'defined(CONFIG_FUSE)' }
 
 ##
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 8fc667231d..f3a84579ba 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,6 +45,7 @@ typedef struct FuseExport {
 
     char *mountpoint;
     bool writable;
+    bool growable;
 } FuseExport;
 
 static GHashTable *exports;
@@ -101,6 +102,7 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     exp->mountpoint = g_strdup(args->mountpoint);
     exp->writable = blk_exp_args->writable;
+    exp->growable = args->growable;
 
     ret = setup_fuse_export(exp, args->mountpoint, errp);
     if (ret < 0) {
@@ -436,7 +438,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 
     size = MIN(size, BDRV_REQUEST_MAX_BYTES);
     if (offset + size > length) {
-        size = length - offset;
+        if (exp->growable) {
+            ret = fuse_do_truncate(exp, offset + size, PREALLOC_MODE_OFF);
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


