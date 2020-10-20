Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C658C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9BD2224B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9BD2224B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsqd-0000Y1-VL
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUsob-0006ql-Mu; Tue, 20 Oct 2020 10:40:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5707 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUsoZ-0001uy-7o; Tue, 20 Oct 2020 10:40:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 22A4C24200025F8071F5;
 Tue, 20 Oct 2020 22:40:23 +0800 (CST)
Received: from DESKTOP-80C7KIU.china.huawei.com (10.174.187.210) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 22:40:14 +0800
From: Zhengui li <lizhengui@huawei.com>
To: <pbonzini@redhat.com>, <stefanha@redhat.com>, <mreitz@redhat.com>,
 <kwolf@redhat.com>
Subject: [PATCH v2 2/2] qemu-img: add support for rate limit in qemu-img
 convert
Date: Tue, 20 Oct 2020 14:39:59 +0000
Message-ID: <1603204799-17544-3-git-send-email-lizhengui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1603204799-17544-1-git-send-email-lizhengui@huawei.com>
References: <1603204799-17544-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.210]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=lizhengui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:15:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xieyingtai@huawei.com, lizhengui@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhengui <lizhengui@huawei.com>

add support for rate limit in qemu-img convert.

Signed-off-by: Zhengui <lizhengui@huawei.com>
---
 docs/tools/qemu-img.rst |  6 +++++-
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 27 ++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index bcb11b0..b615aa8 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -188,6 +188,10 @@ Parameters to convert subcommand:
   allocated target image depending on the host support for getting allocation
   information.
 
+.. option:: -r
+
+   Rate limit for the convert process
+
 .. option:: --salvage
 
   Try to ignore I/O errors when reading.  Unless in quiet mode (``-q``), errors
@@ -410,7 +414,7 @@ Command description:
   4
     Error on reading data
 
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-r RATE_LIMIT] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 
   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 2a31806..7eb489b 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ SRST
 ERST
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-r rate_limit] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
 SRST
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-r RATE_LIMIT] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 ERST
 
 DEF("create", img_create,
diff --git a/qemu-img.c b/qemu-img.c
index 3023abe..a968c74 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -50,6 +50,8 @@
 #include "block/qapi.h"
 #include "crypto/init.h"
 #include "trace/control.h"
+#include "qemu/throttle.h"
+#include "block/throttle-groups.h"
 
 #define QEMU_IMG_VERSION "qemu-img version " QEMU_FULL_VERSION \
                           "\n" QEMU_COPYRIGHT "\n"
@@ -1669,6 +1671,7 @@ enum ImgConvertBlockStatus {
 };
 
 #define MAX_COROUTINES 16
+#define CONVERT_THROTTLE_GROUP "img_convert"
 
 typedef struct ImgConvertState {
     BlockBackend **src;
@@ -2184,6 +2187,17 @@ static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState *dst)
 
 #define MAX_BUF_SECTORS 32768
 
+static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
+{
+    ThrottleConfig cfg;
+
+    throttle_config_init(&cfg);
+    cfg.buckets[THROTTLE_BPS_WRITE].avg = rate_limit;
+
+    blk_io_limits_enable(blk, CONVERT_THROTTLE_GROUP);
+    blk_set_io_limits(blk, &cfg);
+}
+
 static int img_convert(int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = 0;
@@ -2204,6 +2218,7 @@ static int img_convert(int argc, char **argv)
     bool force_share = false;
     bool explict_min_sparse = false;
     bool bitmaps = false;
+    int64_t rate_limit = 0;
 
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -2226,7 +2241,7 @@ static int img_convert(int argc, char **argv)
             {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
+        c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WUr:",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2323,6 +2338,12 @@ static int img_convert(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'r':
+            rate_limit = cvtnum("rate limit", optarg);
+            if (rate_limit < 0) {
+                goto fail_getopt;
+            }
+            break;
         case OPTION_OBJECT: {
             QemuOpts *object_opts;
             object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2712,6 +2733,10 @@ static int img_convert(int argc, char **argv)
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
     }
 
+    if (rate_limit) {
+        set_rate_limit(s.target, rate_limit);
+    }
+
     ret = convert_do_copy(&s);
 
     /* Now copy the bitmaps */
-- 
2.6.4.windows.1


