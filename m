Received: from eggs.gnu.org ([2001:4830:134:3::10]:41623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYu-0000tz-0u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYs-0003ar-QN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:00 -0500
Received: from [59.151.112.132] (port=61481 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYs-0003Wn-AD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:58 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 20:40:07 +0800
Message-ID: <1484743207-10721-4-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] cpu: make the function of
 cpu_common_map_numa_node more efficiently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Current function does some unnecessary operations, such as it makes
the assert() in the loop, and the loop was not stopped in time.

This patch moves the assert() out the loop and stops the loop in
time.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 qom/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index e08dceb..3c655b2 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -343,10 +343,11 @@ static void cpu_common_map_numa_node(CPUState *cpu)
 {
     int i;
 
+    assert(cpu->cpu_index < max_cpus);
     for (i = 0; i < nb_numa_nodes; i++) {
-        assert(cpu->cpu_index < max_cpus);
         if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
             cpu->numa_node = i;
+            return;
         }
     }
 }
-- 
2.5.5
