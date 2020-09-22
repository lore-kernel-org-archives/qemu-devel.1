Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345DC208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRE5wpBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345DC208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfxw-0007nW-4S
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs3-0000Dy-Nl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs1-0000Ti-Ij
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVZyCNs/Dn0aSo/qEbqYorUsU/1QreNRX/oTOcK5AQk=;
 b=eRE5wpBEKxEDPHuW3LoQ8ByjutWE9KSm5/jpbNCdHiMFdce6zgG6eVZUqyJqw+pcZmcmBh
 dAntEocAZwGnj6Fx4igTa+PSnEVp7dnrQjumm7EwVWKFX8c8hZs/GgD22fhfWZh568nGNo
 f1Qy70UYZihzBgVc5D6SrdS9J/0SGxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-sJggnF1eNhqqQOVP0JdP9w-1; Tue, 22 Sep 2020 06:49:58 -0400
X-MC-Unique: sJggnF1eNhqqQOVP0JdP9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC358030C7;
 Tue, 22 Sep 2020 10:49:57 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 552BD73682;
 Tue, 22 Sep 2020 10:49:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/20] fuse: (Partially) implement fallocate()
Date: Tue, 22 Sep 2020 12:49:17 +0200
Message-Id: <20200922104932.46384-6-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:27:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows allocating areas after the (old) EOF as part of a growing
resize, writing zeroes, and discarding.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/export/fuse.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f3a84579ba..7dfb4eb280 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -457,6 +457,84 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
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
+            length -= size;
+        } while (ret == 0 && length > 0);
+    } else if (mode & FALLOC_FL_ZERO_RANGE) {
+        if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + length > blk_len) {
+            ret = fuse_do_truncate(exp, offset + length, PREALLOC_MODE_OFF);
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
+            ret = fuse_do_truncate(exp, offset, PREALLOC_MODE_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        }
+
+        ret = fuse_do_truncate(exp, offset + length, PREALLOC_MODE_FALLOC);
+    } else {
+        ret = -EOPNOTSUPP;
+    }
+
+    fuse_reply_err(req, ret < 0 ? -ret : 0);
+}
+
 /**
  * Let clients flush the exported image.
  */
@@ -477,6 +555,7 @@ static const struct fuse_lowlevel_ops fuse_ops = {
     .open       = fuse_open,
     .read       = fuse_read,
     .write      = fuse_write,
+    .fallocate  = fuse_fallocate,
     .flush      = fuse_flush,
 };
 
-- 
2.26.2


