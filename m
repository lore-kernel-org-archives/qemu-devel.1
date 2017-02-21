Received: from eggs.gnu.org ([2001:4830:134:3::10]:51774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q9-0001be-TT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q9-0003C3-4U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9q8-0003Bp-UA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:45 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:46:38 +0100
Message-Id: <20170221124638.19573-4-pbonzini@redhat.com>
In-Reply-To: <20170221124638.19573-1-pbonzini@redhat.com>
References: <20170221124638.19573-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] cpu-exec: remove unnecessary check of
 cpu->exit_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pavel.dovgaluk@ispras.ru, peter.maydell@linaro.org

The cpu->exit_request check in cpu_loop_exec_tb is unnecessary,
because cpu->tcg_exit_req is always set after cpu->exit_request.
So let the TB exit and we will pick up the exit request later
in cpu_handle_interrupt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index bf126dd..db1de5a 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -535,10 +535,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     uintptr_t ret;
     int32_t insns_left;
 
-    if (unlikely(atomic_read(&cpu->exit_request))) {
-        return;
-    }
-
     trace_exec_tb(tb, tb->pc);
     ret = cpu_tb_exec(cpu, tb);
     tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
-- 
2.9.3
