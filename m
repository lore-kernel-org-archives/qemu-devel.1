Received: from eggs.gnu.org ([2001:4830:134:3::10]:36288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwpTe-0000lI-4m
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwpTZ-0004JC-Ap
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwpTZ-0004HW-3w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:00:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 10:00:28 -0300
Message-Id: <20170926130028.12471-1-ehabkost@redhat.com>
In-Reply-To: <20170926122427.GC4115@localhost.localdomain>
References: <20170926122427.GC4115@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] iothread: Make iothread_stop() idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Currently, iothread_stop_all() makes all iothread objects unsafe
to be destroyed, because qemu_thread_join() ends up being called
twice.

To fix this, make iothread_stop() idempotent by checking
thread->stopped.

Fixes the following crash:

  qemu-system-x86_64 -object iothread,id=iothread0 -monitor stdio -display none
  QEMU 2.10.50 monitor - type 'help' for more information
  (qemu) quit
  qemu: qemu_thread_join: No such process
  Aborted (core dumped)

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 iothread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iothread.c b/iothread.c
index 44c8944dc4..59d0850988 100644
--- a/iothread.c
+++ b/iothread.c
@@ -85,7 +85,7 @@ static int iothread_stop(Object *object, void *opaque)
     IOThread *iothread;
 
     iothread = (IOThread *)object_dynamic_cast(object, TYPE_IOTHREAD);
-    if (!iothread || !iothread->ctx) {
+    if (!iothread || !iothread->ctx || iothread->stopping) {
         return 0;
     }
     iothread->stopping = true;
-- 
2.13.5
