Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D03C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DD820857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DD820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvcc-0002N8-Ev
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c2f93e5bb1ee5cc05875ac40b1f9ad0738241c37@lizzy.crudebyte.com>)
 id 1kVvY6-0003xW-KT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:47:58 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:53121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c2f93e5bb1ee5cc05875ac40b1f9ad0738241c37@lizzy.crudebyte.com>)
 id 1kVvY5-0004Ir-93
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:47:58 -0400
Message-Id: <c2f93e5bb1ee5cc05875ac40b1f9ad0738241c37.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Oct 2020 18:09:20 +0200
Subject: [PULL 04/13] tests/9pfs: Turn fs_readdir_split() into a helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=c2f93e5bb1ee5cc05875ac40b1f9ad0738241c37@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 07:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fs_readdir_split() isn't a top level test function and thus shouldn't
take the "void *obj, void *data, QGuestAllocator *t_alloc" arguments.
Turn it into a helper to be used by test functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321016084.266767.9501523425012383531.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index e07292bdb8..3c187cdc08 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -731,11 +731,8 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 }
 
 /* readdir test where overall request is split over several messages */
-static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc,
-                             uint32_t count)
+static void do_readdir_split(QVirtio9P *v9p, uint32_t count)
 {
-    QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
     uint16_t nqid;
     v9fs_qid qid;
@@ -1002,19 +999,22 @@ static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
 static void fs_readdir_split_128(void *obj, void *data,
                                  QGuestAllocator *t_alloc)
 {
-    fs_readdir_split(obj, data, t_alloc, 128);
+    alloc = t_alloc;
+    do_readdir_split(obj, 128);
 }
 
 static void fs_readdir_split_256(void *obj, void *data,
                                  QGuestAllocator *t_alloc)
 {
-    fs_readdir_split(obj, data, t_alloc, 256);
+    alloc = t_alloc;
+    do_readdir_split(obj, 256);
 }
 
 static void fs_readdir_split_512(void *obj, void *data,
                                  QGuestAllocator *t_alloc)
 {
-    fs_readdir_split(obj, data, t_alloc, 512);
+    alloc = t_alloc;
+    do_readdir_split(obj, 512);
 }
 
 
-- 
2.20.1


