Received: from eggs.gnu.org ([2001:4830:134:3::10]:53573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe6X-0000zW-Ia
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe4A-00049Q-D8
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe49-00047c-4f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:53 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GBcdm079742
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:50 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvtexjq1m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:49 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:29 +0100
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
Message-Id: <20180202161935.20803-5-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 04/10] tests: virtio-9p: wait for completion
 in the test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

In order to test request cancellation, we will need to send multiple
requests and wait for the associated replies. Since we poll the ISR
to know if a request completed, we may have several replies to parse
when we detect ISR was set to 1.

This patch moves the waiting out of the reply parsing path, up into
the functional tests.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-9p-test.c | 14 ++++++++++++--
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
-- 
2.13.6
