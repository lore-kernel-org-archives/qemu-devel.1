Received: from eggs.gnu.org ([2001:4830:134:3::10]:53687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dmhQx-0001g4-Jn
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dmhQv-0004DU-0Q
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:03 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dmhQu-0004DF-QL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:00 -0400
Received: by mail-wr0-x242.google.com with SMTP id k94so2410468wrc.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 07:24:00 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Tue, 29 Aug 2017 10:23:03 -0400
Message-Id: <1504016587-39779-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v8 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch enables qmp interfaces for the fsdev
devices. This provides two interfaces one
for querying info of all the fsdev devices. The second one
to set the IO limits for the required fsdev device.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 qapi/block-core.json | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602..95bbc5e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1819,11 +1819,13 @@
   'data': 'BlockIOThrottle' }
 
 ##
-# @BlockIOThrottle:
-#
-# A set of parameters describing block throttling.
+# == QAPI IOThrottle definitions
+##
+
+##
+# @IOThrottle:
 #
-# @device: Block device name (deprecated, use @id instead)
+# A set of parameters describing IO throttling
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
@@ -1889,12 +1891,11 @@
 #
 # @iops_size: an I/O size in bytes (Since 1.7)
 #
-# @group: throttle group name (Since 2.4)
 #
-# Since: 1.1
+# Since: 2.11
 ##
-{ 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
+{ 'struct': 'IOThrottle',
+  'data': { '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
             'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
             '*bps_max': 'int', '*bps_rd_max': 'int',
             '*bps_wr_max': 'int', '*iops_max': 'int',
@@ -1902,7 +1903,22 @@
             '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
+            '*iops_size': 'int' } }
+
+##
+# @BlockIOThrottle:
+#
+# A set of parameters describing block throttling.
+#
+# @device: Block device name (deprecated, use @id instead)
+#
+# @group: throttle group name (Since 2.4)
+#
+# Since: 1.1
+##
+{ 'struct': 'BlockIOThrottle',
+  'base': 'IOThrottle',
+  'data': { '*device': 'str', '*group': 'str' } }
 
 ##
 # @block-stream:
-- 
1.8.3.1
