Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLM-00007v-6L
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLL-0004bv-1J
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:40 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:18 -0500
Message-Id: <27e0bf9dfb1370e8beb08c7b5ad6894540fff13a.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] block/ssh: don't call libssh2_init() in
 block_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

We don't need libssh2 failure to be fatal (we could just opt to not
register the driver on failure). But, it is probably a good idea to
avoid external library calls during the block_init(), and call the
libssh2 global init function on the first usage, returning any errors.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/ssh.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index b049a16..de81ec8 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -83,12 +83,28 @@ typedef struct BDRVSSHState {
     bool unsafe_flush_warning;
 } BDRVSSHState;
 
-static void ssh_state_init(BDRVSSHState *s)
+static bool ssh_libinit_called;
+
+static int ssh_state_init(BDRVSSHState *s, Error **errp)
 {
+    int ret;
+
+    if (!ssh_libinit_called) {
+        ret = libssh2_init(0);
+        if (ret) {
+            error_setg(errp, "libssh2 initialization failed with %d", ret);
+            return ret;
+        }
+        ssh_libinit_called = true;
+    }
+
+
     memset(s, 0, sizeof *s);
     s->sock = -1;
     s->offset = -1;
     qemu_co_mutex_init(&s->lock);
+
+    return 0;
 }
 
 static void ssh_state_free(BDRVSSHState *s)
@@ -773,7 +789,9 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     int ret;
     int ssh_flags;
 
-    ssh_state_init(s);
+    if (ssh_state_init(s, errp)) {
+        return -EIO;
+    }
 
     ssh_flags = LIBSSH2_FXF_READ;
     if (bdrv_flags & BDRV_O_RDWR) {
@@ -821,8 +839,13 @@ static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
     BDRVSSHState s;
     ssize_t r2;
     char c[1] = { '\0' };
+    Error *local_err = NULL;
 
-    ssh_state_init(&s);
+    ret = ssh_state_init(&s, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return ret;
+    }
 
     /* Get desired file size. */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
@@ -1213,14 +1236,6 @@ static BlockDriver bdrv_ssh = {
 
 static void bdrv_ssh_init(void)
 {
-    int r;
-
-    r = libssh2_init(0);
-    if (r != 0) {
-        fprintf(stderr, "libssh2 initialization failed, %d\n", r);
-        exit(EXIT_FAILURE);
-    }
-
     bdrv_register(&bdrv_ssh);
 }
 
-- 
2.9.5
