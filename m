Received: from eggs.gnu.org ([209.51.188.92]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S8-0008PT-0R
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S6-0007Kg-NU
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:11 -0400
Received: from smtp4.iitb.ac.in ([103.21.127.18]:35310 helo=smtp1.iitb.ac.in)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hD6S6-0007Jg-3j
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:10 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 20EFE1027501
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:07 +0530 (IST)
Received: from jeeves.cse.iitb.ac.in (miller.cse.iitb.ac.in [10.129.3.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 4E866360036
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:05 +0530 (IST)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Sun,  7 Apr 2019 17:28:39 +0530
Message-Id: <20190407115839.25054-3-skrtbhtngr@gmail.com>
In-Reply-To: <20190407115839.25054-1-skrtbhtngr@gmail.com>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move hvf_cpu_synchronize*
 calls to cpu_synchronize* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

Keep the calls made to synchronize cpu by all hypervisors in one place
inside cpu_synchronize_* functions in include/sysemu/hw_accel.h

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 cpus.c                    | 12 ------------
 include/sysemu/hw_accel.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/cpus.c b/cpus.c
index e83f72b48b..026df0dc5f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1021,10 +1021,6 @@ void cpu_synchronize_all_states(void)
=20
     CPU_FOREACH(cpu) {
         cpu_synchronize_state(cpu);
-        /* TODO: move to cpu_synchronize_state() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_state(cpu);
-        }
     }
 }
=20
@@ -1034,10 +1030,6 @@ void cpu_synchronize_all_post_reset(void)
=20
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_reset(cpu);
-        /* TODO: move to cpu_synchronize_post_reset() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_reset(cpu);
-        }
     }
 }
=20
@@ -1047,10 +1039,6 @@ void cpu_synchronize_all_post_init(void)
=20
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_init(cpu);
-        /* TODO: move to cpu_synchronize_post_init() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_init(cpu);
-        }
     }
 }
=20
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index d2ddfb5ad0..bf081b4026 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -15,6 +15,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
+#include "sysemu/hvf.h"
=20
 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_state(cpu);
+    }
 }
=20
 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -40,6 +44,9 @@ static inline void cpu_synchronize_post_reset(CPUState =
*cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_post_reset(cpu);
+    }
 }
=20
 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -53,6 +60,9 @@ static inline void cpu_synchronize_post_init(CPUState *=
cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_post_init(cpu);
+    }
 }
=20
 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
--=20
2.20.1
