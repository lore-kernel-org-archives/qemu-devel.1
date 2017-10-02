Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz1nO-0005ZB-4f
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz1nK-0007tx-1j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:10 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dz1nJ-0007ti-OV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id z96so2646525wrb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:34:05 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon,  2 Oct 2017 10:33:28 -0400
Message-Id: <1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This patch factors out code to use the ThrottleLimits
structure.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 qapi/block-core.json | 75 +++-------------------------------------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 750bb0c..f1d2c13 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1824,86 +1824,17 @@
 #
 # A set of parameters describing block throttling.
 #
-# @device: Block device name (deprecated, use @id instead)
-#
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
-# @bps: total throughput limit in bytes per second
-#
-# @bps_rd: read throughput limit in bytes per second
-#
-# @bps_wr: write throughput limit in bytes per second
-#
-# @iops: total I/O operations per second
-#
-# @iops_rd: read I/O operations per second
-#
-# @iops_wr: write I/O operations per second
-#
-# @bps_max: total throughput limit during bursts,
-#                     in bytes (Since 1.7)
-#
-# @bps_rd_max: read throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @bps_wr_max: write throughput limit during bursts,
-#                        in bytes (Since 1.7)
-#
-# @iops_max: total I/O operations per second during bursts,
-#                      in bytes (Since 1.7)
-#
-# @iops_rd_max: read I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @iops_wr_max: write I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
-#
-# @bps_max_length: maximum length of the @bps_max burst
-#                            period, in seconds. It must only
-#                            be set if @bps_max is set as well.
-#                            Defaults to 1. (Since 2.6)
-#
-# @bps_rd_max_length: maximum length of the @bps_rd_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_rd_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @bps_wr_max_length: maximum length of the @bps_wr_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_wr_max is set as well.
-#                               Defaults to 1. (Since 2.6)
-#
-# @iops_max_length: maximum length of the @iops burst
-#                             period, in seconds. It must only
-#                             be set if @iops_max is set as well.
-#                             Defaults to 1. (Since 2.6)
-#
-# @iops_rd_max_length: maximum length of the @iops_rd_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_rd_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_wr_max_length: maximum length of the @iops_wr_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_wr_max is set as well.
-#                                Defaults to 1. (Since 2.6)
-#
-# @iops_size: an I/O size in bytes (Since 1.7)
+# @device: Block device name (deprecated, use @id instead)
 #
 # @group: throttle group name (Since 2.4)
 #
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
-            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
-            '*bps_max': 'int', '*bps_rd_max': 'int',
-            '*bps_wr_max': 'int', '*iops_max': 'int',
-            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
-            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
-            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
-            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
+  'base': 'ThrottleLimits',
+  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
 
 ##
 # @ThrottleLimits:
-- 
1.8.3.1
