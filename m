Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D4C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 07:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EE92082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 07:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EE92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNBBY-0006SO-NR
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 03:03:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hNBAZ-00066n-07
	for qemu-devel@nongnu.org; Sun, 05 May 2019 03:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hNBAX-0006rb-Uj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 03:02:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2207 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1hNBAV-0006fH-Jk; Sun, 05 May 2019 03:02:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 2DAE08304B1FABB270A5;
	Sun,  5 May 2019 15:02:30 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
	DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server
	id 14.3.439.0; Sun, 5 May 2019 15:02:24 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
Date: Sun, 5 May 2019 15:00:59 +0800
Message-ID: <20190505070059.4664-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of backend
 image
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, ard.biesheuvel@linaro.org,
	armbru@redhat.com, mreitz@redhat.com,
	Xiang Zheng <zhengxiang9@huawei.com>, stefanha@redhat.com,
	guoheyi@huawei.com, wanghaibin.wang@huawei.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505070059.Lyq4oIDE-uobC6vxzuBp31m0JiopQOMfvBLpmgusxfg@z>

Currently we fill the memory space with two 64MB NOR images when
using persistent UEFI variables on virt board. Actually we only use
a very small(non-zero) part of the memory while the rest significant
large(zero) part of memory is wasted.

So this patch checks the block status and only writes the non-zero part
into memory. This requires pflash devices to use sparse files for
backends.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 hw/block/block.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c76..3cb9d4c 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -15,6 +15,44 @@
 #include "qapi/qapi-types-block.h"
 
 /*
+ * Read the non-zeroes parts of @blk into @buf
+ * Reading all of the @blk is expensive if the zeroes parts of @blk
+ * is large enough. Therefore check the block status and only write
+ * the non-zeroes block into @buf.
+ *
+ * Return 0 on success, non-zero on error.
+ */
+static int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
+{
+    int ret;
+    int64_t target_size, bytes, offset = 0;
+    BlockDriverState *bs = blk_bs(blk);
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_SECTORS);
+        if (bytes <= 0) {
+            return 0;
+        }
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (!(ret & BDRV_BLOCK_ZERO)) {
+            ret = bdrv_pread(bs->file, offset, (uint8_t *) buf + offset, bytes);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        offset += bytes;
+    }
+}
+
+/*
  * Read the entire contents of @blk into @buf.
  * @blk's contents must be @size bytes, and @size must be at most
  * BDRV_REQUEST_MAX_BYTES.
@@ -53,7 +91,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
      * block device and read only on demand.
      */
     assert(size <= BDRV_REQUEST_MAX_BYTES);
-    ret = blk_pread(blk, 0, buf, size);
+    ret = blk_pread_nonzeroes(blk, buf);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "can't read block backend");
         return false;
-- 
1.8.3.1



