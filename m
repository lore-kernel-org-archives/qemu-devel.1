Received: from eggs.gnu.org ([2001:4830:134:3::10]:36241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrE-0007rC-8d
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrC-0002FD-KE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:40 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrC-0002Ez-Dg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:38 -0500
Received: by mail-wr0-x241.google.com with SMTP id q39so3111564wrb.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:38 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	s26sm8814533wra.66.2017.02.24.09.40.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 09:40:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:16 +0100
Message-Id: <1487958030-51417-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/17] cpu-exec: remove unnecessary check of
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

The cpu->exit_request check in cpu_loop_exec_tb is unnecessary,
because cpu->tcg_exit_req is always set after cpu->exit_request.
So let the TB exit and we will pick up the exit request later
in cpu_handle_interrupt.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 7ddf66c..7db959c 100644
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
1.8.3.1
