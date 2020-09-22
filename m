Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1757D2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDQ6QG5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1757D2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKg0s-0002u8-13
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsA-0000Tt-7N
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfs8-0000Uv-Cf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVqR4YkAYebBr45NHt4mXQykwLwrAbCfW2ZO2xLVLrQ=;
 b=cDQ6QG5FAMDkfL4TFtlcS3ua9Hu6ZfktPi1m4zE9dz9x0K8D2+l3tbf+UR0VNf1+bBc9Z2
 ngNnAhQt3JD9l+MwMxLABldncphuI4mFptZc4Ikpi81QEdU5py5wLIKLVHu77k/rGeKmFc
 VBcM8vGAoFyRG3PI2LJ6mnWhVCyJe50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-DveOHsiVN_a8WCIbUByumA-1; Tue, 22 Sep 2020 06:50:03 -0400
X-MC-Unique: DveOHsiVN_a8WCIbUByumA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D42B11084C80;
 Tue, 22 Sep 2020 10:50:02 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A005178803;
 Tue, 22 Sep 2020 10:49:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 06/20] fuse: Implement hole detection through lseek
Date: Tue, 22 Sep 2020 12:49:18 +0200
Message-Id: <20200922104932.46384-7-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a relatively new feature in libfuse (available since 3.8.0,
which was released in November 2019), so we have to let configure check
whether it is available before making use of it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 configure           | 32 +++++++++++++++++++
 block/export/fuse.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 meson.build         |  1 +
 3 files changed, 110 insertions(+)

diff --git a/configure b/configure
index 21c31e4694..6b9184b62a 100755
--- a/configure
+++ b/configure
@@ -6226,11 +6226,39 @@ EOF
   fuse_libs=$(pkg-config --libs fuse3)
   if compile_prog "$fuse_cflags" "$fuse_libs"; then
     fuse=yes
+
+    cat > $TMPC <<EOF
+#define FUSE_USE_VERSION 31
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
+                       int whence, struct fuse_file_info *fi)
+{
+    if (whence == SEEK_DATA || whence == SEEK_HOLE) {
+        fuse_reply_lseek(req, offset);
+    } else {
+        fuse_reply_err(req, EINVAL);
+    }
+}
+const struct fuse_lowlevel_ops fuse_ops = {
+    .lseek = fuse_lseek,
+};
+int main(void) { return 0; }
+EOF
+    if compile_prog "$fuse_cflags" "$fuse_libs"; then
+      fuse_lseek=yes
+    else
+      fuse_lseek=no
+    fi
   else
     if test "$fuse" = "yes"; then
       feature_not_found "fuse"
     fi
     fuse=no
+    fuse_lseek=no
   fi
 fi
 
@@ -7425,6 +7453,10 @@ if test "$fuse" = "yes"; then
   echo "CONFIG_FUSE=y" >> $config_host_mak
   echo "FUSE_CFLAGS=$fuse_cflags" >> $config_host_mak
   echo "FUSE_LIBS=$fuse_libs" >> $config_host_mak
+
+  if test "$fuse_lseek" = "yes"; then
+    echo "CONFIG_FUSE_LSEEK=y" >> $config_host_mak
+  fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 7dfb4eb280..ee90f5a185 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -548,6 +548,80 @@ static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
     fuse_reply_err(req, ret < 0 ? -ret : 0);
 }
 
+#ifdef CONFIG_FUSE_LSEEK
+/**
+ * Let clients inquire allocation status.
+ */
+static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
+                       int whence, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+
+    if (whence != SEEK_HOLE && whence != SEEK_DATA) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    while (true) {
+        int64_t pnum;
+        int ret;
+
+        ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
+                                      offset, INT64_MAX, &pnum, NULL, NULL);
+        if (ret < 0) {
+            fuse_reply_err(req, -ret);
+            return;
+        }
+
+        if (!pnum && (ret & BDRV_BLOCK_EOF)) {
+            int64_t blk_len;
+
+            /*
+             * If blk_getlength() rounds (e.g. by sectors), then the
+             * export length will be rounded, too.  However,
+             * bdrv_block_status_above() may return EOF at unaligned
+             * offsets.  We must not let this become visible and thus
+             * always simulate a hole between @offset (the real EOF)
+             * and @blk_len (the client-visible EOF).
+             */
+
+            blk_len = blk_getlength(exp->common.blk);
+            if (blk_len < 0) {
+                fuse_reply_err(req, -blk_len);
+                return;
+            }
+
+            if (offset > blk_len || whence == SEEK_DATA) {
+                fuse_reply_err(req, ENXIO);
+            } else {
+                fuse_reply_lseek(req, offset);
+            }
+            return;
+        }
+
+        if (ret & BDRV_BLOCK_DATA) {
+            if (whence == SEEK_DATA) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        } else {
+            if (whence == SEEK_HOLE) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        }
+
+        /* Safety check against infinite loops */
+        if (!pnum) {
+            fuse_reply_err(req, ENXIO);
+            return;
+        }
+
+        offset += pnum;
+    }
+}
+#endif
+
 static const struct fuse_lowlevel_ops fuse_ops = {
     .lookup     = fuse_lookup,
     .getattr    = fuse_getattr,
@@ -557,6 +631,9 @@ static const struct fuse_lowlevel_ops fuse_ops = {
     .write      = fuse_write,
     .fallocate  = fuse_fallocate,
     .flush      = fuse_flush,
+#ifdef CONFIG_FUSE_LSEEK
+    .lseek      = fuse_lseek,
+#endif
 };
 
 const BlockExportDriver blk_exp_fuse = {
diff --git a/meson.build b/meson.build
index 85addd8562..1db6a46d14 100644
--- a/meson.build
+++ b/meson.build
@@ -1537,6 +1537,7 @@ summary_info += {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
 summary_info += {'rng-none':          config_host.has_key('CONFIG_RNG_NONE')}
 summary_info += {'Linux keyring':     config_host.has_key('CONFIG_SECRET_KEYRING')}
 summary_info += {'fuse exports':      config_host.has_key('CONFIG_FUSE')}
+summary_info += {'fuse lseek':        config_host.has_key('CONFIG_FUSE_LSEEK')}
 summary(summary_info, bool_yn: true)
 
 if not supported_cpus.contains(cpu)
-- 
2.26.2


