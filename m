Received: from eggs.gnu.org ([2001:4830:134:3::10]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqf9C-0004wa-JF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqf99-00083j-E6
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqf99-00083d-5S
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:13:47 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Mar 2017 13:13:44 +0100
Message-Id: <20170322121344.5484-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] Revert "apic: save apic_delivered flag"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This reverts commit 07bfa354772f2de67008dc66c201b627acff0106.
The global variable is only read as part of a

            apic_reset_irq_delivered();
            qemu_irq_raise(s->irq);
            if (!apic_get_irq_delivered()) {

sequence, so the value never matters at migration time.

Reported-by: Dr. David Alan Gilbert <dglibert@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic_common.c           | 33 ---------------------------------
 include/hw/i386/apic_internal.h |  2 --
 2 files changed, 35 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 7a6e771..c3829e3 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -387,25 +387,6 @@ static bool apic_common_sipi_needed(void *opaque)
     return s->wait_for_sipi != 0;
 }
 
-static bool apic_irq_delivered_needed(void *opaque)
-{
-    APICCommonState *s = APIC_COMMON(opaque);
-    return s->cpu == X86_CPU(first_cpu) && apic_irq_delivered != 0;
-}
-
-static void apic_irq_delivered_pre_save(void *opaque)
-{
-    APICCommonState *s = APIC_COMMON(opaque);
-    s->apic_irq_delivered = apic_irq_delivered;
-}
-
-static int apic_irq_delivered_post_load(void *opaque, int version_id)
-{
-    APICCommonState *s = APIC_COMMON(opaque);
-    apic_irq_delivered = s->apic_irq_delivered;
-    return 0;
-}
-
 static const VMStateDescription vmstate_apic_common_sipi = {
     .name = "apic_sipi",
     .version_id = 1,
@@ -418,19 +399,6 @@ static const VMStateDescription vmstate_apic_common_sipi = {
     }
 };
 
-static const VMStateDescription vmstate_apic_irq_delivered = {
-    .name = "apic_irq_delivered",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = apic_irq_delivered_needed,
-    .pre_save = apic_irq_delivered_pre_save,
-    .post_load = apic_irq_delivered_post_load,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT32(apic_irq_delivered, APICCommonState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_apic_common = {
     .name = "apic",
     .version_id = 3,
@@ -465,7 +433,6 @@ static const VMStateDescription vmstate_apic_common = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_apic_common_sipi,
-        &vmstate_apic_irq_delivered,
         NULL
     }
 };
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 20ad28c..1209eb4 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -189,8 +189,6 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
-
-    int apic_irq_delivered; /* for saving static variable */
 };
 
 typedef struct VAPICState {
-- 
2.9.3
