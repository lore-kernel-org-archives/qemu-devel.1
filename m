Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPC-0006Gl-Ve
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPC-0004J0-BX
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOPB-0004I6-P0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPA-00027l-Qx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:56 +0000
Message-Id: <20180215183700.26101-17-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/20] target/arm: Add AIRCR to vmstate struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit commit 3b2e934463121 we added support for the AIRCR
register holding state, but forgot to add it to the vmstate
structs. Since it only holds r/w state if the security extension
is implemented, we can just add it to vmstate_m_security.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180209165810.6668-10-peter.maydell@linaro.org
---
 target/arm/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 30fb1454a6..25cdf4d581 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -423,6 +423,10 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
         VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
         VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
+        /* AIRCR is not secure-only, but our implementation is R/O if the
+         * security extension is unimplemented, so we migrate it here.
+         */
+        VMSTATE_UINT32(env.v7m.aircr, ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.16.1
