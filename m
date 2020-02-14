Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1BBC3B19D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B9524654
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B9524654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cUE-0007I1-R7
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2cTN-0005vf-5z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2cTI-0003mh-1V
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:01:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61668
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2cTH-0003lH-Ru
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:01:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EExvi9139676
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:01:34 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y5vhpjt41-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:01:33 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 14 Feb 2020 15:01:27 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:01:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01EF0ScS37093732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:00:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F182C42049;
 Fri, 14 Feb 2020 15:01:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B933042041;
 Fri, 14 Feb 2020 15:01:22 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.71.236])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:01:22 +0000 (GMT)
Subject: [PATCH v2 1/2] spapr: Don't use spapr_drc_needed() in CAS code
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Feb 2020 16:01:22 +0100
In-Reply-To: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
References: <158169247578.3465937.4013536808417411649.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0028-0000-0000-000003DA8904
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0029-0000-0000-0000249F03EF
Message-Id: <158169248180.3465937.9531405453362718771.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1034 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140119
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
same as for DRC migration, it looks wrong to piggyback a migration helper
for this.

Introduce a helper with slightly more explicit name and use it in both CAS
and DRC migration code. Since a subsequent patch will enhance this helper
to cover the case of hot unplug, let's go for spapr_drc_transient(). While
here convert spapr_hotplugged_dev_before_cas() to the "transient" wording as
well.

This doesn't change any behaviour.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - spapr_drc_transient() helper
---
 hw/ppc/spapr_drc.c         |   20 ++++++++++++++------
 hw/ppc/spapr_hcall.c       |   14 +++++++++-----
 include/hw/ppc/spapr_drc.h |    4 +++-
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fc62e049010f..4c35ce7c5c37 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -456,23 +456,31 @@ void spapr_drc_reset(SpaprDrc *drc)
     }
 }
 
-bool spapr_drc_needed(void *opaque)
+bool spapr_drc_transient(SpaprDrc *drc)
 {
-    SpaprDrc *drc = (SpaprDrc *)opaque;
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    /* If no dev is plugged in there is no need to migrate the DRC state */
+    /*
+     * If no dev is plugged in there is no need to migrate the DRC state
+     * nor to reset the DRC at CAS.
+     */
     if (!drc->dev) {
         return false;
     }
 
     /*
-     * We need to migrate the state if it's not equal to the expected
-     * long-term state, which is the same as the coldplugged initial
-     * state */
+     * We need to reset the DRC at CAS or to migrate the DRC state if it's
+     * not equal to the expected long-term state, which is the same as the
+     * coldplugged initial state.
+     */
     return (drc->state != drck->ready_state);
 }
 
+static bool spapr_drc_needed(void *opaque)
+{
+    return spapr_drc_transient(opaque);
+}
+
 static const VMStateDescription vmstate_spapr_drc = {
     .name = "spapr_drc",
     .version_id = 1,
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b5c0d4..6db3dbde9c92 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1640,20 +1640,24 @@ static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return best_compat;
 }
 
-static bool spapr_hotplugged_dev_before_cas(void)
+static bool spapr_transient_dev_before_cas(void)
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
+
+        if (spapr_drc_transient(drc)) {
             return true;
         }
     }
@@ -1830,7 +1834,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     spapr_irq_update_active_intc(spapr);
 
-    if (spapr_hotplugged_dev_before_cas()) {
+    if (spapr_transient_dev_before_cas()) {
         spapr->cas_reboot = true;
     }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index df3d958a66a2..21af8deac13f 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -278,7 +278,9 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask);
 
 void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
-bool spapr_drc_needed(void *opaque);
+
+/* Returns true if a hot plug/unplug request is pending */
+bool spapr_drc_transient(SpaprDrc *drc);
 
 static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
 {


