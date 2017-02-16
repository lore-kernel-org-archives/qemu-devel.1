Received: from eggs.gnu.org ([2001:4830:134:3::10]:51936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6h-0003tS-FY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6d-0008C7-D2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:27 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6d-0008BX-6O
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so3407905wmu.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:23 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.32.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:32:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:36 +0100
Message-Id: <1487255507-106654-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/23] cpu-exec: tighten barrier on
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
index 1f7d217..d50625b 100644
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
1.8.3.1
