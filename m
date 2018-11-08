Received: from eggs.gnu.org ([2001:4830:134:3::10]:40804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFg-00083o-CH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFe-0004ud-Lo
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gKnFe-0004bE-Bs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:50 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10-v6so1908711wmc.5
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 08:33:33 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Nov 2018 16:33:25 +0000
Message-Id: <20181108163329.19940-3-alex.bennee@linaro.org>
In-Reply-To: <20181108163329.19940-1-alex.bennee@linaro.org>
References: <20181108163329.19940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/6] target/arm64: hold BQL when calling
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Fix the assertion failure when running interrupts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index b92ce3437f..03b0f78831 100644
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
2.17.1
