Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oQ-0003Ix-8h
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oP-0008Jt-2S
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:52 +0200
Message-Id: <20180730150958.14607-8-kwolf@redhat.com>
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] qemu-img: Add -C option for convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c       | 21 +++++++++++++++++----
 qemu-img-cmds.hx |  2 +-
 qemu-img.texi    |  8 +++++++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9b7506b8ae..1acddf693c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2024,11 +2024,12 @@ static int img_convert(int argc, char **argv)
          skip_create = false, progress = false, tgt_image_opts = false;
     int64_t ret = -EINVAL;
     bool force_share = false;
+    bool explict_min_sparse = false;
 
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
         .min_sparse         = 8,
-        .copy_range         = true,
+        .copy_range         = false,
         .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
         .wr_in_order        = true,
         .num_coroutines     = 8,
@@ -2043,7 +2044,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:co:l:S:pt:T:qnm:WU",
+        c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2067,9 +2068,11 @@ static int img_convert(int argc, char **argv)
         case 'B':
             out_baseimg = optarg;
             break;
+        case 'C':
+            s.copy_range = true;
+            break;
         case 'c':
             s.compressed = true;
-            s.copy_range = false;
             break;
         case 'o':
             if (!is_valid_option_list(optarg)) {
@@ -2112,7 +2115,7 @@ static int img_convert(int argc, char **argv)
             }
 
             s.min_sparse = sval / BDRV_SECTOR_SIZE;
-            s.copy_range = false;
+            explict_min_sparse = true;
             break;
         }
         case 'p':
@@ -2172,6 +2175,16 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
 
+    if (s.compressed && s.copy_range) {
+        error_report("Cannot enable copy offloading when -c is used");
+        goto fail_getopt;
+    }
+
+    if (explict_min_sparse && s.copy_range) {
+        error_report("Cannot enable copy offloading when -S is used");
+        goto fail_getopt;
+    }
+
     if (tgt_image_opts && !skip_create) {
         error_report("--target-image-opts requires use of -n flag");
         goto fail_getopt;
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 69758fb6e8..1526f327a5 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -44,7 +44,7 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
 @item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
diff --git a/qemu-img.texi b/qemu-img.texi
index aeb1b9e66c..3b6710a580 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -169,6 +169,12 @@ Number of parallel coroutines for the convert process
 Allow out-of-order writes to the destination. This option improves performance,
 but is only recommended for preallocated devices like host devices or other
 raw block devices.
+@item -C
+Try to use copy offloading to move data from source image to target. This may
+improve performance if the data is remote, such as with NFS or iSCSI backends,
+but will not automatically sparsify zero sectors, and may result in a fully
+allocated target image depending on the host support for getting allocation
+information.
 @end table
 
 Parameters to dd subcommand:
@@ -319,7 +325,7 @@ Error on reading data
 
 @end table
 
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
-- 
2.13.6
