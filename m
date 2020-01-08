Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70DDC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D5C2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PotJdK4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D5C2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47497 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFWM-0001Vp-Kl
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipFTM-0005Sn-8b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipFTL-00016Y-0V
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:55159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipFTK-0000WP-Nj; Wed, 08 Jan 2020 12:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=oaC6J/0lUcjbOOUGMSdrNrClykmLQMSX94HkHdlFe6U=; 
 b=PotJdK4r3/RsQOm6I5s8ld9iBhJnItPcFQTeCXCYW49F4E51WfPVGNXIu85ZDJ0+fqKAZ5WSfxuxvANvWVbOh6jJvkk6A/cZiikuw46KoLLmVMWRsZ5G3jlp/vzBsyuYtPMzrjHhX9VLuq0FcQAqLDPPspo1u7Xlkkj7N3FvhxPFxWmCJWFlyNCLXRoOAzUYkiP6Y3AiHDFVz41Ai8jmtwhjXfBQga6YxMyOj3IFE3pWQdpKIzJR9dyvI44E9Rd/Cfip+67DXRTgnBG4o2KaY0Wj3SboOcY/9JhomyaV3K98GTUbxyOrZEJfL9Rdvf9BdjyQPABBgwv1QDB4nueBpQ==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipFT1-0001HO-Lz; Wed, 08 Jan 2020 18:50:03 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipFSD-0000Db-Bs; Wed, 08 Jan 2020 18:49:13 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qcow2: Don't round the L1 table allocation up to the
 sector size
Date: Wed,  8 Jan 2020 18:49:09 +0100
Message-Id: <672f5b3c7c6bc12548c72ec309a7b2a01d253a72.1578505678.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1578505678.git.berto@igalia.com>
References: <cover.1578505678.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The L1 table is read from disk using the byte-based bdrv_pread() and
is never accessed beyond its last element, so there's no need to
allocate more memory than that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c  | 5 ++---
 block/qcow2-refcount.c | 2 +-
 block/qcow2-snapshot.c | 3 +--
 block/qcow2.c          | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8982b7b762..932fc48919 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -124,12 +124,11 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
 #endif
 
     new_l1_size2 = sizeof(uint64_t) * new_l1_size;
-    new_l1_table = qemu_try_blockalign(bs->file->bs,
-                                       ROUND_UP(new_l1_size2, 512));
+    new_l1_table = qemu_try_blockalign(bs->file->bs, new_l1_size2);
     if (new_l1_table == NULL) {
         return -ENOMEM;
     }
-    memset(new_l1_table, 0, ROUND_UP(new_l1_size2, 512));
+    memset(new_l1_table, 0, new_l1_size2);
 
     if (s->l1_size) {
         memcpy(new_l1_table, s->l1_table, s->l1_size * sizeof(uint64_t));
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..c963bc8de1 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1262,7 +1262,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
      * l1_table_offset when it is the current s->l1_table_offset! Be careful
      * when changing this! */
     if (l1_table_offset != s->l1_table_offset) {
-        l1_table = g_try_malloc0(ROUND_UP(l1_size2, 512));
+        l1_table = g_try_malloc0(l1_size2);
         if (l1_size2 && l1_table == NULL) {
             ret = -ENOMEM;
             goto fail;
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 5ab64da1ec..82c32d4c9b 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -1024,8 +1024,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
         return ret;
     }
     new_l1_bytes = sn->l1_size * sizeof(uint64_t);
-    new_l1_table = qemu_try_blockalign(bs->file->bs,
-                                       ROUND_UP(new_l1_bytes, 512));
+    new_l1_table = qemu_try_blockalign(bs->file->bs, new_l1_bytes);
     if (new_l1_table == NULL) {
         return -ENOMEM;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 92474849db..e8ce966f7f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1499,7 +1499,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     if (s->l1_size > 0) {
         s->l1_table = qemu_try_blockalign(bs->file->bs,
-            ROUND_UP(s->l1_size * sizeof(uint64_t), 512));
+                                          s->l1_size * sizeof(uint64_t));
         if (s->l1_table == NULL) {
             error_setg(errp, "Could not allocate L1 table");
             ret = -ENOMEM;
-- 
2.20.1


