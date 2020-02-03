Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C7C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC92420720
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC92420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykNf-0004hn-0t
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 17:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iykMf-0003t6-4b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iykMc-0007hI-Qh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:38:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26572
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iykMc-0007br-Ju
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:38:42 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013MccUS003249
 for <qemu-devel@nongnu.org>; Mon, 3 Feb 2020 17:38:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xxfrvanvd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 17:38:40 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 3 Feb 2020 22:36:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Feb 2020 22:36:12 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 013MaB6D37421288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2020 22:36:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8A44205C;
 Mon,  3 Feb 2020 22:36:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01EA442068;
 Mon,  3 Feb 2020 22:36:11 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.55.193])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  3 Feb 2020 22:36:10 +0000 (GMT)
Subject: [PATCH 1/3] spapr: Don't use spapr_drc_needed() in CAS code
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 03 Feb 2020 23:36:10 +0100
In-Reply-To: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
References: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20020322-0008-0000-0000-0000034F696A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020322-0009-0000-0000-00004A6FF450
Message-Id: <158076937025.2118610.529669524688469462.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_08:2020-02-02,
 2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1034 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030163
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently don't support hotplug of devices between boot and CAS. If
this happens a CAS reboot is triggered. We detect this during CAS using
the spapr_drc_needed() function which is essentially a VMStateDescription
.needed callback. Even if the condition for CAS reboot happens to be the
same as for DRC migration, it looks wrong to use a migration related helper
for this.

Introduce a helper with more explicit semantics (ie. the device attached
to this DRC is ready or not) and use it in both CAS and DRC migration code.

This doesn't change any behaviour.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c         |    5 ++---
 hw/ppc/spapr_hcall.c       |   12 +++++++++---
 include/hw/ppc/spapr_drc.h |    8 +++++++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 17aeac38016d..d512ac6e1e7f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -455,10 +455,9 @@ void spapr_drc_reset(SpaprDrc *drc)
     }
 }
 
-bool spapr_drc_needed(void *opaque)
+static bool spapr_drc_needed(void *opaque)
 {
     SpaprDrc *drc = (SpaprDrc *)opaque;
-    SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     /* If no dev is plugged in there is no need to migrate the DRC state */
     if (!drc->dev) {
@@ -469,7 +468,7 @@ bool spapr_drc_needed(void *opaque)
      * We need to migrate the state if it's not equal to the expected
      * long-term state, which is the same as the coldplugged initial
      * state */
-    return (drc->state != drck->ready_state);
+    return !spapr_drc_device_ready(drc);
 }
 
 static const VMStateDescription vmstate_spapr_drc = {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b5c0d4..7a33d79bbae9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1642,18 +1642,24 @@ static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
 static bool spapr_hotplugged_dev_before_cas(void)
 {
-    Object *drc_container, *obj;
+    Object *drc_container;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
 
     drc_container = container_get(object_get_root(), "/dr-connector");
     object_property_iter_init(&iter, drc_container);
     while ((prop = object_property_iter_next(&iter))) {
+        SpaprDrc *drc;
+
         if (!strstart(prop->type, "link<", NULL)) {
             continue;
         }
-        obj = object_property_get_link(drc_container, prop->name, NULL);
-        if (spapr_drc_needed(obj)) {
+        drc = SPAPR_DR_CONNECTOR(object_property_get_link(drc_container,
+                                                          prop->name, NULL));
+        if (!drc->dev) {
+            continue;
+        }
+        if (!spapr_drc_device_ready(drc)) {
             return true;
         }
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 83f03cc5773c..8e8bbedb21b7 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -269,7 +269,13 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask);
 
 void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
-bool spapr_drc_needed(void *opaque);
+
+static inline bool spapr_drc_device_ready(SpaprDrc *drc)
+{
+    SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
+    return drc->state == drck->ready_state;
+}
 
 static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
 {


