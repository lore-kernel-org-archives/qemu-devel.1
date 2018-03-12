Received: from eggs.gnu.org ([2001:4830:134:3::10]:39028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkK-0004Nk-5V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkI-0003fS-RL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:32:00 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:39696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkI-0003Bb-FW
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:58 -0400
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 12 Mar 2018 10:31:40 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Mon, 12 Mar 2018 11:31:30 +0100
Message-Id: <1520850690-23245-5-git-send-email-abdallah.bouassida@lauterbach.com>
In-Reply-To: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 4/4] target/arm: Add arm_gdb_set_sysreg()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, khaled.jmal@lauterbach.com, Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

This is a callback to set the cp-regs registered by the dynamic XML.

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
---
>> Adding to that our customers may need this write access, our tool TRACE32®
>> needs this also in some particular cases. For example: temporary disabling MMU
>> to do a physical memory access.

> By clearing the SCTLR bit? That's a good example of a case that
> won't work reliably. If you clear the SCTLR.M bit via raw_write
> this will not perform the tlb_flush() that it needs to, which
> means that if anything does a memory access via the QEMU TLB
> it may get the wrong cached results. If you always clear the
> bit, do one gdb memory access then set the bit then it will
> probably not run into problems but you're walking on thin ice.

Does adding tlb_flush() before or after write_raw_cp_reg()
could solve the reliability issue for other particular cases?
Or is there any improvement that could be done for this write
callback in order to get more reliable results for other
particular cases?

 target/arm/helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5929e0b..bb5a97c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -239,6 +239,20 @@ static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
 
 static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
 {
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    const ARMCPRegInfo *ri;
+    uint32_t key;
+    uint32_t tmp;
+
+    tmp = ldl_p(buf);
+    key = cpu->dyn_xml.cpregs_keys[reg];
+    ri = get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
+    if (ri) {
+        if (!(ri->type & ARM_CP_CONST)) {
+            write_raw_cp_reg(env, ri, tmp);
+            return cpreg_field_is_64bit(ri) ? 8 : 4;
+        }
+    }
     return 0;
 }
 
-- 
2.7.4
