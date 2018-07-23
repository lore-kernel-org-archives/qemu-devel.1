Received: from eggs.gnu.org ([2001:4830:134:3::10]:44453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fhYJy-0004ms-Bt
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fhYJv-0004EO-8j
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:44:06 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fhYJv-0004Ds-0F
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 06:44:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id h4-v6so523390edi.6
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 03:44:01 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 23 Jul 2018 12:43:42 +0200
Message-Id: <20180723104342.22992-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH] pci-pc: add NULL check for qpci_free_pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

The current layout of struct QPCIBusPC provides only one field,
QPCIBus bus, so passing a NULL pointer to qpci_free_pc()
makes container_of(NULL, QPCIBusPC, bus)
returning 0 (NULL), that is correctly handled by g_free().
This is bad practice, allowing the caller to think that it's okay
to always pass NULL to the function, even though this is just a
particular case.
In facts, qpci_free_pc() happens to return NULL only because container_of
computes the subtraction between the given NULL
pointer and offsetof(QPCIBus, bus), with the latter returning 0 too,
since bus is the first element of the struct and there is no
offset betwen itself and QPCIBusPC.

However, if in future the bus field changes its position, for example becoming
the second field, offsetof will return a number > 0, since there is some offset
between the beginning of the struct and the bus field.
Therefore passing a NULL pointer to the container_of macro will return a
negative number, that will be translated into an invalid address passed to
g_free() and causing a seg fault.

Adding a preventive safety check that returns from the function if the
given pointer is NULL solves the problem.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/pci-pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index a7803308b7..bb062bee5a 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -152,6 +152,10 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
 
 void qpci_free_pc(QPCIBus *bus)
 {
+    if (!bus) {
+        return;
+    }
+
     QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);
 
     g_free(s);
-- 
2.17.1
