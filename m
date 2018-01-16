Received: from eggs.gnu.org ([2001:4830:134:3::10]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0007s7-9R
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZs-0000lh-W3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZs-0000lY-Qx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:12 -0500
Received: by mail-ot0-x242.google.com with SMTP id 53so12200695otj.2
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:59 -0600
Message-Id: <1516064279-14816-8-git-send-email-minyard@acm.org>
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/7] ipmi: Allow BMC device properties to be set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index e84d710..9b509f8 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -214,8 +214,8 @@ struct IPMIBmcSim {
     uint8_t device_rev;
     uint8_t fwrev1;
     uint8_t fwrev2;
-    uint8_t mfg_id[3];
-    uint8_t product_id[2];
+    uint32_t mfg_id;
+    uint16_t product_id;
 
     uint8_t restart_cause;
 
@@ -867,11 +867,11 @@ static void get_device_id(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, ibs->fwrev2);
     rsp_buffer_push(rsp, ibs->ipmi_version);
     rsp_buffer_push(rsp, 0x07); /* sensor, SDR, and SEL. */
-    rsp_buffer_push(rsp, ibs->mfg_id[0]);
-    rsp_buffer_push(rsp, ibs->mfg_id[1]);
-    rsp_buffer_push(rsp, ibs->mfg_id[2]);
-    rsp_buffer_push(rsp, ibs->product_id[0]);
-    rsp_buffer_push(rsp, ibs->product_id[1]);
+    rsp_buffer_push(rsp, ibs->mfg_id & 0xff);
+    rsp_buffer_push(rsp, (ibs->mfg_id >> 8) & 0xff);
+    rsp_buffer_push(rsp, (ibs->mfg_id >> 16) & 0xff);
+    rsp_buffer_push(rsp, ibs->product_id & 0xff);
+    rsp_buffer_push(rsp, (ibs->product_id >> 8) & 0xff);
 }
 
 static void set_global_enables(IPMIBmcSim *ibs, uint8_t val)
@@ -1997,6 +1997,13 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT16("fruareasize", IPMIBmcSim, fru.areasize, 1024),
     DEFINE_PROP_STRING("frudatafile", IPMIBmcSim, fru.filename),
     DEFINE_PROP_STRING("sdrfile", IPMIBmcSim, sdr_filename),
+    DEFINE_PROP_UINT8("device_id", IPMIBmcSim, device_id, 0x20),
+    DEFINE_PROP_UINT8("ipmi_version", IPMIBmcSim, ipmi_version, 0x02),
+    DEFINE_PROP_UINT8("device_rev", IPMIBmcSim, device_rev, 0),
+    DEFINE_PROP_UINT8("fwrev1", IPMIBmcSim, fwrev1, 0),
+    DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
+    DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
+    DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
