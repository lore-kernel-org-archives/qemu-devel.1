Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6BC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C577921D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="eMcv9Kjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577921D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUAY-0002wY-S3
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c418f935ac6aed9aa1dc0ceb4b19044a9b7b7968@lizzy.crudebyte.com>)
 id 1kIU9A-0001BL-G4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:54:40 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:37623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c418f935ac6aed9aa1dc0ceb4b19044a9b7b7968@lizzy.crudebyte.com>)
 id 1kIU99-0000jl-3Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=DqzpM+VGQVKR7OCnZLPpx0lh9Fsm7b5Rfn+2RWn2HXo=; b=eMcv9
 KjmDBWAUk66OF+1ExXWM2iN6sANkmjUb4zbh64cr8DVDeGWPXwfAoI3CeBm3kit5cztVJYLaz0zRk
 9h+l7N3IRmlaSmacgeNRCxzgmZpANz+cajF3lTEm5PZsxrC2OV8BoC15NMFRyuswW0tlCtLiV7yPP
 Dm84VazLwZyTttR3yED9kZm8Vzx+hWPdA7p+CjDsfVvv8BzQ8dr3ZR8ALBviKPMMFXsrRgmO3HCMY
 H3BoEYSU7CLZ4yTsGgwJQ031fM/DS403TtjlUVHISVDT9Go8KW55iG6fH7yYz6q+XuBgg99wI9wxK
 432FGFk9jFCbqUGHmvdT5ENJZWoWQ==;
Message-Id: <c418f935ac6aed9aa1dc0ceb4b19044a9b7b7968.1600166281.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1600166281.git.qemu_oss@crudebyte.com>
References: <cover.1600166281.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 6 Sep 2020 18:50:32 +0200
Subject: [PULL 2/2] 9pfs: disable msize warning for synth driver
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=c418f935ac6aed9aa1dc0ceb4b19044a9b7b7968@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 05:20:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patch introduced a performance warning being logged on host
side if client connected with an 'msize' <= 8192. Disable this
performance warning for the synth driver to prevent that warning from
being printed whenever the 9pfs (qtest) test cases are running.

Introduce a new export flag V9FS_NO_PERF_WARN for that purpose, which
might also be used to disable such warnings from the CLI in future.

We could have also prevented the warning by simply raising P9_MAX_SIZE
in virtio-9p-test.c to any value larger than 8192, however in the
context of test cases it makes sense running for edge cases, which
includes the lowest 'msize' value supported by the server which is
4096, hence we want to preserve an msize of 4096 for the test client.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h | 4 ++++
 hw/9pfs/9p-synth.c | 2 ++
 hw/9pfs/9p.c       | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index f2f7772c86..d51cec2f3b 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -64,6 +64,10 @@ typedef struct ExtendedOps {
  */
 #define V9FS_REMAP_INODES           0x00000200
 #define V9FS_FORBID_MULTIDEVS       0x00000400
+/*
+ * Disables certain performance warnings from being logged on host side.
+ */
+#define V9FS_NO_PERF_WARN           0x00000800
 
 #define V9FS_SEC_MASK               0x0000003C
 
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 7eb210ffa8..cec8c0eefc 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -541,6 +541,8 @@ static int synth_init(FsContext *ctx, Error **errp)
     QLIST_INIT(&synth_root.child);
     qemu_mutex_init(&synth_mutex);
 
+    ctx->export_flags |= V9FS_NO_PERF_WARN;
+
     /* Add "." and ".." entries for root */
     v9fs_add_dir_node(&synth_root, synth_root.attr->mode,
                       "..", synth_root.attr, synth_root.attr->inode);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 99b6f24fd6..741d222c3f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1354,7 +1354,7 @@ static void coroutine_fn v9fs_version(void *opaque)
     }
 
     /* 8192 is the default msize of Linux clients */
-    if (s->msize <= 8192) {
+    if (s->msize <= 8192 && !(s->ctx.export_flags & V9FS_NO_PERF_WARN)) {
         warn_report_once(
             "9p: degraded performance: a reasonable high msize should be "
             "chosen on client/guest side (chosen msize is <= 8192). See "
-- 
2.20.1


