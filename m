Received: from eggs.gnu.org ([2001:4830:134:3::10]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mithro@mithis.com>) id 1d0MSd-0004Pd-NY
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mithro@mithis.com>) id 1d0MSa-0004w8-Hy
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:17:59 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:34239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mithro@mithis.com>) id 1d0MSa-0004w0-C2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:17:56 -0400
Received: by mail-pf0-x22a.google.com with SMTP id c198so76057926pfc.1
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 23:17:56 -0700 (PDT)
From: Tim 'mithro' Ansell <mithro@mithis.com>
Date: Tue, 18 Apr 2017 16:15:51 +1000
Message-Id: <20170418061551.196582-3-mithro@mithis.com>
In-Reply-To: <20170418061551.196582-1-mithro@mithis.com>
References: <20170418061551.196582-1-mithro@mithis.com>
Subject: [Qemu-devel] [PATCH 2/2] target/openrisc: Implement EPH bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tim 'mithro' Ansell <mithro@mithis.com>, shorne@gmail.com, Jia Liu <proljc@gmail.com>

Exception Prefix High (EPH) control bit of the Supervision Register
(SR).

The significant bits (31-12) of the vector offset address for each
exception depend on the setting of the Supervision Register (SR)'s EPH
bit and the Exception Vector Base Address Register (EVBAR).

If SR[EPH] is set, the vector offset is logically ORed with the offset
0xF0000000.

This means if EPH is;
 * 0 - Exceptions vectors start at EVBAR
 * 1 - Exception vectors start at EVBAR | 0xF0000000

Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
---
 target/openrisc/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 78f0ba9421..2c91fab380 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -69,6 +69,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         if (env->cpucfgr & CPUCFGR_EVBARP) {
             vect_pc |= env->evbar;
         }
+        if (env->sr & SR_EPH) {
+            vect_pc |= 0xf0000000;
+        }
         env->pc = vect_pc;
     } else {
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
-- 
2.12.1
