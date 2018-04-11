Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f6Djv-0002nR-KE
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f6Djs-0005zq-Gr
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2613 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1f6Djs-0005qQ-6C
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:32 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Wed, 11 Apr 2018 19:16:02 +0800
Message-ID: <20180411111602.20156-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] cpu: skip unpluged cpu when querying cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, wangxinxin.wang@huawei.com, xuyandong2@huawei.com

From: XuYandong <xuyandong2@huawei.com>

After vcpu1 thread exiting, vcpu0 thread (received notification) is still waiting for
holding qemu_global_mutex in cpu_remove_sync, at this moment, vcpu1 is still in global cpus list.
If main thread grab qemu_global_mutex in order to handle qmp command "info cpus",
qmp_query_cpus visit unpluged vcpu1 will lead qemu process to exit.

Signed-off-by: XuYandong <xuyandong2@huawei.com>
---
 cpus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cpus.c b/cpus.c
index 2cb0af9..9b3a6c4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2018,6 +2018,11 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 
     CPU_FOREACH(cpu) {
         CpuInfoList *info;
+
+        if (cpu->unplug) {
+            continue;
+        }
+
 #if defined(TARGET_I386)
         X86CPU *x86_cpu = X86_CPU(cpu);
         CPUX86State *env = &x86_cpu->env;
-- 
1.8.3.1
