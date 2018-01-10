Received: from eggs.gnu.org ([2001:4830:134:3::10]:49025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXq-0005gC-0J
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXp-0000Cm-5X
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:37 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 10 Jan 2018 17:18:43 +0800
Message-Id: <20180110091846.10699-7-famz@redhat.com>
In-Reply-To: <20180110091846.10699-1-famz@redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 6/9] qemu-img: Map bench buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 68b375f998..28d0e4e9f8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3862,6 +3862,7 @@ static int img_bench(int argc, char **argv)
     struct timeval t1, t2;
     int i;
     bool force_share = false;
+    size_t buf_size;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -4050,9 +4051,12 @@ static int img_bench(int argc, char **argv)
         printf("Sending flush every %d requests\n", flush_interval);
     }
 
-    data.buf = blk_blockalign(blk, data.nrreq * data.bufsize);
+    buf_size = data.nrreq * data.bufsize;
+    data.buf = blk_blockalign(blk, buf_size);
     memset(data.buf, pattern, data.nrreq * data.bufsize);
 
+    blk_register_buf(blk, data.buf, buf_size);
+
     data.qiov = g_new(QEMUIOVector, data.nrreq);
     for (i = 0; i < data.nrreq; i++) {
         qemu_iovec_init(&data.qiov[i], 1);
@@ -4073,6 +4077,9 @@ static int img_bench(int argc, char **argv)
            + ((double)(t2.tv_usec - t1.tv_usec) / 1000000));
 
 out:
+    if (data.buf) {
+        blk_unregister_buf(blk, data.buf);
+    }
     qemu_vfree(data.buf);
     blk_unref(blk);
 
-- 
2.14.3
