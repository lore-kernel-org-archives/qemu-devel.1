Received: from eggs.gnu.org ([2001:4830:134:3::10]:56613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIH-0001cP-HK
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIG-0003VN-AL
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:01 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:10 +1000
Message-Id: <20170424015927.8933-31-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/47] ipmi: use a file to load SDRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The IPMI BMC simulator populates the sdr/sensor tables with a minimal
set of entries (Watchdog). But some qemu platforms might want to use
extra entries for their custom needs.

This patch modifies slighty the initializing routine to take into
account a larger set read from a file. The name of the file to use is
defined through a new 'sdr' property of the simulator device.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ipmi/ipmi_bmc_sim.c | 23 +++++++++++++++++++++--
 qemu-options.hx        | 11 ++++++++++-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index c7883d6..1142c0c 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "hw/ipmi/ipmi.h"
 #include "qemu/error-report.h"
+#include "hw/loader.h"
=20
 #define IPMI_NETFN_CHASSIS            0x00
=20
@@ -213,6 +214,7 @@ struct IPMIBmcSim {
     IPMISel sel;
     IPMISdr sdr;
     IPMISensor sensors[MAX_SENSORS];
+    char *sdr_filename;
=20
     /* Odd netfns are for responses, so we only need the even ones. */
     const IPMINetfn *netfns[MAX_NETFNS / 2];
@@ -1696,22 +1698,33 @@ static void ipmi_sdr_init(IPMIBmcSim *ibs)
=20
     sdrs_size =3D sizeof(init_sdrs);
     sdrs =3D init_sdrs;
+    if (ibs->sdr_filename &&
+        !g_file_get_contents(ibs->sdr_filename, (gchar **) &sdrs, &sdrs_=
size,
+                             NULL)) {
+        error_report("failed to load sdr file '%s'", ibs->sdr_filename);
+        sdrs_size =3D sizeof(init_sdrs);
+        sdrs =3D init_sdrs;
+    }
=20
     for (i =3D 0; i < sdrs_size; i +=3D len) {
         struct ipmi_sdr_header *sdrh;
=20
         if (i + IPMI_SDR_HEADER_SIZE > sdrs_size) {
             error_report("Problem with recid 0x%4.4x", i);
-            return;
+            break;
         }
         sdrh =3D (struct ipmi_sdr_header *) &sdrs[i];
         len =3D ipmi_sdr_length(sdrh);
         if (i + len > sdrs_size) {
             error_report("Problem with recid 0x%4.4x", i);
-            return;
+            break;
         }
         sdr_add_entry(ibs, sdrh, len, NULL);
     }
+
+    if (sdrs !=3D init_sdrs) {
+        g_free(sdrs);
+    }
 }
=20
 static const VMStateDescription vmstate_ipmi_sim =3D {
@@ -1780,6 +1793,11 @@ static void ipmi_sim_realize(DeviceState *dev, Err=
or **errp)
     vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
 }
=20
+static Property ipmi_sim_properties[] =3D {
+    DEFINE_PROP_STRING("sdrfile", IPMIBmcSim, sdr_filename),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ipmi_sim_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -1787,6 +1805,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, vo=
id *data)
=20
     dc->hotpluggable =3D false;
     dc->realize =3D ipmi_sim_realize;
+    dc->props =3D ipmi_sim_properties;
     bk->handle_command =3D ipmi_sim_handle_command;
 }
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index 9171bd5..366b088 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -425,7 +425,7 @@ possible drivers and properties, use @code{-device he=
lp} and
 @code{-device @var{driver},help}.
=20
 Some drivers are:
-@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}]
+@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdrfi=
le=3D@var{file}]
=20
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -437,6 +437,15 @@ This address is the BMC's address on the I2C network=
 of management
 controllers.  If you don't know what this means, it is safe to ignore
 it.
=20
+@table @option
+@item bmc=3D@var{id}
+The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item slave_addr=3D@var{val}
+Define slave address to use for the BMC.  The default is 0x20.
+@item sdrfile=3D@var{file}
+file containing raw Sensor Data Records (SDR) data.  The default is none=
.
+@end table
+
 @item -device ipmi-bmc-extern,id=3D@var{id},chardev=3D@var{id}[,slave_ad=
dr=3D@var{val}]
=20
 Add a connection to an external IPMI BMC simulator.  Instead of
--=20
2.9.3
