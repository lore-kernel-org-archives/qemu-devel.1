Received: from eggs.gnu.org ([2001:4830:134:3::10]:45003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N2-0007dT-PQ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3Mz-0000UL-Mj
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 10 Sep 2017 15:37:32 +0100
Message-Id: <1505054255-2990-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/4] ppc: change CPUPPCState access_type from
 int to uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, lvivier@redhat.com

This change was suggested by Alexey in advance of a subsequent commit which
adds access_type into vmstate_ppc_cpu.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h     |    4 ++--
 target/ppc/machine.c |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 12f0949..59d1656 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1010,8 +1010,8 @@ struct CPUPPCState {
     /* Next instruction pointer */
     target_ulong nip;
 
-    int access_type; /* when a memory exception occurs, the access
-                        type is stored here */
+    uint8_t access_type; /* when a memory exception occurs, the access
+                            type is stored here */
 
     CPU_COMMON
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e36b710..e59049f 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -19,6 +19,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     target_ulong sdr1;
     uint32_t fpscr;
     target_ulong xer;
+    int access_type;
 
     for (i = 0; i < 32; i++)
         qemu_get_betls(f, &env->gpr[i]);
@@ -46,7 +47,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     }
     qemu_get_be32s(f, &fpscr);
     env->fpscr = fpscr;
-    qemu_get_sbe32s(f, &env->access_type);
+    qemu_get_sbe32s(f, &access_type);
+    env->access_type = (uint8_t)access_type;
 #if defined(TARGET_PPC64)
     qemu_get_betls(f, &env->spr[SPR_ASR]);
     qemu_get_sbe32s(f, &env->slb_nr);
-- 
1.7.10.4
