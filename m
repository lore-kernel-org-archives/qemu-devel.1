Received: from eggs.gnu.org ([2001:4830:134:3::10]:46453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXic-0001hW-FB
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXib-0002Oi-O9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:42 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 18 May 2017 21:32:30 -0500
Message-Id: <20170519023233.24461-2-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-1-eblake@redhat.com>
References: <20170519023233.24461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qemu-io: Don't die on second open
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

Failure to open a file in qemu-io should normally return 1 on
failure to end the command loop, on the presumption that when
batching commands all on the command line, failure to open means
nothing further can be attempted. But when executing qemu-io
interactively, there is a special case: if open is executed a
second time, we print a hint that the user should try the
interactive 'close' first.  But the hint is useless if we don't
actually LET them try 'close'.

This has been awkward since at least as far back as commit
43642b3, in 2011 (probably earlier, but git blame has a harder
time going past the file renames at that point).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io.c b/qemu-io.c
index 34fa8a1..0c82dac 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -63,7 +63,7 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
     if (qemuio_blk) {
         error_report("file open already, try 'help close'");
         QDECREF(opts);
-        return 1;
+        return 0;
     }

     if (force_share) {
-- 
2.9.4
