Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEr-0000oJ-Iq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEm-0007fT-K4
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fqiEl-0007eH-Uw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECAE94067720
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:08:34 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 17 Aug 2018 11:08:32 -0600
Message-ID: <153452571244.13804.6372546892067907661.stgit@gimli.home>
In-Reply-To: <153452552631.13804.12031418293966530953.stgit@gimli.home>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/4] kvm: Use inhibit to prevent ballooning
 without synchronous mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove KVM specific tests in balloon_page(), instead marking
ballooning as inhibited without KVM_CAP_SYNC_MMU support.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 accel/kvm/kvm-all.c        |    4 ++++
 hw/virtio/virtio-balloon.c |    4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index eb7db92a5e3b..38f468d8e2b1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -39,6 +39,7 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "sysemu/sev.h"
+#include "sysemu/balloon.h"
 
 #include "hw/boards.h"
 
@@ -1698,6 +1699,9 @@ static int kvm_init(MachineState *ms)
     s->many_ioeventfds = kvm_check_many_ioeventfds();
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
+    if (!s->sync_mmu) {
+        qemu_balloon_inhibit(true);
+    }
 
     return 0;
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1f7a87f09429..b5425080c5fb 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -21,7 +21,6 @@
 #include "hw/mem/pc-dimm.h"
 #include "sysemu/balloon.h"
 #include "hw/virtio/virtio-balloon.h"
-#include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
@@ -36,8 +35,7 @@
 
 static void balloon_page(void *addr, int deflate)
 {
-    if (!qemu_balloon_is_inhibited() && (!kvm_enabled() ||
-                                         kvm_has_sync_mmu())) {
+    if (!qemu_balloon_is_inhibited()) {
         qemu_madvise(addr, BALLOON_PAGE_SIZE,
                 deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
     }
