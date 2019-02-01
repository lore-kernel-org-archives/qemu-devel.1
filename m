Received: from eggs.gnu.org ([209.51.188.92]:59072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMF-0008I0-0u
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003k6-6x
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003f9-Nm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id g67so6747806wmd.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.48
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:49 +0000
Message-Id: <20190201160653.13829-44-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/47] target/arm: fix AArch64 virtual address
 space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
extension (yet), the VA address space is 48-bits plus a sign bit. User
mode can only handle the positive half of the address space, so that
makes a limit of 48 bits.

(With LVA, it would be 53 and 52 bits respectively.)

The incorrectly large address space conflicts with PAuth instructions,
which use bits 48-54 and 56-63 for the pointer authentication code. This
also conflicts with (as yet unsupported by QEMU) data tagging and with
the ARMv8.5-MTE extension.

Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 63934a200ad..a68bcc9fedb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2512,7 +2512,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
 
 #if defined(TARGET_AARCH64)
 #  define TARGET_PHYS_ADDR_SPACE_BITS 48
-#  define TARGET_VIRT_ADDR_SPACE_BITS 64
+#  define TARGET_VIRT_ADDR_SPACE_BITS 48
 #else
 #  define TARGET_PHYS_ADDR_SPACE_BITS 40
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
-- 
2.20.1
