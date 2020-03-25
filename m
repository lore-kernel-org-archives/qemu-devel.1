Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D92C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F045F20409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F045F20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7wk-0005rQ-61
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH7ub-00022e-JM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH7ua-000739-B2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15016
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH7ua-00072t-5F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PF4Ahx141378
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuwvups-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:43 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Mar 2020 15:25:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 15:25:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFPbj062390456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:25:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4919511C052;
 Wed, 25 Mar 2020 15:25:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 105B911C04A;
 Wed, 25 Mar 2020 15:25:37 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.41.106])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 15:25:36 +0000 (GMT)
Subject: [PATCH 2/4] spapr: Simplify selection of radix/hash during CAS
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 25 Mar 2020 16:25:36 +0100
In-Reply-To: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032515-0028-0000-0000-000003EB4AB0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032515-0029-0000-0000-000024B0B906
Message-Id: <158514993621.478799.4204740354545734293.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250121
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The guest can select the MMU mode by setting bits 0-1 of byte 24
in OV5 to to 0b00 for hash or 0b01 for radix. As required by the
architecture, we terminate the boot process if any other value
is found there.

The usual way to negotiate features in OV5 is basically ANDing
the bitfield provided by the guest and the bitfield of features
supported by QEMU, previously populated at machine init.

For some not documented reason, MMU is treated differently : bit 1
of byte 24 (the radix/hash bit) is cleared from the guest OV5 and
explicitely set in the final negotiated OV5 if radix was requested.

Since the only expected input from the guest is the radix/hash bit
being set or not, it seems more appropriate to handle this like we
do for XIVE.

Set the radix bit in spapr->ov5 at machine init if it has a chance
to work (ie. power9, either TCG or a radix capable KVM) and rely
exclusively on spapr_ovec_intersect() to set the radix bit in
spapr->ov5_cas.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c       |    1 +
 hw/ppc/spapr_hcall.c |    6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa6e..91f8cfe7a8b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2837,6 +2837,7 @@ static void spapr_machine_init(MachineState *machine)
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_300);
         /* KVM and TCG always allow GTSE with radix... */
         spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
     }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1f123a68e46c..9bed659b1a94 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1738,9 +1738,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         exit(EXIT_FAILURE);
     }
 
-    /* The radix/hash bit in byte 24 requires special handling: */
     guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
-    spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
     guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
 
@@ -1785,14 +1783,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     /* full range of negotiated ov5 capabilities */
     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
     spapr_ovec_cleanup(ov5_guest);
-    /* Now that processing is finished, set the radix/hash bit for the
-     * guest if it requested a valid mode; otherwise terminate the boot. */
+
     if (guest_radix) {
         if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
             error_report("Guest requested unavailable MMU mode (radix).");
             exit(EXIT_FAILURE);
         }
-        spapr_ovec_set(spapr->ov5_cas, OV5_MMU_RADIX_300);
     } else {
         if (kvm_enabled() && kvmppc_has_cap_mmu_radix()
             && !kvmppc_has_cap_mmu_hash_v3()) {


