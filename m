Received: from eggs.gnu.org ([2001:4830:134:3::10]:48609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePni9-000151-Kx
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePni3-00069r-VC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:59:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Dec 2017 11:59:05 +0100
Message-Id: <20171215105905.21338-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Document that x-blockdev-change breaks
 quorum children list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Removing a quorum child node with x-blockdev-change results in a quorum
driver state that cannot be recreated with create options because it
would require a list with gaps. This causes trouble in at least
.bdrv_refresh_filename().

Document this problem so that we won't accidentally mark the command
stable without having addressed it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dd763dcf87..4cc1389834 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3918,6 +3918,10 @@
 # does not support all kinds of operations, all kinds of children, nor
 # all block drivers.
 #
+# FIXME Removing children from a quorum node means introducing gaps in the
+# child indices. This cannot be represented in the 'children' list of
+# BlockdevOptionsQuorum, as returned by .bdrv_refresh_filename().
+#
 # Warning: The data in a new quorum child MUST be consistent with that of
 # the rest of the array.
 #
-- 
2.13.6
