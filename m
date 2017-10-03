Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUt-00032h-Q9
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUt-0001ya-4U
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:44337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzKUs-0001y5-UL
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:19 -0400
Received: by mail-wm0-x244.google.com with SMTP id 196so5527520wma.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:32:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:37 +0200
Message-Id: <1507026521-19230-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] iothread: Make iothread_stop() idempotent
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
Message-Id: <20170926130028.12471-1-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 iothread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iothread.c b/iothread.c
index 44c8944..59d0850 100644
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
1.8.3.1
