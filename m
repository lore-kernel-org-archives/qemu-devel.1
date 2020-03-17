Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1848C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D71D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QqAN9nmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D71D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Xt-0001ht-J7
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96T-0002K8-Tv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96S-0008A1-0w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47397 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96R-0005aq-Kq; Tue, 17 Mar 2020 06:05:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL05lgtz9sTQ; Tue, 17 Mar 2020 21:04:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439480;
 bh=KT5ze/+yN+LYC+I7poQ2KhjH7DVbMMJtLwam/nRyiCk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QqAN9nmD9i2Ily7p6eYGvvr65Aq/cr/YQbXfpcrPSV+6Q03Leze3rHbqD5rkUWZZw
 I1y4FwDtPVZcL9wi7F/l5shL4owHr4J8P7rcv6egf+4szAaBsNfB7sp8Qox+K89k37
 MGln+mvvjtrVXX2W3hZXLETW7YwjlhreI076b5eY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 35/45] spapr: Move creation of ibm,architecture-vec-5 property
Date: Tue, 17 Mar 2020 21:04:13 +1100
Message-Id: <20200317100423.622643-36-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is currently called from spapr_dt_cas_updates() which is a hang
over from when we created this only as a diff to the DT at CAS time.
Now that we fully rebuild the DT at CAS time, just create it along
with the rest of the properties in /chosen.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 144 ++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 79 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5e938833f3..aff8c87fad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -889,22 +889,6 @@ static int spapr_rng_populate_dt(void *fdt)
     return ret ? -1 : 0;
 }
=20
-static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
-                                SpaprOptionVector *ov5_updates)
-{
-    int offset;
-
-    offset =3D fdt_path_offset(fdt, "/chosen");
-    if (offset < 0) {
-        offset =3D fdt_add_subnode(fdt, 0, "chosen");
-        if (offset < 0) {
-            return offset;
-        }
-    }
-    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
-                                  "ibm,architecture-vec-5");
-}
-
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms =3D MACHINE(spapr);
@@ -1043,81 +1027,92 @@ static void spapr_dt_ov5_platform_support(SpaprMa=
chineState *spapr, void *fdt,
                      val, sizeof(val)));
 }
=20
-static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
+static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool re=
set)
 {
     MachineState *machine =3D MACHINE(spapr);
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     int chosen;
-    const char *boot_device =3D machine->boot_order;
-    char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
-    size_t cb =3D 0;
-    char *bootlist =3D get_boot_devices_list(&cb);
=20
     _FDT(chosen =3D fdt_add_subnode(fdt, 0, "chosen"));
=20
-    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
-        _FDT(fdt_setprop_string(fdt, chosen, "bootargs",
-                                machine->kernel_cmdline));
-    }
-    if (spapr->initrd_size) {
-        _FDT(fdt_setprop_cell(fdt, chosen, "linux,initrd-start",
-                              spapr->initrd_base));
-        _FDT(fdt_setprop_cell(fdt, chosen, "linux,initrd-end",
-                              spapr->initrd_base + spapr->initrd_size));
-    }
+    if (reset) {
+        const char *boot_device =3D machine->boot_order;
+        char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
+        size_t cb =3D 0;
+        char *bootlist =3D get_boot_devices_list(&cb);
+
+        if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
+            _FDT(fdt_setprop_string(fdt, chosen, "bootargs",
+                                    machine->kernel_cmdline));
+        }
=20
-    if (spapr->kernel_size) {
-        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
-                              cpu_to_be64(spapr->kernel_size) };
+        if (spapr->initrd_size) {
+            _FDT(fdt_setprop_cell(fdt, chosen, "linux,initrd-start",
+                                  spapr->initrd_base));
+            _FDT(fdt_setprop_cell(fdt, chosen, "linux,initrd-end",
+                                  spapr->initrd_base + spapr->initrd_siz=
e));
+        }
+
+        if (spapr->kernel_size) {
+            uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
+                                  cpu_to_be64(spapr->kernel_size) };
=20
-        _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
+            _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
                          &kprop, sizeof(kprop)));
-        if (spapr->kernel_le) {
-            _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel-le", NULL, 0=
));
+            if (spapr->kernel_le) {
+                _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel-le", NUL=
L, 0));
+            }
         }
-    }
-    if (boot_menu) {
-        _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", boot_menu)=
));
-    }
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_wid=
th));
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_he=
ight));
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_dep=
th));
+        if (boot_menu) {
+            _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", boot_m=
enu)));
+        }
+        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic=
_width));
+        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphi=
c_height));
+        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic=
_depth));
=20
-    if (cb && bootlist) {
-        int i;
+        if (cb && bootlist) {
+            int i;
=20
-        for (i =3D 0; i < cb; i++) {
-            if (bootlist[i] =3D=3D '\n') {
-                bootlist[i] =3D ' ';
+            for (i =3D 0; i < cb; i++) {
+                if (bootlist[i] =3D=3D '\n') {
+                    bootlist[i] =3D ' ';
+                }
             }
+            _FDT(fdt_setprop_string(fdt, chosen, "qemu,boot-list", bootl=
ist));
         }
-        _FDT(fdt_setprop_string(fdt, chosen, "qemu,boot-list", bootlist)=
);
-    }
=20
-    if (boot_device && strlen(boot_device)) {
-        _FDT(fdt_setprop_string(fdt, chosen, "qemu,boot-device", boot_de=
vice));
-    }
+        if (boot_device && strlen(boot_device)) {
+            _FDT(fdt_setprop_string(fdt, chosen, "qemu,boot-device", boo=
t_device));
+        }
+
+        if (!spapr->has_graphics && stdout_path) {
+            /*
+             * "linux,stdout-path" and "stdout" properties are
+             * deprecated by linux kernel. New platforms should only
+             * use the "stdout-path" property. Set the new property
+             * and continue using older property to remain compatible
+             * with the existing firmware.
+             */
+            _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", st=
dout_path));
+            _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_p=
ath));
+        }
=20
-    if (!spapr->has_graphics && stdout_path) {
         /*
-         * "linux,stdout-path" and "stdout" properties are deprecated by=
 linux
-         * kernel. New platforms should only use the "stdout-path" prope=
rty. Set
-         * the new property and continue using older property to remain
-         * compatible with the existing firmware.
+         * We can deal with BAR reallocation just fine, advertise it
+         * to the guest
          */
-        _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout=
_path));
-        _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
-    }
+        if (smc->linux_pci_probe) {
+            _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0=
));
+        }
=20
-    /* We can deal with BAR reallocation just fine, advertise it to the =
guest */
-    if (smc->linux_pci_probe) {
-        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
-    }
+        spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
-    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
+        g_free(stdout_path);
+        g_free(bootlist);
+    }
=20
-    g_free(stdout_path);
-    g_free(bootlist);
+    _FDT(spapr_ovec_populate_dt(fdt, chosen, spapr->ov5_cas,
+                                "ibm,architecture-vec-5"));
 }
=20
 static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
@@ -1243,9 +1238,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
     spapr_dt_rtas(spapr, fdt);
=20
     /* /chosen */
-    if (reset) {
-        spapr_dt_chosen(spapr, fdt);
-    }
+    spapr_dt_chosen(spapr, fdt, reset);
=20
     /* /hypervisor */
     if (kvm_enabled()) {
@@ -1264,13 +1257,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bo=
ol reset, size_t space)
         }
     }
=20
-    /* ibm,client-architecture-support updates */
-    ret =3D spapr_dt_cas_updates(spapr, fdt, spapr->ov5_cas);
-    if (ret < 0) {
-        error_report("couldn't setup CAS properties fdt");
-        exit(1);
-    }
-
     if (smc->dr_phb_enabled) {
         ret =3D spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
         if (ret < 0) {
--=20
2.24.1


