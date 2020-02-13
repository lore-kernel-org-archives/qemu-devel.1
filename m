Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B1C3B18C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4674524677
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4674524677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GaX-0002vI-HE
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2GZj-00020E-Nq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2GZh-0005yy-Mn
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:38:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2GZh-0005wY-Gy
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:38:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01DFTV5A005411
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:38:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucnufqw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:38:44 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 13 Feb 2020 15:38:42 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Feb 2020 15:38:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01DFbi4o40173924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 15:37:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A9AB4C044;
 Thu, 13 Feb 2020 15:38:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF1944C046;
 Thu, 13 Feb 2020 15:38:38 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.71.236])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Feb 2020 15:38:38 +0000 (GMT)
Subject: [PATCH] spapr: Rework hash<->radix transitions at CAS
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Feb 2020 16:38:38 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021315-0020-0000-0000-000003A9D42F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021315-0021-0000-0000-00002201BF8A
Message-Id: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_05:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=2 spamscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130120
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Until the CAS negotiation is over, an HPT can be allocated on three
different paths:

1) during machine reset if the host doesn't support radix,

2) during CAS if the guest wants hash and doesn't support HPT resizing,
   in which case we pre-emptively resize the HPT to accomodate maxram,

3) during CAS if no CAS reboot was requested, the guest wants hash but
   we're currently configured for radix.

Depending on the various combinations of host or guest MMU support,
HPT resizing guest support and the possibility of a CAS reboot, it
is quite hard to know which of these allocates the HPT that will
be ultimately used by the guest that wants to do hash. Also, some of
them have bugs:

- 2) calls spapr_reallocate_hpt() instead of spapr_setup_hpt_and_vrma()
  and thus doesn't update the VRMA size, even though we've just extended
  the HPT. Not sure what issues this can cause,

- 3) doesn't check for HPT resizing support and will always allocate a
  small HPT based on the initial RAM size. This caps the total amount of
  RAM the guest can see, especially if maxram is much higher than the
  initial ram.

We only support guests that do CAS and we already assume that the HPT
isn't being used when we do the pre-emptive resizing at CAS. It thus
seems reasonable to only allocate the HPT at the end of CAS, when no
CAS reboot was requested.

Consolidate the logic so that we only create the HPT during 3), ie.
when we're done with the CAS reboot cycles, and ensure HPT resizing
is taken into account. This fixes the radix->hash transition for
all cases.

The guest can theoretically call CAS several times, without a CAS
reboot in between. Linux guests don't do that, but better safe than
sorry, let's ensure we can also handle the symmetrical hash->radix
transition correctly: free the HPT and set the GR bit in PATE.
An helper is introduced for the latter since this is already what
we do during machine reset when going for radix.

As a bonus, this removes one user of spapr->cas_reboot, which we
want to get rid of in the future.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   25 +++++++++++++++-----
 hw/ppc/spapr_hcall.c   |   59 ++++++++++++++++++++----------------------------
 include/hw/ppc/spapr.h |    1 +
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 828e2cc1359a..88bc0e4e3ca1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1573,9 +1573,19 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
 {
     int hpt_shift;
 
+    /*
+     * HPT resizing is a bit of a special case, because when enabled
+     * we assume an HPT guest will support it until it says it
+     * doesn't, instead of assuming it won't support it until it says
+     * it does.  Strictly speaking that approach could break for
+     * guests which don't make a CAS call, but those are so old we
+     * don't care about them.  Without that assumption we'd have to
+     * make at least a temporary allocation of an HPT sized for max
+     * memory, which could be impossibly difficult under KVM HV if
+     * maxram is large.
+     */
     if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
-        || (spapr->cas_reboot
-            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
+        || !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE)) {
         hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
     } else {
         uint64_t current_ram_size;
@@ -1604,6 +1614,12 @@ static int spapr_reset_drcs(Object *child, void *opaque)
     return 0;
 }
 
+void spapr_reset_patb_entry(SpaprMachineState *spapr)
+{
+    spapr->patb_entry = PATE1_GR;
+    spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
+}
+
 static void spapr_machine_reset(MachineState *machine)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
@@ -1624,10 +1640,7 @@ static void spapr_machine_reset(MachineState *machine)
          * without a HPT because KVM will start them in radix mode.
          * Set the GR bit in PATE so that we know there is no HPT.
          */
-        spapr->patb_entry = PATE1_GR;
-        spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
-    } else {
-        spapr_setup_hpt_and_vrma(spapr);
+        spapr_reset_patb_entry(spapr);
     }
 
     qemu_devices_reset();
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b5c0d4..57ddf0fa6d05 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1677,6 +1677,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     bool raw_mode_supported = false;
     bool guest_xive;
     CPUState *cs;
+    int maxshift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
 
     /* CAS is supposed to be called early when only the boot vCPU is active. */
     CPU_FOREACH(cs) {
@@ -1739,36 +1740,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
 
-    /*
-     * HPT resizing is a bit of a special case, because when enabled
-     * we assume an HPT guest will support it until it says it
-     * doesn't, instead of assuming it won't support it until it says
-     * it does.  Strictly speaking that approach could break for
-     * guests which don't make a CAS call, but those are so old we
-     * don't care about them.  Without that assumption we'd have to
-     * make at least a temporary allocation of an HPT sized for max
-     * memory, which could be impossibly difficult under KVM HV if
-     * maxram is large.
-     */
-    if (!guest_radix && !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
-        int maxshift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
-
-        if (spapr->resize_hpt == SPAPR_RESIZE_HPT_REQUIRED) {
-            error_report(
-                "h_client_architecture_support: Guest doesn't support HPT resizing, but resize-hpt=required");
-            exit(1);
-        }
-
-        if (spapr->htab_shift < maxshift) {
-            /* Guest doesn't know about HPT resizing, so we
-             * pre-emptively resize for the maximum permitted RAM.  At
-             * the point this is called, nothing should have been
-             * entered into the existing HPT */
-            spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            push_sregs_to_kvm_pr(spapr);
-        }
-    }
-
     /* NOTE: there are actually a number of ov5 bits where input from the
      * guest is always zero, and the platform/QEMU enables them independently
      * of guest input. To model these properly we'd want some sort of mask,
@@ -1806,6 +1777,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             error_report("Guest requested unavailable MMU mode (hash).");
             exit(EXIT_FAILURE);
         }
+        if (spapr->resize_hpt == SPAPR_RESIZE_HPT_REQUIRED &&
+            !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
+            error_report(
+                "h_client_architecture_support: Guest doesn't support HPT resizing, but resize-hpt=required");
+            exit(1);
+        }
     }
     spapr->cas_pre_isa3_guest = !spapr_ovec_test(ov1_guest, OV1_PPC_3_00);
     spapr_ovec_cleanup(ov1_guest);
@@ -1838,11 +1815,23 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         void *fdt;
         SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
-        /* If spapr_machine_reset() did not set up a HPT but one is necessary
-         * (because the guest isn't going to use radix) then set it up here. */
-        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt_and_vrma(spapr);
+        if (!guest_radix) {
+            /*
+             * Either spapr_machine_reset() did not set up a HPT but one
+             * is necessary (because the guest isn't going to use radix),
+             * or the guest doesn't know about HPT resizing and we need to
+             * pre-emptively resize for the maximum permitted RAM. Set it
+             * up here. At the point this is called, nothing should have
+             * been entered into the existing HPT.
+             */
+            if (spapr->patb_entry & PATE1_GR || spapr->htab_shift < maxshift) {
+                /* legacy hash or new hash: */
+                spapr_setup_hpt_and_vrma(spapr);
+                push_sregs_to_kvm_pr(spapr);
+            }
+        } else {
+            spapr_free_hpt(spapr);
+            spapr_reset_patb_entry(spapr);
         }
 
         if (fdt_bufsize < sizeof(hdr)) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 09110961a589..9d88b5596481 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -919,4 +919,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+void spapr_reset_patb_entry(SpaprMachineState *spapr);
 #endif /* HW_SPAPR_H */


