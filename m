Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgf-0004an-CH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKge-0000Sb-Mk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKge-0000SF-Ar
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:56 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 667EE8553C
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:45:56 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpdw028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:45:55 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:37 +0100
Message-Id: <20170227124551.8673-4-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] cpu-exec: remove unnecessary check of
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
index 2a0dfb0..ea1e155 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -571,10 +571,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
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
