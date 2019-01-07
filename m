Received: from eggs.gnu.org ([209.51.188.92]:46388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXob-000511-43
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoY-00024Q-5p
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:47 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoX-000216-S4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:46 -0500
Received: by mail-wr1-x435.google.com with SMTP id x10so1052510wrs.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:59 +0000
Message-Id: <20190107163117.16269-20-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/37] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.

The generic loader device (-device loader,file=kernel.bin) can be used
to load a kernel instead of the -kernel option.  Some boards have flash
memory (pflash) that is set via the -pflash or -drive options.

Allow starting QEMU without the -kernel option to accommodate these
scenarios.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103144124.18917-1-stefanha@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 4bf9131b81e..f4446528307 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -285,11 +285,6 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
     big_endian = 0;
 #endif
 
-    if (!kernel_filename && !qtest_enabled()) {
-        error_report("Guest image must be specified (using -kernel)");
-        exit(1);
-    }
-
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         asidx = ARMASIdx_S;
     } else {
-- 
2.19.2
