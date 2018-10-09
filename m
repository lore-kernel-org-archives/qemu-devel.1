Received: from eggs.gnu.org ([2001:4830:134:3::10]:43677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9wvi-0007I7-DM
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9wvg-00070Y-L3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:40:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9wve-0006vP-Sv
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:40:24 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 19:40:17 +0100
Message-Id: <20181009184017.15675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user/sparc/signal.c: Remove unnecessary
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
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Remove a comment suggesting that we need to call tb_flush()
after writing the SPARC signal frame trampoline insns.
This isn't necessary in QEMU, because (even if the guest
architecture requires explicit icache maintenance) we
ensure that memory writes result in invalidation of
translated code from that memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Found (with grep) while looking at what parts of the tree call
tb_flush()...

 linux-user/sparc/signal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index b4c60aa4468..e44e99993c6 100644
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
2.19.0
