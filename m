Received: from eggs.gnu.org ([209.51.188.92]:35807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GH-0002Jx-W7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GG-0003l4-N0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GG-0003W7-Cy
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so4694792wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:17 +0100
Message-Id: <1549390526-24246-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/76] cpu-exec: add assert_no_pages_locked()
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
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

We forgot to add this check in faa9372c07 ("translate-all:
introduce assert_no_pages_locked", 2018-06-15); we only added
it after returning from a longjmp in cpu_exec_step_atomic. Fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7cf1292..49b3259 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -702,6 +702,7 @@ int cpu_exec(CPUState *cpu)
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
+        assert_no_pages_locked();
     }
 
     /* if an exception is pending, we execute it here */
-- 
1.8.3.1
