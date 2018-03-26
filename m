Received: from eggs.gnu.org ([2001:4830:134:3::10]:57112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIx-0006Uv-8N
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIw-0006vY-3o
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIv-0006v9-Sw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:54 -0400
Received: by mail-wr0-x244.google.com with SMTP id d1so6939529wrj.13
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:32 +0200
Message-Id: <1522071403-52486-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/16] hw/net/can: Fix segfaults when using the
 devices without bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The CAN devices can currently be used to crash QEMU, e.g.:

$ x86_64-softmmu/qemu-system-x86_64 -device kvaser_pci
Segmentation fault (core dumped)

So we've got to add a proper check here that the corresponding
bus is available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1521193892-15552-2-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/can/can_sja1000.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6293233..9a85038 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -866,6 +866,10 @@ int can_sja_connect_to_bus(CanSJA1000State *s, CanBusState *bus)
 {
     s->bus_client.info = &can_sja_bus_client_info;
 
+    if (!bus) {
+        return -EINVAL;
+    }
+
     if (can_bus_insert_client(bus, &s->bus_client) < 0) {
         return -1;
     }
-- 
1.8.3.1
