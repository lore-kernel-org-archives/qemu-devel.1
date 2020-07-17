Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E1A20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPrcLxfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E1A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO3s-0006ow-Cj
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwO0m-0001Kj-NT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:54:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwO0k-0004RQ-Sb
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594983278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNBvx4THG0M9pR8FSX6Ps6fHmdrKHB/so8DozTyNlvw=;
 b=KPrcLxfkqsJlO7o5wyzQEX+9Exg87IpoYGHF3eArwNNOGuz3F5oL2OOo8KH1Qw6A/dclMe
 X9MS5uUHKCOY6DerufzYZ/6CwVFCoSbkzibWraLnQZ6O5+NmxcyZci/9c+7NAlG/rc1mUu
 Trg3DRmRQLjx/FPwSuFIzKpBKk4mb24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-NLdMEcwnOCunYQJuxnjR3Q-1; Fri, 17 Jul 2020 06:54:36 -0400
X-MC-Unique: NLdMEcwnOCunYQJuxnjR3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ED5F100CCC1;
 Fri, 17 Jul 2020 10:54:35 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C5246FED1;
 Fri, 17 Jul 2020 10:54:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 2/3] file-posix: Fix check_hdev_writable() with
 auto-read-only
Date: Fri, 17 Jul 2020 12:54:25 +0200
Message-Id: <20200717105426.51134-3-kwolf@redhat.com>
In-Reply-To: <20200717105426.51134-1-kwolf@redhat.com>
References: <20200717105426.51134-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
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
---
 block/file-posix.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e35e15185a..659f780570 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -401,7 +401,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     }
 }
 
-static int check_hdev_writable(BDRVRawState *s)
+static int check_hdev_writable(int fd)
 {
 #if defined(BLKROGET)
     /* Linux block devices can be configured "read-only" using blockdev(8).
@@ -415,7 +415,7 @@ static int check_hdev_writable(BDRVRawState *s)
     struct stat st;
     int readonly = 0;
 
-    if (fstat(s->fd, &st)) {
+    if (fstat(fd, &st)) {
         return -errno;
     }
 
@@ -423,7 +423,7 @@ static int check_hdev_writable(BDRVRawState *s)
         return 0;
     }
 
-    if (ioctl(s->fd, BLKROGET, &readonly) < 0) {
+    if (ioctl(fd, BLKROGET, &readonly) < 0) {
         return -errno;
     }
 
@@ -618,6 +618,15 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
 
@@ -1010,6 +1019,15 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
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
 
@@ -3454,15 +3472,6 @@ hdev_open_Mac_error:
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


