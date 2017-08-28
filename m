Received: from eggs.gnu.org ([2001:4830:134:3::10]:55865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dmSGe-0005HD-BF
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dmSGb-0000Z7-3q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:24 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1dmSGa-0000Y7-Ts
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:21 -0400
Received: by mail-pg0-x241.google.com with SMTP id 83so1281005pgb.3
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 15:12:19 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Aug 2017 17:12:10 -0500
Message-Id: <1503958330-14083-4-git-send-email-minyard@acm.org>
In-Reply-To: <1503958330-14083-1-git-send-email-minyard@acm.org>
References: <1503958330-14083-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/3] ipmi: Add the platform event message
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This lets an event be added to the SEL as if a sensor had generated
it.  The OpenIPMI driver uses it for storing panic event information.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index a0bbfd5..e84d710 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -38,6 +38,7 @@
 
 #define IPMI_NETFN_SENSOR_EVENT       0x04
 
+#define IPMI_CMD_PLATFORM_EVENT_MSG       0x02
 #define IPMI_CMD_SET_SENSOR_EVT_ENABLE    0x28
 #define IPMI_CMD_GET_SENSOR_EVT_ENABLE    0x29
 #define IPMI_CMD_REARM_SENSOR_EVTS        0x2a
@@ -1581,6 +1582,28 @@ static void set_sel_time(IPMIBmcSim *ibs,
     ibs->sel.time_offset = now.tv_sec - ((long) val);
 }
 
+static void platform_event_msg(IPMIBmcSim *ibs,
+                               uint8_t *cmd, unsigned int cmd_len,
+                               RspBuffer *rsp)
+{
+    uint8_t event[16];
+
+    event[2] = 2; /* System event record */
+    event[7] = cmd[2]; /* Generator ID */
+    event[8] = 0;
+    event[9] = cmd[3]; /* EvMRev */
+    event[10] = cmd[4]; /* Sensor type */
+    event[11] = cmd[5]; /* Sensor number */
+    event[12] = cmd[6]; /* Event dir / Event type */
+    event[13] = cmd[7]; /* Event data 1 */
+    event[14] = cmd[8]; /* Event data 2 */
+    event[15] = cmd[9]; /* Event data 3 */
+
+    if (sel_add_event(ibs, event)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_OUT_OF_SPACE);
+    }
+}
+
 static void set_sensor_evt_enable(IPMIBmcSim *ibs,
                                   uint8_t *cmd, unsigned int cmd_len,
                                   RspBuffer *rsp)
@@ -1757,6 +1780,7 @@ static const IPMINetfn chassis_netfn = {
 };
 
 static const IPMICmdHandler sensor_event_cmds[] = {
+    [IPMI_CMD_PLATFORM_EVENT_MSG] = { platform_event_msg, 10 },
     [IPMI_CMD_SET_SENSOR_EVT_ENABLE] = { set_sensor_evt_enable, 4 },
     [IPMI_CMD_GET_SENSOR_EVT_ENABLE] = { get_sensor_evt_enable, 3 },
     [IPMI_CMD_REARM_SENSOR_EVTS] = { rearm_sensor_evts, 4 },
-- 
2.7.4
