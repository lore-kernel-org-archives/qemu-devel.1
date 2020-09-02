Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D62CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9018207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqRW2INQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9018207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWLI-0006Ea-Sh
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGf-0006Wv-2Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGd-0001QE-6b
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzs3aUJxV2cZ6h1cobn1/ATKpeDKXdCUHXnxMVc3LTc=;
 b=dqRW2INQ4fHcHsmPt7yuzzWqEN9G8bL08vCiRWos8/jdJ/XI3cIpjIKMb3JObOG3ZXlZYz
 2TJ+anKjZgRHg4rHmCaMvSyCGoGWyIJdSZdUZqQx50FEMjnFgx2rICbmfJwXH0zB8t5vYf
 vhjkd3BhcsD0+VMr1pSkUQJaNwBY7pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-LIuQ0bi1MSynPckRN6xmHg-1; Wed, 02 Sep 2020 13:09:48 -0400
X-MC-Unique: LIuQ0bi1MSynPckRN6xmHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57AA56C89;
 Wed,  2 Sep 2020 17:09:47 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11F5319C59;
 Wed,  2 Sep 2020 17:09:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 8/8] block/file: switch to use qemu_open/qemu_create for
 improved errors
Date: Wed,  2 Sep 2020 18:09:13 +0100
Message-Id: <20200902170913.1785194-9-berrange@redhat.com>
In-Reply-To: <20200902170913.1785194-1-berrange@redhat.com>
References: <20200902170913.1785194-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
-- 
2.26.2


