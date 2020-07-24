Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5AA2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNQcTdsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5AA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxjZ-00035A-Nq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxi4-0000b6-As
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:26:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxi1-00016t-MK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxBhDE/ZkjIt5D2+hLL2njOG2q6Dd13fvcq5QcRmyYw=;
 b=GNQcTdsDt6kLgmU4eUypAxBFcFg2hpZAP4KBGVw0PQhLfDFBCAy3/pd11uQZS97qy8PZon
 2qg2dfMbM57keqtQEc66XZFXgkUZkPvlT0SMZBbGNiWFzaz/nswQSGzRq+f9pRWqRnRfMP
 c+bBLX75GePViqsaYgeyiYzFsLDM2wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-91YsiT1rND6heLnlrDgs_Q-1; Fri, 24 Jul 2020 09:25:52 -0400
X-MC-Unique: 91YsiT1rND6heLnlrDgs_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38C3D192376B;
 Fri, 24 Jul 2020 13:25:51 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FBA10013D9;
 Fri, 24 Jul 2020 13:25:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] block: switch to use qemu_open/qemu_create for
 improved errors
Date: Fri, 24 Jul 2020 14:25:10 +0100
Message-Id: <20200724132510.3250311-5-berrange@redhat.com>
In-Reply-To: <20200724132510.3250311-1-berrange@redhat.com>
References: <20200724132510.3250311-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently at startup if using cache=none on a filesystem lacking
O_DIRECT such as tmpfs, at startup QEMU prints

qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: file system may not support O_DIRECT
qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Could not open '/tmp/foo.img': Invalid argument

while at QMP level the hint is missing, so QEMU reports just

  "error": {
      "class": "GenericError",
      "desc": "Could not open '/tmp/foo.img': Invalid argument"
  }

which is close to useless for the end user trying to figure out what
they did wrong.

With this change at startup QEMU prints

qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT

while at the QMP level QEMU reports a massively more informative

  "error": {
     "class": "GenericError",
     "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does not support O_DIRECT"
  }

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/file-posix.c            | 18 +++++++-----------
 block/file-win32.c            |  6 ++----
 tests/qemu-iotests/051.out    |  4 ++--
 tests/qemu-iotests/051.pc.out |  4 ++--
 tests/qemu-iotests/061.out    |  2 +-
 tests/qemu-iotests/069.out    |  2 +-
 tests/qemu-iotests/082.out    |  4 ++--
 tests/qemu-iotests/111.out    |  2 +-
 tests/qemu-iotests/226.out    |  6 +++---
 tests/qemu-iotests/232.out    | 12 ++++++------
 tests/qemu-iotests/244.out    |  6 +++---
 11 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index bac2566f10..c63926d592 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -630,11 +630,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     raw_parse_flags(bdrv_flags, &s->open_flags, false);
 
     s->fd = -1;
-    fd = qemu_open_old(filename, s->open_flags, 0644);
+    fd = qemu_open(filename, s->open_flags, errp);
     ret = fd < 0 ? -errno : 0;
 
     if (ret < 0) {
-        error_setg_file_open(errp, -ret, filename);
         if (ret == -EROFS) {
             ret = -EACCES;
         }
@@ -1032,15 +1031,13 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         }
     }
 
-    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open_old() */
+    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
     if (fd == -1) {
         const char *normalized_filename = bs->filename;
         ret = raw_normalize_devicepath(&normalized_filename, errp);
         if (ret >= 0) {
-            assert(!(*open_flags & O_CREAT));
-            fd = qemu_open_old(normalized_filename, *open_flags);
+            fd = qemu_open(normalized_filename, *open_flags, errp);
             if (fd == -1) {
-                error_setg_errno(errp, errno, "Could not reopen file");
                 return -1;
             }
         }
@@ -2411,10 +2408,9 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Create file */
-    fd = qemu_open_old(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
+    fd = qemu_create(file_opts->filename, O_RDWR | O_BINARY, 0644, errp);
     if (fd < 0) {
         result = -errno;
-        error_setg_errno(errp, -result, "Could not create file");
         goto out;
     }
 
@@ -3335,7 +3331,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
     for (index = 0; index < num_of_test_partitions; index++) {
         snprintf(test_partition, sizeof(test_partition), "%ss%d", bsd_path,
                  index);
-        fd = qemu_open_old(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
+        fd = qemu_open(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE, NULL);
         if (fd >= 0) {
             partition_found = true;
             qemu_close(fd);
@@ -3653,7 +3649,7 @@ static int cdrom_probe_device(const char *filename)
     int prio = 0;
     struct stat st;
 
-    fd = qemu_open_old(filename, O_RDONLY | O_NONBLOCK);
+    fd = qemu_open(filename, O_RDONLY | O_NONBLOCK, NULL);
     if (fd < 0) {
         goto out;
     }
@@ -3787,7 +3783,7 @@ static int cdrom_reopen(BlockDriverState *bs)
      */
     if (s->fd >= 0)
         qemu_close(s->fd);
-    fd = qemu_open_old(bs->filename, s->open_flags, 0644);
+    fd = qemu_open(bs->filename, s->open_flags, NULL);
     if (fd < 0) {
         s->fd = -1;
         return -EIO;
diff --git a/block/file-win32.c b/block/file-win32.c
index 8c1845830e..1a31f8a5ba 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -576,11 +576,9 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
         return -EINVAL;
     }
 
-    fd = qemu_open_old(file_opts->filename,
-                       O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
-                       0644);
+    fd = qemu_create(file_opts->filename, O_WRONLY | O_TRUNC | O_BINARY,
+                     0644, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "Could not create file");
         return -EIO;
     }
     set_sparse(fd);
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index de4771bcb3..242dcfe08d 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -363,7 +363,7 @@ Testing: -drive file=foo:bar
 QEMU_PROG: -drive file=foo:bar: Unknown protocol 'foo'
 
 Testing: -drive file.filename=foo:bar
-QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file or directory
+QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar' flags 0x08000: No such file or directory
 
 Testing: -hda file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -374,7 +374,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
-QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
+QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2' flags 0x80000: No such file or directory
 
 
 === Snapshot mode ===
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index f707471fb0..4c41b46986 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -463,7 +463,7 @@ Testing: -drive file=foo:bar
 QEMU_PROG: -drive file=foo:bar: Unknown protocol 'foo'
 
 Testing: -drive file.filename=foo:bar
-QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file or directory
+QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar' flags 0x80000: No such file or directory
 
 Testing: -hda file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -474,7 +474,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
-QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
+QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2' flags 0x80000: No such file or directory
 
 
 === Snapshot mode ===
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index b2d2dfed04..a533b0d416 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -538,7 +538,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: data-file can only be set for images that use an external data file
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No such file or directory
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo' flags 0x80000: No such file or directory
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
diff --git a/tests/qemu-iotests/069.out b/tests/qemu-iotests/069.out
index 126b4d2d51..ffb95c965f 100644
--- a/tests/qemu-iotests/069.out
+++ b/tests/qemu-iotests/069.out
@@ -4,5 +4,5 @@ QA output created by 069
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=131072
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
+qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Could not open 'TEST_DIR/t.IMGFMT.base' flags 0x80000: No such file or directory
 *** done
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 1728aff1e0..5a718ac1b5 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -544,10 +544,10 @@ Supported options:
   size=<size>            - Virtual disk size
 
 Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
+qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help' flags 0x80000: No such file or directory
 
 Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,?': No such file or directory
+qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,?' flags 0x80000: No such file or directory
 
 Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
diff --git a/tests/qemu-iotests/111.out b/tests/qemu-iotests/111.out
index ba034e5c58..90255ea653 100644
--- a/tests/qemu-iotests/111.out
+++ b/tests/qemu-iotests/111.out
@@ -1,4 +1,4 @@
 QA output created by 111
-qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent': No such file or directory
+qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent' flags 0x80000: No such file or directory
 Could not open backing image.
 *** done
diff --git a/tests/qemu-iotests/226.out b/tests/qemu-iotests/226.out
index 42be973ff2..353fc4c799 100644
--- a/tests/qemu-iotests/226.out
+++ b/tests/qemu-iotests/226.out
@@ -6,7 +6,7 @@ QA output created by 226
 qemu-io: can't open: A regular file was expected by the 'file' driver, but something else was given
 qemu-io: warning: Opening a character device as a file using the 'file' driver is deprecated
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Is a directory
 qemu-io: warning: Opening a character device as a file using the 'file' driver is deprecated
 
 === Testing with driver:host_device ===
@@ -14,13 +14,13 @@ qemu-io: warning: Opening a character device as a file using the 'file' driver i
 == Testing RO ==
 qemu-io: can't open: 'host_device' driver expects either a character or block device
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Is a directory
 
 === Testing with driver:host_cdrom ===
 
 == Testing RO ==
 qemu-io: can't open: 'host_cdrom' driver expects either a character or block device
 == Testing RW ==
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80802: Is a directory
 
 *** done
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
index 3bd1a920af..bfa3f20172 100644
--- a/tests/qemu-iotests/232.out
+++ b/tests/qemu-iotests/232.out
@@ -21,11 +21,11 @@ NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 
-QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 
-QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 
@@ -49,11 +49,11 @@ node0: TEST_DIR/t.IMGFMT (file, read-only)
 node0: TEST_DIR/t.IMGFMT (file, read-only)
 node0: TEST_DIR/t.IMGFMT (file, read-only)
 
-QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 node0: TEST_DIR/t.IMGFMT (file)
-QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,read-only=off: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 
-QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0,auto-read-only=off: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 node0: TEST_DIR/t.IMGFMT (file)
-QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0: Could not open 'TEST_DIR/t.IMGFMT' flags 0x80002: Permission denied
 *** done
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index dbab7359a9..34daec97f2 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -9,7 +9,7 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent' flags 0x80002: No such file or directory
 no file open, try 'help open'
 
 Data file required, but without data file name in the image:
@@ -17,14 +17,14 @@ qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' is required for this im
 no file open, try 'help open'
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent' flags 0x80002: No such file or directory
 no file open, try 'help open'
 
 Setting data-file for an image with internal data:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' can only be set for images with an external data file
 no file open, try 'help open'
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': No such file or directory
+qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent' flags 0x80002: No such file or directory
 no file open, try 'help open'
 
 === Conflicting features ===
-- 
2.26.2


