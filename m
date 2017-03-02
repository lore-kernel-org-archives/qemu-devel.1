Received: from eggs.gnu.org ([2001:4830:134:3::10]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnH-0007xw-Va
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnH-0002Tn-7N
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnH-0002TM-1M
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:43 -0500
Received: by mail-wm0-x22e.google.com with SMTP id i17so4774107wmf.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:42 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:31 +0000
Message-Id: <20170302195337.31558-6-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/11] translate-all: exit cpu_restore_state
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
which if it fails will attempt a fault resolution. This never works
during translation as the TB being generated hasn't been added yet.
However with the new locking regime we end up double locking the
tb_lock(). As the tcg_ctx.cpu is only set during translation we use
this to short circuit the restore code and return with a fail.

Most front-ends seem to ignore the pass/fail result anyway but
tolerate not having the cpu environment updated. This is arguably ugly
but will do for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 translate-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/translate-all.c b/translate-all.c
index 7ee273410d..956d54b882 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -333,6 +333,13 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
     TranslationBlock *tb;
     bool r = false;
 
+    /* Don't attempt to restore state if we are translating already */
+    if (tcg_ctx.cpu == cpu) {
+        qemu_log_mask(LOG_UNIMP, "Attempt to resolve CPU state @ 0x%" PRIxPTR
+                      " while translating\n", retaddr);
+        return r;
+    }
+
     tb_lock();
     tb = tb_find_pc(retaddr);
     if (tb) {
-- 
2.11.0
