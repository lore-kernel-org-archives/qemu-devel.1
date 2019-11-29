Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78958C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444FA207FA
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FiT9oC31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444FA207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZ0e-0005OH-G5
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 00:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYuw-0002gj-0W
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaYut-0002ou-Eh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:34:09 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaYur-0002M8-5U; Fri, 29 Nov 2019 00:34:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PNTz6JDlz9sR2; Fri, 29 Nov 2019 16:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575005639;
 bh=cenYxuwXEyURgovfy5vrBzyXXCpM0tGcpKxNSH0Fqxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FiT9oC31/HOeacIXfVMW4+tCI46DYubpuENLGUMvG23cqROaEBLhXMtZh+cwg3RBA
 qQXkaE3rPMBlJZzQoS4Qanu+qusXklombD2dPko0KteLGEoq7zACsN+uY57nRQShPb
 aoTyrnRCEAzX6JCQgwT9FEWdOkwEvDQEc5x5/6Eg=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 2/4] spapr: Improve handling of fdt buffer size
Date: Fri, 29 Nov 2019 16:33:54 +1100
Message-Id: <20191129053356.232413-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129053356.232413-1-david@gibson.dropbear.id.au>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously, spapr_build_fdt() constructed the device tree in a fixed
buffer of size FDT_MAX_SIZE.  This is a bit inflexible, but more
importantly it's awkward for the case where we use it during CAS.  In
that case the guest firmware supplies a buffer and we have to
awkwardly check that what we generated fits into it afterwards, after
doing a lot of size checks during spapr_build_fdt().

Simplify this by having spapr_build_fdt() take a 'space' parameter.
For the CAS case, we pass in the buffer size provided by SLOF, for the
machine init case, we continue to pass FDT_MAX_SIZE.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d9c9a2bcee..d34e317f48 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -917,7 +917,8 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
=20
-static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset);
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
+                             size_t space);
=20
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
@@ -930,24 +931,17 @@ int spapr_h_cas_compose_response(SpaprMachineState =
*spapr,
         return 1;
     }
=20
-    if (size < sizeof(hdr) || size > FW_MAX_SIZE) {
-        error_report("SLOF provided an unexpected CAS buffer size "
-                     TARGET_FMT_lu " (min: %zu, max: %u)",
-                     size, sizeof(hdr), FW_MAX_SIZE);
+    if (size < sizeof(hdr)) {
+        error_report("SLOF provided insufficient CAS buffer "
+                     TARGET_FMT_lu " (min: %zu)", size, sizeof(hdr));
         exit(EXIT_FAILURE);
     }
=20
     size -=3D sizeof(hdr);
=20
-    fdt =3D spapr_build_fdt(spapr, false);
+    fdt =3D spapr_build_fdt(spapr, false, size);
     _FDT((fdt_pack(fdt)));
=20
-    if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
-        g_free(fdt);
-        trace_spapr_cas_failed(size);
-        return -1;
-    }
-
     cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
     cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt=
));
     trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
@@ -1197,7 +1191,8 @@ static void spapr_dt_hypervisor(SpaprMachineState *=
spapr, void *fdt)
     }
 }
=20
-static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
+                             size_t space)
 {
     MachineState *machine =3D MACHINE(spapr);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
@@ -1207,8 +1202,8 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr, bool reset)
     SpaprPhbState *phb;
     char *buf;
=20
-    fdt =3D g_malloc0(FDT_MAX_SIZE);
-    _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
+    fdt =3D g_malloc0(space);
+    _FDT((fdt_create_empty_tree(fdt, space)));
=20
     /* Root node */
     _FDT(fdt_setprop_string(fdt, 0, "device_type", "chrp"));
@@ -1723,19 +1718,13 @@ static void spapr_machine_reset(MachineState *mac=
hine)
      */
     fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
=20
-    fdt =3D spapr_build_fdt(spapr, true);
+    fdt =3D spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
=20
     rc =3D fdt_pack(fdt);
=20
     /* Should only fail if we've built a corrupted tree */
     assert(rc =3D=3D 0);
=20
-    if (fdt_totalsize(fdt) > FDT_MAX_SIZE) {
-        error_report("FDT too big ! 0x%x bytes (max is 0x%x)",
-                     fdt_totalsize(fdt), FDT_MAX_SIZE);
-        exit(1);
-    }
-
     /* Load the fdt */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
--=20
2.23.0


