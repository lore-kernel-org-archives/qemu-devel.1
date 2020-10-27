Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315D320756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMGb2Yc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315D320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXURx-0004qE-71
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIq-0000wb-KH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIm-0001KB-Lv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ku0lgbB4RTZzSq32fKoEbGJ5/3lU/JOWUDW9gngGOwo=;
 b=RMGb2Yc5ptfYP9+uzBnceqpDt6z+nhbbOtmzyevmGfr93MYEZP1mBM5vlLQ1ItZUbEfOBf
 6KVeICUm/+ZAP1QUL1PSIKGEqjihlXO7QMSyx+m3jMkWk49TKkJKG7kTbhLJzKGzTGTpVr
 5n2hB20iPWEVxUa2LvTm9af7y+U95c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-fNqEPtLeNg2AYOp8_ypsmg-1; Tue, 27 Oct 2020 15:06:31 -0400
X-MC-Unique: fNqEPtLeNg2AYOp8_ypsmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F7257008;
 Tue, 27 Oct 2020 19:06:29 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7FA5C1BB;
 Tue, 27 Oct 2020 19:06:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 05/20] fuse: (Partially) implement fallocate()
Date: Tue, 27 Oct 2020 20:05:45 +0100
Message-Id: <20201027190600.192171-6-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

This allows allocating areas after the (old) EOF as part of a growing
resize, writing zeroes, and discarding.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/export/fuse.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 92d2f50bcc..0b9d226b2f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -521,6 +521,89 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
     }
 }
 
+/**
+ * Let clients perform various fallocate() operations.
+ */
+static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
+                           off_t offset, off_t length,
+                           struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    int64_t blk_len;
+    int ret;
+
+    if (!exp->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
+        return;
+    }
+
+    if (mode & FALLOC_FL_KEEP_SIZE) {
+        length = MIN(length, blk_len - offset);
+    }
+
+    if (mode & FALLOC_FL_PUNCH_HOLE) {
+        if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+
+        do {
+            int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
+
+            ret = blk_pdiscard(exp->common.blk, offset, size);
+            offset += size;
+            length -= size;
+        } while (ret == 0 && length > 0);
+    } else if (mode & FALLOC_FL_ZERO_RANGE) {
+        if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + length > blk_len) {
+            /* No need for zeroes, we are going to write them ourselves */
+            ret = fuse_do_truncate(exp, offset + length, false,
+                                   PREALLOC_MODE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        }
+
+        do {
+            int size = MIN(length, BDRV_REQUEST_MAX_BYTES);
+
+            ret = blk_pwrite_zeroes(exp->common.blk,
+                                    offset, size, 0);
+            offset += size;
+            length -= size;
+        } while (ret == 0 && length > 0);
+    } else if (!mode) {
+        /* We can only fallocate at the EOF with a truncate */
+        if (offset < blk_len) {
+            fuse_reply_err(req, EOPNOTSUPP);
+            return;
+        }
+
+        if (offset > blk_len) {
+            /* No preallocation needed here */
+            ret = fuse_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        }
+
+        ret = fuse_do_truncate(exp, offset + length, true,
+                               PREALLOC_MODE_FALLOC);
+    } else {
+        ret = -EOPNOTSUPP;
+    }
+
+    fuse_reply_err(req, ret < 0 ? -ret : 0);
+}
+
 /**
  * Let clients fsync the exported image.
  */
@@ -552,6 +635,7 @@ static const struct fuse_lowlevel_ops fuse_ops = {
     .open       = fuse_open,
     .read       = fuse_read,
     .write      = fuse_write,
+    .fallocate  = fuse_fallocate,
     .flush      = fuse_flush,
     .fsync      = fuse_fsync,
 };
-- 
2.26.2


