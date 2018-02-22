Received: from eggs.gnu.org ([2001:4830:134:3::10]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfW-0004eM-Q2
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfU-0005v4-Jv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36837 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1eovfU-0005ss-CR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:32 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 22 Feb 2018 19:31:42 +0100
Message-Id: <1519324303-5674-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 5/6] hw/mips_cpc: kick a VP when putting it
 into Run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

From: Miodrag Dinic <miodrag.dinic@mips.com>

While testing mttcg VP0 could get stuck in a loop waiting for other
VPs to come up (which never actually happens). To fix this, kick VPs
while they are being powered up by Cluster Power Controller in an
async task which is triggered once the host thread is being spawned.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 hw/misc/mips_cpc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 6d34574..712d842 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -30,6 +30,14 @@ static inline uint64_t cpc_vp_run_mask(MIPSCPCState *cpc)
     return (1ULL << cpc->num_vp) - 1;
 }
 
+static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;
+
+    cpu_reset(cs);
+    cpc->vp_running |= 1ULL << cs->cpu_index;
+}
+
 static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 {
     CPUState *cs = first_cpu;
@@ -37,8 +45,13 @@ static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
     CPU_FOREACH(cs) {
         uint64_t i = 1ULL << cs->cpu_index;
         if (i & vp_run & ~cpc->vp_running) {
-            cpu_reset(cs);
-            cpc->vp_running |= i;
+            /*
+             * To avoid racing with a CPU we are just kicking off.
+             * We do the final bit of preparation for the work in
+             * the target CPUs context.
+             */
+            async_safe_run_on_cpu(cs, mips_cpu_reset_async_work,
+                                  RUN_ON_CPU_HOST_PTR(cpc));
         }
     }
 }
-- 
2.7.4
