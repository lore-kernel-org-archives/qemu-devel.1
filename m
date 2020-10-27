Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B3C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2120B2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxvjiXzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQj6-0007Vv-1z
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQh5-00060q-SG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQh3-0007ch-89
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntqGXYo9lr723+8Dd351mPk63pIW8utRAmMqxbub4sg=;
 b=gxvjiXzgR0msehfO+ES63X6EU1b3cjCEHuCCHv4PdXrrC226ldquPQDgETaRXU91bvRtvJ
 v43ljWAr4YmmZwvMgxBJt06+uaAwAdkZl1NcgCzrZXDkrnEIoli3RFN5GEsA11UjzhJkD0
 5QHPSyLXrYFpFjT7+JQjziiK+iqEk6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-6PMuBtGwMpOKe26lXuXiAQ-1; Tue, 27 Oct 2020 11:15:20 -0400
X-MC-Unique: 6PMuBtGwMpOKe26lXuXiAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5713EC1C0;
 Tue, 27 Oct 2020 15:15:19 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5AF855773;
 Tue, 27 Oct 2020 15:15:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/5] qemu-img: add support for rate limit in qemu-img commit
Date: Tue, 27 Oct 2020 16:15:11 +0100
Message-Id: <20201027151515.213565-2-kwolf@redhat.com>
In-Reply-To: <20201027151515.213565-1-kwolf@redhat.com>
References: <20201027151515.213565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhengui <lizhengui@huawei.com>

add support for rate limit in qemu-img commit.

Signed-off-by: Zhengui <lizhengui@huawei.com>
Message-Id: <1603205264-17424-2-git-send-email-lizhengui@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  4 +++-
 qemu-img.c              | 11 +++++++++--
 qemu-img-cmds.hx        |  4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index c35bd64822..bcb11b0899 100644
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
diff --git a/qemu-img.c b/qemu-img.c
index 2103507936..3023abea8b 100644
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
@@ -1026,6 +1027,12 @@ static int img_commit(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'r':
+            rate_limit = cvtnum("rate limit", optarg);
+            if (rate_limit < 0) {
+                return 1;
+            }
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1099,7 +1106,7 @@ static int img_commit(int argc, char **argv)
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
-    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, 0,
+    commit_active_start("commit", bs, base_bs, JOB_DEFAULT, rate_limit,
                         BLOCKDEV_ON_ERROR_REPORT, NULL, common_block_job_cb,
                         &cbi, false, &local_err);
     aio_context_release(aio_context);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index cab8234235..965c1e3e59 100644
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
-- 
2.28.0


