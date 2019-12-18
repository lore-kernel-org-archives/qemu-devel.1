Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C24C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F85224676
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="SPxy7F0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihb5Y-0006kl-S4
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <2a40095340d9536575af8fd214a7ac647b4603c9@lizzy.crudebyte.com>)
 id 1ihb4C-0005Xz-OK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <2a40095340d9536575af8fd214a7ac647b4603c9@lizzy.crudebyte.com>)
 id 1ihb4B-000436-J6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:16:48 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:52497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <2a40095340d9536575af8fd214a7ac647b4603c9@lizzy.crudebyte.com>)
 id 1ihb4B-0006bb-A1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=dS1iuR3dCQd46YTSHKj8EZ1+/iu1EX7LIzJnLFpbqfQ=; b=SPxy7
 F0MDCIgP8kqguZzShP3LZfUxYXYPE6reJmoNy9o9Qq/fd2gGYvlCUmhtNqHd3qTm41SBtV5Pd+j4m
 cZydf6x8sk5TrDrStOJRalB8yecl0oqXbCvG/aO2zFgLdT855b0tRpw5aHCYRKlOc52OywdEOqgqL
 T6U6Ehu4qGLJD/3xKaxazZRYtDX584PJPfnsr1I/WHxtDGl/j+h6BR1pFcZ9YgxBAny2KqNONOtgf
 SOJ//dJ17qGGFBWA1HuGFc3wBWKLUgFzNKx1VJIuMpKEurDaGBhj3cP2M4FhYUfIdOLjk6GBb3Srf
 4JKw3N3jXaouYm8wgQ8EKlUHysIzg==;
Message-Id: <2a40095340d9536575af8fd214a7ac647b4603c9.1576678644.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Wed, 18 Dec 2019 14:35:56 +0100
Subject: [PATCH v2 5/9] tests/virtio-9p: check file names of R_readdir response
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
whether all directory entries have the expected file names (as
created on 9pfs synth driver side), ignoring their precise order
in result list though.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/virtio-9p-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 48c0eca292..cb5c9fb420 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -565,6 +565,16 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wqid);
 }
 
+static bool fs_dirents_contain_name(struct v9fs_dirent *e, const char* name)
+{
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
@@ -599,6 +609,18 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
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


