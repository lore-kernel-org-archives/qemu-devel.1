Received: from eggs.gnu.org ([2001:4830:134:3::10]:60057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHvNx-0005rV-Af
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHvNw-00017O-Kk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:01:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Jun 2017 18:01:38 +0100
Message-Id: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] block/gluster.c: Handle qdict_array_entries()
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

In qemu_gluster_parse_json(), the call to qdict_array_entries()
could return a negative error code, which we were ignoring
because we assigned the result to an unsigned variable.
Fix this by using the 'int' type instead, which matches the
return type of qdict_array_entries() and also the type
we use for the loop enumeration variable 'i'.

(Spotted by Coverity, CID 1360960.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/gluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 031596a..addceed 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -493,8 +493,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     Error *local_err = NULL;
     char *str = NULL;
     const char *ptr;
-    size_t num_servers;
-    int i, type;
+    int i, type, num_servers;
 
     /* create opts info from runtime_json_opts list */
     opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
-- 
2.7.4
