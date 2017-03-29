Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ct5I7-0001JW-48
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ct5I3-0003Hx-Vj
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:33:03 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ct5I3-0003Hh-R8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 00:32:59 -0400
Received: by mail-yw0-x241.google.com with SMTP id p77so467615ywg.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 21:32:59 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 29 Mar 2017 00:32:57 -0400
Message-Id: <20170329043257.20595-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg/i386: Display AMD HT warning only for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

TCG uses the AMD cpu which warns when we use hyperthreading. Disable
the warning for TCG since it is not necessary.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7aa762245a..66242893b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3647,7 +3647,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
      * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
-    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
+    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned && kvm_enabled()) {
         error_report("AMD CPU doesn't support hyperthreading. Please configure"
                      " -smp options properly.");
         ht_warned = true;
-- 
2.11.0
