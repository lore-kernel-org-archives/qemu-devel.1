Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E692098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E692098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUul4-0000Rj-G8
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUuCR-0003qF-AY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:09:23 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUuCP-0005NC-OR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:09:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-GYHXPfOYPYKkywLysNM6og-1; Tue, 20 Oct 2020 12:09:16 -0400
X-MC-Unique: GYHXPfOYPYKkywLysNM6og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94F6718A0760;
 Tue, 20 Oct 2020 16:09:15 +0000 (UTC)
Received: from bahia.lan (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5F43389;
 Tue, 20 Oct 2020 16:09:14 +0000 (UTC)
Subject: [PATCH v2 1/5] tests/9pfs: Factor out do_version() helper
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 18:09:14 +0200
Message-ID: <160321015403.266767.4533967728943968456.stgit@bahia.lan>
In-Reply-To: <160320977352.266767.5622969302437522296.stgit@bahia.lan>
References: <160320977352.266767.5622969302437522296.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

fs_version() is a top level test function. Factor out the reusable
code to a separate helper instead of hijacking it in other tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/qtest/virtio-9p-test.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c15908f27b3d..59bcea4c3091 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
     v9fs_req_free(req);
 }
=20
-static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
+static void do_version(QVirtio9P *v9p)
 {
-    QVirtio9P *v9p =3D obj;
-    alloc =3D t_alloc;
     const char *version =3D "9P2000.L";
     uint16_t server_len;
     char *server_version;
@@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data, QGuestA=
llocator *t_alloc)
     g_free(server_version);
 }
=20
+static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    alloc =3D t_alloc;
+    do_version(obj);
+}
+
 static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p =3D obj;
     alloc =3D t_alloc;
     P9Req *req;
=20
-    fs_version(v9p, NULL, t_alloc);
+    do_version(v9p);
     req =3D v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, NULL);
@@ -831,7 +835,7 @@ static void fs_walk_dotdot(void *obj, void *data, QGues=
tAllocator *t_alloc)
     v9fs_qid root_qid, *wqid;
     P9Req *req;
=20
-    fs_version(v9p, NULL, t_alloc);
+    do_version(v9p);
     req =3D v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, &root_qid);



