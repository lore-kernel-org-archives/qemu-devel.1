Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5V-0002yq-8J
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgur-0007q5-Ho
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgun-0007eu-3y
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:40 -0400
Message-Id: <20181025144644.15464-7-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 07/71] tcg-runtime: define
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/tcg-runtime.h | 2 ++
 accel/tcg/tcg-runtime.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 1bd39d136d..d767f8515b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_2(cpu_halted_set, TCG_CALL_NO_RWG, void, env, i32)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index d0d4484406..4aa038465f 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
 }
+
+void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+
+    cpu->halted = val;
+}
-- 
2.17.1
