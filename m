Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF844C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7D62098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7D62098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUq0k-0007z3-6N
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUpzG-0006Xn-1d; Tue, 20 Oct 2020 07:39:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50000 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUpzC-0002y2-QX; Tue, 20 Oct 2020 07:39:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4127E4334A3773969C3A;
 Tue, 20 Oct 2020 19:39:20 +0800 (CST)
Received: from DESKTOP-80C7KIU.china.huawei.com (10.174.187.210) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 19:39:13 +0800
From: Zhengui li <lizhengui@huawei.com>
To: <pbonzini@redhat.com>, <stefanha@redhat.com>, <mreitz@redhat.com>,
 <kwolf@redhat.com>
Subject: [PATCH v2 1/2] qemu-img: add support for offline rate limit in
 qemu-img commit
Date: Tue, 20 Oct 2020 11:39:05 +0000
Message-ID: <1603193946-30096-1-git-send-email-lizhengui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.210]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=lizhengui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:04:17
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

Currently, there is no rate limit for qemu-img commit. This may
cause the task of qemu-img commit to consume all the bandwidth
of the storage. This will affect the IO performance of other processes
and virtual machines under shared storage. So we add support for
offline rate limit in qemu-img commit to get better quality of sevice.

Signed-off-by: Zhengui <lizhengui@huawei.com>
---
 docs/tools/qemu-img.rst |  4 +++-
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index c35bd64..bcb11b0 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -349,7 +349,7 @@ Command description:
   state after (the attempt at) repairing it. That is, a successful ``-r all``
   will yield the exit code 0, independently of the image state before.
 
-.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
+.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-r RATE_LIMIT] [-d] [-p] FILENAME
 
   Commit the changes recorded in *FILENAME* in its base image or backing file.
   If the backing file is smaller than the snapshot, then the backing file will be
@@ -371,6 +371,8 @@ Command description:
   garbage data when read. For this reason, ``-b`` implies ``-d`` (so that
   the top image stays valid).
 
+  The rate limit for the commit process is specified by ``-r``.
+
 .. option:: compare [--object OBJECTDEF] [--image-opts] [-f FMT] [-F FMT] [-T SRC_CACHE] [-p] [-q] [-s] [-U] FILENAME1 FILENAME2
 
   Check if two images have the same content. You can compare images with
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b89c019..2a31806 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -34,9 +34,9 @@ SRST
 ERST
 
 DEF("commit", img_commit,
-    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
+    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-r rate_limit] [-d] [-p] filename")
 SRST
-.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
+.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-r RATE_LIMIT] [-d] [-p] FILENAME
 ERST
 
 DEF("compare", img_compare,
diff --git a/qemu-img.c b/qemu-img.c
index 2103507..ea66139 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -980,6 +980,7 @@ static int img_commit(int argc, char **argv)
     CommonBlockJobCBInfo cbi;
     bool image_opts = false;
     AioContext *aio_context;
+    int64_t rate_limit = 0;
 
     fmt = NULL;
     cache = BDRV_DEFAULT_CACHE;
@@ -991,7 +992,7 @@ static int img_commit(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:ht:b:dpq",
+        c = getopt_long(argc, argv, ":f:ht:b:dpqr:",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1026,6 +1027,15 @@ static int img_commit(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'r': {
+            int64_t sval;
+
+            sval = cvtnum("rate limit", optarg);
+            if (sval < 0) {
+                return 1;
+            }
+            rate_limit = sval;
+        }   break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1099,7 +1109,7 @@ static int img_commit(int argc, char **argv)
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
-    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, 0,
+    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, rate_limit,
                         BLOCKDEV_ON_ERROR_REPORT, NULL, common_block_job_cb,
                         &cbi, false, &local_err);
     aio_context_release(aio_context);
-- 
2.6.4.windows.1


