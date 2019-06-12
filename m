Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C01CC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFF6206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YzSx0EDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFF6206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawPh-0002WV-7U
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8n-0004YE-LS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8l-00073c-91
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60001 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haw8k-00071O-I1; Wed, 12 Jun 2019 01:49:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NwtR4sXfz9sNt; Wed, 12 Jun 2019 15:49:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560318575;
 bh=ZzXHpk4SPL5Xit/JDm8FZtI1PKJAeduhvqwVZi7MhI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzSx0EDTPyTgvLuyGJpHEwTLMAQ5cm3QU1H6RWNv9Wy+Aj8wSNnUisH195ou12BeS
 6dzJHIqSdqVeleZ6r0stvWPgpuPEZpL+cq51mN4A9mS0rsgV7EdNpxHQXHwqyL771h
 2cAT5yGdEvlzdwCWq0DqcgWNChs8gaXDKOytVcYM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 15:49:22 +1000
Message-Id: <20190612054929.21136-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 06/13] spapr: Clean up spapr_drc_populate_dt()
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
Cc: lvivier@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes some minor cleanups to spapr_drc_populate_dt(), renaming it to
the shorter and more idiomatic spapr_dt_drc() along the way.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr.c             |  7 +++----
 hw/ppc/spapr_drc.c         | 13 ++++++-------
 hw/ppc/spapr_pci.c         |  3 +--
 include/hw/ppc/spapr_drc.h |  3 +--
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 44573adce7..507fd50dd5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1320,13 +1320,12 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
     spapr_populate_cpus_dt_node(fdt, spapr);
=20
     if (smc->dr_lmb_enabled) {
-        _FDT(spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE=
_LMB));
+        _FDT(spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
     }
=20
     if (mc->has_hotpluggable_cpus) {
         int offset =3D fdt_path_offset(fdt, "/cpus");
-        ret =3D spapr_drc_populate_dt(fdt, offset, NULL,
-                                    SPAPR_DR_CONNECTOR_TYPE_CPU);
+        ret =3D spapr_dt_drc(fdt, offset, NULL, SPAPR_DR_CONNECTOR_TYPE_=
CPU);
         if (ret < 0) {
             error_report("Couldn't set up CPU DR device tree properties"=
);
             exit(1);
@@ -1363,7 +1362,7 @@ static void *spapr_build_fdt(SpaprMachineState *spa=
pr)
     }
=20
     if (smc->dr_phb_enabled) {
-        ret =3D spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_T=
YPE_PHB);
+        ret =3D spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
         if (ret < 0) {
             error_report("Couldn't set up PHB DR device tree properties"=
);
             exit(1);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 597f236b9c..bacadfcac5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -781,7 +781,7 @@ SpaprDrc *spapr_drc_by_id(const char *type, uint32_t =
id)
 }
=20
 /**
- * spapr_drc_populate_dt
+ * spapr_dt_drc
  *
  * @fdt: libfdt device tree
  * @path: path in the DT to generate properties
@@ -794,8 +794,7 @@ SpaprDrc *spapr_drc_by_id(const char *type, uint32_t =
id)
  *
  * as documented in PAPR+ v2.1, 13.5.2
  */
-int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
-                          uint32_t drc_type_mask)
+int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type=
_mask)
 {
     Object *root_container;
     ObjectProperty *prop;
@@ -873,7 +872,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
     *(uint32_t *)drc_names->str =3D cpu_to_be32(drc_count);
     *(uint32_t *)drc_types->str =3D cpu_to_be32(drc_count);
=20
-    ret =3D fdt_setprop(fdt, fdt_offset, "ibm,drc-indexes",
+    ret =3D fdt_setprop(fdt, offset, "ibm,drc-indexes",
                       drc_indexes->data,
                       drc_indexes->len * sizeof(uint32_t));
     if (ret) {
@@ -881,7 +880,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
         goto out;
     }
=20
-    ret =3D fdt_setprop(fdt, fdt_offset, "ibm,drc-power-domains",
+    ret =3D fdt_setprop(fdt, offset, "ibm,drc-power-domains",
                       drc_power_domains->data,
                       drc_power_domains->len * sizeof(uint32_t));
     if (ret) {
@@ -889,14 +888,14 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset=
, Object *owner,
         goto out;
     }
=20
-    ret =3D fdt_setprop(fdt, fdt_offset, "ibm,drc-names",
+    ret =3D fdt_setprop(fdt, offset, "ibm,drc-names",
                       drc_names->str, drc_names->len);
     if (ret) {
         error_report("Couldn't finalize ibm,drc-names property");
         goto out;
     }
=20
-    ret =3D fdt_setprop(fdt, fdt_offset, "ibm,drc-types",
+    ret =3D fdt_setprop(fdt, offset, "ibm,drc-types",
                       drc_types->str, drc_types->len);
     if (ret) {
         error_report("Couldn't finalize ibm,drc-types property");
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index dc5e46e6d4..546ca29bb7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2276,8 +2276,7 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_=
phandle, void *fdt,
         return ret;
     }
=20
-    ret =3D spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
-                                SPAPR_DR_CONNECTOR_TYPE_PCI);
+    ret =3D spapr_dt_drc(fdt, bus_off, OBJECT(phb), SPAPR_DR_CONNECTOR_T=
YPE_PCI);
     if (ret) {
         return ret;
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index fad0a887f9..c2c543a591 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -266,8 +266,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, const=
 char *type,
                                          uint32_t id);
 SpaprDrc *spapr_drc_by_index(uint32_t index);
 SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
-int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
-                          uint32_t drc_type_mask);
+int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type=
_mask);
=20
 void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
--=20
2.21.0


