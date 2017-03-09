Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4I-0005AX-7n
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4H-0006Wa-1I
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:14 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clw4G-0006V1-Rn
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:12 -0500
Received: by mail-wr0-x231.google.com with SMTP id g10so42712134wrg.2
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:17:12 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Mar 2017 11:17:10 +0000
Message-Id: <20170309111714.20394-8-alex.bennee@linaro.org>
In-Reply-To: <20170309111714.20394-1-alex.bennee@linaro.org>
References: <20170309111714.20394-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/11] translate-all: exit cpu_restore_state
 early if translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The translation code uses cpu_ld*_code which can trigger a tlb_fill
which if it fails will erroneously attempts a fault resolution. This
never works during translation as the TB being generated hasn't been
added yet. The target should have checked retaddr before calling
cpu_restore_state but for those that have yet to be fixed we do it
here to avoid a recursive tb_lock() under MTTCG's new locking regime.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 translate-all.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/translate-all.c b/translate-all.c
index d42d003e67..34480aebba 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -333,6 +333,19 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
     TranslationBlock *tb;
     bool r = false;
 
+    /* A retaddr of zero is invalid so we really shouldn't have ended
+     * up here. The target code has likely forgotten to check retaddr
+     * != 0 before attempting to restore state. We return early to
+     * avoid blowing up on a recursive tb_lock(). The target must have
+     * previously survived a failed cpu_restore_state because
+     * tb_find_pc(0) would have failed anyway. It still should be
+     * fixed though.
+     */
+
+    if (!retaddr) {
+        return r;
+    }
+
     tb_lock();
     tb = tb_find_pc(retaddr);
     if (tb) {
-- 
2.11.0
