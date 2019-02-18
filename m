Received: from eggs.gnu.org ([209.51.188.92]:58270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf85-0001tO-2t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvf84-0002hL-DW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:22:25 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 10:21:57 +0100
Message-Id: <20190218092202.26683-2-david@redhat.com>
In-Reply-To: <20190218092202.26683-1-david@redhat.com>
References: <20190218092202.26683-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/6] cpus: Properly release the iothread
 lock when killing a dummy VCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

This enables CPU unplug under qtest.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cpus.c b/cpus.c
index 154daf57dc..e83f72b48b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1333,6 +1333,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug);
 
+    qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
 #endif
-- 
2.17.2
