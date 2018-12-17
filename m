Received: from eggs.gnu.org ([2001:4830:134:3::10]:54995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzw-0002Hq-Cf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzt-0007Rz-9H
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYnzs-0007MD-SC
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:29 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:34 +0200
Message-Id: <20181217081047.2039-11-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 10/23] qapi: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

pvrdma requires that the same GID attached to it will be attached to the
backend device in the host.

A new QMP messages is defined so pvrdma device can broadcast any change
made to its GID table. This event is captured by libvirt which in  turn
will update the GID table in the backend device.

Depend on: "qapi: Reduce Makefile boilerplate"

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS           |  1 +
 Makefile.objs         |  3 ++-
 qapi/qapi-schema.json |  1 +
 qapi/rdma.json        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 qapi/rdma.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b68080094..525bcdcf41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2335,6 +2335,7 @@ F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
 F: contrib/rdmacm-mux/*
+F: qapi/rdma.json
 
 Build and test automation
 -------------------------
diff --git a/Makefile.objs b/Makefile.objs
index 319f14d937..bc5b8a8442 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,5 +1,6 @@
 QAPI_MODULES = block-core block char common crypto introspect job migration
-QAPI_MODULES += misc net rocker run-state sockets tpm trace transaction ui
+QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
+QAPI_MODULES += ui
 
 #######################################################################
 # Common libraries for tools and emulators
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..3bbdfcee84 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -86,6 +86,7 @@
 { 'include': 'char.json' }
 { 'include': 'job.json' }
 { 'include': 'net.json' }
+{ 'include': 'rdma.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
 { 'include': 'ui.json' }
diff --git a/qapi/rdma.json b/qapi/rdma.json
new file mode 100644
index 0000000000..1ed0eec48b
--- /dev/null
+++ b/qapi/rdma.json
@@ -0,0 +1,38 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = RDMA device
+##
+
+##
+# @RDMA_GID_STATUS_CHANGED:
+#
+# Emitted when guest driver adds/deletes GID to/from device
+#
+# @netdev: RoCE Network Device name - char *
+#
+# @gid-status: Add or delete indication - bool
+#
+# @subnet-prefix: Subnet Prefix - uint64
+#
+# @interface-id : Interface ID - uint64
+#
+# Since: 4.0
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
+#     "event": "RDMA_GID_STATUS_CHANGED",
+#     "data":
+#         {"netdev": "bridge0",
+#         "interface-id": 15880512517475447892,
+#         "gid-status": true,
+#         "subnet-prefix": 33022}}
+#
+##
+{ 'event': 'RDMA_GID_STATUS_CHANGED',
+  'data': { 'netdev'        : 'str',
+            'gid-status'    : 'bool',
+            'subnet-prefix' : 'uint64',
+            'interface-id'  : 'uint64' } }
-- 
2.17.2
