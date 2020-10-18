Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBEC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 06:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13C320EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 06:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13C320EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU2JI-0008FX-Nd
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 02:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kU2Gw-0006Xi-Dr; Sun, 18 Oct 2020 02:34:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38996 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kU2Gt-0006C7-Rr; Sun, 18 Oct 2020 02:34:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 02C5AE006DC6BB0AAC8B;
 Sun, 18 Oct 2020 14:34:11 +0800 (CST)
Received: from DESKTOP-80C7KIU.china.huawei.com (10.174.187.210) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sun, 18 Oct 2020 14:34:03 +0800
From: Zhengui li <lizhengui@huawei.com>
To: <pbonzini@redhat.com>, <stefanha@redhat.com>, <mreitz@redhat.com>,
 <kwolf@redhat.com>
Subject: [PATCH] qemu-img: add support for rate limit in qemu-img commit
Date: Sun, 18 Oct 2020 06:33:59 +0000
Message-ID: <1603002839-1532-1-git-send-email-lizhengui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.210]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=lizhengui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 02:34:11
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
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b89c019..ed55b76 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -34,9 +34,9 @@ SRST
 ERST
 
 DEF("commit", img_commit,
-    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
+    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-s speed] [-d] [-p] filename")
 SRST
-.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-d] [-p] FILENAME
+.. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t CACHE] [-b BASE] [-s SPEED] [-d] [-p] FILENAME
 ERST
 
 DEF("compare", img_compare,
diff --git a/qemu-img.c b/qemu-img.c
index 2103507..74e4d64 100644
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
+        c = getopt_long(argc, argv, ":f:ht:b:dpqs:",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1026,6 +1027,14 @@ static int img_commit(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 's': {
+            unsigned long long sval;
+            if (qemu_strtou64(optarg, NULL, 10, &sval)) {
+                error_report("rate limit parse failed");
+                return 1;
+            }
+            rate_limit = (int64_t)sval * 1024 * 1024;
+        }   break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1099,7 +1108,7 @@ static int img_commit(int argc, char **argv)
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
-    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, 0,
+    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, rate_limit,
                         BLOCKDEV_ON_ERROR_REPORT, NULL, common_block_job_cb,
                         &cbi, false, &local_err);
     aio_context_release(aio_context);
-- 
1.8.3.1


