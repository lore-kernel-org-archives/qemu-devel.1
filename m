Received: from eggs.gnu.org ([2001:4830:134:3::10]:45079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOI-0006QV-TM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOG-0006CR-4c
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:50 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56031)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOF-0006B7-Gd
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:48 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Wed, 26 Jul 2017 02:18:36 -0400
Message-Id: <1501049917-4701-2-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel]  [PATCH v2 1/2] hmp: dump ids including socket-id,
 core-id and so on for 'info registers'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

This patch add output of CPUs' socket-id, core-id, thread-id and
apic-id for 'info registers', which can be used for querying other
hmp commands.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
---
 target/i386/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index f63eb3d..a52f300 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -416,6 +416,14 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     int eflags, i, nb;
     char cc_op_name[32];
     static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
+    APICCommonState *s = APIC_COMMON(cpu->apic_state);
+
+    if (!s) {
+        cpu_fprintf(f, "local apic state not available\n");
+        return;
+    }
+    cpu_fprintf(f, "(socket-id:%d core-id:%d thread-id:%d apic-id:%d)\n",
+            cpu->socket_id, cpu->core_id, cpu->thread_id, s->id);
 
     eflags = cpu_compute_eflags(env);
 #ifdef TARGET_X86_64
-- 
1.8.3.1
