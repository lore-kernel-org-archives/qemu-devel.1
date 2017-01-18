Received: from eggs.gnu.org ([2001:4830:134:3::10]:36801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt0-0006PX-1a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysw-0002bP-1M
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:22 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTysv-0002ad-RD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:17 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so7566565wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:17 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:19 +0100
Message-Id: <1484779123-18968-7-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

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
index f65d8b5..21fe0d1 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -736,8 +736,9 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
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
2.7.2
