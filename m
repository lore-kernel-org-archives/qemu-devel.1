Received: from eggs.gnu.org ([2001:4830:134:3::10]:35077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcC-0004LK-Dw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcA-0004N6-Ey
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:49 +0100
Message-Id: <20180305083655.6186-2-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] openpic_kvm: drop
 address_space_to_flatview call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org

The MemoryListener is registered on address_space_memory, there is
not much to assert.  This currently works because the callback
is invoked only once when the listener is registered, but section->fv
is the _new_ FlatView, not the old one on later calls and that
would break.

This confines address_space_to_flatview to exec.c and memory.c.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/openpic_kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fa83420254..39a6f369c5 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -124,10 +124,6 @@ static void kvm_openpic_region_add(MemoryListener *listener,
     uint64_t reg_base;
     int ret;
 
-    if (section->fv != address_space_to_flatview(&address_space_memory)) {
-        abort();
-    }
-
     /* Ignore events on regions that are not us */
     if (section->mr != &opp->mem) {
         return;
-- 
2.14.3
