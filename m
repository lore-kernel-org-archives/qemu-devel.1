Received: from eggs.gnu.org ([2001:4830:134:3::10]:59696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8U-00029T-Ot
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ8R-0006dG-M3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3108 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNZ8R-0006D2-6N
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:51 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 16 Nov 2018 15:59:50 +0800
Message-ID: <570359424051acbdd6816bc224ed2c03de2ab210.1542384802.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542384802.git.xiezhide@huawei.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 3/6] fsdev-throttle-qmp: Rewrite
 BlockIOThrottle with ThrottleLimits as its base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

Rewrite BlockIOThrottle with ThrottleLimits as its base class and modify related code

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 blockdev.c           |  2 ++
 qapi/block-core.json | 73 ++--------------------------------------------------
 2 files changed, 4 insertions(+), 71 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index fce5d8f..89921ec 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2752,6 +2752,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         cfg.op_size = arg->iops_size;
     }
 
+    throttle_limits_to_config(qapi_BlockIOThrottle_base(arg), &cfg, errp);
+
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4ffaaea..3abd6af 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2155,82 +2155,13 @@
 #
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
-#
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
