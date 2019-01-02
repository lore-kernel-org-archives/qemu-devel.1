Received: from eggs.gnu.org ([208.118.235.92]:43843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gebAh-0003Kc-3k
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 02:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gebAd-0003xa-Qm
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 02:42:34 -0500
Received: from m12-18.163.com ([220.181.12.18]:53723)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gebAd-0003vT-47
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 02:42:31 -0500
From: Li Qiang <liq3ea@163.com>
Date: Tue,  1 Jan 2019 23:41:14 -0800
Message-Id: <20190102074114.26988-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] qom: cpu: destroy work_mutex in
 cpu_common_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com, cota@braap.org, philmd@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Commit 376692b9dc6(cpus: protect work list with work_mutex)
initialize a work_mutex in cpu_common_initfn, however forget
to destroy it. This will cause resource leak when hotunplug cpu
or hotplug cpu fails.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 qom/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qom/cpu.c b/qom/cpu.c
index 9ad1372d57..367ebf9d61 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -380,6 +380,9 @@ static void cpu_common_initfn(Object *obj)
 
 static void cpu_common_finalize(Object *obj)
 {
+    CPUState *cpu = CPU(obj);
+
+    qemu_mutex_destroy(&cpu->work_mutex);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
-- 
2.17.1
