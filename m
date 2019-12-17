Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4529E20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="duOEa1Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4529E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih50Y-0008IK-Jk
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iV-0000Dl-9X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iR-0005nb-T5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:15 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55305 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iR-0005UW-IQ; Mon, 16 Dec 2019 23:44:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWV17mhz9sSp; Tue, 17 Dec 2019 15:43:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557814;
 bh=0iPUaHnfHvwmQN/HVOaXeUDSVR/0Qc7oi4z2XkI4XvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=duOEa1WpjVZZTvCXheJ6aFjf0DKjmsOq8UXjkePPCvPa0LkWTt2kulgSQlxCYbfhd
 NctQ1SNieFNecqm29TIzZc4dYBEp/F7T+NBhKtIVzZeUxpIWjrnS7UqSUnAGaRyNBZ
 Gnxx9A6m6eAsxFc38OND8XhFVcGlPApYO5PfHjcE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 24/88] ipmi: Add support to customize OEM functions
Date: Tue, 17 Dec 2019 15:42:18 +1100
Message-Id: <20191217044322.351838-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Corey Minyard <cminyard@mvista.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The routine ipmi_register_oem_netfn() lets external modules register
command handlers for OEM functions. Required for the PowerNV machine.

Cc: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191028070027.22752-2-clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ipmi/ipmi_bmc_sim.c | 50 +++++-------------------------------------
 include/hw/ipmi/ipmi.h | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 71e56f3b13..6670cf039d 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -167,32 +167,14 @@ typedef struct IPMISensor {
 #define MAX_SENSORS 20
 #define IPMI_WATCHDOG_SENSOR 0
=20
-typedef struct IPMIBmcSim IPMIBmcSim;
-typedef struct RspBuffer RspBuffer;
-
 #define MAX_NETFNS 64
=20
-typedef struct IPMICmdHandler {
-    void (*cmd_handler)(IPMIBmcSim *s,
-                        uint8_t *cmd, unsigned int cmd_len,
-                        RspBuffer *rsp);
-    unsigned int cmd_len_min;
-} IPMICmdHandler;
-
-typedef struct IPMINetfn {
-    unsigned int cmd_nums;
-    const IPMICmdHandler *cmd_handlers;
-} IPMINetfn;
-
 typedef struct IPMIRcvBufEntry {
     QTAILQ_ENTRY(IPMIRcvBufEntry) entry;
     uint8_t len;
     uint8_t buf[MAX_IPMI_MSG_SIZE];
 } IPMIRcvBufEntry;
=20
-#define TYPE_IPMI_BMC_SIMULATOR "ipmi-bmc-sim"
-#define IPMI_BMC_SIMULATOR(obj) OBJECT_CHECK(IPMIBmcSim, (obj), \
-                                        TYPE_IPMI_BMC_SIMULATOR)
 struct IPMIBmcSim {
     IPMIBmc parent;
=20
@@ -279,28 +261,8 @@ struct IPMIBmcSim {
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
=20
-struct RspBuffer {
-    uint8_t buffer[MAX_IPMI_MSG_SIZE];
-    unsigned int len;
-};
-
 #define RSP_BUFFER_INITIALIZER { }
=20
-static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
-{
-    rsp->buffer[2] =3D byte;
-}
-
-/* Add a byte to the response. */
-static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
-{
-    if (rsp->len >=3D sizeof(rsp->buffer)) {
-        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
-        return;
-    }
-    rsp->buffer[rsp->len++] =3D byte;
-}
-
 static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
                                        unsigned int n)
 {
@@ -630,8 +592,8 @@ static void ipmi_init_sensors_from_sdrs(IPMIBmcSim *s=
)
     }
 }
=20
-static int ipmi_register_netfn(IPMIBmcSim *s, unsigned int netfn,
-                               const IPMINetfn *netfnd)
+int ipmi_sim_register_netfn(IPMIBmcSim *s, unsigned int netfn,
+                        const IPMINetfn *netfnd)
 {
     if ((netfn & 1) || (netfn >=3D MAX_NETFNS) || (s->netfns[netfn / 2])=
) {
         return -1;
@@ -1860,10 +1822,10 @@ static const IPMINetfn storage_netfn =3D {
=20
 static void register_cmds(IPMIBmcSim *s)
 {
-    ipmi_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);
-    ipmi_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_netfn)=
;
-    ipmi_register_netfn(s, IPMI_NETFN_APP, &app_netfn);
-    ipmi_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_ne=
tfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_APP, &app_netfn);
+    ipmi_sim_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);
 }
=20
 static uint8_t init_sdrs[] =3D {
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 6f2413b39b..8a99d958bb 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -55,6 +55,7 @@ enum ipmi_op {
 #define IPMI_CC_COMMAND_NOT_SUPPORTED                    0xd5
=20
 #define IPMI_NETFN_APP                0x06
+#define IPMI_NETFN_OEM                0x3a
=20
 #define IPMI_DEBUG 1
=20
@@ -265,4 +266,45 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
                       const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
 void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
=20
+#define TYPE_IPMI_BMC_SIMULATOR "ipmi-bmc-sim"
+#define IPMI_BMC_SIMULATOR(obj) OBJECT_CHECK(IPMIBmcSim, (obj), \
+                                        TYPE_IPMI_BMC_SIMULATOR)
+
+typedef struct IPMIBmcSim IPMIBmcSim;
+
+typedef struct RspBuffer {
+    uint8_t buffer[MAX_IPMI_MSG_SIZE];
+    unsigned int len;
+} RspBuffer;
+
+static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
+{
+    rsp->buffer[2] =3D byte;
+}
+
+/* Add a byte to the response. */
+static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
+{
+    if (rsp->len >=3D sizeof(rsp->buffer)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
+        return;
+    }
+    rsp->buffer[rsp->len++] =3D byte;
+}
+
+typedef struct IPMICmdHandler {
+    void (*cmd_handler)(IPMIBmcSim *s,
+                        uint8_t *cmd, unsigned int cmd_len,
+                        RspBuffer *rsp);
+    unsigned int cmd_len_min;
+} IPMICmdHandler;
+
+typedef struct IPMINetfn {
+    unsigned int cmd_nums;
+    const IPMICmdHandler *cmd_handlers;
+} IPMINetfn;
+
+int ipmi_sim_register_netfn(IPMIBmcSim *s, unsigned int netfn,
+                            const IPMINetfn *netfnd);
+
 #endif
--=20
2.23.0


