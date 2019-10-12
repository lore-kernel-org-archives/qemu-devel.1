Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BFC47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE0C206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE0C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ7LF-0005MQ-IR
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 22:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJ7KA-00045i-OG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJ7K9-0001IK-Ov
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:11741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJ7K9-0001Hj-Gb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:40:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 19:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,286,1566889200"; d="scan'208";a="395935154"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2019 19:40:03 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 1/2] migration/compress: compress QEMUFile is not writable
Date: Sat, 12 Oct 2019 10:39:31 +0800
Message-Id: <20191012023932.1863-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012023932.1863-1-richardw.yang@linux.intel.com>
References: <20191012023932.1863-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We open a file with empty_ops for compress QEMUFile, which means this is
not writable.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/qemu-file.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 26fb25ddc1..f3d99a96ec 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -744,11 +744,8 @@ static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
 /* Compress size bytes of data start at p and store the compressed
  * data to the buffer of f.
  *
- * When f is not writable, return -1 if f has no space to save the
- * compressed data.
- * When f is wirtable and it has no space to save the compressed data,
- * do fflush first, if f still has no space to save the compressed
- * data, return -1.
+ * Since the file is dummy file with empty_ops, return -1 if f has no space to
+ * save the compressed data.
  */
 ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
                                   const uint8_t *p, size_t size)
@@ -756,14 +753,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     ssize_t blen = IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
 
     if (blen < compressBound(size)) {
-        if (!qemu_file_is_writable(f)) {
-            return -1;
-        }
-        qemu_fflush(f);
-        blen = IO_BUF_SIZE - sizeof(int32_t);
-        if (blen < compressBound(size)) {
-            return -1;
-        }
+        return -1;
     }
 
     blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
-- 
2.17.1


