Received: from eggs.gnu.org ([2001:4830:134:3::10]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm39T-0005p7-3Z
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm39O-0005g3-AM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm39O-0005fv-4v
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:50:58 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1658815561
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 18:50:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Mar 2017 15:50:46 -0300
Message-Id: <20170309185046.17555-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] kvmclock: Don't crash QEMU if KVM is
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Most machines don't allow sysbus devices like "kvmclock" to be
created from the command-line, but some of them do (the ones with
has_dynamic_sysbus=true). In those cases, it's possible to
manually create a kvmclock device without KVM being enabled,
making QEMU crash:

  $ qemu-system-x86_64 -machine q35,accel=tcg -device kvmclock
  Segmentation fault (core dumped)

This changes kvmclock's realize method to return an error if KVM
is disabled, to ensure it won't crash QEMU.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index ef9d560f9c..13eca374cd 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -22,6 +22,7 @@
 #include "kvm_i386.h"
 #include "hw/sysbus.h"
 #include "hw/kvm/clock.h"
+#include "qapi/error.h"
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -208,6 +209,11 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "kvmclock device requires KVM");
+        return;
+    }
+
     kvm_update_clock(s);
 
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
-- 
2.11.0.259.g40922b1
