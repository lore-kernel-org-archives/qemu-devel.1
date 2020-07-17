Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E82C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E54208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXeENo7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E54208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPzn-0005Su-Fz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPu0-0005IR-9X
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPty-0008Qy-91
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyM7taanMtzcIzn1q0y+5d1wTFMhwtGopq99wjJ+WHM=;
 b=SXeENo7+h7LCwbnFaadpyM9l98RM7Q8HZGMsFtcs/C8+NLSW1JjBzxDqoC8NkgMqo1bucP
 qMbAV1UMNX4JA5OeLxmsBryrFcTuXoeFgYqZPSnGctAQ0XdtBKKzeEvMgdk/6udLPvKeq3
 VpRKHgYR4qr9lrXtXS+RO6wyNLXF51A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-MTii7PWZPP2cjBkOacX8qg-1; Fri, 17 Jul 2020 08:55:43 -0400
X-MC-Unique: MTii7PWZPP2cjBkOacX8qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A48419324B6;
 Fri, 17 Jul 2020 12:55:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28CEA710B1;
 Fri, 17 Jul 2020 12:55:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/12] file-posix: Fix check_hdev_writable() with auto-read-only
Date: Fri, 17 Jul 2020 14:55:09 +0200
Message-Id: <20200717125510.238374-12-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Linux block devices, being able to open the device read-write
doesn't necessarily mean that the device is actually writable (one
example is a read-only LV, as you get with lvchange -pr <device>). We
have check_hdev_writable() to check this condition and fail opening the
image read-write if it's not actually writable.

However, this check doesn't take auto-read-only into account, but
results in a hard failure instead of downgrading to read-only where
possible.

Fix this and do the writable check not based on BDRV_O_RDWR, but only
when this actually results in opening the file read-write. A second
check is inserted in raw_reconfigure_getfd() to have the same check when
dynamic auto-read-only upgrades an image file from read-only to
read-write.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200717105426.51134-3-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index dd7dab07d6..996e45ab95 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -425,7 +425,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     }
 }
 
-static int check_hdev_writable(BDRVRawState *s)
+static int check_hdev_writable(int fd)
 {
 #if defined(BLKROGET)
     /* Linux block devices can be configured "read-only" using blockdev(8).
@@ -439,7 +439,7 @@ static int check_hdev_writable(BDRVRawState *s)
     struct stat st;
     int readonly = 0;
 
-    if (fstat(s->fd, &st)) {
+    if (fstat(fd, &st)) {
         return -errno;
     }
 
@@ -447,7 +447,7 @@ static int check_hdev_writable(BDRVRawState *s)
         return 0;
     }
 
-    if (ioctl(s->fd, BLKROGET, &readonly) < 0) {
+    if (ioctl(fd, BLKROGET, &readonly) < 0) {
         return -errno;
     }
 
@@ -642,6 +642,15 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->fd = fd;
 
+    /* Check s->open_flags rather than bdrv_flags due to auto-read-only */
+    if (s->open_flags & O_RDWR) {
+        ret = check_hdev_writable(s->fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "The device is not writable");
+            goto fail;
+        }
+    }
+
     s->perm = 0;
     s->shared_perm = BLK_PERM_ALL;
 
@@ -1034,6 +1043,15 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         }
     }
 
+    if (fd != -1 && (*open_flags & O_RDWR)) {
+        ret = check_hdev_writable(fd);
+        if (ret < 0) {
+            qemu_close(fd);
+            error_setg_errno(errp, -ret, "The device is not writable");
+            return -1;
+        }
+    }
+
     return fd;
 }
 
@@ -3478,15 +3496,6 @@ hdev_open_Mac_error:
     /* Since this does ioctl the device must be already opened */
     bs->sg = hdev_is_sg(bs);
 
-    if (flags & BDRV_O_RDWR) {
-        ret = check_hdev_writable(s);
-        if (ret < 0) {
-            raw_close(bs);
-            error_setg_errno(errp, -ret, "The device is not writable");
-            return ret;
-        }
-    }
-
     return ret;
 }
 
-- 
2.25.4


