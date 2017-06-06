Received: from eggs.gnu.org ([2001:4830:134:3::10]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5X-00060H-6E
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5S-0007ON-Gp
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:19 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com
	([40.107.3.103]:45293
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5S-0007Ny-5x
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:14 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:41 +0300
Message-Id: <20170606181948.16238-17-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/23] hyperv: map overlay pages after updating
 msrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

There is a design flaw in the Hyper-V SynIC implementation in KVM: when
message page or event flags page is enabled by setting the corresponding
msr, KVM zeroes it out.  This violates the spec in general (per spec,
the pages have to be overlay ones and only zeroed at cpu reset), but
it's non-fatal in normal operation because the user exit happens after
the page is zeroed, so it's the underlying guest page which is zeroed
out, and sane guests don't depend on its contents to be preserved while
it's overlaid.

However, in the case of vmstate load the overlay pages are set up before
msrs are set so the contents of those pages get lost.

To work it around, avoid setting up overlay pages in .post_load.
Instead, postpone it until after the msrs are pushed to KVM.  As a
result, KVM just zeroes out the underlying guest pages similar to how it
happens during guest-initiated msr writes, which is tolerable.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/kvm.c     | 8 ++++++++
 target/i386/machine.c | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 433c912..b0b7595 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2761,6 +2761,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
             return ret;
         }
     }
+    /*
+     * to work around buggy KVM which zeroes out the message and event pages in
+     * KVM_SET_MSRS handler, only map the overlay pages after kvm_put_msrs,
+     * making vmstate load work similar to guest-initiated set_msr
+     */
+    if (level >= KVM_PUT_RESET_STATE) {
+        hyperv_synic_update(x86_cpu);
+    }
 
     ret = kvm_put_tscdeadline_msr(x86_cpu);
     if (ret < 0) {
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8022c24..eb00b19 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,7 +7,6 @@
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
-#include "hyperv.h"
 
 #include "sysemu/kvm.h"
 
@@ -634,19 +633,11 @@ static bool hyperv_synic_enable_needed(void *opaque)
     return false;
 }
 
-static int hyperv_synic_post_load(void *opaque, int version_id)
-{
-    X86CPU *cpu = opaque;
-    hyperv_synic_update(cpu);
-    return 0;
-}
-
 static const VMStateDescription vmstate_msr_hyperv_synic = {
     .name = "cpu/msr_hyperv_synic",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_synic_enable_needed,
-    .post_load = hyperv_synic_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
-- 
2.9.4
