Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO07s-0000aN-8z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dO07p-0005Hu-0H
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:18:16 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dO07o-0005HA-OC
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:18:12 -0400
Received: by mail-wr0-x22e.google.com with SMTP id c11so18856410wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 04:18:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 22 Jun 2017 12:18:45 +0100
Message-Id: <20170622111845.5296-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm/helper: document potential CNTV
 register bear trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Christoffer Dall <cdall@linaro.org>

The ARM KVM encodings have been inadvertently switched for
CNTV_CVAL_EL0/CNTVCT_EL0 in the register API since its introduction.
Fortunately this doesn't currently mater as the reset values for both
are the same. However if this ever changes things will break in
interesting ways.

Migration is currently unaffected as we just use
cpu->cpreg_vmstate_indexes/cpreg_vmstate_values verbatim. However this
would break if we ever supported migration between KVM and TCG models.

For now we just warn future generations who may touch this code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Christoffer Dall <cdall@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2594faa9b8..e7a0e39583 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -211,6 +211,11 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
+/*
+ * FIXME: the KVM API has switched encodings for
+ * CNTV_CVAL_EL0/CNTVCT_EL0 which need to be fixed if we want to
+ * change the reset values or support KVM<->TCG migration.
+ */
 bool write_cpustate_to_list(ARMCPU *cpu)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
@@ -234,6 +239,7 @@ bool write_cpustate_to_list(ARMCPU *cpu)
     return ok;
 }
 
+/* FIXME: see above re:CNTV_CVAL_EL0/CNTVCT_EL0 encodings */
 bool write_list_to_cpustate(ARMCPU *cpu)
 {
     int i;
@@ -1961,6 +1967,11 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
                                    cp15.c14_timer[GTIMER_VIRT].ctl),
       .writefn = gt_virt_ctl_write, .raw_writefn = raw_write,
     },
+    /* WARNING! For *KVM only* the switched API encoding means this
+     * actually gets loaded in fresh VMs as CNTV_CVAL_EL0. This will
+     * need to be fixed in write_[cpustate_to_list|list_to_cpustate]
+     * if you want to change the reset value.
+     */
     { .name = "CNTV_CTL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 1,
       .type = ARM_CP_IO, .access = PL1_RW | PL0_R,
@@ -2053,6 +2064,11 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_vtimer_access,
       .writefn = gt_virt_cval_write, .raw_writefn = raw_write,
     },
+    /* WARNING! For *KVM only* the switched API encoding means this
+     * actually gets loaded in fresh VMs as CNTVCT_EL0. This will need
+     * to be fixed in write_[cpustate_to_list|list_to_cpustate] if you
+     * want to change the reset value.
+     */
     { .name = "CNTV_CVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 2,
       .access = PL1_RW | PL0_R,
-- 
2.13.0
