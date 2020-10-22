Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E3C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88792065D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="brlWcWcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88792065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVvf-0005ot-Pq
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVuf-0004L7-4R; Thu, 22 Oct 2020 04:25:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVub-00069t-JD; Thu, 22 Oct 2020 04:25:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8OvPr168283;
 Thu, 22 Oct 2020 08:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hCQdChAQCcyhN8Dlzatt/sr54/BTy2eCSaPSjnCiuAk=;
 b=brlWcWcPrOamM6i6Cn/T859qreXgf4XVvMYWowMyNEtzzkN1QDWNirW77EvguQiKYX/4
 XPsvMak4a3l+vfnf+8I5F4soshQ/eVVyu1FmmQ7c9XnmE4D1CYXvTXO2NRnO0rncCzQB
 KX78y3jle0ptePKyKOU3ndXxv5LvJ53uLAqbRT6LTGtVVCNPzocsLnD2Hx/XV/4VIDCR
 ydSgqEkfeNg9RWvYosBLXRzkoxRVtHsjlypUP/C9LCU/43YRoy0B1vcRiEXqvMxCrdR2
 R1kLPqKTi5UHPTkERSxuduAwRkGyg+sxfBRTP6jLlj5CJj9gGw4vZcxdnXKFh4rbYegB nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 349jrpvpry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 08:25:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8G8NX094828;
 Thu, 22 Oct 2020 08:25:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 348a6qbcp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:25:25 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M8PN0x000463;
 Thu, 22 Oct 2020 08:25:23 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 01:25:23 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 2/8] hw/misc/pvpanic: Cosmetic renaming
Date: Thu, 22 Oct 2020 10:42:50 +0300
Message-Id: <1603352576-21671-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
References: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=1 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=1 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220056
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=mihai.carabas@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:25:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>, Peng Hao <peng.hao2@zte.com.cn>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

To ease the MMIO device addition in the next patch, rename:
- ISA_PVPANIC_DEVICE -> PVPANIC_ISA_DEVICE.
- PVPanicState -> PVPanicISAState.
- TYPE_PVPANIC -> TYPE_PVPANIC_ISA.
- MemoryRegion io -> mr.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 hw/misc/pvpanic.c         | 28 ++++++++++++++++------------
 include/hw/misc/pvpanic.h |  2 +-
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 598d547..2e085f4 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -30,9 +30,9 @@
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
 #define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
 
-typedef struct PVPanicState PVPanicState;
-DECLARE_INSTANCE_CHECKER(PVPanicState, ISA_PVPANIC_DEVICE,
-                         TYPE_PVPANIC)
+typedef struct PVPanicISAState PVPanicISAState;
+DECLARE_INSTANCE_CHECKER(PVPanicISAState, PVPANIC_ISA_DEVICE,
+                         TYPE_PVPANIC_ISA)
 
 static void handle_event(int event)
 {
@@ -56,10 +56,14 @@ static void handle_event(int event)
 
 #include "hw/isa/isa.h"
 
-struct PVPanicState {
+/*
+ * PVPanicISAState for ISA device and
+ * use ioport.
+ */
+struct PVPanicISAState {
     ISADevice parent_obj;
 
-    MemoryRegion io;
+    MemoryRegion mr;
     uint16_t ioport;
 };
 
@@ -86,15 +90,15 @@ static const MemoryRegionOps pvpanic_ops = {
 
 static void pvpanic_isa_initfn(Object *obj)
 {
-    PVPanicState *s = ISA_PVPANIC_DEVICE(obj);
+    PVPanicISAState *s = PVPANIC_ISA_DEVICE(obj);
 
-    memory_region_init_io(&s->io, OBJECT(s), &pvpanic_ops, s, "pvpanic", 1);
+    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s, "pvpanic", 1);
 }
 
 static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *d = ISA_DEVICE(dev);
-    PVPanicState *s = ISA_PVPANIC_DEVICE(dev);
+    PVPanicISAState *s = PVPANIC_ISA_DEVICE(dev);
     FWCfgState *fw_cfg = fw_cfg_find();
     uint16_t *pvpanic_port;
 
@@ -107,11 +111,11 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
     fw_cfg_add_file(fw_cfg, "etc/pvpanic-port", pvpanic_port,
                     sizeof(*pvpanic_port));
 
-    isa_register_ioport(d, &s->io, s->ioport);
+    isa_register_ioport(d, &s->mr, s->ioport);
 }
 
 static Property pvpanic_isa_properties[] = {
-    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicState, ioport, 0x505),
+    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -125,9 +129,9 @@ static void pvpanic_isa_class_init(ObjectClass *klass, void *data)
 }
 
 static TypeInfo pvpanic_isa_info = {
-    .name          = TYPE_PVPANIC,
+    .name          = TYPE_PVPANIC_ISA,
     .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(PVPanicState),
+    .instance_size = sizeof(PVPanicISAState),
     .instance_init = pvpanic_isa_initfn,
     .class_init    = pvpanic_isa_class_init,
 };
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index ae0c818..30e9f8f 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -17,7 +17,7 @@
 
 #include "qom/object.h"
 
-#define TYPE_PVPANIC "pvpanic"
+#define TYPE_PVPANIC_ISA "pvpanic"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
1.8.3.1


