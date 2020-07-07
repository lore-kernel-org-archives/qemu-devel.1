Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13BB20674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywmr9ap7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13BB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqE9-00082A-Vw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7N-0002VP-1z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq78-0006qn-6u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gp8AvkLHGhKVLb6Tljp6BaY5+4XVcugq4zFdIKeXoRc=;
 b=Ywmr9ap7zsro/RIwlg85aoEvpj3+ewidRbds5wh+6Uf1CwjS9ZIjbMzcAMF5qvujRfwN1b
 lVP/v6fvb7RNwop/MRCtiT3tF+iSiRUM6Ui1xn8B+/GcmvCpRH8JyrIPhvyb+njlxoQObV
 zZuoMhS+jPZfBMqDXwMGPS99sPCuhzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-P6EUTslgNhaHL4e7yjZXlg-1; Tue, 07 Jul 2020 12:06:28 -0400
X-MC-Unique: P6EUTslgNhaHL4e7yjZXlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826AF107ACCA;
 Tue,  7 Jul 2020 16:06:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F167277896;
 Tue,  7 Jul 2020 16:06:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E534711275F6; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 28/45] qom: Use returned bool to check for failure,
 Coccinelle part
Date: Tue,  7 Jul 2020 18:05:56 +0200
Message-Id: <20200707160613.848843-29-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables conversion of

    foo(..., &err);
    if (err) {
        ...
    }

to

    if (!foo(..., errp)) {
        ...
    }

for QOM functions that now return true / false on success / error.
Coccinelle script:

    @@
    identifier fun = {
        object_apply_global_props, object_initialize_child_with_props,
        object_initialize_child_with_propsv, object_property_get,
        object_property_get_bool, object_property_parse, object_property_set,
        object_property_set_bool, object_property_set_int,
        object_property_set_link, object_property_set_qobject,
        object_property_set_str, object_property_set_uint, object_set_props,
        object_set_propv, user_creatable_add_dict,
        user_creatable_complete, user_creatable_del
    };
    expression list args, args2;
    typedef Error;
    Error *err;
    @@
    -    fun(args, &err, args2);
    -    if (err)
    +    if (!fun(args, &err, args2))
         {
             ...
         }

Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
ARMSSE being used both as typedef and function-like macro there.
Convert manually.

Line breaks tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/arm/armsse.c              | 52 +++++++++++++++---------------------
 hw/arm/armv7m.c              | 20 ++++++--------
 hw/arm/aspeed_ast2600.c      |  5 ++--
 hw/arm/aspeed_soc.c          |  5 ++--
 hw/arm/bcm2835_peripherals.c |  5 ++--
 hw/arm/bcm2836.c             | 12 ++++-----
 hw/arm/cubieboard.c          | 11 ++++----
 hw/arm/digic.c               |  4 +--
 hw/arm/nrf51_soc.c           |  8 +++---
 hw/arm/stm32f405_soc.c       |  7 +++--
 hw/arm/xlnx-zynqmp.c         | 14 +++++-----
 hw/block/xen-block.c         | 15 +++++------
 hw/core/qdev.c               |  3 +--
 hw/i386/x86.c                |  3 +--
 hw/ppc/pnv_psi.c             |  4 +--
 hw/s390x/s390-pci-bus.c      |  3 +--
 hw/s390x/s390-virtio-ccw.c   |  3 +--
 hw/scsi/scsi-bus.c           |  3 +--
 hw/sd/aspeed_sdhci.c         |  8 +++---
 hw/sd/ssi-sd.c               |  3 +--
 hw/virtio/virtio-rng.c       |  5 ++--
 qdev-monitor.c               |  3 +--
 qom/object.c                 | 15 ++++-------
 qom/object_interfaces.c      |  6 ++---
 softmmu/vl.c                 |  4 +--
 target/arm/monitor.c         |  3 +--
 target/i386/cpu.c            | 11 +++-----
 target/s390x/cpu_models.c    |  3 +--
 28 files changed, 96 insertions(+), 142 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 1f8ce94ecc..c8604926a3 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -534,22 +534,20 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * later if necessary.
          */
         if (extract32(info->cpuwait_rst, i, 1)) {
-            object_property_set_bool(cpuobj, "start-powered-off", true, &err);
-            if (err) {
+            if (!object_property_set_bool(cpuobj, "start-powered-off", true,
+                                          &err)) {
                 error_propagate(errp, err);
                 return;
             }
         }
         if (!s->cpu_fpu[i]) {
-            object_property_set_bool(cpuobj, "vfp", false, &err);
-            if (err) {
+            if (!object_property_set_bool(cpuobj, "vfp", false, &err)) {
                 error_propagate(errp, err);
                 return;
             }
         }
         if (!s->cpu_dsp[i]) {
-            object_property_set_bool(cpuobj, "dsp", false, &err);
-            if (err) {
+            if (!object_property_set_bool(cpuobj, "dsp", false, &err)) {
                 error_propagate(errp, err);
                 return;
             }
@@ -604,9 +602,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 DeviceState *devs = DEVICE(splitter);
                 int cpunum;
 
-                object_property_set_int(splitter, "num-lines", info->num_cpus,
-                                        &err);
-                if (err) {
+                if (!object_property_set_int(splitter, "num-lines",
+                                             info->num_cpus, &err)) {
                     error_propagate(errp, err);
                     return;
                 }
@@ -658,9 +655,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * multiple lines, one for each of the PPCs within the ARMSSE and one
      * that will be an output from the ARMSSE to the system.
      */
-    object_property_set_int(OBJECT(&s->sec_resp_splitter), "num-lines", 3,
-                            &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->sec_resp_splitter),
+                                 "num-lines", 3, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -702,9 +698,9 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* We must OR together lines from the MPC splitters to go to the NVIC */
-    object_property_set_int(OBJECT(&s->mpc_irq_orgate), "num-lines",
-                            IOTS_NUM_EXP_MPC + info->sram_banks, &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->mpc_irq_orgate), "num-lines",
+                                 IOTS_NUM_EXP_MPC + info->sram_banks,
+                                 &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -841,9 +837,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * ones) are sent individually to the security controller, and also
      * ORed together to give a single combined PPC interrupt to the NVIC.
      */
-    object_property_set_int(OBJECT(&s->ppc_irq_orgate), "num-lines", NUM_PPCS,
-                            &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->ppc_irq_orgate),
+                                 "num-lines", NUM_PPCS, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -949,15 +944,13 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                           qdev_get_gpio_in_named(dev_apb_ppc1,
                                                  "cfg_sec_resp", 0));
 
-    object_property_set_int(OBJECT(&s->sysinfo), "SYS_VERSION",
-                            info->sys_version, &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->sysinfo), "SYS_VERSION",
+                                 info->sys_version, &err)) {
         error_propagate(errp, err);
         return;
     }
-    object_property_set_int(OBJECT(&s->sysinfo), "SYS_CONFIG",
-                            armsse_sys_config_value(s, info), &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->sysinfo), "SYS_CONFIG",
+                                 armsse_sys_config_value(s, info), &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1005,8 +998,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* This OR gate wires together outputs from the secure watchdogs to NMI */
-    object_property_set_int(OBJECT(&s->nmi_orgate), "num-lines", 2, &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->nmi_orgate), "num-lines", 2,
+                                 &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -1049,8 +1042,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         Object *splitter = OBJECT(&s->ppc_irq_splitter[i]);
 
-        object_property_set_int(splitter, "num-lines", 2, &err);
-        if (err) {
+        if (!object_property_set_int(splitter, "num-lines", 2, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -1095,8 +1087,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
         DeviceState *dev_splitter = DEVICE(splitter);
 
-        object_property_set_int(OBJECT(splitter), "num-lines", 2, &err);
-        if (err) {
+        if (!object_property_set_int(OBJECT(splitter), "num-lines", 2,
+                                     &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 923f7fad40..2e6dabbbaf 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -174,31 +174,27 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
     }
     if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
-        object_property_set_uint(OBJECT(s->cpu), "init-svtor", s->init_svtor,
-                                 &err);
-        if (err != NULL) {
+        if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
+                                      s->init_svtor, &err)) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
-                                 s->start_powered_off, &err);
-        if (err != NULL) {
+        if (!object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
+                                      s->start_powered_off, &err)) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, &err);
-        if (err != NULL) {
+        if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, &err)) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, &err);
-        if (err != NULL) {
+        if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -243,8 +239,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             Object *obj = OBJECT(&s->bitband[i]);
             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
-            object_property_set_int(obj, "base", bitband_input_addr[i], &err);
-            if (err != NULL) {
+            if (!object_property_set_int(obj, "base",
+                                         bitband_input_addr[i], &err)) {
                 error_propagate(errp, err);
                 return;
             }
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index e6e2cf0737..22cbe68449 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -356,9 +356,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                            sc->memmap[ASPEED_SDRAM], &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
+                                 sc->memmap[ASPEED_SDRAM], &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 27704d87ea..ff5f4d6a52 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -308,9 +308,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                            sc->memmap[ASPEED_SDRAM], &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
+                                 sc->memmap[ASPEED_SDRAM], &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a6ccf3b368..cb724c18e8 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -222,9 +222,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_uint(OBJECT(&s->fb), "vcram-base",
-                             ram_size - vcram_size, &err);
-    if (err) {
+    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
+                                  ram_size - vcram_size, &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 91d31a5cb7..0d373af1a1 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -110,17 +110,17 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-                                info->peri_base, &err);
-        if (err) {
+        if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+                                     info->peri_base, &err)) {
             error_propagate(errp, err);
             return;
         }
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
-                                 n >= s->enabled_cpus, &err);
-        if (err) {
+        if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
+                                      "start-powered-off",
+                                      n >= s->enabled_cpus,
+                                      &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 302919246b..1c6c792eb6 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -62,20 +62,19 @@ static void cubieboard_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(a10));
     object_unref(OBJECT(a10));
 
-    object_property_set_int(OBJECT(&a10->emac), "phy-addr", 1, &err);
-    if (err != NULL) {
+    if (!object_property_set_int(OBJECT(&a10->emac), "phy-addr", 1, &err)) {
         error_reportf_err(err, "Couldn't set phy address: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&a10->timer), "clk0-freq", 32768, &err);
-    if (err != NULL) {
+    if (!object_property_set_int(OBJECT(&a10->timer), "clk0-freq", 32768,
+                                 &err)) {
         error_reportf_err(err, "Couldn't set clk0 frequency: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&a10->timer), "clk1-freq", 24000000, &err);
-    if (err != NULL) {
+    if (!object_property_set_int(OBJECT(&a10->timer), "clk1-freq", 24000000,
+                                 &err)) {
         error_reportf_err(err, "Couldn't set clk1 frequency: ");
         exit(1);
     }
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index ffc89d86b8..2306034840 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -56,8 +56,8 @@ static void digic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     int i;
 
-    object_property_set_bool(OBJECT(&s->cpu), "reset-hivecs", true, &err);
-    if (err != NULL) {
+    if (!object_property_set_bool(OBJECT(&s->cpu), "reset-hivecs", true,
+                                  &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index c440cd11e9..7877d2bf60 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -106,9 +106,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
     /* UICR, FICR, NVMC, FLASH */
-    object_property_set_uint(OBJECT(&s->nvm), "flash-size", s->flash_size,
-                             &err);
-    if (err) {
+    if (!object_property_set_uint(OBJECT(&s->nvm), "flash-size",
+                                  s->flash_size, &err)) {
         error_propagate(errp, err);
         return;
     }
@@ -141,8 +140,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* TIMER */
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
-        object_property_set_uint(OBJECT(&s->timer[i]), "id", i, &err);
-        if (err) {
+        if (!object_property_set_uint(OBJECT(&s->timer[i]), "id", i, &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 07ce323a64..ddc680bfe0 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -160,10 +160,9 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* ADC device, the IRQs are ORed together */
-    object_initialize_child_with_props(OBJECT(s), "adc-orirq", &s->adc_irqs,
-                                       sizeof(s->adc_irqs), TYPE_OR_IRQ, &err,
-                                       NULL);
-    if (err != NULL) {
+    if (!object_initialize_child_with_props(OBJECT(s), "adc-orirq",
+                                            &s->adc_irqs, sizeof(s->adc_irqs),
+                                            TYPE_OR_IRQ, &err, NULL)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index e7fe85f1d8..055b778d11 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -507,18 +507,16 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - SDIO Specification Version 3.0
          * - eMMC Specification Version 4.51
          */
-        object_property_set_uint(sdhci, "sd-spec-version", 3, &err);
-        if (err) {
+        if (!object_property_set_uint(sdhci, "sd-spec-version", 3, &err)) {
             error_propagate(errp, err);
             return;
         }
-        object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES, &err);
-        if (err) {
+        if (!object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
+                                      &err)) {
             error_propagate(errp, err);
             return;
         }
-        object_property_set_uint(sdhci, "uhs", UHS_I, &err);
-        if (err) {
+        if (!object_property_set_uint(sdhci, "uhs", UHS_I, &err)) {
             error_propagate(errp, err);
             return;
         }
@@ -606,8 +604,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
-        object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128, &err);
-        if (err) {
+        if (!object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
+                                      &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 0e6e6df5fa..89a4d02a1b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -935,22 +935,21 @@ static void xen_block_device_create(XenBackendInstance *backend,
     xendev = XEN_DEVICE(qdev_new(type));
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
-    object_property_set_str(OBJECT(xendev), "vdev", vdev, &local_err);
-    if (local_err) {
+    if (!object_property_set_str(OBJECT(xendev), "vdev", vdev,
+                                 &local_err)) {
         error_propagate_prepend(errp, local_err, "failed to set 'vdev': ");
         goto fail;
     }
 
-    object_property_set_str(OBJECT(xendev), "drive",
-                            xen_block_drive_get_node_name(drive), &local_err);
-    if (local_err) {
+    if (!object_property_set_str(OBJECT(xendev), "drive",
+                                 xen_block_drive_get_node_name(drive),
+                                 &local_err)) {
         error_propagate_prepend(errp, local_err, "failed to set 'drive': ");
         goto fail;
     }
 
-    object_property_set_str(OBJECT(xendev), "iothread", iothread->id,
-                            &local_err);
-    if (local_err) {
+    if (!object_property_set_str(OBJECT(xendev), "iothread", iothread->id,
+                                 &local_err)) {
         error_propagate_prepend(errp, local_err,
                                 "failed to set 'iothread': ");
         goto fail;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8de99f6ba5..d6416fb894 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -396,8 +396,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    object_property_set_bool(OBJECT(dev), "realized", true, &err);
-    if (err) {
+    if (!object_property_set_bool(OBJECT(dev), "realized", true, &err)) {
         error_propagate(errp, err);
     }
     return !err;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 54760197cf..22b524e0ab 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -121,8 +121,7 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     Error *local_err = NULL;
     Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    object_property_set_uint(cpu, "apic-id", apic_id, &local_err);
-    if (local_err) {
+    if (!object_property_set_uint(cpu, "apic-id", apic_id, &local_err)) {
         goto out;
     }
     qdev_realize(DEVICE(cpu), NULL, &local_err);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e23276983f..604788a8eb 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -505,8 +505,8 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
     unsigned int i;
 
     /* Create PSI interrupt control source */
-    object_property_set_int(OBJECT(ics), "nr-irqs", PSI_NUM_INTERRUPTS, &err);
-    if (err) {
+    if (!object_property_set_int(OBJECT(ics), "nr-irqs", PSI_NUM_INTERRUPTS,
+                                 &err)) {
         error_propagate(errp, err);
         return;
     }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a7b2a15a96..24de4edfc6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -824,8 +824,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
         return NULL;
     }
 
-    object_property_set_str(OBJECT(dev), "target", target, &local_err);
-    if (local_err) {
+    if (!object_property_set_str(OBJECT(dev), "target", target, &local_err)) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
                                 "zPCI device could not be created: ");
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index be4859fa49..62af349c31 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -71,8 +71,7 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
     S390CPU *cpu = S390_CPU(object_new(typename));
     Error *err = NULL;
 
-    object_property_set_int(OBJECT(cpu), "core-id", core_id, &err);
-    if (err != NULL) {
+    if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, &err)) {
         goto out;
     }
     qdev_realize(DEVICE(cpu), NULL, &err);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 4860863f1d..a83939f7d0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -283,8 +283,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), "share-rw", share_rw, &err);
-    if (err != NULL) {
+    if (!object_property_set_bool(OBJECT(dev), "share-rw", share_rw, &err)) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
         return NULL;
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 29aa11df66..687b300773 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -132,15 +132,13 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
         Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
         SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
 
-        object_property_set_int(sdhci_slot, "sd-spec-version", 2, &err);
-        if (err) {
+        if (!object_property_set_int(sdhci_slot, "sd-spec-version", 2, &err)) {
             error_propagate(errp, err);
             return;
         }
 
-        object_property_set_uint(sdhci_slot, "capareg",
-                                 ASPEED_SDHCI_CAPABILITIES, &err);
-        if (err) {
+        if (!object_property_set_uint(sdhci_slot, "capareg",
+                                      ASPEED_SDHCI_CAPABILITIES, &err)) {
             error_propagate(errp, err);
             return;
         }
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index d4b57cda80..ad825220e2 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -261,8 +261,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
         }
     }
 
-    object_property_set_bool(OBJECT(carddev), "spi", true, &err);
-    if (err) {
+    if (!object_property_set_bool(OBJECT(carddev), "spi", true, &err)) {
         goto fail;
     }
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 85f7163e2d..8d052fbeed 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -194,9 +194,8 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
     if (vrng->conf.rng == NULL) {
         Object *default_backend = object_new(TYPE_RNG_BUILTIN);
 
-        user_creatable_complete(USER_CREATABLE(default_backend),
-                                &local_err);
-        if (local_err) {
+        if (!user_creatable_complete(USER_CREATABLE(default_backend),
+                                     &local_err)) {
             error_propagate(errp, local_err);
             object_unref(default_backend);
             return;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8d2de6a147..cd46157bcf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -183,8 +183,7 @@ static int set_property(void *opaque, const char *name, const char *value,
     if (strcmp(name, "bus") == 0)
         return 0;
 
-    object_property_parse(obj, name, value, &err);
-    if (err != NULL) {
+    if (!object_property_parse(obj, name, value, &err)) {
         error_propagate(errp, err);
         return -1;
     }
diff --git a/qom/object.c b/qom/object.c
index c4b915a484..25c5ddb78f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -405,8 +405,7 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
             continue;
         }
         p->used = true;
-        object_property_parse(obj, p->property, p->value, &err);
-        if (err != NULL) {
+        if (!object_property_parse(obj, p->property, p->value, &err)) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
             /*
@@ -566,8 +565,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        user_creatable_complete(uc, &local_err);
-        if (local_err) {
+        if (!user_creatable_complete(uc, &local_err)) {
             object_unparent(obj);
             goto out;
         }
@@ -764,8 +762,7 @@ Object *object_new_with_propv(const char *typename,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        user_creatable_complete(uc, &local_err);
-        if (local_err) {
+        if (!user_creatable_complete(uc, &local_err)) {
             if (id != NULL) {
                 object_unparent(obj);
             }
@@ -810,8 +807,7 @@ int object_set_propv(Object *obj,
         const char *value = va_arg(vargs, char *);
 
         g_assert(value != NULL);
-        object_property_parse(obj, propname, value, &local_err);
-        if (local_err) {
+        if (!object_property_parse(obj, propname, value, &local_err)) {
             error_propagate(errp, local_err);
             return -1;
         }
@@ -1594,8 +1590,7 @@ char *object_property_print(Object *obj, const char *name, bool human,
     Error *local_err = NULL;
 
     v = string_output_visitor_new(human, &string);
-    object_property_get(obj, name, v, &local_err);
-    if (local_err) {
+    if (!object_property_get(obj, name, v, &local_err)) {
         error_propagate(errp, local_err);
         goto out;
     }
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 382198504c..15fff66c3c 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -70,8 +70,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         goto out;
     }
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-        object_property_set(obj, e->key, v, &local_err);
-        if (local_err) {
+        if (!object_property_set(obj, e->key, v, &local_err)) {
             break;
         }
     }
@@ -88,8 +87,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
                                   id, obj);
     }
 
-    user_creatable_complete(USER_CREATABLE(obj), &local_err);
-    if (local_err) {
+    if (!user_creatable_complete(USER_CREATABLE(obj), &local_err)) {
         if (id != NULL) {
             object_property_del(object_get_objects_root(), id);
         }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4903129867..aa79d3e79f 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2450,9 +2450,7 @@ static int object_parse_property_opt(Object *obj,
         return 0;
     }
 
-    object_property_parse(obj, name, value, &local_err);
-
-    if (local_err) {
+    if (!object_property_parse(obj, name, value, &local_err)) {
         error_propagate(errp, local_err);
         return -1;
     }
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 087726a394..c162c5fb68 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -184,8 +184,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         i = 0;
         while ((name = cpu_model_advertised_features[i++]) != NULL) {
             if (qdict_get(qdict_in, name)) {
-                object_property_set(obj, name, visitor, &err);
-                if (err) {
+                if (!object_property_set(obj, name, visitor, &err)) {
                     break;
                 }
             }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dd83cb7f72..2b60b61ced 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5271,9 +5271,8 @@ static void object_apply_props(Object *obj, QDict *props, Error **errp)
     Error *err = NULL;
 
     for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
-        object_property_set_qobject(obj, qdict_entry_key(prop),
-                                    qdict_entry_value(prop), &err);
-        if (err) {
+        if (!object_property_set_qobject(obj, qdict_entry_key(prop),
+                                         qdict_entry_value(prop), &err)) {
             break;
         }
     }
@@ -6340,16 +6339,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), prop, true, &local_err);
-        if (local_err) {
+        if (!object_property_set_bool(OBJECT(cpu), prop, true, &local_err)) {
             goto out;
         }
     }
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), prop, false, &local_err);
-        if (local_err) {
+        if (!object_property_set_bool(OBJECT(cpu), prop, false, &local_err)) {
             goto out;
         }
     }
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ab206186b..f3ba30e93e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -517,8 +517,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
             return;
         }
         for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-            object_property_set(obj, e->key, visitor, &err);
-            if (err) {
+            if (!object_property_set(obj, e->key, visitor, &err)) {
                 break;
             }
         }
-- 
2.26.2


