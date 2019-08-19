Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F32C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB7222CEA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB7222CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkbt-0005SS-HA
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hzkMR-0003Qj-0y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hzkMO-0006eK-VK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:47170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hzkMO-0006c8-Ny; Mon, 19 Aug 2019 12:18:20 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hzkML-0001qZ-H0; Mon, 19 Aug 2019 19:18:17 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 19:18:11 +0300
Message-Id: <20190819161811.15872-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9] qemu-io: add pattern file for write command
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch allows to provide a pattern file for write
command. There was no similar ability before.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
v9:
  * replace flag cast to int with bool [Eric]
  * fix the error message [Eric]
  * use qemu_io_free instead of qemu_vfree [Eric]
  * add function description [Eric]

v8: fix according to Max's comments
  * get rid of unnecessary buffer for the pattern
  * buffer allocation just in bytes
  * take into account the missalign offset
  * don't copy file name
  * changed char* to const char* in input params

v7:
  * fix variable naming
  * make code more readable
  * extend help for write command

v6:
  * the pattern file is read once to reduce io

v5:
  * file name initiated with null to make compilers happy

v4:
  * missing signed-off clause added

v3:
  * missing file closing added
  * exclusive flags processing changed
  * buffer void* converted to char* to fix pointer arithmetics
  * file reading error processing added
---
 qemu-io-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 6 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 09750a23ce..f7bdfe673b 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -351,6 +351,77 @@ static void qemu_io_free(void *p)
     qemu_vfree(p);
 }
 
+/*
+ * qemu_io_alloc_from_file()
+ *
+ * Allocates the buffer and populates it with the content of the given file
+ * up to @len bytes. If the file length is less then @len, then the buffer
+ * is populated with then file content cyclically.
+ *
+ * @blk - the block backend where the buffer content is going to be written to
+ * @len - the buffer length
+ * @file_name - the file to copy the content from
+ *
+ * Returns: the buffer pointer on success
+ *          NULL on error
+ */
+static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
+                                     const char *file_name)
+{
+    char *buf, *buf_origin;
+    FILE *f = fopen(file_name, "r");
+    int pattern_len;
+
+    if (!f) {
+        perror(file_name);
+        return NULL;
+    }
+
+    if (qemuio_misalign) {
+        len += MISALIGN_OFFSET;
+    }
+
+    buf_origin = buf = blk_blockalign(blk, len);
+
+    if (qemuio_misalign) {
+        buf_origin += MISALIGN_OFFSET;
+    }
+
+    pattern_len = fread(buf_origin, 1, len, f);
+
+    if (ferror(f)) {
+        perror(file_name);
+        goto error;
+    }
+
+    if (pattern_len == 0) {
+        fprintf(stderr, "%s: file is empty\n", file_name);
+        goto error;
+    }
+
+    fclose(f);
+
+    if (len > pattern_len) {
+        len -= pattern_len;
+        buf += pattern_len;
+
+        while (len > 0) {
+            size_t len_to_copy = MIN(pattern_len, len);
+
+            memcpy(buf, buf_origin, len_to_copy);
+
+            len -= len_to_copy;
+            buf += len_to_copy;
+        }
+    }
+
+    return buf_origin;
+
+error:
+    qemu_io_free(buf_origin);
+    return NULL;
+}
+
 static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
 {
     uint64_t i;
@@ -949,6 +1020,7 @@ static void write_help(void)
 " -n, -- with -z, don't allow slow fallback\n"
 " -p, -- ignored for backwards compatibility\n"
 " -P, -- use different pattern to fill file\n"
+" -s, -- use a pattern file to fill the write buffer\n"
 " -C, -- report statistics in a machine parsable format\n"
 " -q, -- quiet mode, do not show I/O statistics\n"
 " -u, -- with -z, allow unmapping\n"
@@ -965,7 +1037,7 @@ static const cmdinfo_t write_cmd = {
     .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-bcCfnquz] [-P pattern] off len",
+    .args       = "[-bcCfnquz] [-P pattern | -s source_file] off len",
     .oneline    = "writes a number of bytes at a specified offset",
     .help       = write_help,
 };
@@ -974,7 +1046,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
 {
     struct timeval t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
-    bool Pflag = false, zflag = false, cflag = false;
+    bool Pflag = false, zflag = false, cflag = false, sflag = false;
     int flags = 0;
     int c, cnt, ret;
     char *buf = NULL;
@@ -983,8 +1055,9 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     /* Some compilers get confused and warn if this is not initialized.  */
     int64_t total = 0;
     int pattern = 0xcd;
+    const char *file_name = NULL;
 
-    while ((c = getopt(argc, argv, "bcCfnpP:quz")) != -1) {
+    while ((c = getopt(argc, argv, "bcCfnpP:quzs:")) != -1) {
         switch (c) {
         case 'b':
             bflag = true;
@@ -1020,6 +1093,10 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         case 'z':
             zflag = true;
             break;
+        case 's':
+            sflag = true;
+            file_name = optarg;
+            break;
         default:
             qemuio_command_usage(&write_cmd);
             return -EINVAL;
@@ -1051,8 +1128,9 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    if (zflag && Pflag) {
-        printf("-z and -P cannot be specified at the same time\n");
+    if ((bool)zflag + (bool)Pflag + (bool)sflag > 1) {
+        printf("Only one of -z, -P, and -s "
+               "can be specified at the same time\n");
         return -EINVAL;
     }
 
@@ -1088,7 +1166,14 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     }
 
     if (!zflag) {
-        buf = qemu_io_alloc(blk, count, pattern);
+        if (sflag) {
+            buf = qemu_io_alloc_from_file(blk, count, file_name);
+            if (!buf) {
+                return -EINVAL;
+            }
+        } else {
+            buf = qemu_io_alloc(blk, count, pattern);
+        }
     }
 
     gettimeofday(&t1, NULL);
-- 
2.17.0


