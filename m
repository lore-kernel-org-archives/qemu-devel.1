Received: from eggs.gnu.org ([2001:4830:134:3::10]:42075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHJ-0000Ne-Sd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHF-0001NU-VV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:13 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:54925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkHF-0001My-M8
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:09 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4778A3018A
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:35 +0200
Message-Id: <1491396106-26376-11-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/21] ipmi: add SET_SENSOR_READING command
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

SET_SENSOR_READING is a complex IPMI command (IPMI spec : "35.17 Set
Sensor Reading And Event Status Command"). Here is a very minimum
framework fitting the Open PowerNV platform needs. This command is
used on this platform to set the "System Firmware Progress" sensor and
the "Boot Count" sensor.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 133 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 133 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 155561d06614..26036b20d4df 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -45,6 +45,7 @@
 #define IPMI_CMD_GET_SENSOR_READING       0x2d
 #define IPMI_CMD_SET_SENSOR_TYPE          0x2e
 #define IPMI_CMD_GET_SENSOR_TYPE          0x2f
+#define IPMI_CMD_SET_SENSOR_READING       0x30
=20
 /* #define IPMI_NETFN_APP             0x06 In ipmi.h */
=20
@@ -1739,6 +1740,137 @@ static void get_sensor_type(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, sens->evt_reading_type_code);
 }
=20
+static void set_sensor_reading(IPMIBmcSim *ibs,
+                               uint8_t *cmd, unsigned int cmd_len,
+                               RspBuffer *rsp)
+{
+    IPMISensor *sens;
+    uint8_t evd1;
+    uint8_t evd2;
+    uint8_t evd3;
+
+    if ((cmd[2] > MAX_SENSORS) ||
+            !IPMI_SENSOR_GET_PRESENT(ibs->sensors + cmd[2])) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQ_ENTRY_NOT_PRESENT);
+        return;
+    }
+
+    sens =3D ibs->sensors + cmd[2];
+
+    /* Sensor Reading operation */
+    switch ((cmd[3]) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value to sensor reading byte */
+        sens->reading =3D cmd[4];
+        break;
+    case 2:
+    case 3:
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    /* Deassertion bits operation */
+    switch ((cmd[3] >> 2) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value */
+        if (cmd_len > 7) {
+            sens->deassert_states =3D cmd[7];
+        }
+        if (cmd_len > 8) {
+            sens->deassert_states =3D cmd[8] << 8;
+        }
+
+    case 2: /* mask on */
+        if (cmd_len > 7) {
+            sens->deassert_states |=3D cmd[7];
+        }
+        if (cmd_len > 8) {
+            sens->deassert_states |=3D cmd[8] << 8;
+        }
+        break;
+    case 3: /* mask off */
+        if (cmd_len > 7) {
+            sens->deassert_states &=3D cmd[7];
+        }
+        if (cmd_len > 8) {
+            sens->deassert_states &=3D (cmd[8] << 8);
+        }
+        break;
+    }
+
+    /* Assertion bits operation */
+    switch ((cmd[3] >> 4) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value */
+        if (cmd_len > 5) {
+            sens->assert_states =3D cmd[5];
+        }
+        if (cmd_len > 6) {
+            sens->assert_states =3D cmd[6] << 8;
+        }
+
+    case 2: /* mask on */
+        if (cmd_len > 5) {
+            sens->assert_states |=3D cmd[5];
+        }
+        if (cmd_len > 6) {
+            sens->assert_states |=3D cmd[6] << 8;
+        }
+        break;
+    case 3: /* mask off */
+        if (cmd_len > 5) {
+            sens->assert_states &=3D cmd[5];
+        }
+        if (cmd_len > 6) {
+            sens->assert_states &=3D (cmd[6] << 8);
+        }
+        break;
+    }
+
+    evd1 =3D evd2 =3D evd3 =3D 0x0;
+    if (cmd_len > 9) {
+        evd1 =3D cmd[9];
+    }
+    if (cmd_len > 10) {
+        evd2 =3D cmd[10];
+    }
+    if (cmd_len > 11) {
+        evd3 =3D cmd[11];
+    }
+
+    /* Event Data Bytes operation */
+    switch ((cmd[3] >> 6) & 0x3) {
+    case 0: /* Do not use the event data in message */
+        evd1 =3D evd2 =3D evd3 =3D 0x0;
+        break;
+    case 1: /* Write given values to event data bytes excluding bits
+             * [3:0] Event Data 1. */
+        evd1 &=3D 0xf0;
+        break;
+    case 2: /* Write given values to event data bytes including bits
+             * [3:0] Event Data 1. */
+        break;
+    case 3:
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    if (IPMI_SENSOR_IS_DISCRETE(sens)) {
+        unsigned int bit =3D evd1 & 0xf;
+        uint16_t mask =3D (1 << bit);
+
+        if (sens->assert_states & mask & sens->assert_enable) {
+            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
+        }
+
+        if (sens->deassert_states & mask & sens->deassert_enable) {
+            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
+        }
+    }
+}
=20
 static const IPMICmdHandler chassis_cmds[] =3D {
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] =3D { chassis_capabilities },
@@ -1759,6 +1891,7 @@ static const IPMICmdHandler sensor_event_cmds[] =3D=
 {
     [IPMI_CMD_GET_SENSOR_READING] =3D { get_sensor_reading, 3 },
     [IPMI_CMD_SET_SENSOR_TYPE] =3D { set_sensor_type, 5 },
     [IPMI_CMD_GET_SENSOR_TYPE] =3D { get_sensor_type, 3 },
+    [IPMI_CMD_SET_SENSOR_READING] =3D { set_sensor_reading, 5 },
 };
 static const IPMINetfn sensor_event_netfn =3D {
     .cmd_nums =3D ARRAY_SIZE(sensor_event_cmds),
--=20
2.7.4
