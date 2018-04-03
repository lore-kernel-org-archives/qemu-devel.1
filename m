Received: from eggs.gnu.org ([2001:4830:134:3::10]:53709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NR8-0000hI-0H
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NR3-0000CY-OV
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:25 -0400
Received: from mout.web.de ([212.227.15.14]:58665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f3NR3-0000Bd-Ed
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:21 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Date: Tue,  3 Apr 2018 17:00:56 +0200
Message-Id: <6f4d44ffde55d074cbceb48309c1678600abad2f.1522767657.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522767657.git.jan.kiszka@web.de>
References: <cover.1522767657.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522767657.git.jan.kiszka@web.de>
References: <cover.1522767657.git.jan.kiszka@web.de>
Subject: [Qemu-devel] [PATCH 3/4] target-i386: Mark cpu_vmexit noreturn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

It calls cpu_loop_exit in system emulation mode (and should never be
called in user emulation mode).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/i386/cpu.h        | 4 ++--
 target/i386/svm_helper.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 78db1b833a..d711634c2f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1764,8 +1764,8 @@ void helper_lock_init(void);
 /* svm_helper.c */
 void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
                                    uint64_t param, uintptr_t retaddr);
-void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
-                uintptr_t retaddr);
+void QEMU_NORETURN cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
+                              uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1);
 
 /* seg_helper.c */
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 303106981c..e3288955f1 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -62,6 +62,7 @@ void helper_invlpga(CPUX86State *env, int aflag)
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
+    assert(0);
 }
 
 void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
-- 
2.13.6
