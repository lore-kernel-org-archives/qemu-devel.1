Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZt0-0008Jv-UC
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZsv-0004IA-PR
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egZsv-0004EC-Er
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UHddel061863
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:51 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fttpbgssa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:49 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 Jan 2018 17:39:45 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 Jan 2018 18:39:35 +0100
In-Reply-To: <20180130173935.5172-1-groug@kaod.org>
References: <20180130173935.5172-1-groug@kaod.org>
Message-Id: <20180130173935.5172-11-groug@kaod.org>
Subject: [Qemu-devel] [PULL 10/10] tests/virtio-9p: explicitly handle
 potential integer overflows
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

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-9p-test.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 41fa492cb778..f4824fa33b87 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -168,7 +168,7 @@ static uint16_t v9fs_string_size(const char *string)
 {
     size_t len = strlen(string);
 
-    g_assert_cmpint(len, <=, UINT16_MAX);
+    g_assert_cmpint(len, <=, UINT16_MAX - 2);
 
     return 2 + len;
 }
@@ -209,17 +209,20 @@ static P9Req *v9fs_req_init(QVirtIO9P *v9p, uint32_t size, uint8_t id,
                             uint16_t tag)
 {
     P9Req *req = g_new0(P9Req, 1);
-    uint32_t t_size = 7 + size; /* 9P header has well-known size of 7 bytes */
+    uint32_t total_size = 7; /* 9P header has well-known size of 7 bytes */
     P9Hdr hdr = {
-        .size = cpu_to_le32(t_size),
         .id = id,
         .tag = cpu_to_le16(tag)
     };
 
-    g_assert_cmpint(t_size, <=, P9_MAX_SIZE);
+    g_assert_cmpint(total_size, <=, UINT32_MAX - size);
+    total_size += size;
+    hdr.size = cpu_to_le32(total_size);
+
+    g_assert_cmpint(total_size, <=, P9_MAX_SIZE);
 
     req->v9p = v9p;
-    req->t_size = t_size;
+    req->t_size = total_size;
     req->t_msg = guest_alloc(v9p->qs->alloc, req->t_size);
     v9fs_memwrite(req, &hdr, 7);
     req->tag = tag;
@@ -305,8 +308,13 @@ static void v9fs_rlerror(P9Req *req, uint32_t *err)
 static P9Req *v9fs_tversion(QVirtIO9P *v9p, uint32_t msize, const char *version,
                             uint16_t tag)
 {
-    P9Req *req = v9fs_req_init(v9p, 4 + v9fs_string_size(version), P9_TVERSION,
-                               tag);
+    P9Req *req;
+    uint32_t body_size = 4;
+    uint16_t string_size = v9fs_string_size(version);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+    req = v9fs_req_init(v9p, body_size, P9_TVERSION, tag);
 
     v9fs_uint32_write(req, msize);
     v9fs_string_write(req, version);
@@ -366,12 +374,15 @@ static P9Req *v9fs_twalk(QVirtIO9P *v9p, uint32_t fid, uint32_t newfid,
 {
     P9Req *req;
     int i;
-    uint32_t size = 4 + 4 + 2;
+    uint32_t body_size = 4 + 4 + 2;
 
     for (i = 0; i < nwname; i++) {
-        size += v9fs_string_size(wnames[i]);
+        uint16_t wname_size = v9fs_string_size(wnames[i]);
+
+        g_assert_cmpint(body_size, <=, UINT32_MAX - wname_size);
+        body_size += wname_size;
     }
-    req = v9fs_req_init(v9p,  size, P9_TWALK, tag);
+    req = v9fs_req_init(v9p,  body_size, P9_TWALK, tag);
     v9fs_uint32_write(req, fid);
     v9fs_uint32_write(req, newfid);
     v9fs_uint16_write(req, nwname);
-- 
2.13.6
