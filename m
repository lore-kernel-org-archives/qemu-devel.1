Received: from eggs.gnu.org ([2001:4830:134:3::10]:41815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUD-0000DV-AJ
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUB-0007Gb-DM
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:53 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djBUB-0007FT-6L
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:51 -0400
Received: by mail-pg0-x243.google.com with SMTP id 123so18973679pga.5
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 14:40:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Sat, 19 Aug 2017 16:40:38 -0500
Message-Id: <1503178840-21512-2-git-send-email-minyard@acm.org>
In-Reply-To: <1503178840-21512-1-git-send-email-minyard@acm.org>
References: <1503178840-21512-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 1/3] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The minimum message size was wrong for both commands, for getting
the time it's zero and for setting the time it's 4.  And the data
was being pulled from the wrong place in the set time message, it
should be the first four bytes.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 277c28c..1c732aa 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1571,7 +1571,7 @@ static void set_sel_time(IPMIBmcSim *ibs,
     uint32_t val;
     struct ipmi_time now;
 
-    val = cmd[2] | (cmd[3] << 8) | (cmd[4] << 16) | (cmd[5] << 24);
+    val = cmd[0] | (cmd[1] << 8) | (cmd[2] << 16) | (cmd[3] << 24);
     ipmi_gettime(&now);
     ibs->sel.time_offset = now.tv_sec - ((long) val);
 }
@@ -1802,8 +1802,8 @@ static const IPMICmdHandler storage_cmds[] = {
     [IPMI_CMD_GET_SEL_ENTRY] = { get_sel_entry, 8 },
     [IPMI_CMD_ADD_SEL_ENTRY] = { add_sel_entry, 18 },
     [IPMI_CMD_CLEAR_SEL] = { clear_sel, 8 },
-    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time, 6 },
-    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time },
+    [IPMI_CMD_GET_SEL_TIME] = { get_sel_time },
+    [IPMI_CMD_SET_SEL_TIME] = { set_sel_time, 4 },
 };
 
 static const IPMINetfn storage_netfn = {
-- 
2.7.4
