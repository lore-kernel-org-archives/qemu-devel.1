Received: from eggs.gnu.org ([209.51.188.92]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy7-0004No-U3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy7-0004AW-4f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldy6-00049V-SF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id v13so24483160wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:50 +0100
Message-Id: <1548093980-43088-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/49] cpu-exec: add assert_no_pages_locked()
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
index 870027d..55e0ca4 100644
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
1.8.3.1
