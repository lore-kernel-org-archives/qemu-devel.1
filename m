Received: from eggs.gnu.org ([2001:4830:134:3::10]:46912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQX-0007uK-2u
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQV-00043W-UZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:37 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:51 +0100
Message-Id: <1506092407-26985-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 04/20] target/arm: Restore security state on
 exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Now that we can handle the CONTROL.SPSEL bit not necessarily being
in sync with the current stack pointer, we can restore the correct
security state on exception return. This happens before we start
to read registers off the stack frame, but after we have taken
possible usage faults for bad exception return magic values and
updated CONTROL.SPSEL.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 509a1aa..a3c63c3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6371,6 +6371,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      */
     write_v7m_control_spsel(env, return_to_sp_process);
 
+    switch_v7m_security_state(env, return_to_secure);
+
     {
         /* The stack pointer we should be reading the exception frame from
          * depends on bits in the magic exception return type value (and
-- 
2.7.4
