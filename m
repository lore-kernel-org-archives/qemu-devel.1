Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGy-0008Mi-31
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkGu-0001BE-2m
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:52 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:40649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkGt-0001A5-PI
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:48 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B0E7746D8D
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:42:46 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:32 +0200
Message-Id: <1491396106-26376-8-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/21] ipmi: provide support for FRUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

This patch provides a simple FRU support for the BMC simulator. FRUs
are loaded from a file which name is specified in the object
properties, each entry having a fixed size, also specified in the
properties. If the file is unknown or not accessible for some reason,
a unique entry of 1024 bytes is created as a default. Just enough to
start some simulation.

These commands complies with the IPMI spec : "34. FRU Inventory Device
Commands".

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
---

 Changes since v3:

 - removed min/max definitions and used MIN() from "qemu/osdep.h"
=20
 Changes since v2:

 - changed 'struct rsp_buffer' to 'RspBuffer'
=20
 Changes since v1:

 - change property name to 'fruareasize' and 'frudatafile'
 - add documentation of new properties
=20
 hw/ipmi/ipmi_bmc_sim.c | 128 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 qemu-options.hx        |   8 +++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 1142c0caae66..eae7b2d8c92b 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -80,6 +80,9 @@
 #define IPMI_CMD_ENTER_SDR_REP_UPD_MODE   0x2A
 #define IPMI_CMD_EXIT_SDR_REP_UPD_MODE    0x2B
 #define IPMI_CMD_RUN_INIT_AGENT           0x2C
+#define IPMI_CMD_GET_FRU_AREA_INFO        0x10
+#define IPMI_CMD_READ_FRU_DATA            0x11
+#define IPMI_CMD_WRITE_FRU_DATA           0x12
 #define IPMI_CMD_GET_SEL_INFO             0x40
 #define IPMI_CMD_GET_SEL_ALLOC_INFO       0x41
 #define IPMI_CMD_RESERVE_SEL              0x42
@@ -122,6 +125,13 @@ typedef struct IPMISdr {
     uint8_t overflow;
 } IPMISdr;
=20
+typedef struct IPMIFru {
+    char *filename;
+    unsigned int nentries;
+    uint16_t areasize;
+    uint8_t *data;
+} IPMIFru;
+
 typedef struct IPMISensor {
     uint8_t status;
     uint8_t reading;
@@ -213,6 +223,7 @@ struct IPMIBmcSim {
=20
     IPMISel sel;
     IPMISdr sdr;
+    IPMIFru fru;
     IPMISensor sensors[MAX_SENSORS];
     char *sdr_filename;
=20
@@ -1317,6 +1328,91 @@ static void get_sel_info(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, (ibs->sel.overflow << 7) | 0x02);
 }
=20
+static void get_fru_area_info(IPMIBmcSim *ibs,
+                         uint8_t *cmd, unsigned int cmd_len,
+                         RspBuffer *rsp)
+{
+    uint8_t fruid;
+    uint16_t fru_entry_size;
+
+    fruid =3D cmd[2];
+
+    if (fruid >=3D ibs->fru.nentries) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    fru_entry_size =3D ibs->fru.areasize;
+
+    rsp_buffer_push(rsp, fru_entry_size & 0xff);
+    rsp_buffer_push(rsp, fru_entry_size >> 8 & 0xff);
+    rsp_buffer_push(rsp, 0x0);
+}
+
+static void read_fru_data(IPMIBmcSim *ibs,
+                         uint8_t *cmd, unsigned int cmd_len,
+                         RspBuffer *rsp)
+{
+    uint8_t fruid;
+    uint16_t offset;
+    int i;
+    uint8_t *fru_entry;
+    unsigned int count;
+
+    fruid =3D cmd[2];
+    offset =3D (cmd[3] | cmd[4] << 8);
+
+    if (fruid >=3D ibs->fru.nentries) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    if (offset >=3D ibs->fru.areasize - 1) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    fru_entry =3D &ibs->fru.data[fruid * ibs->fru.areasize];
+
+    count =3D MIN(cmd[5], ibs->fru.areasize - offset);
+
+    rsp_buffer_push(rsp, count & 0xff);
+    for (i =3D 0; i < count; i++) {
+        rsp_buffer_push(rsp, fru_entry[offset + i]);
+    }
+}
+
+static void write_fru_data(IPMIBmcSim *ibs,
+                         uint8_t *cmd, unsigned int cmd_len,
+                         RspBuffer *rsp)
+{
+    uint8_t fruid;
+    uint16_t offset;
+    uint8_t *fru_entry;
+    unsigned int count;
+
+    fruid =3D cmd[2];
+    offset =3D (cmd[3] | cmd[4] << 8);
+
+    if (fruid >=3D ibs->fru.nentries) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    if (offset >=3D ibs->fru.areasize - 1) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    fru_entry =3D &ibs->fru.data[fruid * ibs->fru.areasize];
+
+    count =3D MIN(cmd_len - 5, ibs->fru.areasize - offset);
+
+    memcpy(fru_entry + offset, cmd + 5, count);
+
+    rsp_buffer_push(rsp, count & 0xff);
+}
+
 static void reserve_sel(IPMIBmcSim *ibs,
                         uint8_t *cmd, unsigned int cmd_len,
                         RspBuffer *rsp)
@@ -1653,6 +1749,9 @@ static const IPMINetfn app_netfn =3D {
 };
=20
 static const IPMICmdHandler storage_cmds[] =3D {
+    [IPMI_CMD_GET_FRU_AREA_INFO] =3D { get_fru_area_info, 3 },
+    [IPMI_CMD_READ_FRU_DATA] =3D { read_fru_data, 5 },
+    [IPMI_CMD_WRITE_FRU_DATA] =3D { write_fru_data, 5 },
     [IPMI_CMD_GET_SDR_REP_INFO] =3D { get_sdr_rep_info },
     [IPMI_CMD_RESERVE_SDR_REP] =3D { reserve_sdr_rep },
     [IPMI_CMD_GET_SDR] =3D { get_sdr, 8 },
@@ -1755,6 +1854,31 @@ static const VMStateDescription vmstate_ipmi_sim =3D=
 {
     }
 };
=20
+static void ipmi_fru_init(IPMIFru *fru)
+{
+    int fsize;
+    int size =3D 0;
+
+    fsize =3D get_image_size(fru->filename);
+    if (fsize > 0) {
+        size =3D QEMU_ALIGN_UP(fsize, fru->areasize);
+        fru->data =3D g_malloc0(size);
+        if (load_image_size(fru->filename, fru->data, fsize) !=3D fsize)=
 {
+            error_report("Could not load file '%s'", fru->filename);
+            g_free(fru->data);
+            fru->data =3D NULL;
+        }
+    }
+
+    if (!fru->data) {
+        /* give one default FRU */
+        size =3D fru->areasize;
+        fru->data =3D g_malloc0(size);
+    }
+
+    fru->nentries =3D size / fru->areasize;
+}
+
 static void ipmi_sim_realize(DeviceState *dev, Error **errp)
 {
     IPMIBmc *b =3D IPMI_BMC(dev);
@@ -1776,6 +1900,8 @@ static void ipmi_sim_realize(DeviceState *dev, Erro=
r **errp)
=20
     ipmi_sdr_init(ibs);
=20
+    ipmi_fru_init(&ibs->fru);
+
     ibs->acpi_power_state[0] =3D 0;
     ibs->acpi_power_state[1] =3D 0;
=20
@@ -1794,6 +1920,8 @@ static void ipmi_sim_realize(DeviceState *dev, Erro=
r **errp)
 }
=20
 static Property ipmi_sim_properties[] =3D {
+    DEFINE_PROP_UINT16("fruareasize", IPMIBmcSim, fru.areasize, 1024),
+    DEFINE_PROP_STRING("frudatafile", IPMIBmcSim, fru.filename),
     DEFINE_PROP_STRING("sdrfile", IPMIBmcSim, sdr_filename),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index 10b755ee4a5e..86b0904d6b79 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -425,7 +425,7 @@ possible drivers and properties, use @code{-device he=
lp} and
 @code{-device @var{driver},help}.
=20
 Some drivers are:
-@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdrfi=
le=3D@var{file}]
+@item -device ipmi-bmc-sim,id=3D@var{id}[,slave_addr=3D@var{val}][,sdrfi=
le=3D@var{file}][,furareasize=3D@var{val}][,furdatafile=3D@var{file}]
=20
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -443,7 +443,11 @@ The BMC to connect to, one of ipmi-bmc-sim or ipmi-b=
mc-extern above.
 @item slave_addr=3D@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=3D@var{file}
-file containing raw Sensor Data Records (SDR) data.  The default is none=
.
+file containing raw Sensor Data Records (SDR) data. The default is none.
+@item fruareasize=3D@var{val}
+size of a Field Replaceable Unit (FRU) area.  The default is 1024.
+@item frudatafile=3D@var{file}
+file containing raw Field Replaceable Unit (FRU) inventory data. The def=
ault is none.
 @end table
=20
 @item -device ipmi-bmc-extern,id=3D@var{id},chardev=3D@var{id}[,slave_ad=
dr=3D@var{val}]
--=20
2.7.4
