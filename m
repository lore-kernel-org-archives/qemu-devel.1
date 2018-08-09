Received: from eggs.gnu.org ([2001:4830:134:3::10]:53946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSk-0000i8-1G
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSi-00077U-VJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:14 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSi-00076q-Nh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:12 -0400
Received: by mail-pl0-x244.google.com with SMTP id x6-v6so1972192plv.10
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:48 -0700
Message-Id: <20180809042206.15726-3-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/20] target/arm: Set ID_AA64PFR0 bits for SVE
 for -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

This it a hair out of spec in that we have and advertise, support
for fp16 in aarch64 mode, but do not have nor advertise the same
in aarch32 mode.  Rationale as commented.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4d629bb99b..ae650b608e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -282,15 +282,24 @@ static void aarch64_max_initfn(Object *obj)
         cpu->id_aa64isar1 = deposit64(cpu->id_aa64isar1, 16, 4, 1);
         cpu->id_isar5 = deposit32(cpu->id_isar5, 28, 4, 1);
 
-#ifdef CONFIG_USER_ONLY
-        /* We don't set these in system emulation mode for the moment,
-         * since we don't correctly set the ID registers to advertise them,
-         * and in some cases they're only available in AArch64 and not AArch32,
-         * whereas the architecture requires them to be present in both if
-         * present in either.
+        /* TODO: This is not yet implemented for AArch32, whereas the
+         * architecture requires a feature to be present in both if
+         * it is present in either.  However, it is required by SVE,
+         * so we don't want to leave it out of AArch64 state.
+         *
+         * Practically, the Linux kernel does not query the MVFR1 bit
+         * nor expose this as a HWCAP bit to AArch32 userland.  Thus
+         * userland, if it wanted to use fp16, would have to probe for
+         * support by executing an insn and checking for SIGILL.
+         * At which point it will get the correct answer: unsupported.
          */
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+        cpu->id_aa64pfr0 = deposit64(cpu->id_aa64pfr0, 20, 4, 1);
+
         set_feature(&cpu->env, ARM_FEATURE_SVE);
+        cpu->id_aa64pfr0 = deposit64(cpu->id_aa64pfr0, 32, 4, 1);
+
+#ifdef CONFIG_USER_ONLY
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
          */
-- 
2.17.1
