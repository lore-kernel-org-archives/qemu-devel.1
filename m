Received: from eggs.gnu.org ([2001:4830:134:3::10]:53336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTT-0000Cw-JQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTP-0002JS-KG
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45600
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTP-0002JH-Cn
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESote077938
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:27 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vcdp0dg4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:26 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 07:32:25 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:21 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405874166.9522.16716950523410954304.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 2/7] tests: virtio-9p: improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 060407b20e39..9556291567a4 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -236,6 +236,16 @@ static void v9fs_req_send(P9Req *req)
     req->t_off = 0;
 }
 
+static const char *rmessage_name(uint8_t id)
+{
+    return
+        id == P9_RLERROR ? "RLERROR" :
+        id == P9_RVERSION ? "RVERSION" :
+        id == P9_RATTACH ? "RATTACH" :
+        id == P9_RWALK ? "RWALK" :
+        "<unknown>";
+}
+
 static void v9fs_req_recv(P9Req *req, uint8_t id)
 {
     QVirtIO9P *v9p = req->v9p;
@@ -258,11 +268,15 @@ static void v9fs_req_recv(P9Req *req, uint8_t id)
     g_assert_cmpint(hdr.size, <=, P9_MAX_SIZE);
     g_assert_cmpint(hdr.tag, ==, req->tag);
 
-    if (hdr.id != id && hdr.id == P9_RLERROR) {
-        uint32_t err;
-        v9fs_uint32_read(req, &err);
-        g_printerr("Received Rlerror (%d) instead of Response %d\n", err, id);
-        g_assert_not_reached();
+    if (hdr.id != id) {
+        g_printerr("Received response %d (%s) instead of %d (%s)\n",
+                   hdr.id, rmessage_name(hdr.id), id, rmessage_name(id));
+
+        if (hdr.id == P9_RLERROR) {
+            uint32_t err;
+            v9fs_uint32_read(req, &err);
+            g_printerr("Rlerror has errno %d (%s)\n", err, strerror(err));
+        }
     }
     g_assert_cmpint(hdr.id, ==, id);
 }
