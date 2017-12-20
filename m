Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIJ-0004uz-AX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReII-0006ok-53
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:38 +0100
Message-Id: <20171220131939.27543-14-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/14] block: Document that x-blockdev-change
 breaks quorum children list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Removing a quorum child node with x-blockdev-change results in a quorum
driver state that cannot be recreated with create options because it
would require a list with gaps. This causes trouble in at least
.bdrv_refresh_filename().

Document this problem so that we won't accidentally mark the command
stable without having addressed it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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
