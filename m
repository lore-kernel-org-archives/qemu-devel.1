Received: from eggs.gnu.org ([209.51.188.92]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8t-0005BW-9f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8s-0002rl-CR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:55 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:06 +1000
Message-Id: <20190503055316.6441-4-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 03/13] target/ppc: Add SPR ASDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The Access Segment Descriptor Register (ASDR) provides information about
the storage element when taking a hypervisor storage interrupt. When
performing nested radix address translation, this is normally the guest
real address. This register is present on POWER9 processors and later.

Implement the ADSR, note read and write access is limited to the
hypervisor.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h                | 1 +
 target/ppc/translate_init.inc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 19b3e1de0e..8d66265e5a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1797,6 +1797,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_MPC_MD_DBRAM1     (0x32A)
 #define SPR_RCPU_L2U_RA3      (0x32B)
 #define SPR_TAR               (0x32F)
+#define SPR_ASDR              (0x330)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
 #define SPR_MMCRC             (0x353)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 9cd33e79ef..a0cae58e19 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8243,6 +8243,12 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_ptcr,
                         KVM_REG_PPC_PTCR, 0x00000000);
+    /* Address Segment Descriptor Register */
+    spr_register_hv(env, SPR_ASDR, "ASDR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_generic, &spr_write_generic,
+                    0x0000000000000000);
 #endif
 }
 
-- 
2.13.6
