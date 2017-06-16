Received: from eggs.gnu.org ([2001:4830:134:3::10]:47245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLsSX-0002Jm-RA
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLsSU-0007Vq-Ns
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:42:49 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:38629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1dLsSU-0007Ph-Bu
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:42:46 -0400
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <1701daf4-b2de-a9fb-7337-7aa791676516@lauterbach.com>
Date: Fri, 16 Jun 2017 15:42:34 +0100
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] target-arm: Bug fix in filling the cp_regs
 hashtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Khaled Jmal <khaled.jmal@lauterbach.com>

Check if the CPU supports AARCH64 before adding  the 64bit view of
the coprocessor's register to the cp_regs hashtable.

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
---
Bug description: if a register has the .state = ARM_CP_STATE_BOTH, its 
64bit view will be added to the hashtable even if the CPU is not 64bit.

  target/arm/helper.c | 12 +++++++-----
  1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2594faa..7fa2889 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5607,11 +5607,13 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                              break;
                          }
                      } else {
-                        /* AArch64 registers get mapped to non-secure 
instance
-                         * of AArch32 */
-                        add_cpreg_to_hashtable(cpu, r, opaque, state,
-                                               ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2);
+                        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+                            /* AArch64 registers get mapped to 
non-secure instance
+                             * of AArch32 */
+                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+ ARM_CP_SECSTATE_NS,
+                                                   crm, opc1, opc2);
+                        }
                      }
                  }
              }
-- 
1.9.1
