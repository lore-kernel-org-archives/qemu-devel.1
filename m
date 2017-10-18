Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyL-0003mV-4O
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyJ-0002Nb-Rg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyJ-0002N0-LT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:31 -0400
Received: by mail-wm0-x242.google.com with SMTP id k4so11170990wmc.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:19 +0200
Message-Id: <1508343141-31835-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/29] Revert "qdev: Free QemuOpts when the QOM
 path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.

This patch originally addressed an issue where a DEVICE_DELETED
event could be emitted (in device_unparent()) before a Device's
QemuOpts were cleaned up (in device_finalize()), leading to a
"duplicate ID" error if management attempted to immediately add
a device with the same ID in response to the DEVICE_DELETED event.

An alternative will be implemented in a subsequent patch where we
defer the DEVICE_DELETED event until device_finalize(), which would
also prevent the race, so we revert the original fix in preparation.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20171016222315.407-3-mdroth@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0019a49..418cdac 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1069,6 +1069,7 @@ static void device_finalize(Object *obj)
     NamedGPIOList *ngl, *next;
 
     DeviceState *dev = DEVICE(obj);
+    qemu_opts_del(dev->opts);
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
@@ -1118,9 +1119,6 @@ static void device_unparent(Object *obj)
         g_free(dev->canonical_path);
         dev->canonical_path = NULL;
     }
-
-    qemu_opts_del(dev->opts);
-    dev->opts = NULL;
 }
 
 static void device_class_init(ObjectClass *class, void *data)
-- 
1.8.3.1
