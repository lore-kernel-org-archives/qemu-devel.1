Received: from eggs.gnu.org ([2001:4830:134:3::10]:55424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYr-0007nH-6a
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYq-0006ir-GV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:21 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYq-0006ih-Cb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:20 -0500
Received: by mail-qk0-x243.google.com with SMTP id e1so951720qkh.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:42 -0800
Message-Id: <20170112025606.27332-7-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/30] target-sparc: on UA2005 don't deliver
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
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

As described in Chapter 5.7.6 of the UltraSPARC Architecture 2005,
outstanding disrupting exceptions that are destined for privileged mode can only
cause a trap when the virtual processor is in nonprivileged or privileged mode and
PSTATE.ie = 1. At all other times, they are held pending.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <bfd3fe8edac04f925b2251dedf6f540266e0c6c5.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
