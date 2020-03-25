Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3675C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63F7206F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F7206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7zp-0000g0-SN
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH7ua-00021K-Vc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH7uZ-00072p-PU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64582
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH7uZ-0006wI-L5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PF2mlA075115
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywf2jdfq8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:37 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Mar 2020 15:25:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 15:25:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFPVgg51314836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:25:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3543742041;
 Wed, 25 Mar 2020 15:25:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0E0B42042;
 Wed, 25 Mar 2020 15:25:30 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.41.106])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 15:25:30 +0000 (GMT)
Subject: [PATCH 1/4] spapr: Don't check capabilities removed between CAS calls
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 25 Mar 2020 16:25:30 +0100
In-Reply-To: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032515-0016-0000-0000-000002F7973D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032515-0017-0000-0000-0000335B3B39
Message-Id: <158514993021.478799.10928618293640651819.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1034 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250123
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

We currently check if some capability in OV5 was removed by the guest
since the previous CAS, and we trigger a CAS reboot in that case. This
was required because it could call for a device-tree property or node
removal, that we didn't support until recently (see commit 6787d27b04a7
"spapr: add option vector handling in CAS-generated resets" for details).

Now that we render a full FDT at CAS and that SLOF is able to handle
node removal, we don't need to do a CAS reset in this case anymore.
Also, this check can only return true if the guest has already called
CAS since the last full system reset (otherwise spapr->ov5_cas is
empty). Linux doesn't do that so this can be considered as dead code
for the vast majority of existing setups.

Drop the check. Since the only use of the ov5_cas_old variable is
precisely the check itself, drop the variable as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 40c86e91eb89..1f123a68e46c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1676,7 +1676,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     target_ulong fdt_bufsize = args[2];
     target_ulong ov_table;
     uint32_t cas_pvr;
-    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
+    SpaprOptionVector *ov1_guest, *ov5_guest;
     bool guest_radix;
     Error *local_err = NULL;
     bool raw_mode_supported = false;
@@ -1781,22 +1781,10 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
      * by LoPAPR 1.1, 14.5.4.8, which QEMU doesn't implement, we don't need
      * to worry about this for now.
      */
-    ov5_cas_old = spapr_ovec_clone(spapr->ov5_cas);
-
-    /* also clear the radix/hash bit from the current ov5_cas bits to
-     * be in sync with the newly ov5 bits. Else the radix bit will be
-     * seen as being removed and this will generate a reset loop
-     */
-    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
 
     /* full range of negotiated ov5 capabilities */
     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
     spapr_ovec_cleanup(ov5_guest);
-    /* capabilities that have been added since CAS-generated guest reset.
-     * if capabilities have since been removed, generate another reset
-     */
-    spapr->cas_reboot = !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);
-    spapr_ovec_cleanup(ov5_cas_old);
     /* Now that processing is finished, set the radix/hash bit for the
      * guest if it requested a valid mode; otherwise terminate the boot. */
     if (guest_radix) {


