Received: from eggs.gnu.org ([2001:4830:134:3::10]:53352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1p-0002OX-3R
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1n-0007Tr-MO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:25 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1n-0007SV-GH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:23 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g19so68076883wrb.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:13 +0100
Message-Id: <20170407154221.26918-5-alex.bennee@linaro.org>
In-Reply-To: <20170407154221.26918-1-alex.bennee@linaro.org>
References: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/12] target/i386/misc_helper: wrap BQL
 around another IRQ generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

Anything that calls into HW emulation must be protected by the BQL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/misc_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index ca2ea09f54..628f64aad5 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
@@ -156,7 +157,9 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
         break;
     case 8:
         if (!(env->hflags2 & HF2_VINTR_MASK)) {
+            qemu_mutex_lock_iothread();
             cpu_set_apic_tpr(x86_env_get_cpu(env)->apic_state, t0);
+            qemu_mutex_unlock_iothread();
         }
         env->v_tpr = t0 & 0x0f;
         break;
-- 
2.11.0
