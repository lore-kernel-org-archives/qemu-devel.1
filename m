Received: from eggs.gnu.org ([2001:4830:134:3::10]:33179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dX-0002Ne-Sl
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dV-0007iF-W8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:27 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8dV-0007hj-Ps
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:25 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so59111734wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:12 +0100
Message-Id: <1485531620-121182-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] memory: make memory_listener_unregister
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

Make it easy to unregister a MemoryListener without tracking whether it
had been registered before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v3: new

 memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/memory.c b/memory.c
index 2bfc37f..8fafd4c 100644
--- a/memory.c
+++ b/memory.c
@@ -2371,8 +2371,13 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
 
 void memory_listener_unregister(MemoryListener *listener)
 {
+    if (!listener->address_space) {
+        return;
+    }
+
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
+    listener->address_space = NULL;
 }
 
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
-- 
1.8.3.1
