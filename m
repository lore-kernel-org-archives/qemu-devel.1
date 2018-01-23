Received: from eggs.gnu.org ([208.118.235.92]:32913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee89i-0001KX-KR
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee89d-00063y-Qj
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:06 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:56126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ee89d-00061n-IR
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:01 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D1067B9291
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 00:38:59 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 24 Jan 2018 00:38:55 +0100
Message-ID: <151675073560.29381.3088132885564486565.stgit@bahia.lan>
In-Reply-To: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
References: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/7] tests: virtio-9p: wait for completion in
 the test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

In order to test request cancellation, we will need to send multiple
requests and wait for the associated replies. Since we poll the ISR
to know if a request completed, we may have several replies to parse
when we detect ISR was set to 1.

This patch moves the waiting out of the reply parsing path, up into
the functional tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 5ada2839b9ae..cb086315a36e 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -246,13 +246,17 @@ static const char *rmessage_name(uint8_t id)
         "<unknown>";
 }
 
-static void v9fs_req_recv(P9Req *req, uint8_t id)
+static void v9fs_req_wait_for_reply(P9Req *req)
 {
     QVirtIO9P *v9p = req->v9p;
-    P9Hdr hdr;
 
     qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head,
                            QVIRTIO_9P_TIMEOUT_US);
+}
+
+static void v9fs_req_recv(P9Req *req, uint8_t id)
+{
+    P9Hdr hdr;
 
     v9fs_memread(req, &hdr, 7);
     hdr.size = ldl_le_p(&hdr.size);
@@ -398,6 +402,7 @@ static void fs_version(QVirtIO9P *v9p)
     P9Req *req;
 
     req = v9fs_tversion(v9p, P9_MAX_SIZE, version, P9_NOTAG);
+    v9fs_req_wait_for_reply(req);
     v9fs_rversion(req, &server_len, &server_version);
 
     g_assert_cmpmem(server_version, server_len, version, strlen(version));
@@ -411,6 +416,7 @@ static void fs_attach(QVirtIO9P *v9p)
 
     fs_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
+    v9fs_req_wait_for_reply(req);
     v9fs_rattach(req, NULL);
 }
 
@@ -431,6 +437,7 @@ static void fs_walk(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
+    v9fs_req_wait_for_reply(req);
     v9fs_rwalk(req, &nwqid, &wqid);
 
     g_assert_cmpint(nwqid, ==, P9_MAXWELEM);
@@ -452,6 +459,7 @@ static void fs_walk_no_slash(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req);
     v9fs_rlerror(req, &err);
 
     g_assert_cmpint(err, ==, ENOENT);
@@ -467,9 +475,11 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
 
     fs_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
+    v9fs_req_wait_for_reply(req);
     v9fs_rattach(req, &root_qid);
 
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req);
     v9fs_rwalk(req, NULL, &wqid); /* We now we'll get one qid */
 
     g_assert_cmpmem(&root_qid, 13, wqid[0], 13);
