Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvt-0006Br-RS
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvs-0006Oc-Q5
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvs-0006O8-Kf
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:56 -0500
Received: by mail-wm1-x344.google.com with SMTP id c126so7865756wmh.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:56 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:16 +0200
Message-Id: <20181222095036.29743-12-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 11/31] qapi: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

pvrdma requires that the same GID attached to it will be attached to the
backend device in the host.

A new QMP messages is defined so pvrdma device can broadcast any change
made to its GID table. This event is captured by libvirt which in  turn
will update the GID table in the backend device.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 MAINTAINERS           |  1 +
 Makefile.objs         |  3 ++-
 qapi/qapi-schema.json |  1 +
 qapi/rdma.json        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 qapi/rdma.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 856d379b0a..180695f5d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2413,6 +2413,7 @@ F: hw/rdma/*
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
index 0000000000..b58105b1b6
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
+# @netdev: RoCE Network Device name
+#
+# @gid-status: Add or delete indication
+#
+# @subnet-prefix: Subnet Prefix
+#
+# @interface-id : Interface ID
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
2.17.1
