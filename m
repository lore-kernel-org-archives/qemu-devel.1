Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AE3221E7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cK28ktZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AE3221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUAg-0003GF-Co
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU2M-0006oj-E4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU2K-0008R9-7K
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2ouGnkiYaquzvHLH10l3C36l1wlfZEHCowdYJan56E=;
 b=cK28ktZUrNFmql3uyFZsB7Z8AVFGoDdvQUXeebzig7Bc+rw/oWZLyu9pvu3jAsVECwO5if
 BYfT376NbLM54fSxai5bZib9cnEIwS05W6Pury+841LmfICZ8fY3gUtejVJHssq3Dr08FA
 yYwVU9AKhLex6TIi2hyepMyt1KWZtcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-1LyKDxvVMaC3bEDG3vgDRQ-1; Wed, 16 Sep 2020 05:47:33 -0400
X-MC-Unique: 1LyKDxvVMaC3bEDG3vgDRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3969E80EDA3;
 Wed, 16 Sep 2020 09:47:32 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A14975123;
 Wed, 16 Sep 2020 09:47:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] block/file: switch to use qemu_open/qemu_create for
 improved errors
Date: Wed, 16 Sep 2020 10:47:05 +0100
Message-Id: <20200916094705.2625331-9-berrange@redhat.com>
In-Reply-To: <20200916094705.2625331-1-berrange@redhat.com>
References: <20200916094705.2625331-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img': filesystem does not support O_DIRECT

while at the QMP level QEMU reports a massively more informative

  "error": {
     "class": "GenericError",
     "desc": "Unable to open '/tmp/foo.img': filesystem does not support O_DIRECT"
  }

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/file-posix.c | 18 +++++++-----------
 block/file-win32.c |  6 ++----
 2 files changed, 9 insertions(+), 15 deletions(-)

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
index b28603c7d5..2642088bd6 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -596,11 +596,9 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
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
-- 
2.26.2


