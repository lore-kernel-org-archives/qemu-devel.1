Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E695C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C5920866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLYH-00010s-UH
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iiLVL-0005fy-E5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iiLVK-0005RN-A3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61004
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iiLVK-0005Qh-4O
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:51:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKGRtK8101801
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:51:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x0ksq7370-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:51:53 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 20 Dec 2019 16:51:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 20 Dec 2019 16:51:50 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBKGpnMq54132760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2019 16:51:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E8D64C052;
 Fri, 20 Dec 2019 16:51:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2DA14C04E;
 Fri, 20 Dec 2019 16:51:48 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.169.241])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 20 Dec 2019 16:51:48 +0000 (GMT)
Subject: [PATCH 2/2] ppc/pnv: Use the CPU topology to compute the default
 number of chips
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Fri, 20 Dec 2019 17:51:48 +0100
In-Reply-To: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
References: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19122016-0020-0000-0000-0000039A4E99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122016-0021-0000-0000-000021F17D9C
Message-Id: <157686070815.97184.16561911770080665569.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_04:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1034 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200127
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Multi TCG mandates the CPU topology to be dimensioned to the actual
number of CPUs, depending on the number of chips the user asked for.
That is, '-machine num-chips=N' should always have a '-smp' companion
with a topology that meats the resulting number of CPUs, typically
'-smp sockets=N'.

Simplify the command line for these setups by computing the default
number of chips based on the CPU topology, ie. no need to explicitely
set "num-chips" anymore. This must be done at machine init because
smp_parse() is called after instance init.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f8cf2b6d760f..9b777b7084a0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -768,6 +768,19 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
 
+    if (!pnv->num_chips) {
+        uint32_t num_chips =
+            machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
+        Error *local_err = NULL;
+
+        object_property_set_uint(OBJECT(pnv), num_chips, "num-chips",
+                                 &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
@@ -1722,6 +1735,9 @@ static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
      */
     if (!is_power_of_2(num_chips) || num_chips > 4) {
         error_setg(errp, "invalid number of chips: '%d'", num_chips);
+        error_append_hint(errp,
+                          "Set 'num-chips' implicitely with '-smp sockets=N'. "
+                          "Valid values are : 1, 2 or 4.\n");
         return;
     }
 
@@ -1735,12 +1751,6 @@ static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
     pnv->num_chips = num_chips;
 }
 
-static void pnv_machine_instance_init(Object *obj)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-    pnv->num_chips = 1;
-}
-
 static void pnv_machine_class_props_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "num-chips", "uint32",
@@ -1874,7 +1884,6 @@ static const TypeInfo types[] = {
         .parent        = TYPE_MACHINE,
         .abstract       = true,
         .instance_size = sizeof(PnvMachineState),
-        .instance_init = pnv_machine_instance_init,
         .class_init    = pnv_machine_class_init,
         .class_size    = sizeof(PnvMachineClass),
         .interfaces = (InterfaceInfo[]) {


