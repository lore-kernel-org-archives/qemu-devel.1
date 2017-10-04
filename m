Received: from eggs.gnu.org ([2001:4830:134:3::10]:58518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjE-0000en-C3
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjD-0001JG-Ac
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 20:43:43 -0500
Message-Id: <20171004014347.25099-2-eblake@redhat.com>
In-Reply-To: <20171004014347.25099-1-eblake@redhat.com>
References: <20171004014347.25099-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] qemu-io: Add -C for opening with
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Make it easier to enable copy-on-read during iotests, by
exposing a new bool option to main and open.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 265445ad89..c70bde3eb1 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -102,6 +102,7 @@ static void open_help(void)
 " Opens a file for subsequent use by all of the other qemu-io commands.\n"
 " -r, -- open file read-only\n"
 " -s, -- use snapshot file\n"
+" -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
 " -k, -- use kernel AIO implementation (on Linux only)\n"
@@ -120,7 +121,7 @@ static const cmdinfo_t open_cmd = {
     .argmin     = 1,
     .argmax     = -1,
     .flags      = CMD_NOFILE_OK,
-    .args       = "[-rsnkU] [-t cache] [-d discard] [-o options] [path]",
+    .args       = "[-rsCnkU] [-t cache] [-d discard] [-o options] [path]",
     .oneline    = "open the file specified by path",
     .help       = open_help,
 };
@@ -145,7 +146,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     QDict *opts;
     bool force_share = false;

-    while ((c = getopt(argc, argv, "snro:kt:d:U")) != -1) {
+    while ((c = getopt(argc, argv, "snCro:kt:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -154,6 +155,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
             flags |= BDRV_O_NOCACHE;
             writethrough = false;
             break;
+        case 'C':
+            flags |= BDRV_O_COPY_ON_READ;
+            break;
         case 'r':
             readonly = 1;
             break;
@@ -251,6 +255,7 @@ static void usage(const char *name)
 "  -r, --read-only      export read-only\n"
 "  -s, --snapshot       use snapshot file\n"
 "  -n, --nocache        disable host cache, short for -t none\n"
+"  -C, --copy-on-read   enable copy-on-read\n"
 "  -m, --misalign       misalign allocations for O_DIRECT\n"
 "  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
 "  -t, --cache=MODE     use the given cache mode for the image\n"
@@ -439,7 +444,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnmkt:T:U";
+    const char *sopt = "hVc:d:f:rsnCmkt:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -448,6 +453,7 @@ int main(int argc, char **argv)
         { "read-only", no_argument, NULL, 'r' },
         { "snapshot", no_argument, NULL, 's' },
         { "nocache", no_argument, NULL, 'n' },
+        { "copy-on-read", no_argument, NULL, 'C' },
         { "misalign", no_argument, NULL, 'm' },
         { "native-aio", no_argument, NULL, 'k' },
         { "discard", required_argument, NULL, 'd' },
@@ -492,6 +498,9 @@ int main(int argc, char **argv)
             flags |= BDRV_O_NOCACHE;
             writethrough = false;
             break;
+        case 'C':
+            flags |= BDRV_O_COPY_ON_READ;
+            break;
         case 'd':
             if (bdrv_parse_discard_flags(optarg, &flags) < 0) {
                 error_report("Invalid discard option: %s", optarg);
-- 
2.13.6
