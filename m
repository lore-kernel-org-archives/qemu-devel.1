Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpWsV-00073p-Ay
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpWsS-00046d-7a
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:48:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59341 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fpWsR-00042T-MU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:48:40 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Tue, 14 Aug 2018 18:48:13 +0800
Message-ID: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

I got the following error when migrating a VM with watchdog
device:

{"timestamp": {"seconds": 1533884471, "microseconds": 668099},
"event": "WATCHDOG", "data": {"action": "reset"}}
{"timestamp": {"seconds": 1533884471, "microseconds": 677658},
"event": "RESET", "data": {"guest": true}}
{"timestamp": {"seconds": 1533884471, "microseconds": 677874},
"event": "STOP"}
qemu-system-x86_64: invalid runstate transition: 'prelaunch' -> 'postmigrate'
Aborted

The run state transition is RUN_STATE_FINISH_MIGRATE to RUN_STATE_PRELAUNCH,
then the migration thread aborted when it tries to set RUN_STATE_POSTMIGRATE.
There is a race between the main loop thread and the migration thread I think.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 16b913f..298ce91 100644
--- a/vl.c
+++ b/vl.c
@@ -637,6 +637,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
     { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_POSTMIGRATE },
 
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
-- 
1.8.3.1
