Received: from eggs.gnu.org ([2001:4830:134:3::10]:60606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDctp-0003Yg-Hr
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDcto-0005xg-JS
	for qemu-devel@nongnu.org; Wed, 24 May 2017 16:28:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 24 May 2017 15:28:38 -0500
Message-Id: <20170524202842.26724-2-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-1-eblake@redhat.com>
References: <20170524202842.26724-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

Most callback commands in qemu-io return 0 to keep the interpreter
loop running, or 1 to quit immediately.  However, open_f() just
passed through the return value of openfile(), which has different
semantics of returning 0 if a file was opened, or 1 on any failure.

As a result of mixing the return semantics, we are forcing the
qemu-io interpreter to exit early on any failures, which is rather
annoying when some of the failures are obviously trying to give
the user a hint of how to proceed (if we didn't then kill qemu-io
out from under the user's feet):

$ qemu-io
qemu-io> open foo
qemu-io> open foo
file open already, try 'help close'
$ echo $?
0

Meanwhile, we WANT openfile() to report failures, as it is the
way that 'qemu-io -c "$something" no_such_file' knows to exit
early rather than attempting $something.  So the solution is to
fix open_f() to always return 0 (when we are in interactive mode,
even failure to open should not end the session), and save the
return value of openfile() for command line use in main().

This has been awkward since at least as far back as commit
e3aff4f, in 2009.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: fix open_f(), not openfile()
---
 qemu-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 34fa8a1..b3febc2 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -230,13 +230,14 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
     qemu_opts_reset(&empty_opts);

     if (optind == argc - 1) {
-        return openfile(argv[optind], flags, writethrough, force_share, opts);
+        openfile(argv[optind], flags, writethrough, force_share, opts);
     } else if (optind == argc) {
-        return openfile(NULL, flags, writethrough, force_share, opts);
+        openfile(NULL, flags, writethrough, force_share, opts);
     } else {
         QDECREF(opts);
-        return qemuio_command_usage(&open_cmd);
+        qemuio_command_usage(&open_cmd);
     }
+    return 0;
 }

 static int quit_f(BlockBackend *blk, int argc, char **argv)
-- 
2.9.4
