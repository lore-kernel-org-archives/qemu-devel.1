Received: from eggs.gnu.org ([209.51.188.92]:42594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUh0-000896-OG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUgy-0006y0-LP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjUgx-0006wy-Dc
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:07 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 15 Jan 2019 14:47:53 -0500
Message-Id: <20190115194754.7670-2-cota@braap.org>
In-Reply-To: <20190115194754.7670-1-cota@braap.org>
References: <20190115194754.7670-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/2] cpu-exec: add assert_no_pages_locked()
 after longjmp
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

We forgot to add this check in faa9372c07 ("translate-all:
introduce assert_no_pages_locked", 2018-06-15); we only added
it after returning from a longjmp in cpu_exec_step_atomic. Fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 870027d435..55e0ca41c4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -699,6 +699,7 @@ int cpu_exec(CPUState *cpu)
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
+        assert_no_pages_locked();
     }
 
     /* if an exception is pending, we execute it here */
-- 
2.17.1
