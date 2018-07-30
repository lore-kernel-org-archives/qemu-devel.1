Received: from eggs.gnu.org ([2001:4830:134:3::10]:55843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaO-0000Tf-CN
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEaN-00023y-Jc
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:08 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkEaN-00023p-FQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:16:07 -0400
Received: by mail-ua0-x22a.google.com with SMTP id c12-v6so8731679uan.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:16:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 30 Jul 2018 16:15:53 -0400
Message-Id: <20180730201553.32423-5-richard.henderson@linaro.org>
In-Reply-To: <20180730201553.32423-1-richard.henderson@linaro.org>
References: <20180730201553.32423-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] linux-user/sparc: Flush register windows
 before clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

As seen as the very first instruction of sys_clone in the kernel.

Ideally this would be done in or before cpu_copy, and not with a
separate explicit test vs the syscall number, but this is a more
minimal solution.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/cpu_loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 91f714afc6..fe83f25686 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -169,6 +169,9 @@ void cpu_loop (CPUSPARCState *env)
         case 0x110:
         case 0x16d:
 #endif
+            if (env->gregs[1] == TARGET_NR_clone) {
+                flush_windows(env);
+            }
             ret = do_syscall (env, env->gregs[1],
                               env->regwptr[0], env->regwptr[1],
                               env->regwptr[2], env->regwptr[3],
-- 
2.17.1
