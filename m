Received: from eggs.gnu.org ([2001:4830:134:3::10]:45417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hf-0001Ey-1d
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5he-0008AC-7n
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:03 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:53 -0500
Message-Id: <20180619014319.28272-28-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 027/113] openpic_kvm: drop
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
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The MemoryListener is registered on address_space_memory, there is
not much to assert.  This currently works because the callback
is invoked only once when the listener is registered, but section->fv
is the _new_ FlatView, not the old one on later calls and that
would break.

This confines address_space_to_flatview to exec.c and memory.c.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 80d2b933f9fe3e53d4f76a45a1bc1a0175669468)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
