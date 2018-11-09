Received: from eggs.gnu.org ([2001:4830:134:3::10]:42451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bC-0001CL-3y
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8b8-0002y3-Qb
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL8b6-0002mU-VF
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:25 -0500
Received: by mail-wr1-x444.google.com with SMTP id j26-v6so2303128wre.1
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:21:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Nov 2018 15:21:15 +0000
Message-Id: <20181109152119.9242-4-alex.bennee@linaro.org>
In-Reply-To: <20181109152119.9242-1-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/7] target/arm64: kvm debug set target_el
 when passing exception to guest
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

When we are debugging the guest all exceptions come our way but might
be for the guest's own debug exceptions. We use the ->do_interrupt()
infrastructure to inject the exception into the guest. However, we are
missing a full setup of the exception structure, causing an assert
later down the line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - tweak commit msg for grammar
---
 target/arm/kvm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c39150e5e1..46fbe6d8ff 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1000,6 +1000,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
     cs->exception_index = EXCP_BKPT;
     env->exception.syndrome = debug_exit->hsr;
     env->exception.vaddress = debug_exit->far;
+    env->exception.target_el = 1;
     qemu_mutex_lock_iothread();
     cc->do_interrupt(cs);
     qemu_mutex_unlock_iothread();
-- 
2.17.1
