Received: from eggs.gnu.org ([209.51.188.92]:42825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbC-0002YQ-Oo
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb2-00076e-DZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVb2-00076F-71
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id v13so15436166wrw.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:19 +0000
Message-Id: <20190118145805.6852-4-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/49] target/arm: Allow Aarch32 exception
 return to switch from Mon->Hyp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alexander Graf <agraf@suse.de>

In U-boot, we switch from S-SVC -> Mon -> Hyp mode when we want to
enter Hyp mode. The change into Hyp mode is done by doing an
exception return from Mon. This doesn't work with current QEMU.

The problem is that in bad_mode_switch() we refuse to allow
the change of mode.

Note that bad_mode_switch() is used to do validation for two situations:

 (1) changes to mode by instructions writing to CPSR.M
     (ie not exception take/return) -- this corresponds to the
     Armv8 Arm ARM pseudocode Arch32.WriteModeByInstr
 (2) changes to mode by exception return

Attempting to enter or leave Hyp mode via case (1) is forbidden in
v8 and UNPREDICTABLE in v7, and QEMU is correct to disallow it
there. However, we're already doing that check at the top of the
bad_mode_switch() function, so if that passes then we should allow
the case (2) exception return mode changes to switch into Hyp mode.

We want to test whether we're trying to return to the nonexistent
"secure Hyp" mode, so we need to look at arm_is_secure_below_el3()
rather than arm_is_secure(), since the latter is always true if
we're in Mon (EL3).

Signed-off-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190109152430.32359-1-agraf@suse.de
[PMM: rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f00c141ef96..9bf8fbd8f9b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6297,7 +6297,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
         return 0;
     case ARM_CPU_MODE_HYP:
         return !arm_feature(env, ARM_FEATURE_EL2)
-            || arm_current_el(env) < 2 || arm_is_secure(env);
+            || arm_current_el(env) < 2 || arm_is_secure_below_el3(env);
     case ARM_CPU_MODE_MON:
         return arm_current_el(env) < 3;
     default:
-- 
2.20.1
