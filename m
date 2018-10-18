Received: from eggs.gnu.org ([2001:4830:134:3::10]:47800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXK-0004CA-RV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDDXG-00007n-QF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:00:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDDXG-000057-FQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 15:00:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 18 Oct 2018 21:00:26 +0200
Message-Id: <20181018190026.9494-3-laurent@vivier.eu>
In-Reply-To: <20181018190026.9494-1-laurent@vivier.eu>
References: <20181018190026.9494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [2 2/2] linux-user/sparc/signal.c: Remove unnecessary
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Remove a comment suggesting that we need to call tb_flush()
after writing the SPARC signal frame trampoline insns.
This isn't necessary in QEMU, because (even if the guest
architecture requires explicit icache maintenance) we
ensure that memory writes result in invalidation of
translated code from that memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181009184017.15675-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index b4c60aa446..e44e99993c 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -258,10 +258,6 @@ void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(val32, &sf->insns[1]);
         if (err)
             goto sigsegv;
-
-        /* Flush instruction space. */
-        // flush_sig_insns(current->mm, (unsigned long) &(sf->insns[0]));
-        // tb_flush(env);
     }
     unlock_user(sf, sf_addr, sizeof(struct target_signal_frame));
     return;
-- 
2.17.2
