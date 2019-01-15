Received: from eggs.gnu.org ([209.51.188.92]:42619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUh2-0008A4-Ja
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUgy-0006yS-QC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjUgy-0006wx-I7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 15 Jan 2019 14:47:54 -0500
Message-Id: <20190115194754.7670-3-cota@braap.org>
In-Reply-To: <20190115194754.7670-1-cota@braap.org>
References: <20190115194754.7670-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/2] cpu-exec: reset BQL after longjmp in
 cpu_exec_step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Just like we do in cpu_exec().

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 55e0ca41c4..fefd955d66 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -266,6 +266,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
 #ifndef CONFIG_SOFTMMU
         tcg_debug_assert(!have_mmap_lock());
 #endif
+        if (qemu_mutex_iothread_locked()) {
+            qemu_mutex_unlock_iothread();
+        }
         assert_no_pages_locked();
     }
 
-- 
2.17.1
