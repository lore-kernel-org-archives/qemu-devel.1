Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E17C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B72220659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B72220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41473 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsppk-0002Tt-8h
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hspp5-0001CN-4J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hspp4-0000vL-1w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:43:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:51112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hspp3-0000sd-OI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:43:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 07:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; d="scan'208";a="347557230"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga005.jf.intel.com with ESMTP; 31 Jul 2019 07:43:17 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 22:42:25 +0800
Message-Id: <20190731144225.3784-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731144225.3784-1-richardw.yang@linux.intel.com>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
this happens, buf_index is reset. Currently, this is not checked and
buf_index would always been adjust with buf size.

This is not harmful, but will waste some space in file buffer.

This patch make add_to_iovec() return 1 when it has flushed the file.
Then the caller could check the return value to see whether it is
necessary to adjust the buf_index any more.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 35c22605dd..05d9f42ddb 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
     return ret;
 }
 
-static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
-                         bool may_free)
+/*
+ * Add buf to iovec. Do flush if iovec is full.
+ *
+ * Return values:
+ * 1 iovec is full and flushed
+ * 0 iovec is not flushed
+ *
+ */
+static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
+                        bool may_free)
 {
     /* check for adjacent buffer and coalesce them */
     if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
@@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
 
     if (f->iovcnt >= MAX_IOV_SIZE) {
         qemu_fflush(f);
+        return 1;
     }
+
+    return 0;
 }
 
 void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
@@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
         }
         memcpy(f->buf + f->buf_index, buf, l);
         f->bytes_xfer += l;
-        add_to_iovec(f, f->buf + f->buf_index, l, false);
-        f->buf_index += l;
-        if (f->buf_index == IO_BUF_SIZE) {
-            qemu_fflush(f);
+        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
+            f->buf_index += l;
+            if (f->buf_index == IO_BUF_SIZE) {
+                qemu_fflush(f);
+            }
         }
         if (qemu_file_get_error(f)) {
             break;
@@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
 
     f->buf[f->buf_index] = v;
     f->bytes_xfer++;
-    add_to_iovec(f, f->buf + f->buf_index, 1, false);
-    f->buf_index++;
-    if (f->buf_index == IO_BUF_SIZE) {
-        qemu_fflush(f);
+    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
+        f->buf_index++;
+        if (f->buf_index == IO_BUF_SIZE) {
+            qemu_fflush(f);
+        }
     }
 }
 
@@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     }
 
     qemu_put_be32(f, blen);
-    add_to_iovec(f, f->buf + f->buf_index, blen, false);
-    f->buf_index += blen;
-    if (f->buf_index == IO_BUF_SIZE) {
-        qemu_fflush(f);
+    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
+        f->buf_index += blen;
+        if (f->buf_index == IO_BUF_SIZE) {
+            qemu_fflush(f);
+        }
     }
     return blen + sizeof(int32_t);
 }
-- 
2.17.1


