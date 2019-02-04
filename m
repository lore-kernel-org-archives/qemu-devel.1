Received: from eggs.gnu.org ([209.51.188.92]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6p-00050Y-NR
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6n-0003Rv-Po
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6l-0003Lb-S3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:41 -0500
Received: by mail-wr1-x433.google.com with SMTP id x10so940547wrs.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:11 +0100
Message-Id: <1549305379-51117-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/77] cpu-exec: reset BQL after longjmp in
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
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Just like we do in cpu_exec().

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 49b3259..fab30af 100644
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
1.8.3.1
