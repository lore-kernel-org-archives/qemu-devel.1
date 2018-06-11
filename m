Received: from eggs.gnu.org ([2001:4830:134:3::10]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNms-00054h-ER
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmq-00027s-Rm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:14 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:06 +0200
Message-Id: <20180611142611.6609-25-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 24/29] qemu-img: Remove deprecated -s
 snapshot_id_or_name option
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

From: Thomas Huth <thuth@redhat.com>

It has been marked as deprecated since QEMU v2.0 already, so it
is time now to finally remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1528288551-31641-1-git-send-email-thuth@redhat.com
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c             | 7 +------
 qemu-doc.texi          | 7 -------
 qemu-img-cmds.hx       | 4 ++--
 qemu-img.texi          | 7 ++-----
 tests/qemu-iotests/029 | 2 +-
 tests/qemu-iotests/080 | 4 ++--
 6 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ae4acb655b..1dcdd47254 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -148,8 +148,6 @@ static void QEMU_NORETURN help(void)
            "  'snapshot_param' is param used for internal snapshot, format\n"
            "    is 'snapshot.id=[ID],snapshot.name=[NAME]', or\n"
            "    '[ID_OR_NAME]'\n"
-           "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
-           "    instead\n"
            "  '-c' indicates that target image must be compressed (qcow format only)\n"
            "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
            "       new backing file match exactly. The image doesn't need a working\n"
@@ -2018,7 +2016,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:co:s:l:S:pt:T:qnm:WU",
+        c = getopt_long(argc, argv, ":hf:O:B:co:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2059,9 +2057,6 @@ static int img_convert(int argc, char **argv)
                 g_free(old_options);
             }
             break;
-        case 's':
-            snapshot_name = optarg;
-            break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
                 sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 2effe66d6b..9aff6b4ea9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2927,13 +2927,6 @@ Option @option{-virtioconsole} has been replaced by
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
 replacement since it is not needed anymore.
 
-@section qemu-img command line arguments
-
-@subsection convert -s (since 2.0.0)
-
-The ``convert -s snapshot_id_or_name'' argument is obsoleted
-by the ``convert -l snapshot_param'' argument instead.
-
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3d2f7b26eb..69758fb6e8 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -44,9 +44,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("create", img_create,
diff --git a/qemu-img.texi b/qemu-img.texi
index 2be8206a05..aeb1b9e66c 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -61,9 +61,6 @@ by the used format or see the format descriptions below for details.
 is param used for internal snapshot, format is
 'snapshot.id=[ID],snapshot.name=[NAME]' or '[ID_OR_NAME]'
 
-@item snapshot_id_or_name
-is deprecated, use snapshot_param instead
-
 @end table
 
 @table @option
@@ -322,9 +319,9 @@ Error on reading data
 
 @end table
 
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
-Convert the disk image @var{filename} or a snapshot @var{snapshot_param}(@var{snapshot_id_or_name} is deprecated)
+Convert the disk image @var{filename} or a snapshot @var{snapshot_param}
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
 option) or use any format specific options like encryption (@code{-o} option).
 
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 30bab24dc0..5cff6875bf 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -92,7 +92,7 @@ _make_test_img 64M
 { $QEMU_IMG snapshot -c foo $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 poke_file "$TEST_IMG" "$offset_size" "\x00\x00\x00\x00\x00\x00\x02\x00"
 poke_file "$TEST_IMG" "$offset_l1_size" "\x00\x00\x00\x01"
-{ $QEMU_IMG convert -s foo $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IMG convert -l foo $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 
 # success, all done
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 4dbe68e950..f0eb42f390 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -176,7 +176,7 @@ _make_test_img 64M
 { $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
 poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x00"
-{ $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+{ $QEMU_IMG convert -l test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
@@ -190,7 +190,7 @@ _make_test_img 64M
 { $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
 poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
-{ $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+{ $QEMU_IMG convert -l test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
-- 
2.17.1
