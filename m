Received: from eggs.gnu.org ([2001:4830:134:3::10]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlQ-0002Ac-9d
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlM-0001Xh-MT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:28 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43365
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQVlM-0001Wq-Fq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:24 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 29 Jun 2017 11:28:52 +0200
Message-Id: <1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 2/3] arm: fix the armv7m reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com, alistair@alistair23.me, frederic.konrad@adacore.com

This fixes an odd bug when a ROM is present somewhere and an alias @0x00000000
is pointing to the ROM. The "if (rom)" test fails and we don't get a valid reset
state. QEMU later crashes with an exception because the ARMv7-M starts with the
ARM instruction set. (eg: PC & 0x01 is 0).

This patch uses memory_region_get_offset_within_address_space introduced before
to check if an alias doesn't point to a flash somewhere.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/arm/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 28a9141..b8afd97 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -201,6 +201,20 @@ static void arm_cpu_reset(CPUState *s)
 
         /* Load the initial SP and PC from the vector table at address 0 */
         rom = rom_ptr(0);
+
+        if (!rom) {
+            /* Sometimes address 0x00000000 is an alias to a flash which
+             * actually have a ROM.
+             */
+            MemoryRegionSection section;
+            hwaddr offset = 0;
+
+            section = memory_region_find(s->as->root, 0, 8);
+            offset = memory_region_get_offset_within_address_space(section.mr);
+            memory_region_unref(section.mr);
+            rom = rom_ptr(offset);
+        }
+
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
-- 
1.8.3.1
