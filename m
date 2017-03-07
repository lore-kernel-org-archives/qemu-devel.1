Received: from eggs.gnu.org ([2001:4830:134:3::10]:48938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHVQ-0000ul-7J
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHVO-0008C0-FI
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:58:32 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clHVO-0008BW-97
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:58:30 -0500
Received: by mail-wm0-x231.google.com with SMTP id n11so93408762wma.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:58:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Mar 2017 15:50:50 +0000
Message-Id: <20170307155054.5833-8-alex.bennee@linaro.org>
In-Reply-To: <20170307155054.5833-1-alex.bennee@linaro.org>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/11] translate-all: exit cpu_restore_state
 early if translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

The translation code uses cpu_ld*_code which can trigger a tlb_fill
which if it fails will erroneously attempts a fault resolution. This
never works during translation as the TB being generated hasn't been
added yet. The target should have checked retaddr before calling
cpu_restore_state but for those that have yet to be fixed we do it
here to avoid a recursive tb_lock() under MTTCG's new locking regime.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - check retaddr instead
  - reword commit/comments to be clearer
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
