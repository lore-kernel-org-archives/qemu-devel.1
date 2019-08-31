Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50811C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1054B23697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ea+lR4OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1054B23697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3snV-0000zr-5a
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 22:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1i3sl5-0000MA-5h
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1i3sl2-0005YP-Uj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:04:53 -0400
Received: from m12-13.163.com ([220.181.12.13]:60919)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>)
 id 1i3skt-0004uh-Ly; Fri, 30 Aug 2019 22:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=NfqNl877nCR/D/aM0d
 taU66xKq6QVIG5592QvPQsrK4=; b=ea+lR4OUcrhfKYylc5ADLUburyopuHbHkm
 3WVRATM4DXi81+pYWA60pR3pWa5XhvivwddbF1fMR/V20f21wACVZ8cjQ+0TGez4
 nLEgOPw4qhAFFhY2qj/rHcOKsxcui1U5bYP2NBh3TSFS16IGqLvpNDUxBr4FrSm0
 6y6hBwJyQ=
Received: from localhost.localdomain (unknown [183.158.152.47])
 by smtp9 (Coremail) with SMTP id DcCowAAXheex1WldVYrCAQ--.6740S2;
 Sat, 31 Aug 2019 10:04:34 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: kwolf@redhat.com,
	mreitz@redhat.com
Date: Fri, 30 Aug 2019 19:04:32 -0700
Message-Id: <20190831020432.61473-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAAXheex1WldVYrCAQ--.6740S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxtr1kAF1xJry3ury8Xwb_yoW8KFy5pr
 9FgryfGr1FgryrJr4DG3srZr4fW3yDCryUGFyxGw1Yqa4akr17Xr4kKryDuFWUKws3Zrs8
 Zr4UGr1xuryxtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMxRDUUUUU=
X-Originating-IP: [183.158.152.47]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZhIibVaD3Oh7ngAAs-
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH] block: qcow2: free 'refcount_table' in error
 path
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, when doing './check -qcow2 098'. We can get following
asan output:

qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
+
+=================================================================
+==60365==ERROR: LeakSanitizer: detected memory leaks
+
+Direct leak of 65536 byte(s) in 1 object(s) allocated from:
+    #0 0x7f3ed729fd38 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded38)
+    #1 0x56274517fe66 in make_completely_empty block/IMGFMT.c:4219
+    #2 0x562745180e51 in IMGFMT_make_empty block/IMGFMT.c:4313
+    #3 0x56274509b14e in img_commit /home/test/qemu5/qemu/qemu-img.c:1053
+    #4 0x5627450b4b74 in main /home/test/qemu5/qemu/qemu-img.c:5097
+    #5 0x7f3ed4f2fb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)

This is because the logic of clean resource in 'make_completely_empty' is
wrong. The patch frees the 's->refcount_table' in error path.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 block/qcow2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7c5a4859f7..23fe713d4c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4243,7 +4243,7 @@ static int make_completely_empty(BlockDriverState *bs)
     ret = bdrv_pwrite_sync(bs->file, s->cluster_size,
                            &rt_entry, sizeof(rt_entry));
     if (ret < 0) {
-        goto fail_broken_refcounts;
+        goto fail;
     }
     s->refcount_table[0] = 2 * s->cluster_size;
 
@@ -4252,7 +4252,7 @@ static int make_completely_empty(BlockDriverState *bs)
     offset = qcow2_alloc_clusters(bs, 3 * s->cluster_size + l1_size2);
     if (offset < 0) {
         ret = offset;
-        goto fail_broken_refcounts;
+        goto fail;
     } else if (offset > 0) {
         error_report("First cluster in emptied image is in use");
         abort();
@@ -4274,6 +4274,9 @@ static int make_completely_empty(BlockDriverState *bs)
 
     return 0;
 
+fail:
+    g_free(s->refcount_table);
+
 fail_broken_refcounts:
     /* The BDS is unusable at this point. If we wanted to make it usable, we
      * would have to call qcow2_refcount_close(), qcow2_refcount_init(),
@@ -4283,8 +4286,6 @@ fail_broken_refcounts:
      * that that sequence will fail as well. Therefore, just eject the BDS. */
     bs->drv = NULL;
 
-fail:
-    g_free(new_reftable);
     return ret;
 }
 
-- 
2.17.1



