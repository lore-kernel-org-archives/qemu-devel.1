Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E513C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3509221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EtkGSem9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3509221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVy7-0000My-Pm
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVwq-0007Xb-Vk; Thu, 22 Oct 2020 04:27:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kVVwo-00076J-9p; Thu, 22 Oct 2020 04:27:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8ODRg008760;
 Thu, 22 Oct 2020 08:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=P73tB6V8HboKqkNO+5D1J1iSewP3IjymN3EA3sKR3mI=;
 b=EtkGSem9MnPRURgxNGpYS5WPtaE0WTY6BswM22CL0NrSDQdiU5MCMiUHOmavqdX1yCBy
 G95zn2Hm3gNlW9/mYFf5yIw4HKEZrg95oT9tFUemYD42XmXAy2X/fsSqdsfHjpUzVcLJ
 midjW3QvRjpdjfxJGYJgpBL5Hw5VJWhNTGXkDistuNcNIo/JkH6dEfW4PW9iqh7dUfjc
 +g7b+u8GUvt5u0IjGY1l9wMHrzc6k8+d3QaTRkry0XvFC07+ltFDQiAL7qRl++LRK3QT
 TjbkNH2Tih7vwwpvNfCTKNRA2gy3EzwEWCxRWHtXjlvp9HUlzIKu08l0tgBetxQpcsbN zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 34ak16mw97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 08:27:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M8G8aV094847;
 Thu, 22 Oct 2020 08:25:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 348a6qbcux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:25:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M8Peb6015325;
 Thu, 22 Oct 2020 08:25:41 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 01:25:40 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 8/8] pvpanic: break dependency on ISA_BUS
Date: Thu, 22 Oct 2020 10:42:56 +0300
Message-Id: <1603352576-21671-9-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
References: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220056
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:09:38
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pvpanic is supported on ARM VIRT MACHINE as an MMIO device, no need for an ISA
bus.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 hw/arm/Kconfig    | 1 +
 hw/misc/Kconfig   | 2 +-
 hw/misc/pvpanic.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6b..0dd570b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,7 @@ config ARM_VIRT
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
     select ACPI_NVDIMM
+    select PVPANIC
 
 config CHEETAH
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3185456..5924e70 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -117,7 +117,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
-    depends on ISA_BUS
+    depends on ISA_BUS || ARM_VIRT
 
 config AUX
     bool
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 136f1d6..a70adb8 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -105,6 +105,7 @@ static const MemoryRegionOps pvpanic_ops = {
     },
 };
 
+#ifdef CONFIG_ISA_BUS
 static void pvpanic_isa_initfn(Object *obj)
 {
     PVPanicISAState *s = PVPANIC_ISA_DEVICE(obj);
@@ -152,6 +153,7 @@ static TypeInfo pvpanic_isa_info = {
     .instance_init = pvpanic_isa_initfn,
     .class_init    = pvpanic_isa_class_init,
 };
+#endif
 
 static void pvpanic_mmio_initfn(Object *obj)
 {
@@ -180,7 +182,9 @@ static TypeInfo pvpanic_mmio_info = {
 
 static void pvpanic_register_types(void)
 {
+#ifdef CONFIG_ISA_BUS
     type_register_static(&pvpanic_isa_info);
+#endif
     type_register_static(&pvpanic_mmio_info);
 }
 
-- 
1.8.3.1


