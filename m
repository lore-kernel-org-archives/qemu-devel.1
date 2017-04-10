Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqr-0002UG-Vs
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxYqo-00037F-8T
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:25 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxYqo-00036I-20
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:55:22 -0400
Received: by mail-wm0-x233.google.com with SMTP id t189so36720387wmt.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:55:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Apr 2017 13:55:16 +0100
Message-Id: <20170410125524.21008-4-alex.bennee@linaro.org>
In-Reply-To: <20170410125524.21008-1-alex.bennee@linaro.org>
References: <20170410125524.21008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/11] target/i386/misc_helper: wrap BQL around
 another IRQ generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Anything that calls into HW emulation must be protected by the BQL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>

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
