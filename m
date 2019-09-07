Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1871AC433EF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D299A21835
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VXWX4SXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D299A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6jQ8-0008DB-0C
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 18:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM7-00040T-Gu
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM6-0005da-4G
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM2-0005aj-O9; Sat, 07 Sep 2019 18:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567895930; x=1599431930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nEes3Wgtb3JW9qFDYao6VzVJMKi0IJ2s2eYSgN00rvE=;
 b=VXWX4SXr7xAO+nlZVsMhdnaNOwq5PQIrZ3k4GwF9VqeaGBt6weUcOBTS
 3iDJAvSzrqeQZXu+2BQW/YQQJlLA1Kgn3pJKM4gF+F66RoPVB1VJGCtAH
 PYEexgFHXic1bbgGb2odFrqYHhnBk4q1DErdo1hH/xnEbB7N2eB0nM0Nr
 O8P1UcXsGMPc8Z6NYG2aXXXasIwFm9wf4XtNxxpI0P6tAIJKagR/IMO0z
 3hyUW83hYP3oNSYpT6jj0Ty4GGezo7PaQSHJl9fMkBEnLWIf2AjsVMgvO
 TmCy4iKJ//glE4NI5YwWxs4yLTscKhQJgso3xe/yYGxJM+CMyeliSBKaZ g==;
IronPort-SDR: U4kyYZxVglqzYa0t+r/eo3HuZ8Zqzar2T5zb22IBdlAI+QDtS/iQDT7aRG3MtVM0OjOJ7HRq2g
 RFA2qk33TuIo1k7lKyq8BuvIw3KUHuX5Xt862wsyxAfs6NigXU53FAHGCYaXNvh8B0yDYAqhs3
 XOdvc5gX69VbkFnkw6ErnnHuzSWmWvt1saZh0nqYjd7aZNTYy18rSpu+uy/eqUzDkaWlVK8FpD
 K2v0JJal5bcLVyjacR33KWkADF4YbeeG5Tu9YU6afMVb4oe4mHP4ZS7zlmBx06nY4eF4ogqwun
 +VU=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="224505948"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 06:38:45 +0800
IronPort-SDR: cWvg8FdTSLz+pI4p3ynedZ6A3tiKxGCdWGD0MpI+01txSXyiSVmcBsoGIEZBwYd2fXCOocneUN
 nZQULCS4a2UF1ufWLbmCyA0+CCDUPze2a9qLHAKKKpqYlbKQIDu+Dmce9eNjW24gvfebUyfMb5
 /pPJJMbYcAQzLojE94Kmdk62ttM33OUszCysXQhckF2PRvEMDqtKVxAEBGG8WKgUrQg0BDJ3at
 IOkKO6CoRc6G4o7dHZZutCMLPo1aYDqI2N+xPkvL0SWDLl7ZpNoavgUwfXL7ggwgBaRJLKCY3O
 FSMWF8+dRVLwfeS0vdEsnbcY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2019 15:35:35 -0700
IronPort-SDR: CV+8Lu8xnmm8cK8NgcWnkt/dmeQYML/OJpO34JJvn0wO2RBvZINVayjuouJzxNCPL22mJ0xYVv
 Bfqlwzm5HRgJKYzaQ64Wy60wCEz8lfFxxpO2yHsn5keA4GqKKeANhbF7ZUhw0szv8qzhKCx0MS
 YxkQMwREKp1NwqszajzoeNTi6KTzYJYZBjqn0h8GEQw8RbQJst/VRx8b4GWEyjL29rTOtN7N0T
 7hoI83bJZQW43pEv9kNhWIJlHsHWbnzrhEVt18+eXkS1fu7D1fwAic1zjZfUGcJ3oITvDebgFl
 tiI=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2019 15:38:45 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Sat,  7 Sep 2019 18:38:39 -0400
Message-Id: <20190907223841.20210-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
References: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v7 2/4] raw: Recognize zoned backing devices
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this patch is to recognize a zoned block device (ZBD)
when it is opened as a raw file. The new code initializes the zoned
model propery introduced by the previous commit.

This commit is Linux-specific as it gets the Zoned Block Device Model
value (none/host-managed/host-aware) from sysfs on the host.

In order to avoid code duplication in file-posix.c, a common helper
function is added to read values of sysfs entries under
/sys/block/<dev>/queue. This way, the existing function that reads
the value of "max_segments" entry and the the new function that reads
"zoned" value both share the same helper code.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 75 ++++++++++++++++++++++++++++++++++++++--------
 block/io.c         |  5 ++++
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 71f168ee2f..caacb21f07 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1067,15 +1067,13 @@ static int sg_get_max_transfer_length(int fd)
 #endif
 }
 
-static int sg_get_max_segments(int fd)
+static int hdev_read_blk_queue_entry(int fd, const char *key,
+    char *buf, int buf_len)
 {
 #ifdef CONFIG_LINUX
-    char buf[32];
-    const char *end;
     char *sysfspath = NULL;
     int ret;
     int sysfd = -1;
-    long max_segments;
     struct stat st;
 
     if (fstat(fd, &st)) {
@@ -1083,23 +1081,45 @@ static int sg_get_max_segments(int fd)
         goto out;
     }
 
-    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
-                                major(st.st_rdev), minor(st.st_rdev));
+    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
+                                major(st.st_rdev), minor(st.st_rdev), key);
     sysfd = open(sysfspath, O_RDONLY);
     if (sysfd == -1) {
         ret = -errno;
         goto out;
     }
     do {
-        ret = read(sysfd, buf, sizeof(buf) - 1);
+        ret = read(sysfd, buf, buf_len - 1);
     } while (ret == -1 && errno == EINTR);
     if (ret < 0) {
         ret = -errno;
-        goto out;
     } else if (ret == 0) {
         ret = -EIO;
+    }
+out:
+    if (sysfd != -1) {
+        close(sysfd);
+    }
+    g_free(sysfspath);
+    return ret;
+#else
+    return -ENOTSUP;
+#endif
+}
+
+static int sg_get_max_segments(int fd)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    const char *end;
+    int ret;
+    long max_segments;
+
+    ret = hdev_read_blk_queue_entry(fd, "max_segments", buf, sizeof(buf));
+    if (ret < 0) {
         goto out;
     }
+
     buf[ret] = 0;
     /* The file is ended with '\n', pass 'end' to accept that. */
     ret = qemu_strtol(buf, &end, 10, &max_segments);
@@ -1108,22 +1128,45 @@ static int sg_get_max_segments(int fd)
     }
 
 out:
-    if (sysfd != -1) {
-        close(sysfd);
-    }
-    g_free(sysfspath);
     return ret;
 #else
     return -ENOTSUP;
 #endif
 }
 
+static BdrvZonedModel hdev_get_zoned_model(int fd)
+{
+#ifdef CONFIG_LINUX
+    char buf[32];
+    BdrvZonedModel zm = BDRV_ZONED_MODEL_NONE;
+    int ret;
+
+    ret = hdev_read_blk_queue_entry(fd, "zoned", buf, sizeof(buf));
+    if (ret < 0) {
+        goto out;
+    }
+
+    buf[ret - 1] = '\0'; /* replace the newline character with NULL */
+    if (strcmp(buf, "host-managed") == 0) {
+        zm = BDRV_ZONED_MODEL_HM;
+    } else if (strcmp(buf, "host-aware") == 0) {
+        zm = BDRV_ZONED_MODEL_HA;
+    }
+
+out:
+    return zm;
+#else
+    return BDRV_ZONED_MODEL_NONE;
+#endif
+}
+
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
     if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+        ret = sg_get_max_transfer_length(s->fd);
 
         if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
             bs->bl.max_transfer = pow2floor(ret);
@@ -1133,6 +1176,12 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
         if (ret > 0) {
             bs->bl.max_transfer = MIN(bs->bl.max_transfer, ret * getpagesize());
         }
+
+    }
+
+    ret = hdev_get_zoned_model(s->fd);
+    if (ret >= 0) {
+        bs->bl.zoned_model = ret;
     }
 
     raw_probe_alignment(bs, s->fd, errp);
diff --git a/block/io.c b/block/io.c
index 0fa10831ed..147c320061 100644
--- a/block/io.c
+++ b/block/io.c
@@ -157,6 +157,11 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
             return;
         }
         bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
+
+        /* Propagate zoned model */
+        if (!bs->probed) {
+            bs->bl.zoned_model = bs->file->bs->bl.zoned_model;
+        }
     } else {
         bs->bl.min_mem_alignment = 512;
         bs->bl.opt_mem_alignment = getpagesize();
-- 
2.21.0


