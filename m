Received: from eggs.gnu.org ([2001:4830:134:3::10]:53716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1d1Rrr-000577-Do
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1d1Rrp-0007wS-1Z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:16:30 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:47413)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1d1Rrm-0007nh-PF
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:16:28 -0400
From: Ping Li <li.ping288@zte.com.cn>
Date: Sat, 22 Apr 2017 06:34:32 +0800
Message-Id: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
Subject: [Qemu-devel] [PATCH] Block layer core: Fix qemu-img 'amend'
 subcommand failure of adjusting backing file in different path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Ping Li <li.ping288@zte.com.cn>

Currently, qemu-img 'amend' subcommand would fail to adjust image's backing file
which was moved into different path.
For example, parent.qcow2, the backing file of leaf.qcow2, first is at /home/a/,
then moved into /home/b/. Originally this command,
 "qemu-img amend -f qcow2 -o backing_fmt=qcow2,backing_file=/home/b/parent.qcow2 leaf.qcow2",
 would fail because qemu-img failed to open the old backing file of leaf.qcow2.
Give the 'amend' subcommand a '-u' option to not open the old backing file
 while openning leaf.qcow2.

Signed-off-by: Li Ping<li.ping288@zte.com.cn>
---
 qemu-img.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..a32e9d6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -145,9 +145,10 @@ static void QEMU_NORETURN help(void)
            "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
            "    instead\n"
            "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
-           "       match exactly. The image doesn't need a working backing file before\n"
-           "       rebasing in this case (useful for renaming the backing file)\n"
+           "  '-u' enables unsafe rebasing or amending. It is assumed that old and new\n"
+           "       backing file match exactly. For rebasing, the image doesn't need a working\n"
+           "       backing file before rebasing in this case(useful for renaming the backing file).\n"
+           "       For amending, it doesn't open backing file(useful for moving images)\n"
            "  '-h' with or without a command shows this help and lists the supported formats\n"
            "  '-p' show progress of command (only certain commands)\n"
            "  '-q' use Quiet mode - do not print any output (except errors)\n"
@@ -3538,7 +3539,7 @@ static int img_amend(int argc, char **argv)
     QemuOptsList *create_opts = NULL;
     QemuOpts *opts = NULL;
     const char *fmt = NULL, *filename, *cache;
-    int flags;
+    int flags = 0;
     bool writethrough;
     bool quiet = false, progress = false;
     BlockBackend *blk = NULL;
@@ -3553,7 +3554,7 @@ static int img_amend(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":ho:f:t:pq",
+        c = getopt_long(argc, argv, ":ho:f:t:pqu",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3595,6 +3596,9 @@ static int img_amend(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'u':
+            flags |= BDRV_O_NO_BACKING;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -3639,7 +3643,7 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    flags = BDRV_O_RDWR;
+    flags |= BDRV_O_RDWR;
     ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
     if (ret < 0) {
         error_report("Invalid cache option: %s", cache);
-- 
1.8.3.1
