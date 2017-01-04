Received: from eggs.gnu.org ([2001:4830:134:3::10]:57810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq8-00078f-Qf
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq5-0000E7-LN
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgq5-0000Dn-CW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048JYlg090522
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:28 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rmq81wbg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:28 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:25 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:43 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-10-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 09/13] tests: virtio-9p: add version operation
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

This patch lays the foundations to be able to test 9P operations and
provides a test for the version operation as a first example.

A 9P request is composed of a T-message sent by the client (guest) to the
server (QEMU), and a R-message sent by the server back to the client.

The following general calls are available to implement requests for any
9P operations:

v9fs_req_init(): allocates the request structure and the guest memory for
                 the T-message

v9fs_req_send(): allocates the guest memory for the R-message and sends the
                 T-message to QEMU

v9fs_req_recv(): waits for QEMU to answer and does some sanity checks on the
                 returned R-message header

v9fs_req_free(): releases the guest memory and the request structure

Helpers are provided, to be used by each specific 9P operation to copy data
to/from the guest memory.

The version operation is used to negotiate the 9P protocol version to be
used and the maximum buffer size for exchanged data. It is necessarily
the first message of a 9P session. For simplicity, the maximum buffer size
is hardcoded to 4k, which should be enough for functional tests.

The test simply advertises the "9P2000.L" version to QEMU and expects QEMU
to answer it is supported.

References:

http://man.cat-v.org/plan_9/5/intro
http://man.cat-v.org/plan_9/5/version

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 727316086337..b3ee956cbcb2 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -16,6 +16,7 @@
 #include "libqos/virtio-pci.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/9pfs/9p.h"
 
 static const char mount_tag[] = "qtest";
 
@@ -98,6 +99,226 @@ static void pci_config(QVirtIO9P *v9p)
     g_free(tag);
 }
 
+#define P9_MAX_SIZE 4096 /* Max size of a T-message or R-message */
+
+typedef struct {
+    QVirtIO9P *v9p;
+    uint16_t tag;
+    uint64_t t_msg;
+    uint32_t t_size;
+    uint64_t r_msg;
+    /* No r_size, it is hardcoded to P9_MAX_SIZE */
+    size_t t_off;
+    size_t r_off;
+} P9Req;
+
+static void v9fs_memwrite(P9Req *req, const void *addr, size_t len)
+{
+    memwrite(req->t_msg + req->t_off, addr, len);
+    req->t_off += len;
+}
+
+static void v9fs_memskip(P9Req *req, size_t len)
+{
+    req->r_off += len;
+}
+
+static void v9fs_memrewind(P9Req *req, size_t len)
+{
+    req->r_off -= len;
+}
+
+static void v9fs_memread(P9Req *req, void *addr, size_t len)
+{
+    memread(req->r_msg + req->r_off, addr, len);
+    req->r_off += len;
+}
+
+static void v9fs_uint16_write(P9Req *req, uint16_t val)
+{
+    uint16_t le_val = cpu_to_le16(val);
+
+    v9fs_memwrite(req, &le_val, 2);
+}
+
+static void v9fs_uint16_read(P9Req *req, uint16_t *val)
+{
+    v9fs_memread(req, val, 2);
+    le16_to_cpus(val);
+}
+
+static void v9fs_uint32_write(P9Req *req, uint32_t val)
+{
+    uint32_t le_val = cpu_to_le32(val);
+
+    v9fs_memwrite(req, &le_val, 4);
+}
+
+static void v9fs_uint32_read(P9Req *req, uint32_t *val)
+{
+    v9fs_memread(req, val, 4);
+    le32_to_cpus(val);
+}
+
+/* len[2] string[len] */
+static uint16_t v9fs_string_size(const char *string)
+{
+    size_t len = strlen(string);
+
+    g_assert_cmpint(len, <=, UINT16_MAX);
+
+    return 2 + len;
+}
+
+static void v9fs_string_write(P9Req *req, const char *string)
+{
+    int len = strlen(string);
+
+    g_assert_cmpint(len, <=, UINT16_MAX);
+
+    v9fs_uint16_write(req, (uint16_t) len);
+    v9fs_memwrite(req, string, len);
+}
+
+static void v9fs_string_read(P9Req *req, uint16_t *len, char **string)
+{
+    uint16_t local_len;
+
+    v9fs_uint16_read(req, &local_len);
+    if (len) {
+        *len = local_len;
+    }
+    if (string) {
+        *string = g_malloc(local_len);
+        v9fs_memread(req, *string, local_len);
+    } else {
+        v9fs_memskip(req, local_len);
+    }
+}
+
+ typedef struct {
+    uint32_t size;
+    uint8_t id;
+    uint16_t tag;
+} QEMU_PACKED P9Hdr;
+
+static P9Req *v9fs_req_init(QVirtIO9P *v9p, uint32_t size, uint8_t id,
+                            uint16_t tag)
+{
+    P9Req *req = g_new0(P9Req, 1);
+    uint32_t t_size = 7 + size; /* 9P header has well-known size of 7 bytes */
+    P9Hdr hdr = {
+        .size = cpu_to_le32(t_size),
+        .id = id,
+        .tag = cpu_to_le16(tag)
+    };
+
+    g_assert_cmpint(t_size, <=, P9_MAX_SIZE);
+
+    req->v9p = v9p;
+    req->t_size = t_size;
+    req->t_msg = guest_alloc(v9p->qs->alloc, req->t_size);
+    v9fs_memwrite(req, &hdr, 7);
+    req->tag = tag;
+    return req;
+}
+
+static void v9fs_req_send(P9Req *req)
+{
+    QVirtIO9P *v9p = req->v9p;
+    uint32_t free_head;
+
+    req->r_msg = guest_alloc(v9p->qs->alloc, P9_MAX_SIZE);
+    free_head = qvirtqueue_add(v9p->vq, req->t_msg, req->t_size, false, true);
+    qvirtqueue_add(v9p->vq, req->r_msg, P9_MAX_SIZE, true, false);
+    qvirtqueue_kick(v9p->dev, v9p->vq, free_head);
+    req->t_off = 0;
+}
+
+static void v9fs_req_recv(P9Req *req, uint8_t id)
+{
+    QVirtIO9P *v9p = req->v9p;
+    P9Hdr hdr;
+    int i;
+
+    for (i = 0; i < 10; i++) {
+        qvirtio_wait_queue_isr(v9p->dev, v9p->vq, 1000 * 1000);
+
+        v9fs_memread(req, &hdr, 7);
+        le32_to_cpus(&hdr.size);
+        le16_to_cpus(&hdr.tag);
+        if (hdr.size >= 7) {
+            break;
+        }
+        v9fs_memrewind(req, 7);
+    }
+
+    g_assert_cmpint(hdr.size, >=, 7);
+    g_assert_cmpint(hdr.size, <=, P9_MAX_SIZE);
+    g_assert_cmpint(hdr.tag, ==, req->tag);
+
+    if (hdr.id != id && hdr.id == P9_RLERROR) {
+        uint32_t err;
+        v9fs_uint32_read(req, &err);
+        g_printerr("Received Rlerror (%d) instead of Response %d\n", err, id);
+        g_assert_not_reached();
+    }
+    g_assert_cmpint(hdr.id, ==, id);
+}
+
+static void v9fs_req_free(P9Req *req)
+{
+    QVirtIO9P *v9p = req->v9p;
+
+    guest_free(v9p->qs->alloc, req->t_msg);
+    guest_free(v9p->qs->alloc, req->r_msg);
+    g_free(req);
+}
+
+/* size[4] Tversion tag[2] msize[4] version[s] */
+static P9Req *v9fs_tversion(QVirtIO9P *v9p, uint32_t msize, const char *version)
+{
+    P9Req *req = v9fs_req_init(v9p, 4 + v9fs_string_size(version), P9_TVERSION,
+                               P9_NOTAG);
+
+    v9fs_uint32_write(req, msize);
+    v9fs_string_write(req, version);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rversion tag[2] msize[4] version[s] */
+static void v9fs_rversion(P9Req *req, uint16_t *len, char **version)
+{
+    uint32_t msize;
+
+    v9fs_req_recv(req, P9_RVERSION);
+    v9fs_uint32_read(req, &msize);
+
+    g_assert_cmpint(msize, ==, P9_MAX_SIZE);
+
+    if (len || version) {
+        v9fs_string_read(req, len, version);
+    }
+
+    v9fs_req_free(req);
+}
+
+static void fs_version(QVirtIO9P *v9p)
+{
+    const char *version = "9P2000.L";
+    uint16_t server_len;
+    char *server_version;
+    P9Req *req;
+
+    req = v9fs_tversion(v9p, P9_MAX_SIZE, version);
+    v9fs_rversion(req, &server_len, &server_version);
+
+    g_assert_cmpmem(server_version, server_len, version, strlen(version));
+
+    g_free(server_version);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -121,6 +342,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     v9fs_qtest_pci_add("/virtio/9p/pci/nop", NULL);
     v9fs_qtest_pci_add("/virtio/9p/pci/config", pci_config);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/version/basic", fs_version);
 
     return g_test_run();
 }
-- 
2.7.4
