Received: from eggs.gnu.org ([209.51.188.92]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEWA-0002g1-1E
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW6-0003fu-3o
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:13 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54202 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtEW3-0003br-QR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Feb 2019 17:31:23 +0100
Message-Id: <1549902684-21740-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/6] hw/mips_cpc: kick a VP when putting it
 into Run statewq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org, pburton@wavecomp.com, cota@braap.org

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

While testing mttcg VP0 could get stuck in a loop waiting for other
VPs to come up (which never actually happens). To fix this, kick VPs
while they are being powered up by Cluster Power Controller in an
async task which is triggered once the host thread is being spawned.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 hw/misc/mips_cpc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 6d34574..712d842 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -30,6 +30,14 @@ static inline uint64_t cpc_vp_run_mask(MIPSCPCState *c=
pc)
     return (1ULL << cpc->num_vp) - 1;
 }
=20
+static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data=
)
+{
+    MIPSCPCState *cpc =3D (MIPSCPCState *) data.host_ptr;
+
+    cpu_reset(cs);
+    cpc->vp_running |=3D 1ULL << cs->cpu_index;
+}
+
 static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 {
     CPUState *cs =3D first_cpu;
@@ -37,8 +45,13 @@ static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_=
run)
     CPU_FOREACH(cs) {
         uint64_t i =3D 1ULL << cs->cpu_index;
         if (i & vp_run & ~cpc->vp_running) {
-            cpu_reset(cs);
-            cpc->vp_running |=3D i;
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
--=20
2.7.4
