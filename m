Received: from eggs.gnu.org ([2001:4830:134:3::10]:54895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO2-0006Rq-1G
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNz-0000xk-Qw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:46 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPNz-0000xa-KU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:43 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so553824wmr.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:43 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:37 +0100
Message-Id: <bfd3fe8edac04f925b2251dedf6f540266e0c6c5.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 06/30] target-sparc: on UA2005 don't deliver
 Interrupt_level_n IRQs in hypervisor mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

As described in Chapter 5.7.6 of the UltraSPARC Architecture 2005,
outstanding disrupting exceptions that are destined for privileged mode can only
cause a trap when the virtual processor is in nonprivileged or privileged mode and
PSTATE.ie = 1. At all other times, they are held pending.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f2e923d..7233140 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -733,8 +733,9 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     if (env1->psret != 0)
         return 1;
 #else
-    if (env1->pstate & PS_IE)
+    if ((env1->pstate & PS_IE) && !cpu_hypervisor_mode(env1)) {
         return 1;
+    }
 #endif
 
     return 0;
-- 
1.8.3.1
