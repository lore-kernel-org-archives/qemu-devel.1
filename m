Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwir-00080Q-G1
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwio-0002BJ-5w
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:17 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwio-0002BA-1N
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:14 -0500
Received: by mail-qt0-x242.google.com with SMTP id w20so20059407qtb.1
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:05 +0100
Message-Id: <20170129210910.6333-3-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] cpu-exec: tighten barrier on
 TCG_EXIT_REQUESTED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru

This seems to have worked just fine so far on weakly-ordered
architectures, but I don't see anything that prevents the
reordering from:

    store 1 to exit_request
    store 1 to tcg_exit_req
                                 load tcg_exit_req
                                 store 0 to tcg_exit_req
                                 load exit_request
                                 store 0 to exit_request
    store 1 to exit_request
    store 1 to tcg_exit_req

to this:

    store 1 to exit_request
    store 1 to tcg_exit_req
                                 load tcg_exit_req
                                 load exit_request
    store 1 to exit_request
    store 1 to tcg_exit_req
                                 store 0 to tcg_exit_req
                                 store 0 to exit_request

therefore losing a request.  It's possible that other memory barriers
(e.g. in rcu_read_unlock) are hiding it, but better safe than
sorry.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 2dc10c1..4065e0e 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -552,11 +552,11 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          * have set something else (eg exit_request or
          * interrupt_request) which we will handle
          * next time around the loop.  But we need to
-         * ensure the tcg_exit_req read in generated code
+         * ensure the zeroing of tcg_exit_req (see cpu_tb_exec)
          * comes before the next read of cpu->exit_request
          * or cpu->interrupt_request.
          */
-        smp_rmb();
+        smp_mb();
         *last_tb = NULL;
         break;
     case TB_EXIT_ICOUNT_EXPIRED:
-- 
2.9.3
