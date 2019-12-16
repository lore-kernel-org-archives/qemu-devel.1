Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D309C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562B124672
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="DOwwp1xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562B124672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihNKC-0003Zs-Hs
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 19:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <d7b84b1ca693b51413e9e7c148739fec0a5fcdca@lizzy.crudebyte.com>)
 id 1ihNHN-0001nv-Ux
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <d7b84b1ca693b51413e9e7c148739fec0a5fcdca@lizzy.crudebyte.com>)
 id 1ihNHM-0001dI-ED
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:33:29 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:44093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <d7b84b1ca693b51413e9e7c148739fec0a5fcdca@lizzy.crudebyte.com>)
 id 1ihNHM-0008Ou-6x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Subject:Date:Cc:To:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=Of3kdSNGm1c+zy/bfBvYPY10KOTunHycAP/quTGcvK4=; b=DOwwp
 1xFX2Pbl3pylqHR+PjM5cOywxNj8/JsLt6FPdWrHLGCFjW58Tkjmk4S4/n+R+hSo0JKLrry85HVIG
 c73iAMHqgNZ384s028tsGYC01MZVD+U6umrRjjvDzR6xTkMxXBp8F9+NKDn/ISjcRv+5+GPCmE63d
 aHIIfZXAbIeyAITadV6evWD7ZzswTbz+mzh3Ocs4oykSU/aqQqFxCer2mCl4ZD3drJhtk82/xagWa
 zgYZ/jOIMLiav/cEj53VkNXbnrysaPeQKwQh/0oHCiyjXGQZsk0KqycVP6EqJ4i9HaQlZ+8intxtB
 eOQRR20klocaL0h/AtDtFQSmVuW6Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Mon, 16 Dec 2019 16:34:04 +0100
Subject: [PATCH 5/9] tests/virtio-9p: check file names of READDIR response
Message-Id: <E1ihMv6-00077n-K5@lizzy.crudebyte.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
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

Additionally to the already existing check for expected amount
of directory entries returned by R_readdir response, also check
whether all entries have the expected file names, ignoring
their precise order in result list though.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/virtio-9p-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index ab5926527a..dafea1ae61 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -563,6 +563,15 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wqid);
 }
 
+static bool fs_dirents_contain_name(struct v9fs_dirent *e, const char* name) {
+    for (; e; e = e->next) {
+        if (!strcmp(e->name, name)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -600,6 +609,18 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
         QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
     );
 
+    /*
+     * Check all file names exist in returned entries, ignore their order
+     * though.
+     */
+    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
+    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
+    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
+        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
+        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
+        g_free(name);
+    }
+
     v9fs_free_dirents(entries);
     g_free(wnames[0]);
 }
-- 
2.20.1


