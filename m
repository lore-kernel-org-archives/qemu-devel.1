Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB553C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43C12341A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43C12341A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzBy-0001A5-0b
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:04:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVzA3-00008Y-S1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVzA2-0003Bv-Mm
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:02:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVzA0-00038J-5M; Wed, 29 May 2019 10:02:32 -0400
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVz9w-00041Y-L7; Wed, 29 May 2019 17:02:28 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: eblake@redhat.com,
	kwolf@redhat.com,
	mreitz@redhat.com
Date: Wed, 29 May 2019 17:02:17 +0300
Message-Id: <20190529140217.12841-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3] qemu-io: add pattern file for write command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch allows to provide a pattern file for write
command. There was no similar ability before.
---
 qemu-io-cmds.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 09750a23ce..b75ffaa739 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -21,6 +21,7 @@
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
+#include "string.h"
 
 #define CMD_NOFILE_OK   0x01
 
@@ -343,6 +344,61 @@ static void *qemu_io_alloc(BlockBackend *blk, size_t len, int pattern)
     return buf;
 }
 
+static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
+                                     char *file_name)
+{
+    char *buf, *buf_pos;
+    FILE *f = fopen(file_name, "r");
+    int l;
+
+    if (!f) {
+        printf("'%s': %s\n", file_name, strerror(errno));
+        return NULL;
+    }
+
+    if (qemuio_misalign) {
+        len += MISALIGN_OFFSET;
+    }
+    buf = blk_blockalign(blk, len);
+    memset(buf, 0, len);
+
+    buf_pos = buf;
+
+    while (len > 0) {
+        l = fread(buf_pos, sizeof(char), len, f);
+
+        if (feof(f)) {
+           rewind(f);
+        }
+
+        if (ferror(f)) {
+            printf("'%s': %s\n", file_name, strerror(errno));
+            goto error;
+        }
+
+        if (l == 0) {
+            printf("'%s' is empty\n", file_name);
+            goto error;
+        }
+
+        len -= l;
+        buf_pos += l;
+    }
+
+    if (qemuio_misalign) {
+        buf += MISALIGN_OFFSET;
+    }
+
+    goto out;
+
+error:
+    qemu_vfree(buf);
+    buf = NULL;
+out:
+    fclose(f);
+    return buf;
+}
+
 static void qemu_io_free(void *p)
 {
     if (qemuio_misalign) {
@@ -965,7 +1021,7 @@ static const cmdinfo_t write_cmd = {
     .perm       = BLK_PERM_WRITE,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-bcCfnquz] [-P pattern] off len",
+    .args       = "[-bcCfnquz] [-P pattern | -s source_file] off len",
     .oneline    = "writes a number of bytes at a specified offset",
     .help       = write_help,
 };
@@ -974,7 +1030,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
 {
     struct timeval t1, t2;
     bool Cflag = false, qflag = false, bflag = false;
-    bool Pflag = false, zflag = false, cflag = false;
+    bool Pflag = false, zflag = false, cflag = false, sflag = false;
     int flags = 0;
     int c, cnt, ret;
     char *buf = NULL;
@@ -983,8 +1039,9 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     /* Some compilers get confused and warn if this is not initialized.  */
     int64_t total = 0;
     int pattern = 0xcd;
+    char *file_name;
 
-    while ((c = getopt(argc, argv, "bcCfnpP:quz")) != -1) {
+    while ((c = getopt(argc, argv, "bcCfnpP:quzs:")) != -1) {
         switch (c) {
         case 'b':
             bflag = true;
@@ -1020,6 +1077,10 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         case 'z':
             zflag = true;
             break;
+        case 's':
+            sflag = true;
+            file_name = g_strdup(optarg);
+            break;
         default:
             qemuio_command_usage(&write_cmd);
             return -EINVAL;
@@ -1051,8 +1112,8 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    if (zflag && Pflag) {
-        printf("-z and -P cannot be specified at the same time\n");
+    if ((int)zflag + (int)Pflag + (int)sflag > 1) {
+        printf("Only one of -z, -P, and -s can be specified at the same time\n");
         return -EINVAL;
     }
 
@@ -1088,7 +1149,14 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
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


