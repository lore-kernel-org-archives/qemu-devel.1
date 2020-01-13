Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB6C33CAE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDE921556
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UWQQmmjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDE921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irAAj-0008Fr-Uh
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <178b9a7187b004998ffb313ef750851cdbfbcf6c@lizzy.crudebyte.com>)
 id 1irA9T-00069V-BY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <178b9a7187b004998ffb313ef750851cdbfbcf6c@lizzy.crudebyte.com>)
 id 1irA9S-00083m-Ar
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:33:47 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:51305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <178b9a7187b004998ffb313ef750851cdbfbcf6c@lizzy.crudebyte.com>)
 id 1irA9S-0007Cq-4E
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=gSrLBSeXST+abK1XbYVkGJqXNFTw0aCRskxx7cYuZSs=; b=UWQQm
 mjoTPNdhEHqMVk6AY9QFdwIvpFrjR6euqqw0XF3mP57PS36ct8ibrN6TtIJJJiTH7WtSEWXecX3r4
 PtdTDSmjcAADDTSBybOShpbjINELO3+O83XW67RJCxPt6FZ98APrKX2wDVsz/T/uw4MxE1Q6vk8qL
 t8kfA9kfOaY6/6SGlsAhkKWGEFyL8ZEjX+wUjQABro4UWjuYxJGT/Z5ZtLfGFmNPZR/4pPUrPh2ge
 jYNSlCwSA2BD3KEkU1TfyGPE591Xq1GTmFDlqggDgjb89G8VGFpNlxrVxMrf5i0CES/thd4oIIS1C
 s8HNp8gDqyxKelTp+i1fzHbYbjagQ==;
Message-Id: <178b9a7187b004998ffb313ef750851cdbfbcf6c.1578957500.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1578957500.git.qemu_oss@crudebyte.com>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 14 Jan 2020 00:13:55 +0100
Subject: [PATCH v3 07/11] tests/virtio-9p: failing splitted readdir test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
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

This patch is not intended to be merged. It resembles
an issue (with debug messages) where the splitted
readdir test fails because server is interrupted with
transport error "Failed to decode VirtFS request type 40",
which BTW fails both with the unoptimized and with the
optimized 9p readdir code.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/virtio-9p-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 55bfe41dfd..f5a8a192b5 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -644,13 +644,14 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
     int fid;
     uint64_t offset;
     /* the Treaddir 'count' parameter values to be tested */
-    const uint32_t vcount[] = { 512, 256 };
+    const uint32_t vcount[] = { 512, 256, 128 };
     const int nvcount = sizeof(vcount) / sizeof(uint32_t);
 
     fs_attach(v9p, NULL, t_alloc);
 
     /* iterate over all 'count' parameter values to be tested with Treaddir */
     for (subtest = 0; subtest < nvcount; ++subtest) {
+        printf("\nsubtest[%d] with count=%d\n", subtest, vcount[subtest]);
         fid = subtest + 1;
         offset = 0;
         entries = NULL;
@@ -671,12 +672,16 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
          * entries
          */
         while (true) {
+            printf("\toffset=%ld\n", offset);
             npartialentries = 0;
             partialentries = NULL;
 
+            printf("Treaddir fid=%d offset=%ld count=%d\n",
+                   fid, offset, vcount[subtest]);
             req = v9fs_treaddir(v9p, fid, offset, vcount[subtest], 0);
             v9fs_req_wait_for_reply(req, NULL);
             v9fs_rreaddir(req, &count, &npartialentries, &partialentries);
+            printf("\t\tnpartial=%d nentries=%d\n", npartialentries, nentries);
             if (npartialentries > 0 && partialentries) {
                 if (!entries) {
                     entries = partialentries;
@@ -713,6 +718,8 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
         }
 
         v9fs_free_dirents(entries);
+
+        printf("PASSED subtest[%d]\n", subtest);
     }
 
     g_free(wnames[0]);
-- 
2.20.1


