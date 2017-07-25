Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da122-0001no-5h
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da120-0000tA-ON
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:54 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:43779 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da120-0000sA-EL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:52 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:35 +0200
Message-Id: <1500993699-19299-7-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 06/10] block/qcow2: simplify ret usage in
 qcow2_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fd52e1..ffe609d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3031,7 +3031,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int refcount_order;
     const char *encryptfmt = NULL;
     Error *local_err = NULL;
-    int ret;
+    int ret = -EINVAL;
 
     /* Read out options */
     size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
@@ -3043,7 +3043,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         if (qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT)) {
             error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
                        BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
-            ret = -EINVAL;
             goto finish;
         }
     } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
@@ -3052,7 +3051,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
         goto finish;
     }
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
@@ -3061,14 +3059,12 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                                &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
         goto finish;
     }
 
     version = qcow2_opt_get_version_del(opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
         goto finish;
     }
 
@@ -3079,21 +3075,18 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     if (backing_file && prealloc != PREALLOC_MODE_OFF) {
         error_setg(errp, "Backing file and preallocation cannot be used at "
                    "the same time");
-        ret = -EINVAL;
         goto finish;
     }
 
     if (version < 3 && (flags & BLOCK_FLAG_LAZY_REFCOUNTS)) {
         error_setg(errp, "Lazy refcounts only supported with compatibility "
                    "level 1.1 and above (use compat=1.1 or greater)");
-        ret = -EINVAL;
         goto finish;
     }
 
     refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        ret = -EINVAL;
         goto finish;
     }
 
@@ -3110,13 +3103,11 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         visit_start_struct(v, NULL, NULL, 0, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            ret = -EINVAL;
             goto finish;
         }
         visit_type_Qcow2Compress_members(v, &compress, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            ret = -EINVAL;
             goto finish;
         }
         visit_end_struct(v, NULL);
@@ -3126,12 +3117,12 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         qcow2_check_compress_settings(&compress, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            ret = -EINVAL;
             goto finish;
         }
         compress_ptr = &compress;
     }
 
+    /* ret is still -EINVAL until here */
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
                         encryptfmt, compress_ptr, &local_err);
-- 
1.9.1
