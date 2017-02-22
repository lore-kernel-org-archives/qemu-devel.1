Received: from eggs.gnu.org ([2001:4830:134:3::10]:38184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVE-0003CL-Pw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVC-0008EA-05
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:36 +1100
Message-Id: <20170222063348.32176-32-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/43] hw/pci-host/prep: Do not use hw_error()
 in realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

hw_error() is for CPU related errors only (it prints out a
register dump and calls abort()), so we should not use it
if we just failed to load the bios image. Apart from that,
realize() functions should not exit directly but always set
the errp with error_setg() in case of errors instead.
Additionally, move some code around and delete the bios memory
subregion again in case of such an error, so that we leave a
clean state when returning to the caller.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/prep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 5580293..260a119 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -309,7 +309,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
     memory_region_set_readonly(&s->bios, true);
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SI=
ZE),
                                 &s->bios);
-    vmstate_register_ram_global(&s->bios);
     if (s->bios_name) {
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
         if (filename) {
@@ -328,12 +327,15 @@ static void raven_realize(PCIDevice *d, Error **err=
p)
                 }
             }
         }
+        g_free(filename);
         if (bios_size < 0 || bios_size > BIOS_SIZE) {
-            /* FIXME should error_setg() */
-            hw_error("qemu: could not load bios image '%s'\n", s->bios_n=
ame);
+            memory_region_del_subregion(get_system_memory(), &s->bios);
+            error_setg(errp, "Could not load bios image '%s'", s->bios_n=
ame);
+            return;
         }
-        g_free(filename);
     }
+
+    vmstate_register_ram_global(&s->bios);
 }
=20
 static const VMStateDescription vmstate_raven =3D {
@@ -361,7 +363,6 @@ static void raven_class_init(ObjectClass *klass, void=
 *data)
     /*
      * Reason: PCI-facing part of the host bridge, not usable without
      * the host-facing part, which can't be device_add'ed, yet.
-     * Reason: realize() method uses hw_error().
      */
     dc->cannot_instantiate_with_device_add_yet =3D true;
 }
--=20
2.9.3
