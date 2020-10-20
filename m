Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1858122247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1858122247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtLV-00085m-P8
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUtIW-0003zU-Gt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:36 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:57263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUtIU-0006WB-TR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:36 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-h4eWMekeMWGKlyXWzHtp2w-1; Tue, 20 Oct 2020 11:11:29 -0400
X-MC-Unique: h4eWMekeMWGKlyXWzHtp2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19DF41074656;
 Tue, 20 Oct 2020 15:11:28 +0000 (UTC)
Received: from bahia.lan (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4198C6EF69;
 Tue, 20 Oct 2020 15:11:27 +0000 (UTC)
Subject: [PATCH 4/5] tests/9pfs: Factor out do_fs_attach() helper
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 17:11:26 +0200
Message-ID: <160320668629.255209.17942580749099373236.stgit@bahia.lan>
In-Reply-To: <160320655763.255209.3890094487013964615.stgit@bahia.lan>
References: <160320655763.255209.3890094487013964615.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 11:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fs_attach() is a top level test function. Factor out the sugar
to a separate helper instead of hijacking it in other tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/qtest/virtio-9p-test.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 95638662e14d..1e1b1433014b 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -589,10 +589,8 @@ static void fs_version(void *obj, void *data, QGuestAl=
locator *t_alloc)
     do_fs_version(obj);
 }
=20
-static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
+static void do_fs_attach(QVirtio9P *v9p)
 {
-    QVirtio9P *v9p =3D obj;
-    alloc =3D t_alloc;
     P9Req *req;
=20
     do_fs_version(v9p);
@@ -601,6 +599,12 @@ static void fs_attach(void *obj, void *data, QGuestAll=
ocator *t_alloc)
     v9fs_rattach(req, NULL);
 }
=20
+static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    alloc =3D t_alloc;
+    do_fs_attach(obj);
+}
+
 static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p =3D obj;
@@ -615,7 +619,7 @@ static void fs_walk(void *obj, void *data, QGuestAlloca=
tor *t_alloc)
         wnames[i] =3D g_strdup_printf(QTEST_V9FS_SYNTH_WALK_FILE, i);
     }
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nwqid, &wqid);
@@ -684,7 +688,7 @@ static void fs_readdir(void *obj, void *data, QGuestAll=
ocator *t_alloc)
     struct V9fsDirent *entries =3D NULL;
     P9Req *req;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nqid, NULL);
@@ -738,7 +742,7 @@ static void do_fs_readdir_split(QVirtio9P *v9p, uint32_=
t count)
     int fid;
     uint64_t offset;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
=20
     fid =3D 1;
     offset =3D 0;
@@ -814,7 +818,7 @@ static void fs_walk_no_slash(void *obj, void *data, QGu=
estAllocator *t_alloc)
     P9Req *req;
     uint32_t err;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlerror(req, &err);
@@ -854,7 +858,7 @@ static void fs_lopen(void *obj, void *data, QGuestAlloc=
ator *t_alloc)
     char *const wnames[] =3D { g_strdup(QTEST_V9FS_SYNTH_LOPEN_FILE) };
     P9Req *req;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -876,7 +880,7 @@ static void fs_write(void *obj, void *data, QGuestAlloc=
ator *t_alloc)
     uint32_t count;
     P9Req *req;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -903,7 +907,7 @@ static void fs_flush_success(void *obj, void *data, QGu=
estAllocator *t_alloc)
     uint32_t reply_len;
     uint8_t should_block;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -940,7 +944,7 @@ static void fs_flush_ignored(void *obj, void *data, QGu=
estAllocator *t_alloc)
     uint32_t count;
     uint8_t should_block;
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     req =3D v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
@@ -1026,7 +1030,7 @@ static void fs_create_dir(void *obj, void *data, QGue=
stAllocator *t_alloc)
=20
     g_assert(root_path !=3D NULL);
=20
-    fs_attach(v9p, NULL, t_alloc);
+    do_fs_attach(v9p);
     fs_mkdir(v9p, data, t_alloc, "/", "01");
=20
     /* check if created directory really exists now ... */



