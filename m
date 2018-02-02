Received: from eggs.gnu.org ([2001:4830:134:3::10]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehfhM-0001Qm-5I
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehfgG-0003XI-Oo
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:04:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe47-00045l-TL
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GIpwD039268
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:51 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrmaree1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:50 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:47 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:28 +0100
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
Message-Id: <20180202161935.20803-4-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 03/10] tests: virtio-9p: move request tag to
 the test functions
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

It doesn't really makes sense to hide the request tag from the test
functions. It prevents to test the 9p server behavior when passed
a wrong tag (ie, still in use or different from P9_NOTAG for a
version request). Also the spec says that a tag is reusable as soon
as the corresponding request was replied or flushed: no need to
always increment tags like we do now. And finaly, an upcoming test
of the flush command will need to manipulate tags explicitely.

This simply changes all request functions to have a tag argument.
Except for the version request which needs P9_NOTAG, all other
tests can pass 0 since they wait for the reply before sending
another request.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-9p-test.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 00f00f7246e9..5ada2839b9ae 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -27,7 +27,6 @@ typedef struct {
     QOSState *qs;
     QVirtQueue *vq;
     char *test_share;
-    uint16_t p9_req_tag;
 } QVirtIO9P;
 
 static QVirtIO9P *qvirtio_9p_start(const char *driver)
@@ -294,10 +293,11 @@ static void v9fs_rlerror(P9Req *req, uint32_t *err)
 }
 
 /* size[4] Tversion tag[2] msize[4] version[s] */
-static P9Req *v9fs_tversion(QVirtIO9P *v9p, uint32_t msize, const char *version)
+static P9Req *v9fs_tversion(QVirtIO9P *v9p, uint32_t msize, const char *version,
+                            uint16_t tag)
 {
     P9Req *req = v9fs_req_init(v9p, 4 + v9fs_string_size(version), P9_TVERSION,
-                               P9_NOTAG);
+                               tag);
 
     v9fs_uint32_write(req, msize);
     v9fs_string_write(req, version);
@@ -323,12 +323,12 @@ static void v9fs_rversion(P9Req *req, uint16_t *len, char **version)
 }
 
 /* size[4] Tattach tag[2] fid[4] afid[4] uname[s] aname[s] n_uname[4] */
-static P9Req *v9fs_tattach(QVirtIO9P *v9p, uint32_t fid, uint32_t n_uname)
+static P9Req *v9fs_tattach(QVirtIO9P *v9p, uint32_t fid, uint32_t n_uname,
+                           uint16_t tag)
 {
     const char *uname = ""; /* ignored by QEMU */
     const char *aname = ""; /* ignored by QEMU */
-    P9Req *req = v9fs_req_init(v9p, 4 + 4 + 2 + 2 + 4, P9_TATTACH,
-                               ++(v9p->p9_req_tag));
+    P9Req *req = v9fs_req_init(v9p, 4 + 4 + 2 + 2 + 4, P9_TATTACH, tag);
 
     v9fs_uint32_write(req, fid);
     v9fs_uint32_write(req, P9_NOFID);
@@ -353,7 +353,7 @@ static void v9fs_rattach(P9Req *req, v9fs_qid *qid)
 
 /* size[4] Twalk tag[2] fid[4] newfid[4] nwname[2] nwname*(wname[s]) */
 static P9Req *v9fs_twalk(QVirtIO9P *v9p, uint32_t fid, uint32_t newfid,
-                         uint16_t nwname, char *const wnames[])
+                         uint16_t nwname, char *const wnames[], uint16_t tag)
 {
     P9Req *req;
     int i;
@@ -362,7 +362,7 @@ static P9Req *v9fs_twalk(QVirtIO9P *v9p, uint32_t fid, uint32_t newfid,
     for (i = 0; i < nwname; i++) {
         size += v9fs_string_size(wnames[i]);
     }
-    req = v9fs_req_init(v9p,  size, P9_TWALK, ++(v9p->p9_req_tag));
+    req = v9fs_req_init(v9p,  size, P9_TWALK, tag);
     v9fs_uint32_write(req, fid);
     v9fs_uint32_write(req, newfid);
     v9fs_uint16_write(req, nwname);
@@ -397,7 +397,7 @@ static void fs_version(QVirtIO9P *v9p)
     char *server_version;
     P9Req *req;
 
-    req = v9fs_tversion(v9p, P9_MAX_SIZE, version);
+    req = v9fs_tversion(v9p, P9_MAX_SIZE, version, P9_NOTAG);
     v9fs_rversion(req, &server_len, &server_version);
 
     g_assert_cmpmem(server_version, server_len, version, strlen(version));
@@ -410,7 +410,7 @@ static void fs_attach(QVirtIO9P *v9p)
     P9Req *req;
 
     fs_version(v9p);
-    req = v9fs_tattach(v9p, 0, getuid());
+    req = v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_rattach(req, NULL);
 }
 
@@ -430,7 +430,7 @@ static void fs_walk(QVirtIO9P *v9p)
     }
 
     fs_attach(v9p);
-    req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames);
+    req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
     v9fs_rwalk(req, &nwqid, &wqid);
 
     g_assert_cmpint(nwqid, ==, P9_MAXWELEM);
@@ -451,7 +451,7 @@ static void fs_walk_no_slash(QVirtIO9P *v9p)
     uint32_t err;
 
     fs_attach(v9p);
-    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_rlerror(req, &err);
 
     g_assert_cmpint(err, ==, ENOENT);
@@ -466,10 +466,10 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
     P9Req *req;
 
     fs_version(v9p);
-    req = v9fs_tattach(v9p, 0, getuid());
+    req = v9fs_tattach(v9p, 0, getuid(), 0);
     v9fs_rattach(req, &root_qid);
 
-    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
     v9fs_rwalk(req, NULL, &wqid); /* We now we'll get one qid */
 
     g_assert_cmpmem(&root_qid, 13, wqid[0], 13);
-- 
2.13.6
