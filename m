Received: from eggs.gnu.org ([2001:4830:134:3::10]:58136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1m-0004Eq-9x
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1k-0007pU-LK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1k-0007eF-DH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1b-0002u1-PK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:32 +0100
Message-Id: <1507305585-20608-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/20] target/arm: Restore security state on
 exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that we can handle the CONTROL.SPSEL bit not necessarily being
in sync with the current stack pointer, we can restore the correct
security state on exception return. This happens before we start
to read registers off the stack frame, but after we have taken
possible usage faults for bad exception return magic values and
updated CONTROL.SPSEL.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-5-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 36173e2..b82fc9f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6381,6 +6381,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      */
     write_v7m_control_spsel(env, return_to_sp_process);
 
+    switch_v7m_security_state(env, return_to_secure);
+
     {
         /* The stack pointer we should be reading the exception frame from
          * depends on bits in the magic exception return type value (and
-- 
2.7.4
