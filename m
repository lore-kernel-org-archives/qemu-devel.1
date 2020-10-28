Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8082475E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOKIHCzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8082475E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmGC-0007jZ-Ni
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmEh-0006kt-8y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:15:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmEf-0006Hd-90
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:15:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEEXSY001651
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=l812kBoC7zLblWSR96zqNQEIbS3y9E16/eX8r+rPHCI=;
 b=XOKIHCzKqG/ToOUKAJSUBWylZoskppHtqjUoKdIWi885YRq04iwJl5aNPDuuQQnOA0Qh
 f5me4xujI0D92IwP8e5eKm54GhzDBhJdOkpy5rJ0f3VcsHKUraDEupslsejvgFfgbsw5
 RzEKT0ettLO7wKJZ2OHsuqNXVZWEH8+TIF3qwTeIen6z+Q2j8XE/OMO4VXJLExAQ5IZb
 mwfuXIeGg0G7GTpiR7aJ/9JhGkhMF754OD4evgOxhF2d89CoBhZsFBD5NLPQ2TDtNnAQ
 oq/GsM22KSwxU7AuYDAjt4dETMCWlBzQ849uVJRF3pIg3817lHPVAOY/9KjXz224JTNH Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 34dgm458se-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEAMHT004433
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 34cx1s1dqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SEFSvi012067
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:28 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Oct 2020 07:15:28 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] pvpanic: break dependency on ISA_BUS adding PCI
Date: Wed, 28 Oct 2020 15:32:59 +0200
Message-Id: <1603891979-11961-7-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
References: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280097
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:15:30
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pvpanic is supported on ARM VIRT MACHINE as an PCI device, no need for an ISA
bus.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 hw/misc/Kconfig   | 2 +-
 hw/misc/pvpanic.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3185456..b650982 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -117,7 +117,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
-    depends on ISA_BUS
+    depends on ISA_BUS || PCI
 
 config AUX
     bool
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index b0bf7d4..f80cf6c 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -106,6 +106,7 @@ static const MemoryRegionOps pvpanic_ops = {
     },
 };
 
+#ifdef CONFIG_ISA_BUS
 static void pvpanic_isa_initfn(Object *obj)
 {
     PVPanicISAState *s = PVPANIC_ISA_DEVICE(obj);
@@ -153,6 +154,7 @@ static TypeInfo pvpanic_isa_info = {
     .instance_init = pvpanic_isa_initfn,
     .class_init    = pvpanic_isa_class_init,
 };
+#endif
 
 /* pvpanic pci device*/
 
@@ -193,7 +195,9 @@ static TypeInfo pvpanic_pci_info = {
 
 static void pvpanic_register_types(void)
 {
+#ifdef CONFIG_ISA_BUS
     type_register_static(&pvpanic_isa_info);
+#endif
     type_register_static(&pvpanic_pci_info);
 }
 
-- 
1.8.3.1


