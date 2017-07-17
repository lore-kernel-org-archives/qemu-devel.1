Received: from eggs.gnu.org ([2001:4830:134:3::10]:59865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXEIc-0007XR-P3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXEIb-00022p-L1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:15:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 17:15:14 -0500
Message-Id: <20170717221516.7692-2-eblake@redhat.com>
In-Reply-To: <20170717221516.7692-1-eblake@redhat.com>
References: <20170717221516.7692-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] nbd: Fix iotests failure due to changed
 client error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Commit 8ecaeae8 changed the way the client requests an NBD export,
and in the process also changed the resulting error message when
the export is not present, breaking a couple of iotests.  The error
message is now directly given by the server (a failed NBD_OPT_GO)
instead of implied by the client (after exhausting NBD_OPT_LIST),
but looking at the testsuite changes, it proves worthwhile to
reword the error message to be slightly less verbose (as this is
one particular error message likely to be hit by a user).

Note that the error message is now sensitive to which binary is
running the server as well as the client (since the expected
output is replaying a message received from the server - for that
matter, it depends on a server new enough to understand NBD_OPT_GO);
in general iotests are run on client and server from the same source
code base so the default setup will pass; but if it proves
problematic for people overriding QEMU_PROG, QEMU_IMG_PROG,
QEMU_IO_PROG, and QEMU_NBD_PROG to point across multiple builds for
cross-version integration testing, we may have to later tweak or
sanitize the output somehow.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170717142310.17048-1-eblake@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 nbd/client.c               | 5 ++---
 tests/qemu-iotests/140.out | 3 ++-
 tests/qemu-iotests/143.out | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index c3ee9f36b1..846bdc394c 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -232,8 +232,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
         break;

     case NBD_REP_ERR_UNKNOWN:
-        error_setg(errp, "Requested export not available for option %" PRIx32
-                   " (%s)", reply->option, nbd_opt_lookup(reply->option));
+        error_setg(errp, "Requested export not available");
         break;

     case NBD_REP_ERR_SHUTDOWN:
@@ -253,7 +252,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
     }

     if (msg) {
-        error_append_hint(errp, "%s\n", msg);
+        error_append_hint(errp, "server reported: %s\n", msg);
     }

  cleanup:
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 0689b2b41c..7295b3d975 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -8,7 +8,8 @@ wrote 65536/65536 bytes at offset 0
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
-can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
+can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Requested export not available
+server reported: export 'drv' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 0978b8985a..1c7fb45543 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -1,7 +1,8 @@
 QA output created by 143
 {"return": {}}
 {"return": {}}
-can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: No export with name 'no_such_export' available
+can't open device nbd+unix:///no_such_export?socket=TEST_DIR/nbd: Requested export not available
+server reported: export 'no_such_export' not present
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
-- 
2.13.3
