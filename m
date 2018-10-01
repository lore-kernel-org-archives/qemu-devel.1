Received: from eggs.gnu.org ([2001:4830:134:3::10]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747b-0005G3-UV
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Y-00056r-Le
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com
	([104.47.37.49]:27474
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Y-000562-CI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:44 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:27 +0000
Message-ID: <1538423049-29524-2-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 1/9] x86_iommu: move the kernel-irqchip
 check in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

Interrupt remapping needs kernel-irqchip=3D{off|split} on both Intel and AM=
D
platforms. Move the check in common place.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/intel_iommu.c | 7 -------
 hw/i386/x86-iommu.c   | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada1..84dbc20 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3248,13 +3248,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
 {
     X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
=20
-    /* Currently Intel IOMMU IR only support "kernel-irqchip=3D{off|split}=
" */
-    if (x86_iommu->intr_supported && kvm_irqchip_in_kernel() &&
-        !kvm_irqchip_is_split()) {
-        error_setg(errp, "Intel Interrupt Remapping cannot work with "
-                         "kernel-irqchip=3Don, please use 'split|off'.");
-        return false;
-    }
     if (s->intr_eim =3D=3D ON_OFF_AUTO_ON && !x86_iommu->intr_supported) {
         error_setg(errp, "eim=3Don cannot be selected without intremap=3Do=
n");
         return false;
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 8a01a2d..7440cb8 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "sysemu/kvm.h"
=20
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -94,6 +95,14 @@ static void x86_iommu_realize(DeviceState *dev, Error **=
errp)
         return;
     }
=20
+    /* Both Intel and AMD IOMMU IR only support "kernel-irqchip=3D{off|spl=
it}" */
+    if (x86_iommu->intr_supported && kvm_irqchip_in_kernel() &&
+        !kvm_irqchip_is_split()) {
+        error_setg(errp, "Interrupt Remapping cannot work with "
+                         "kernel-irqchip=3Don, please use 'split|off'.");
+        return;
+    }
+
     if (x86_class->realize) {
         x86_class->realize(dev, errp);
     }
--=20
2.7.4
