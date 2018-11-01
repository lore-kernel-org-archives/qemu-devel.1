Received: from eggs.gnu.org ([2001:4830:134:3::10]:51017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIFro-0007Jt-Mo
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIFrn-0001uy-RF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:30:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Nov 2018 16:30:37 +0000
Message-Id: <20181101163037.800-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] blockdev: Consistently use
 snapshot_node_name in external_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

In the function external_snapshot_prepare() we have a
BlockdevSnapshotSync struct, which has the usual combination
of has_snapshot_node_name and snapshot_node_name fields for an
optional field. We set up a local variable
        const char *snapshot_node_name =
            s->has_snapshot_node_name ? s->snapshot_node_name : NULL;

and then mostly use "if (!snapshot_node_name)" for checking
whether we have a snapshot node name. The exception is that in
one place we check s->has_snapshot_node_name instead. This
confuses Coverity (CID 1396473), which thinks it might be
possible to get here with s->has_snapshot_node_name true but
snapshot_node_name NULL, and warns that the call to
qdict_put_str() will segfault in that case.

Make the code consistent and unconfuse Coverity by using
the same check for this conditional that we do in the rest
of the surrounding code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: tested only with "make check"...

 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 574adbcb7f5..b24610c606e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1639,7 +1639,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         }
 
         options = qdict_new();
-        if (s->has_snapshot_node_name) {
+        if (snapshot_node_name) {
             qdict_put_str(options, "node-name", snapshot_node_name);
         }
         qdict_put_str(options, "driver", format);
-- 
2.19.1
