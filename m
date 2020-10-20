Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C78C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983F220EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983F220EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvZT-0005WZ-Jb
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ccc858509ddfa3f6244cc4caf92c4149b7269b43@lizzy.crudebyte.com>)
 id 1kVvY0-0003sg-Gq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:47:52 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ccc858509ddfa3f6244cc4caf92c4149b7269b43@lizzy.crudebyte.com>)
 id 1kVvXo-0004HB-9H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:47:52 -0400
Message-Id: <ccc858509ddfa3f6244cc4caf92c4149b7269b43.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Oct 2020 18:09:14 +0200
Subject: [PULL 01/13] tests/9pfs: Factor out do_version() helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=ccc858509ddfa3f6244cc4caf92c4149b7269b43@lizzy.crudebyte.com;
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

fs_version() is a top level test function. Factor out the reusable
code to a separate helper instead of hijacking it in other tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321015403.266767.4533967728943968456.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c15908f27b..59bcea4c30 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
     v9fs_req_free(req);
 }
 
-static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
+static void do_version(QVirtio9P *v9p)
 {
-    QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     const char *version = "9P2000.L";
     uint16_t server_len;
     char *server_version;
@@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(server_version);
 }
 
+static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    alloc = t_alloc;
+    do_version(obj);
+}
+
 static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     alloc = t_alloc;
     P9Req *req;
 
-    fs_version(v9p, NULL, t_alloc);
+    do_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, NULL);
@@ -831,7 +835,7 @@ static void fs_walk_dotdot(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_qid root_qid, *wqid;
     P9Req *req;
 
-    fs_version(v9p, NULL, t_alloc);
+    do_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, &root_qid);
-- 
2.20.1


