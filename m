Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8v-0006W0-3T
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8t-0001h3-WD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:17 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:57 -0500
Message-Id: <20180621031957.134718-8-eblake@redhat.com>
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] docs/interop: add nbd.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Describe new metadata namespace: "qemu".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180609151758.17343-7-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt | 38 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 docs/interop/nbd.txt

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
new file mode 100644
index 00000000000..77b5f459111
--- /dev/null
+++ b/docs/interop/nbd.txt
@@ -0,0 +1,38 @@
+Qemu supports the NBD protocol, and has an internal NBD client (see
+block/nbd.c), an internal NBD server (see blockdev-nbd.c), and an
+external NBD server tool (see qemu-nbd.c). The common code is placed
+in nbd/*.
+
+The NBD protocol is specified here:
+https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
+
+The following paragraphs describe some specific properties of NBD
+protocol realization in Qemu.
+
+= Metadata namespaces =
+
+Qemu supports the "base:allocation" metadata context as defined in the
+NBD protocol specification, and also defines an additional metadata
+namespace "qemu".
+
+
+== "qemu" namespace ==
+
+The "qemu" namespace currently contains only one type of context,
+related to exposing the contents of a dirty bitmap alongside the
+associated disk contents.  That context has the following form:
+
+    qemu:dirty-bitmap:<dirty-bitmap-export-name>
+
+Each dirty-bitmap metadata context defines only one flag for extents
+in reply for NBD_CMD_BLOCK_STATUS:
+
+    bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"
+
+For NBD_OPT_LIST_META_CONTEXT the following queries are supported
+in addition to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
+
+* "qemu:" - returns list of all available metadata contexts in the
+            namespace.
+* "qemu:dirty-bitmap:" - returns list of all available dirty-bitmap
+                         metadata contexts.
diff --git a/MAINTAINERS b/MAINTAINERS
index da91501c7a6..efb17e6ac0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1972,6 +1972,7 @@ F: nbd/
 F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
+F: docs/interop/nbd.txt
 T: git git://repo.or.cz/qemu/ericb.git nbd

 NFS
-- 
2.14.4
