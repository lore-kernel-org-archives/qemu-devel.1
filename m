Received: from eggs.gnu.org ([2001:4830:134:3::10]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9c-0003RF-QS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9b-0006as-UA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9b-0006Zp-Nx
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:31 -0400
Received: by mail-wm0-x242.google.com with SMTP id v190so583018wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:08 +0100
Message-Id: <1489508300-48184-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/18] kvmclock: Don't crash QEMU if KVM is
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
Cc: Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

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
Message-Id: <20170309185046.17555-1-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index ef9d560..13eca37 100644
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
1.8.3.1
