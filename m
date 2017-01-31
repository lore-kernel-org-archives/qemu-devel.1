Received: from eggs.gnu.org ([2001:4830:134:3::10]:48066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cYgYb-0004lh-MD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cYgYY-0005Im-Iy
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:05:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41655
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cYgYY-0005IZ-DK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:05:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0VLxH4W111528
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:05:40 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28au5gm38g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:05:40 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 31 Jan 2017 20:05:38 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 31 Jan 2017 20:05:17 -0200
Message-Id: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] linux-user: fill target sigcontext struct
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, qemu-ppc@nongnu.org

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
2.7.4
