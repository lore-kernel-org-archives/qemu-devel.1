Received: from eggs.gnu.org ([2001:4830:134:3::10]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHM-0007cD-2Y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHJ-0003LC-CV
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHI-0003Al-Sg
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:49 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:51 +0200
Message-Id: <20181105124559.21561-11-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 10/18] json: Define new QMP message for pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

pvrdma requires that the same GID attached to it will be attached to the
backend device in the host.

A new QMP messages is defined so pvrdma device can broadcast any change
made to its GID table. This event is captured by libvirt which in turn
will update the GID table in the backend device.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS           |  1 +
 Makefile              |  3 ++-
 Makefile.objs         |  4 ++++
 qapi/qapi-schema.json |  1 +
 qapi/rdma.json        | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 qapi/rdma.json

diff --git a/MAINTAINERS b/MAINTAINERS
index e087d58ac6..a149f68a8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2232,6 +2232,7 @@ F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
 F: contrib/rdmacm-mux/*
+F: qapi/rdma.json
 
 Build and test automation
 -------------------------
diff --git a/Makefile b/Makefile
index 94072776ff..db4ce60ee5 100644
--- a/Makefile
+++ b/Makefile
@@ -599,7 +599,8 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
-               $(SRC_PATH)/qapi/ui.json
+               $(SRC_PATH)/qapi/ui.json \
+               $(SRC_PATH)/qapi/rdma.json
 
 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
 qapi/qapi-types.c qapi/qapi-types.h \
diff --git a/Makefile.objs b/Makefile.objs
index cc7df3ad80..76d8028f2f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,7 @@ util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
 util-obj-y += qapi/qapi-types-ui.o
+util-obj-y += qapi/qapi-types-rdma.o
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
 util-obj-y += qapi/qapi-visit-block-core.o
@@ -40,6 +41,7 @@ util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
 util-obj-y += qapi/qapi-visit-ui.o
+util-obj-y += qapi/qapi-visit-rdma.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
 util-obj-y += qapi/qapi-events-block.o
@@ -58,6 +60,7 @@ util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
 util-obj-y += qapi/qapi-events-ui.o
+util-obj-y += qapi/qapi-events-rdma.o
 util-obj-y += qapi/qapi-introspect.o
 
 chardev-obj-y = chardev/
@@ -155,6 +158,7 @@ common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
 common-obj-y += qapi/qapi-commands-ui.o
+common-obj-y += qapi/qapi-commands-rdma.o
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
 endif
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..a650d80f83 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -94,3 +94,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'rdma.json' }
diff --git a/qapi/rdma.json b/qapi/rdma.json
new file mode 100644
index 0000000000..44d6432e8d
--- /dev/null
+++ b/qapi/rdma.json
@@ -0,0 +1,34 @@
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
+# Since: 2.12.1
+#
+# Example:
+#
+# <- { {"timestamp": {"seconds": 1540819325, "microseconds": 504544},
+#       "event": "ADDGID", "data": {"netdev": "bridge0",
+#       "interface-id": 7052258031502978997, "subnet-prefix": 33022}}
+#
+##
+{ 'event': 'RDMA_GID_STATUS_CHANGED',
+  'data': { 'netdev'        : 'str',
+            'gid-status'    : 'bool',
+            'subnet-prefix' : 'uint64',
+            'interface-id'  : 'uint64' } }
-- 
2.17.2
