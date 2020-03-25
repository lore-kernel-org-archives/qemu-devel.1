Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF8C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9C0206F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9C0206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38411 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH82T-0002vF-90
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jH7uh-0002Hv-Pf
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jH7ug-00075x-42
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jH7uf-00075e-SR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:25:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PF4lvB099100
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7usdp7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 11:25:48 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 25 Mar 2020 15:25:42 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 15:25:40 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFPhBb59179198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:25:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5275AE04D;
 Wed, 25 Mar 2020 15:25:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEC15AE057;
 Wed, 25 Mar 2020 15:25:43 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.41.106])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 15:25:43 +0000 (GMT)
Subject: [PATCH 3/4] spapr/cas: Separate CAS handling from rebuilding the FDT
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 25 Mar 2020 16:25:42 +0100
In-Reply-To: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032515-0020-0000-0000-000003BADE61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032515-0021-0000-0000-00002213650C
Message-Id: <158514994229.478799.2178881312094922324.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=48 malwarescore=0
 priorityscore=1501 clxscore=1034 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003250121
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment "ibm,client-architecture-support" ("CAS") is implemented
in SLOF and QEMU assists via the custom H_CAS hypercall which copies
an updated flatten device tree (FDT) blob to the SLOF memory which
it then uses to update its internal tree.

When we enable the OpenFirmware client interface in QEMU, we won't need
to copy the FDT to the guest as the client is expected to fetch
the device tree using the client interface.

This moves FDT rebuild out to a separate helper which is going to be
called from the "ibm,client-architecture-support" handler and leaves
writing FDT to the guest in the H_CAS handler.

This should not cause any behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200310050733.29805-3-aik@ozlabs.ru>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |    1 -
 hw/ppc/spapr_hcall.c   |   67 +++++++++++++++++++++++++++++-------------------
 include/hw/ppc/spapr.h |    7 +++++
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91f8cfe7a8b1..c522cd205fee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,7 +96,6 @@
  *
  * We load our kernel at 4M, leaving space for SLOF initial image
  */
-#define FDT_MAX_SIZE            0x100000
 #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that */
 #define FW_MAX_SIZE             0x400000
 #define FW_FILE_NAME            "slof.bin"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9bed659b1a94..b424bca4d2c0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1665,16 +1665,12 @@ static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spapr)
     spapr_clear_pending_hotplug_events(spapr);
 }
 
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong opcode,
-                                                  target_ulong *args)
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong vec,
+                                            target_ulong fdt_bufsize)
 {
-    /* Working address in data buffer */
-    target_ulong addr = ppc64_phys_to_real(args[0]);
-    target_ulong fdt_buf = args[1];
-    target_ulong fdt_bufsize = args[2];
-    target_ulong ov_table;
+    target_ulong ov_table; /* Working address in data buffer */
     uint32_t cas_pvr;
     SpaprOptionVector *ov1_guest, *ov5_guest;
     bool guest_radix;
@@ -1694,7 +1690,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
     }
 
-    cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
+    cas_pvr = cas_check_pvr(spapr, cpu, &vec, &raw_mode_supported, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return H_HARDWARE;
@@ -1717,7 +1713,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     }
 
     /* For the future use: here @ov_table points to the first option vector */
-    ov_table = addr;
+    ov_table = vec;
 
     ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
     if (!ov1_guest) {
@@ -1823,7 +1819,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (!spapr->cas_reboot) {
         void *fdt;
-        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
         /* If spapr_machine_reset() did not set up a HPT but one is necessary
          * (because the guest isn't going to use radix) then set it up here. */
@@ -1832,21 +1827,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             spapr_setup_hpt(spapr);
         }
 
-        if (fdt_bufsize < sizeof(hdr)) {
-            error_report("SLOF provided insufficient CAS buffer "
-                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
-            exit(EXIT_FAILURE);
-        }
-
-        fdt_bufsize -= sizeof(hdr);
-
         fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
-        _FDT((fdt_pack(fdt)));
-
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
-                                  fdt_totalsize(fdt));
-        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
 
         g_free(spapr->fdt_blob);
         spapr->fdt_size = fdt_totalsize(fdt);
@@ -1861,6 +1842,40 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong opcode,
+                                                  target_ulong *args)
+{
+    target_ulong vec = ppc64_phys_to_real(args[0]);
+    target_ulong fdt_buf = args[1];
+    target_ulong fdt_bufsize = args[2];
+    target_ulong ret;
+    SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
+
+    if (fdt_bufsize < sizeof(hdr)) {
+        error_report("SLOF provided insufficient CAS buffer "
+                     TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
+        exit(EXIT_FAILURE);
+    }
+
+    fdt_bufsize -= sizeof(hdr);
+
+    ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
+    if (ret == H_SUCCESS) {
+        _FDT((fdt_pack(spapr->fdt_blob)));
+        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
+        spapr->fdt_initial_size = spapr->fdt_size;
+
+        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
+        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
+                                  spapr->fdt_size);
+        trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
+    }
+
+    return ret;
+}
+
 static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a036821..b7e13e5aafb7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -102,6 +102,8 @@ typedef enum {
 #define SPAPR_CAP_FIXED_CCD             0x03
 #define SPAPR_CAP_FIXED_NA              0x10 /* Lets leave a bit of a gap... */
 
+#define FDT_MAX_SIZE                    0x100000
+
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
@@ -566,6 +568,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_bufsize);
+
 /* Virtual Processor Area structure constants */
 #define VPA_MIN_SIZE           640
 #define VPA_SIZE_OFFSET        0x4


