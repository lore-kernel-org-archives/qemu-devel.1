Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D0C20578
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bjJWIBmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D0C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVnV-0004aW-Kw
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <791b4a190c14e1d85dbeb457b242fe6837f6c446@lizzy.crudebyte.com>)
 id 1kYVek-0001DF-M0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <791b4a190c14e1d85dbeb457b242fe6837f6c446@lizzy.crudebyte.com>)
 id 1kYVej-00037W-0b
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=eeuqH5oLjRogQTrznzf5l9BTjeSWCCwATfx/A0TEzns=; b=bjJWI
 BmS7ruoFdXCxw7sZo2GYqx63knlwcTYEjzNtKDJgrnZXSDtZfNJKW0vNRVIqrOkE532HHGJ52AhOq
 naQ5fYmj5Pn7WA8kt1Q/uXG+pUllrdZV7mQ2YYSbmrvBDbwa6YUMRhfecRtIjqPMoDkIIaJLeyk/B
 RO0WVOZ3eu4S5uaupt5e6rs14EJ8avYWUS+kZnrVS1unllLpWrr9yBLcCGkspdiXmPw/Q+ao9yV7E
 EXPhtKDVbiklfAvoI599/V0zcJneZFG+uzSjIB6TUywWDtuH6OylpQAGg0tiFplU2p5lLxze5b3vH
 t3ko3aA6kaMssLd9MqrLDXQenmsPw==;
Message-Id: <791b4a190c14e1d85dbeb457b242fe6837f6c446.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 18:09:34 +0200
Subject: [PULL v2 06/16] tests/9pfs: Factor out do_attach() helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=791b4a190c14e1d85dbeb457b242fe6837f6c446@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

From: Greg Kurz <groug@kaod.org>

fs_attach() is a top level test function. Factor out the reusable
code to a separate helper instead of hijacking it in other tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321017450.266767.17377192504263871186.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 93a2a4cd76..e07292bdb8 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -589,10 +589,8 @@ static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
     do_version(obj);
 }
 
-static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
+static void do_attach(QVirtio9P *v9p)
 {
-    QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     P9Req *req;
 
     do_version(v9p);
@@ -601,6 +599,12 @@ static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_rattach(req, NULL);
 }
 
+static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    alloc = t_alloc;
+    do_attach(obj);
+}
+
 static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -615,7 +619,7 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
         wnames[i] = g_strdup_printf(QTEST_V9FS_SYNTH_WALK_FILE, i);
     }
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nwqid, &wqid);
@@ -684,7 +688,7 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
     struct V9fsDirent *entries = NULL;
     P9Req *req;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nqid, NULL);
@@ -741,7 +745,7 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc,
     int fid;
     uint64_t offset;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
 
     fid = 1;
     offset = 0;
@@ -817,7 +821,7 @@ static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
     P9Req *req;
     uint32_t err;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlerror(req, &err);
@@ -857,7 +861,7 @@ static void fs_lopen(void *obj, void *data, QGuestAllocator *t_alloc)
     char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_LOPEN_FILE) };
     P9Req *req;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -879,7 +883,7 @@ static void fs_write(void *obj, void *data, QGuestAllocator *t_alloc)
     uint32_t count;
     P9Req *req;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -906,7 +910,7 @@ static void fs_flush_success(void *obj, void *data, QGuestAllocator *t_alloc)
     uint32_t reply_len;
     uint8_t should_block;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -943,7 +947,7 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     uint32_t count;
     uint8_t should_block;
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -1026,7 +1030,7 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
 
     g_assert(root_path != NULL);
 
-    fs_attach(v9p, NULL, t_alloc);
+    do_attach(v9p);
     fs_mkdir(v9p, data, t_alloc, "/", "01");
 
     /* check if created directory really exists now ... */
-- 
2.20.1


