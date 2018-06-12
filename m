Received: from eggs.gnu.org ([2001:4830:134:3::10]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3r-0002rE-NV
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3q-0001yl-9I
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:54 +1000
Message-Id: <20180612064503.14282-25-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/33] target/ppc: Allow PIR read in privileged
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, luporl <leandro.lupori@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

From: luporl <leandro.lupori@gmail.com>

According to PowerISA, the PIR register should be readable in privileged
mode also, not only in hypervisor privileged mode.

PowerISA 3.0 - 4.3.3 Processor Identification Register

"Read access to the PIR is privileged; write access is not provided."

Figure 18 in section 4.4.4 explicitly confirms that mfspr PIR is privileged
and doesn't require hypervisor state.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 1a89017dde..bb9296f5a3 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -7819,7 +7819,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
     /* Processor identification */
     spr_register_hv(env, SPR_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
     spr_register_hv(env, SPR_HID0, "HID0",
-- 
2.17.1
