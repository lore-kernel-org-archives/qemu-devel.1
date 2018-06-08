Received: from eggs.gnu.org ([2001:4830:134:3::10]:41367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFE-0007FZ-Dd
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFD-0005Ox-AU
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:04 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 18:23:53 +0300
Message-Id: <20180608152353.98712-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180608152353.98712-1-vsementsov@virtuozzo.com>
References: <20180608152353.98712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 6/6] docs/interop: add nbd.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Describe new metadata namespace: "qemu".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/interop/nbd.txt | 37 +++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 docs/interop/nbd.txt

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
new file mode 100644
index 0000000000..7366269fc0
--- /dev/null
+++ b/docs/interop/nbd.txt
@@ -0,0 +1,37 @@
+Qemu supports NBD protocol, and has internal NBD client (look at
+block/nbd.c), internal NBD server (look at blockdev-nbd.c) as well as
+external NBD server tool - qemu-nbd.c. The common code is placed in
+nbd/*.
+
+NBD protocol is specified here:
+https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
+
+This following paragraphs describe some specific properties of NBD
+protocol realization in Qemu.
+
+
+= Metadata namespaces =
+
+Qemu supports "base:allocation" metadata context as defined in the NBD
+protocol specification and defines own metadata namespace: "qemu".
+
+
+== "qemu" namespace ==
+
+For now, the only type of metadata context in the namespace is dirty
+bitmap. All available metadata contexts have the following form:
+
+   qemu:dirty-bitmap:<dirty-bitmap-export-name>
+
+Each dirty-bitmap metadata context defines the only one flag for
+extents in reply for NBD_CMD_BLOCK_STATUS:
+
+    bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"
+
+For NBD_OPT_LIST_META_CONTEXT the following queries are supported
+additionally to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
+
+* "qemu:" : returns list of all available metadata contexts in the
+            namespace.
+* "qemu:dirty-bitmap:" : returns list of all available dirty-bitmap
+                         metadata contexts.
diff --git a/MAINTAINERS b/MAINTAINERS
index e187b1f18f..887b479440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1923,6 +1923,7 @@ F: nbd/
 F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
+F: docs/interop/nbd.txt
 T: git git://repo.or.cz/qemu/ericb.git nbd
 
 NFS
-- 
2.11.1
