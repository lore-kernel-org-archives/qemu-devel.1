Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmF-0004OP-KY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmC-0001eA-B8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:49 +0200
Message-Id: <20180611142611.6609-8-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 07/29] qemu-img: Add print_amend_option_help()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The more generic print_block_option_help() function is not really
suitable for qemu-img amend, for a couple of reasons:
(1) We do not need to append the protocol-level options, as amendment
    happens only on one node and does not descend downwards to its
    children.
(2) print_block_option_help() says those options are "supported".  For
    option amendment, we do not really know that.  So this new function
    explicitly says that those options are the creation options, and not
    all of them may be supported.
(3) If the driver does not support option amendment, we should not print
    anything (except for an error message that amendment is not
    supported).

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1537956
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509210023.20283-5-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 30 ++++++++++++++++++++++++--
 tests/qemu-iotests/082.out | 44 +++++++++++++++++++++++---------------
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 52008c5647..07935cb232 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3658,6 +3658,32 @@ static void amend_status_cb(BlockDriverState *bs,
     qemu_progress_print(100.f * offset / total_work_size, 0);
 }
 
+static int print_amend_option_help(const char *format)
+{
+    BlockDriver *drv;
+
+    /* Find driver and parse its options */
+    drv = bdrv_find_format(format);
+    if (!drv) {
+        error_report("Unknown file format '%s'", format);
+        return 1;
+    }
+
+    if (!drv->bdrv_amend_options) {
+        error_report("Format driver '%s' does not support option amendment",
+                     format);
+        return 1;
+    }
+
+    /* Every driver supporting amendment must have create_opts */
+    assert(drv->create_opts);
+
+    printf("Creation options for '%s':\n", format);
+    qemu_opts_print_help(drv->create_opts);
+    printf("\nNote that not all of these options may be amendable.\n");
+    return 0;
+}
+
 static int img_amend(int argc, char **argv)
 {
     Error *err = NULL;
@@ -3757,7 +3783,7 @@ static int img_amend(int argc, char **argv)
     if (fmt && has_help_option(options)) {
         /* If a format is explicitly specified (and possibly no filename is
          * given), print option help here */
-        ret = print_block_option_help(filename, fmt);
+        ret = print_amend_option_help(fmt);
         goto out;
     }
 
@@ -3786,7 +3812,7 @@ static int img_amend(int argc, char **argv)
 
     if (has_help_option(options)) {
         /* If the format was auto-detected, print option help here */
-        ret = print_block_option_help(filename, fmt);
+        ret = print_amend_option_help(fmt);
         goto out;
     }
 
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 1527fbe1b7..4e52dce8d6 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -546,7 +546,7 @@ cluster_size: 65536
 === amend: help for -o ===
 
 Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -564,10 +564,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -585,10 +586,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -606,10 +608,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -627,10 +630,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -648,10 +652,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -669,10 +674,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -690,10 +696,11 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -711,7 +718,8 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+
+Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2
 
@@ -731,7 +739,7 @@ Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2 -o ,, -o help TEST_DIR/
 qemu-img: Invalid option list: ,,
 
 Testing: amend -f qcow2 -o help
-Supported options:
+Creation options for 'qcow2':
 size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
@@ -750,6 +758,8 @@ preallocation    Preallocation mode (allowed values: off, metadata, falloc, full
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
 
+Note that not all of these options may be amendable.
+
 Testing: convert -o help
 Supported options:
 size             Virtual disk size
-- 
2.17.1
