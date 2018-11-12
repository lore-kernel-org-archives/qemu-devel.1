Received: from eggs.gnu.org ([2001:4830:134:3::10]:60627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFht-00046J-Rx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFht-0000ge-92
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFht-0008MG-1V
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:01 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhL-0005sD-H1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:07 +0000
Message-Id: <20181112170816.500-8-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/16] target/arm64: hold BQL when calling
 do_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Fix the assertion failure when running interrupts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181109152119.9242-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6351a54b287..c39150e5e18 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1000,7 +1000,9 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
     cs->exception_index = EXCP_BKPT;
     env->exception.syndrome = debug_exit->hsr;
     env->exception.vaddress = debug_exit->far;
+    qemu_mutex_lock_iothread();
     cc->do_interrupt(cs);
+    qemu_mutex_unlock_iothread();
 
     return false;
 }
-- 
2.19.1
