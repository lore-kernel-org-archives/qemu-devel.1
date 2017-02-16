Received: from eggs.gnu.org ([2001:4830:134:3::10]:53812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCm-0000iw-D4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCh-0002M7-O9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:44 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:65068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCh-0002LZ-D9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:14 +0100
Message-Id: <20170216143816.2384-13-laurent@vivier.eu>
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 12/14] linux-user: fill target sigcontext
 struct accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

A segfault is noticed when an emulated program uses any of ucontext
regs fields. Risu detected this issue in the following operation when
handling a signal:
  ucontext_t *uc = (ucontext_t*)uc;
  uc->uc_mcontext.regs->nip += 4;

but this works fine:
  uc->uc_mcontext.gp_regs[PT_NIP] += 4;

This patch set regs to a valid location as well as other sigcontext
fields.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5064de0..8209539 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     target_ulong rt_sf_addr, newsp = 0;
     int i, err = 0;
 #if defined(TARGET_PPC64)
+    struct target_sigcontext *sc = 0;
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
 #endif
 
@@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
 #if defined(TARGET_PPC64)
     mctx = &rt_sf->uc.tuc_sigcontext.mcontext;
     trampptr = &rt_sf->trampoline[0];
+
+    sc = &rt_sf->uc.tuc_sigcontext;
+    __put_user(h2g(mctx), &sc->regs);
+    __put_user(sig, &sc->signal);
 #else
     mctx = &rt_sf->uc.tuc_mcontext;
     trampptr = (uint32_t *)&rt_sf->uc.tuc_mcontext.tramp;
-- 
2.9.3
