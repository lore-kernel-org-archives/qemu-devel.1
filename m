Received: from eggs.gnu.org ([209.51.188.92]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dp-0004fg-1h
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dm-00053k-Ti
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:20 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 15 Apr 2019 15:27:19 +0200
Message-Id: <1555334842-195718-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/5] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

rs6000mc_realize() violates memory_region_allocate_system_memory() contract
by calling it multiple times which could break -mem-path. Replace it with
plain memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/rs6000_mc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 45cb95e..ea174f1 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -142,6 +142,7 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     RS6000MCState *s = RS6000MC_DEVICE(dev);
     int socket = 0;
     unsigned int ram_size = s->ram_size / MiB;
+    Error *local_err = NULL;
 
     while (socket < 6) {
         if (ram_size >= 64) {
@@ -163,19 +164,21 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
         if (s->simm_size[socket]) {
             char name[] = "simm.?";
             name[5] = socket + '0';
-            memory_region_allocate_system_memory(&s->simm[socket], OBJECT(dev),
-                                                 name,
-                                                 s->simm_size[socket] * MiB);
+            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
+                                   s->simm_size[socket] * MiB, &local_err);
+            if (local_err) {
+                goto out;
+            }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
         }
     }
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
-        error_setg(errp, "RAM size incompatible with this board. "
+        error_setg(&local_err, "RAM size incompatible with this board. "
                    "Try again with something else, like %" PRId64 " MB",
                    s->ram_size / MiB - ram_size);
-        return;
+        goto out;
     }
 
     if (s->autoconfigure) {
@@ -191,6 +194,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
 
     isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
                              rs6000mc_port_list, s, "rs6000mc");
+out:
+    error_propagate(errp, local_err);
 }
 
 static const VMStateDescription vmstate_rs6000mc = {
-- 
2.7.4
