Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE968C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF41206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE0W4Kpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF41206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefXE-0002oB-Ln
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKT-0002xP-PK
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKL-000758-7z
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIsG3kKuAJbkC6+Pmyg5nYJSg1TvMIzCoGmIqRhBUhg=;
 b=fE0W4KpgFUa1ZLfiwtQuIM7sSpNixgEadvB5bj0j1vL9AGGK2doTLUyDsBU0e1t2g+ZjE+
 OYQJ4xYvSLuMmmBZxnNXoK/y6/JsWG3LU7dISWuscdnJ/u/5VM94Bz+QhxixbNTu6k6W4c
 JYc7+4BsWIW6W4+E/6u6hPDKYfWzxFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-yz-aZrecM7OF0Y-10FIcZA-1; Fri, 29 May 2020 09:45:33 -0400
X-MC-Unique: yz-aZrecM7OF0Y-10FIcZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A6B107ACCA;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D597768DE;
 Fri, 29 May 2020 13:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58639113522C; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/58] qom: Less verbose object_initialize_child()
Date: Fri, 29 May 2020 15:45:01 +0200
Message-Id: <20200529134523.8477-37-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users of object_initialize_child() pass the obvious child size
argument.  Almost all pass &error_abort and no properties.  Tiresome.

Rename object_initialize_child() to
object_initialize_child_with_props() to free the name.  New
convenience wrapper object_initialize_child() automates the size
argument, and passes &error_abort and no properties.

Rename object_initialize_childv() to
object_initialize_child_with_propsv() for consistency.

Convert callers with this Coccinelle script:

    @@
    expression parent, propname, type;
    expression child, size;
    symbol error_abort;
    @@
    -    object_initialize_child(parent, propname, OBJECT(child), size, type, &error_abort, NULL)
    +    object_initialize_child(parent, propname, child, size, type, &error_abort, NULL)

    @@
    expression parent, propname, type;
    expression child;
    symbol error_abort;
    @@
    -    object_initialize_child(parent, propname, child, sizeof(*child), type, &error_abort, NULL)
    +    object_initialize_child(parent, propname, child, type)

    @@
    expression parent, propname, type;
    expression child;
    symbol error_abort;
    @@
    -    object_initialize_child(parent, propname, &child, sizeof(child), type, &error_abort, NULL)
    +    object_initialize_child(parent, propname, &child, type)

    @@
    expression parent, propname, type;
    expression child, size, err;
    expression list props;
    @@
    -    object_initialize_child(parent, propname, child, size, type, err, props)
    +    object_initialize_child_with_props(parent, propname, child, size, type, err, props)

Note that Coccinelle chokes on ARMSSE typedef vs. macro in
hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
the spatch run.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/qom/object.h            | 30 +++++++++++++++++++----
 hw/arm/allwinner-a10.c          |  5 ++--
 hw/arm/allwinner-h3.c           |  5 ++--
 hw/arm/armsse.c                 | 26 +++++++-------------
 hw/arm/aspeed.c                 |  4 +---
 hw/arm/aspeed_ast2600.c         |  4 +---
 hw/arm/aspeed_soc.c             |  4 +---
 hw/arm/bcm2836.c                |  3 +--
 hw/arm/digic.c                  |  4 +---
 hw/arm/exynos4210.c             |  3 +--
 hw/arm/fsl-imx25.c              |  4 +---
 hw/arm/fsl-imx31.c              |  4 +---
 hw/arm/fsl-imx6.c               |  5 ++--
 hw/arm/fsl-imx6ul.c             |  4 ++--
 hw/arm/fsl-imx7.c               |  5 ++--
 hw/arm/imx25_pdk.c              |  3 +--
 hw/arm/kzm.c                    |  3 +--
 hw/arm/mps2-tz.c                | 14 +++++------
 hw/arm/musca.c                  | 14 +++++------
 hw/arm/raspi.c                  |  4 ++--
 hw/arm/stm32f405_soc.c          |  6 ++---
 hw/arm/xlnx-versal.c            |  5 ++--
 hw/arm/xlnx-zcu102.c            |  3 +--
 hw/arm/xlnx-zynqmp.c            | 16 +++++--------
 hw/char/serial-isa.c            |  3 +--
 hw/char/serial-pci-multi.c      |  4 +---
 hw/char/serial-pci.c            |  3 +--
 hw/char/serial.c                |  6 ++---
 hw/core/sysbus.c                |  4 ++--
 hw/dma/xilinx_axidma.c          |  9 +++----
 hw/intc/pnv_xive.c              |  6 ++---
 hw/intc/spapr_xive.c            |  6 ++---
 hw/microblaze/xlnx-zynqmp-pmu.c |  7 +++---
 hw/misc/macio/macio.c           | 10 ++++----
 hw/net/xilinx_axienet.c         |  9 +++----
 hw/pci-host/designware.c        |  3 +--
 hw/pci-host/gpex.c              |  3 +--
 hw/pci-host/pnv_phb3.c          | 12 ++++------
 hw/pci-host/pnv_phb4.c          |  6 ++---
 hw/pci-host/pnv_phb4_pec.c      |  6 ++---
 hw/pci-host/q35.c               |  3 +--
 hw/pci-host/xilinx-pcie.c       |  3 +--
 hw/ppc/pnv.c                    | 42 ++++++++++++---------------------
 hw/ppc/pnv_psi.c                |  6 ++---
 hw/ppc/spapr.c                  |  6 ++---
 hw/riscv/riscv_hart.c           |  4 +---
 hw/riscv/sifive_e.c             |  4 +---
 hw/riscv/sifive_u.c             | 12 +++-------
 hw/virtio/virtio.c              |  5 ++--
 qom/object.c                    | 19 +++++++++++----
 50 files changed, 160 insertions(+), 219 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index b3eb05d65d..9ce6c9c460 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -783,7 +783,7 @@ int object_set_propv(Object *obj,
 void object_initialize(void *obj, size_t size, const char *typename);
 
 /**
- * object_initialize_child:
+ * object_initialize_child_with_props:
  * @parentobj: The parent object to add a property to
  * @propname: The name of the property
  * @childobj: A pointer to the memory to be used for the object.
@@ -803,12 +803,13 @@ void object_initialize(void *obj, size_t size, const char *typename);
  * If the object implements the user creatable interface, the object will
  * be marked complete once all the properties have been processed.
  */
-void object_initialize_child(Object *parentobj, const char *propname,
+void object_initialize_child_with_props(Object *parentobj,
+                             const char *propname,
                              void *childobj, size_t size, const char *type,
                              Error **errp, ...) QEMU_SENTINEL;
 
 /**
- * object_initialize_childv:
+ * object_initialize_child_with_propsv:
  * @parentobj: The parent object to add a property to
  * @propname: The name of the property
  * @childobj: A pointer to the memory to be used for the object.
@@ -819,10 +820,31 @@ void object_initialize_child(Object *parentobj, const char *propname,
  *
  * See object_initialize_child() for documentation.
  */
-void object_initialize_childv(Object *parentobj, const char *propname,
+void object_initialize_child_with_propsv(Object *parentobj,
+                              const char *propname,
                               void *childobj, size_t size, const char *type,
                               Error **errp, va_list vargs);
 
+/**
+ * object_initialize_child:
+ * @parent: The parent object to add a property to
+ * @propname: The name of the property
+ * @child: A precisely typed pointer to the memory to be used for the
+ * object.
+ * @type: The name of the type of the object to instantiate.
+ *
+ * This is like
+ * object_initialize_child_with_props(parent, propname,
+ *                                    child, sizeof(*child), type,
+ *                                    &error_abort, NULL)
+ */
+#define object_initialize_child(parent, propname, child, type)          \
+    object_initialize_child_internal((parent), (propname),              \
+                                     (child), sizeof(*(child)), (type))
+void object_initialize_child_internal(Object *parent, const char *propname,
+                                      void *child, size_t size,
+                                      const char *type);
+
 /**
  * object_dynamic_cast:
  * @obj: The object to cast.
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 6e1329a4a2..49c51463e1 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -41,9 +41,8 @@ static void aw_a10_init(Object *obj)
 {
     AwA10State *s = AW_A10(obj);
 
-    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            ARM_CPU_TYPE_NAME("cortex-a8"),
-                            &error_abort, NULL);
+    object_initialize_child(obj, "cpu", &s->cpu,
+                            ARM_CPU_TYPE_NAME("cortex-a8"));
 
     sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
                           TYPE_AW_A10_PIC);
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index f10674da5a..7dc3671155 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -194,9 +194,8 @@ static void allwinner_h3_init(Object *obj)
     s->memmap = allwinner_h3_memmap;
 
     for (int i = 0; i < AW_H3_NUM_CPUS; i++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpus[i], sizeof(s->cpus[i]),
-                                ARM_CPU_TYPE_NAME("cortex-a7"),
-                                &error_abort, NULL);
+        object_initialize_child(obj, "cpu[*]", &s->cpus[i],
+                                ARM_CPU_TYPE_NAME("cortex-a7"));
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index c1953a41b3..20bedbe044 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -252,9 +252,7 @@ static void armsse_init(Object *obj)
         char *name;
 
         name = g_strdup_printf("cluster%d", i);
-        object_initialize_child(obj, name, &s->cluster[i],
-                                sizeof(s->cluster[i]), TYPE_CPU_CLUSTER,
-                                &error_abort, NULL);
+        object_initialize_child(obj, name, &s->cluster[i], TYPE_CPU_CLUSTER);
         qdev_prop_set_uint32(DEVICE(&s->cluster[i]), "cluster-id", i);
         g_free(name);
 
@@ -288,15 +286,13 @@ static void armsse_init(Object *obj)
         g_free(name);
     }
     object_initialize_child(obj, "mpc-irq-orgate", &s->mpc_irq_orgate,
-                            sizeof(s->mpc_irq_orgate), TYPE_OR_IRQ,
-                            &error_abort, NULL);
+                            TYPE_OR_IRQ);
 
     for (i = 0; i < IOTS_NUM_EXP_MPC + info->sram_banks; i++) {
         char *name = g_strdup_printf("mpc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
 
-        object_initialize_child(obj, name, splitter, sizeof(*splitter),
-                                TYPE_SPLIT_IRQ, &error_abort, NULL);
+        object_initialize_child(obj, name, splitter, TYPE_SPLIT_IRQ);
         g_free(name);
     }
     sysbus_init_child_obj(obj, "timer0", &s->timer0, sizeof(s->timer0),
@@ -376,21 +372,16 @@ static void armsse_init(Object *obj)
             g_free(name);
         }
     }
-    object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
-                            sizeof(s->nmi_orgate), TYPE_OR_IRQ,
-                            &error_abort, NULL);
+    object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate, TYPE_OR_IRQ);
     object_initialize_child(obj, "ppc-irq-orgate", &s->ppc_irq_orgate,
-                            sizeof(s->ppc_irq_orgate), TYPE_OR_IRQ,
-                            &error_abort, NULL);
+                            TYPE_OR_IRQ);
     object_initialize_child(obj, "sec-resp-splitter", &s->sec_resp_splitter,
-                            sizeof(s->sec_resp_splitter), TYPE_SPLIT_IRQ,
-                            &error_abort, NULL);
+                            TYPE_SPLIT_IRQ);
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         char *name = g_strdup_printf("ppc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->ppc_irq_splitter[i];
 
-        object_initialize_child(obj, name, splitter, sizeof(*splitter),
-                                TYPE_SPLIT_IRQ, &error_abort, NULL);
+        object_initialize_child(obj, name, splitter, TYPE_SPLIT_IRQ);
         g_free(name);
     }
     if (info->num_cpus > 1) {
@@ -399,8 +390,7 @@ static void armsse_init(Object *obj)
                 char *name = g_strdup_printf("cpu-irq-splitter%d", i);
                 SplitIRQ *splitter = &s->cpu_irq_splitter[i];
 
-                object_initialize_child(obj, name, splitter, sizeof(*splitter),
-                                        TYPE_SPLIT_IRQ, &error_abort, NULL);
+                object_initialize_child(obj, name, splitter, TYPE_SPLIT_IRQ);
                 g_free(name);
             }
         }
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 296057b1ab..c548d24621 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -267,9 +267,7 @@ static void aspeed_machine_init(MachineState *machine)
                        UINT32_MAX);
     memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
 
-    object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
-                            sizeof(bmc->soc), amc->soc_name, &error_abort,
-                            NULL);
+    object_initialize_child(OBJECT(machine), "soc", &bmc->soc, amc->soc_name);
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b912d19f80..beb688fd8f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -127,9 +127,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
-                                sizeof(s->cpu[i]), sc->cpu_type,
-                                &error_abort, NULL);
+        object_initialize_child(obj, "cpu[*]", &s->cpu[i], sc->cpu_type);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 3ec1257c14..18d1763aba 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -142,9 +142,7 @@ static void aspeed_soc_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
-                                sizeof(s->cpu[i]), sc->cpu_type,
-                                &error_abort, NULL);
+        object_initialize_child(obj, "cpu[*]", &s->cpu[i], sc->cpu_type);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index e51b4e0c43..82cd1d2df8 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -53,8 +53,7 @@ static void bcm2836_init(Object *obj)
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
-                                sizeof(s->cpu[n].core), info->cpu_type,
-                                &error_abort, NULL);
+                                info->cpu_type);
     }
 
     sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 22434a65a2..6153d5f108 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -36,9 +36,7 @@ static void digic_init(Object *obj)
     DigicState *s = DIGIC(obj);
     int i;
 
-    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            ARM_CPU_TYPE_NAME("arm946"),
-                            &error_abort, NULL);
+    object_initialize_child(obj, "cpu", &s->cpu, ARM_CPU_TYPE_NAME("arm946"));
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
 #define DIGIC_TIMER_NAME_MLEN    11
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 9ff1a11f80..86cbd63857 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -482,8 +482,7 @@ static void exynos4210_init(Object *obj)
         char *name = g_strdup_printf("pl330-irq-orgate%d", i);
         qemu_or_irq *orgate = &s->pl330_irq_orgate[i];
 
-        object_initialize_child(obj, name, orgate, sizeof(*orgate),
-                                TYPE_OR_IRQ, &error_abort, NULL);
+        object_initialize_child(obj, name, orgate, TYPE_OR_IRQ);
         g_free(name);
     }
 }
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index cdaa79c26b..d8340e3527 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -38,9 +38,7 @@ static void fsl_imx25_init(Object *obj)
     FslIMX25State *s = FSL_IMX25(obj);
     int i;
 
-    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            ARM_CPU_TYPE_NAME("arm926"),
-                            &error_abort, NULL);
+    object_initialize_child(obj, "cpu", &s->cpu, ARM_CPU_TYPE_NAME("arm926"));
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 1e7959863d..54eec89701 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -33,9 +33,7 @@ static void fsl_imx31_init(Object *obj)
     FslIMX31State *s = FSL_IMX31(obj);
     int i;
 
-    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            ARM_CPU_TYPE_NAME("arm1136"),
-                            &error_abort, NULL);
+    object_initialize_child(obj, "cpu", &s->cpu, ARM_CPU_TYPE_NAME("arm1136"));
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f58c85aa8c..88fbba84a4 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -43,9 +43,8 @@ static void fsl_imx6_init(Object *obj)
 
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                ARM_CPU_TYPE_NAME("cortex-a9"),
-                                &error_abort, NULL);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a9"));
     }
 
     sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 3ecb212da6..491f1b7f73 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -34,8 +34,8 @@ static void fsl_imx6ul_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    object_initialize_child(obj, "cpu0", &s->cpu, sizeof(s->cpu),
-                            ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort, NULL);
+    object_initialize_child(obj, "cpu0", &s->cpu,
+                            ARM_CPU_TYPE_NAME("cortex-a7"));
 
     /*
      * A7MPCORE
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 89c3b64c06..5cf2b7a808 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -38,9 +38,8 @@ static void fsl_imx7_init(Object *obj)
 
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort,
-                                NULL);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a7"));
     }
 
     /*
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 75076f2ea4..69b95711e4 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -73,8 +73,7 @@ static void imx25_pdk_init(MachineState *machine)
     unsigned int alias_offset;
     int i;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_FSL_IMX25, &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
 
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 34f6bcb491..0275d63079 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -71,8 +71,7 @@ static void kzm_init(MachineState *machine)
     unsigned int alias_offset;
     unsigned int i;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_FSL_IMX31, &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX31);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07d11e439f..8a050228d0 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -414,9 +414,10 @@ static void mps2tz_common_init(MachineState *machine)
             char *name = g_strdup_printf("mps2-irq-splitter%d", i);
             SplitIRQ *splitter = &mms->cpu_irq_splitter[i];
 
-            object_initialize_child(OBJECT(machine), name,
-                                    splitter, sizeof(*splitter),
-                                    TYPE_SPLIT_IRQ, &error_fatal, NULL);
+            object_initialize_child_with_props(OBJECT(machine), name,
+                                               splitter, sizeof(*splitter),
+                                               TYPE_SPLIT_IRQ, &error_fatal,
+                                               NULL);
             g_free(name);
 
             object_property_set_int(OBJECT(splitter), 2, "num-lines",
@@ -436,9 +437,7 @@ static void mps2tz_common_init(MachineState *machine)
      * lines, one for each of the PPCs we create here, plus one per MSC.
      */
     object_initialize_child(OBJECT(machine), "sec-resp-splitter",
-                            &mms->sec_resp_splitter,
-                            sizeof(mms->sec_resp_splitter),
-                            TYPE_SPLIT_IRQ, &error_abort, NULL);
+                            &mms->sec_resp_splitter, TYPE_SPLIT_IRQ);
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc) + ARRAY_SIZE(mms->msc),
                             "num-lines", &error_fatal);
@@ -472,8 +471,7 @@ static void mps2tz_common_init(MachineState *machine)
      * Create the OR gate for this.
      */
     object_initialize_child(OBJECT(mms), "uart-irq-orgate",
-                            &mms->uart_irq_orgate, sizeof(mms->uart_irq_orgate),
-                            TYPE_OR_IRQ, &error_abort, NULL);
+                            &mms->uart_irq_orgate, TYPE_OR_IRQ);
     object_property_set_int(OBJECT(&mms->uart_irq_orgate), 10, "num-lines",
                             &error_fatal);
     object_property_set_bool(OBJECT(&mms->uart_irq_orgate), true,
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index ba99dd1941..cd7df7c191 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -404,9 +404,9 @@ static void musca_init(MachineState *machine)
         char *name = g_strdup_printf("musca-irq-splitter%d", i);
         SplitIRQ *splitter = &mms->cpu_irq_splitter[i];
 
-        object_initialize_child(OBJECT(machine), name,
-                                splitter, sizeof(*splitter),
-                                TYPE_SPLIT_IRQ, &error_fatal, NULL);
+        object_initialize_child_with_props(OBJECT(machine), name, splitter,
+                                           sizeof(*splitter), TYPE_SPLIT_IRQ,
+                                           &error_fatal, NULL);
         g_free(name);
 
         object_property_set_int(OBJECT(splitter), 2, "num-lines",
@@ -424,10 +424,10 @@ static void musca_init(MachineState *machine)
      * The sec_resp_cfg output from the SSE-200 must be split into multiple
      * lines, one for each of the PPCs we create here.
      */
-    object_initialize_child(OBJECT(machine), "sec-resp-splitter",
-                            &mms->sec_resp_splitter,
-                            sizeof(mms->sec_resp_splitter),
-                            TYPE_SPLIT_IRQ, &error_fatal, NULL);
+    object_initialize_child_with_props(OBJECT(machine), "sec-resp-splitter",
+                                       &mms->sec_resp_splitter,
+                                       sizeof(mms->sec_resp_splitter),
+                                       TYPE_SPLIT_IRQ, &error_fatal, NULL);
 
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc), "num-lines", &error_fatal);
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a8e26a70bb..78cb995251 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -282,8 +282,8 @@ static void raspi_machine_init(MachineState *machine)
                                         machine->ram, 0);
 
     /* Setup the SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            board_soc_type(board_rev), &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            board_soc_type(board_rev));
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine->ram));
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index c9a530eecf..33a83bd1d4 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -169,9 +169,9 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* ADC device, the IRQs are ORed together */
-    object_initialize_child(OBJECT(s), "adc-orirq", &s->adc_irqs,
-                            sizeof(s->adc_irqs), TYPE_OR_IRQ,
-                            &err, NULL);
+    object_initialize_child_with_props(OBJECT(s), "adc-orirq", &s->adc_irqs,
+                                       sizeof(s->adc_irqs), TYPE_OR_IRQ, &err,
+                                       NULL);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c3d47bb9e9..12e4469cf4 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -32,9 +32,8 @@ static void versal_create_apu_cpus(Versal *s)
     for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
         Object *obj;
 
-        object_initialize_child(OBJECT(s), "apu-cpu[*]",
-                                &s->fpd.apu.cpu[i], sizeof(s->fpd.apu.cpu[i]),
-                                XLNX_VERSAL_ACPU_TYPE, &error_abort, NULL);
+        object_initialize_child(OBJECT(s), "apu-cpu[*]", &s->fpd.apu.cpu[i],
+                                XLNX_VERSAL_ACPU_TYPE);
         obj = OBJECT(&s->fpd.apu.cpu[i]);
         object_property_set_int(obj, s->cfg.psci_conduit,
                                 "psci-conduit", &error_abort);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 77c84b82ab..822e24af65 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -116,8 +116,7 @@ static void xlnx_zcu102_init(MachineState *machine)
                  ram_size);
     }
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_XLNX_ZYNQMP, &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_XLNX_ZYNQMP);
 
     object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                          "ddr-ram", &error_abort);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index f08abf60d7..890139d6a2 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -187,17 +187,15 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
     }
 
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
-                            sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
-                            &error_abort, NULL);
+                            TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
 
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
         object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
-                                &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                                ARM_CPU_TYPE_NAME("cortex-r5f"),
-                                &error_abort, NULL);
+                                &s->rpu_cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-r5f"));
 
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
@@ -230,15 +228,13 @@ static void xlnx_zynqmp_init(Object *obj)
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
-                            sizeof(s->apu_cluster), TYPE_CPU_CLUSTER,
-                            &error_abort, NULL);
+                            TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
 
     for (i = 0; i < num_apus; i++) {
         object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
-                                &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
-                                ARM_CPU_TYPE_NAME("cortex-a53"),
-                                &error_abort, NULL);
+                                &s->apu_cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index f13dd98c60..7630a874a8 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -114,8 +114,7 @@ static void serial_isa_initfn(Object *o)
 {
     ISASerialState *self = ISA_SERIAL(o);
 
-    object_initialize_child(o, "serial", &self->state, sizeof(self->state),
-                            TYPE_SERIAL, &error_abort, NULL);
+    object_initialize_child(o, "serial", &self->state, TYPE_SERIAL);
 }
 
 static const TypeInfo serial_isa_info = {
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 23d0ebe2cd..1d65d64c4e 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -187,9 +187,7 @@ static void multi_serial_init(Object *o)
     size_t i, nports = multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(dev));
 
     for (i = 0; i < nports; i++) {
-        object_initialize_child(o, "serial[*]", &pms->state[i],
-                                sizeof(pms->state[i]),
-                                TYPE_SERIAL, &error_abort, NULL);
+        object_initialize_child(o, "serial[*]", &pms->state[i], TYPE_SERIAL);
     }
 }
 
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 65eacfae0e..5f5ff10a75 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -108,8 +108,7 @@ static void serial_pci_init(Object *o)
 {
     PCISerialState *ps = PCI_SERIAL(o);
 
-    object_initialize_child(o, "serial", &ps->state, sizeof(ps->state),
-                            TYPE_SERIAL, &error_abort, NULL);
+    object_initialize_child(o, "serial", &ps->state, TYPE_SERIAL);
 }
 
 static const TypeInfo serial_pci_info = {
diff --git a/hw/char/serial.c b/hw/char/serial.c
index a0cab38fb0..57c299e993 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1014,8 +1014,7 @@ static void serial_io_instance_init(Object *o)
 {
     SerialIO *sio = SERIAL_IO(o);
 
-    object_initialize_child(o, "serial", &sio->serial, sizeof(sio->serial),
-                            TYPE_SERIAL, &error_abort, NULL);
+    object_initialize_child(o, "serial", &sio->serial, TYPE_SERIAL);
 
     qdev_alias_all_properties(DEVICE(&sio->serial), o);
 }
@@ -1148,8 +1147,7 @@ static void serial_mm_instance_init(Object *o)
 {
     SerialMM *smm = SERIAL_MM(o);
 
-    object_initialize_child(o, "serial", &smm->serial, sizeof(smm->serial),
-                            TYPE_SERIAL, &error_abort, NULL);
+    object_initialize_child(o, "serial", &smm->serial, TYPE_SERIAL);
 
     qdev_alias_all_properties(DEVICE(&smm->serial), o);
 }
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 7ff1b5f2de..e8d08d349b 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -348,8 +348,8 @@ BusState *sysbus_get_default(void)
 void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
                            size_t childsize, const char *childtype)
 {
-    object_initialize_child(parent, childname, child, childsize, childtype,
-                            &error_abort, NULL);
+    object_initialize_child_with_props(parent, childname, child, childsize,
+                                       childtype, &error_abort, NULL);
     qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
 }
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 460102b142..6a9df2c4db 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -579,13 +579,10 @@ static void xilinx_axidma_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     object_initialize_child(OBJECT(s), "axistream-connected-target",
-                            &s->rx_data_dev, sizeof(s->rx_data_dev),
-                            TYPE_XILINX_AXI_DMA_DATA_STREAM, &error_abort,
-                            NULL);
+                            &s->rx_data_dev, TYPE_XILINX_AXI_DMA_DATA_STREAM);
     object_initialize_child(OBJECT(s), "axistream-control-connected-target",
-                            &s->rx_control_dev, sizeof(s->rx_control_dev),
-                            TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
-                            NULL);
+                            &s->rx_control_dev,
+                            TYPE_XILINX_AXI_DMA_CONTROL_STREAM);
     object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
                              (Object **)&s->dma_mr,
                              qdev_prop_allow_set_link_before_realize,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index aeda488bd1..892c78069d 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1796,11 +1796,9 @@ static void pnv_xive_init(Object *obj)
     PnvXive *xive = PNV_XIVE(obj);
 
     object_initialize_child(obj, "ipi_source", &xive->ipi_source,
-                            sizeof(xive->ipi_source), TYPE_XIVE_SOURCE,
-                            &error_abort, NULL);
+                            TYPE_XIVE_SOURCE);
     object_initialize_child(obj, "end_source", &xive->end_source,
-                            sizeof(xive->end_source), TYPE_XIVE_END_SOURCE,
-                            &error_abort, NULL);
+                            TYPE_XIVE_END_SOURCE);
 }
 
 /*
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 6608d7220a..263cd1253c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -272,12 +272,10 @@ static void spapr_xive_instance_init(Object *obj)
 {
     SpaprXive *xive = SPAPR_XIVE(obj);
 
-    object_initialize_child(obj, "source", &xive->source, sizeof(xive->source),
-                            TYPE_XIVE_SOURCE, &error_abort, NULL);
+    object_initialize_child(obj, "source", &xive->source, TYPE_XIVE_SOURCE);
 
     object_initialize_child(obj, "end_source", &xive->end_source,
-                            sizeof(xive->end_source), TYPE_XIVE_END_SOURCE,
-                            &error_abort, NULL);
+                            TYPE_XIVE_END_SOURCE);
 
     /* Not connected to the KVM XIVE device */
     xive->fd = -1;
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index aa90b9d1be..bd56eccd66 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -61,8 +61,7 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
 
-    object_initialize_child(obj, "pmu-cpu", &s->cpu, sizeof(s->cpu),
-                            TYPE_MICROBLAZE_CPU, &error_abort, NULL);
+    object_initialize_child(obj, "pmu-cpu", &s->cpu, TYPE_MICROBLAZE_CPU);
 
     sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
                           TYPE_XLNX_PMU_IO_INTC);
@@ -174,8 +173,8 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                                 pmu_ram);
 
     /* Create the PMU device */
-    object_initialize_child(OBJECT(machine), "pmu", pmu, sizeof(*pmu),
-                            TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "pmu", pmu,
+                            TYPE_XLNX_ZYNQMP_PMU_SOC);
     object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
 
     /* Load the kernel */
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 216bdc69c0..a2698e4a20 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -98,8 +98,8 @@ static void macio_init_child_obj(MacIOState *s, const char *childname,
                                  void *child, size_t childsize,
                                  const char *childtype)
 {
-    object_initialize_child(OBJECT(s), childname, child, childsize, childtype,
-                            &error_abort, NULL);
+    object_initialize_child_with_props(OBJECT(s), childname, child, childsize,
+                                       childtype, &error_abort, NULL);
     qdev_set_parent_bus(DEVICE(child), BUS(&s->macio_bus));
 }
 
@@ -351,8 +351,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
 
         /* PMU */
-        object_initialize_child(OBJECT(s), "pmu", &s->pmu, sizeof(s->pmu),
-                                TYPE_VIA_PMU, &error_abort, NULL);
+        object_initialize_child(OBJECT(s), "pmu", &s->pmu, TYPE_VIA_PMU);
         object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
@@ -370,8 +369,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_unparent(OBJECT(&ns->gpio));
 
         /* CUDA */
-        object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->cuda),
-                                TYPE_CUDA, &error_abort, NULL);
+        object_initialize_child(OBJECT(s), "cuda", &s->cuda, TYPE_CUDA);
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
 
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 44fe04d889..c2f40b8ea9 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1020,13 +1020,10 @@ static void xilinx_enet_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     object_initialize_child(OBJECT(s), "axistream-connected-target",
-                            &s->rx_data_dev, sizeof(s->rx_data_dev),
-                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abort,
-                            NULL);
+                            &s->rx_data_dev, TYPE_XILINX_AXI_ENET_DATA_STREAM);
     object_initialize_child(OBJECT(s), "axistream-control-connected-target",
-                            &s->rx_control_dev, sizeof(s->rx_control_dev),
-                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM, &error_abort,
-                            NULL);
+                            &s->rx_control_dev,
+                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM);
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &enet_ops, s, "enet", 0x40000);
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 2e97d6b17f..8492c18991 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -722,8 +722,7 @@ static void designware_pcie_host_init(Object *obj)
     DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
     DesignwarePCIERoot *root = &s->root;
 
-    object_initialize_child(obj, "root",  root, sizeof(*root),
-                            TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NULL);
+    object_initialize_child(obj, "root", root, TYPE_DESIGNWARE_PCIE_ROOT);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 3dfb3bf599..2bdbe7b456 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -124,8 +124,7 @@ static void gpex_host_initfn(Object *obj)
     GPEXHost *s = GPEX_HOST(obj);
     GPEXRootState *root = &s->gpex_root;
 
-    object_initialize_child(obj, "gpex_root",  root, sizeof(*root),
-                            TYPE_GPEX_ROOT_DEVICE, &error_abort, NULL);
+    object_initialize_child(obj, "gpex_root", root, TYPE_GPEX_ROOT_DEVICE);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 8dcfe4a2fd..6e2b0174f6 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -968,23 +968,19 @@ static void pnv_phb3_instance_init(Object *obj)
     QLIST_INIT(&phb->dma_spaces);
 
     /* LSI sources */
-    object_initialize_child(obj, "lsi", &phb->lsis, sizeof(phb->lsis),
-                             TYPE_ICS, &error_abort, NULL);
+    object_initialize_child(obj, "lsi", &phb->lsis, TYPE_ICS);
 
     /* Default init ... will be fixed by HW inits */
     phb->lsis.offset = 0;
 
     /* MSI sources */
-    object_initialize_child(obj, "msi", &phb->msis, sizeof(phb->msis),
-                            TYPE_PHB3_MSI, &error_abort, NULL);
+    object_initialize_child(obj, "msi", &phb->msis, TYPE_PHB3_MSI);
 
     /* Power Bus Common Queue */
-    object_initialize_child(obj, "pbcq", &phb->pbcq, sizeof(phb->pbcq),
-                            TYPE_PNV_PBCQ, &error_abort, NULL);
+    object_initialize_child(obj, "pbcq", &phb->pbcq, TYPE_PNV_PBCQ);
 
     /* Root Port */
-    object_initialize_child(obj, "root", &phb->root, sizeof(phb->root),
-                            TYPE_PNV_PHB3_ROOT_PORT, &error_abort, NULL);
+    object_initialize_child(obj, "root", &phb->root, TYPE_PNV_PHB3_ROOT_PORT);
     qdev_prop_set_int32(DEVICE(&phb->root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&phb->root), "multifunction", false);
 }
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index aba710fd1f..368ae9eacd 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1155,12 +1155,10 @@ static void pnv_phb4_instance_init(Object *obj)
     QLIST_INIT(&phb->dma_spaces);
 
     /* XIVE interrupt source object */
-    object_initialize_child(obj, "source", &phb->xsrc, sizeof(phb->xsrc),
-                            TYPE_XIVE_SOURCE, &error_abort, NULL);
+    object_initialize_child(obj, "source", &phb->xsrc, TYPE_XIVE_SOURCE);
 
     /* Root Port */
-    object_initialize_child(obj, "root", &phb->root, sizeof(phb->root),
-                            TYPE_PNV_PHB4_ROOT_PORT, &error_abort, NULL);
+    object_initialize_child(obj, "root", &phb->root, TYPE_PNV_PHB4_ROOT_PORT);
 
     qdev_prop_set_int32(DEVICE(&phb->root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&phb->root), "multifunction", false);
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 565345a018..f9b41c5042 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -370,8 +370,7 @@ static void pnv_pec_instance_init(Object *obj)
 
     for (i = 0; i < PHB4_PEC_MAX_STACKS; i++) {
         object_initialize_child(obj, "stack[*]", &pec->stacks[i],
-                                sizeof(pec->stacks[i]), TYPE_PNV_PHB4_PEC_STACK,
-                                &error_abort, NULL);
+                                TYPE_PNV_PHB4_PEC_STACK);
     }
 }
 
@@ -522,8 +521,7 @@ static void pnv_pec_stk_instance_init(Object *obj)
 {
     PnvPhb4PecStack *stack = PNV_PHB4_PEC_STACK(obj);
 
-    object_initialize_child(obj, "phb", &stack->phb, sizeof(stack->phb),
-                            TYPE_PNV_PHB4, &error_abort, NULL);
+    object_initialize_child(obj, "phb", &stack->phb, TYPE_PNV_PHB4);
 }
 
 static void pnv_pec_stk_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 8d526457f4..d6028543d2 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -212,8 +212,7 @@ static void q35_host_initfn(Object *obj)
     memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
                           "pci-conf-data", 4);
 
-    object_initialize_child(OBJECT(s), "mch",  &s->mch, sizeof(s->mch),
-                            TYPE_MCH_PCI_DEVICE, &error_abort, NULL);
+    object_initialize_child(OBJECT(s), "mch", &s->mch, TYPE_MCH_PCI_DEVICE);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
     /* mch's object_initialize resets the default value, set it again */
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index e4fc8abb6a..3b321421b6 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -151,8 +151,7 @@ static void xilinx_pcie_host_init(Object *obj)
     XilinxPCIEHost *s = XILINX_PCIE_HOST(obj);
     XilinxPCIERoot *root = &s->root;
 
-    object_initialize_child(obj, "root",  root, sizeof(*root),
-                            TYPE_XILINX_PCIE_ROOT, &error_abort, NULL);
+    object_initialize_child(obj, "root", root, TYPE_XILINX_PCIE_ROOT);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ffaf12b006..8cf097ae7c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1061,22 +1061,16 @@ static void pnv_chip_power8_instance_init(Object *obj)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
 
-    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
-                            TYPE_PNV8_PSI, &error_abort, NULL);
+    object_initialize_child(obj, "psi", &chip8->psi, TYPE_PNV8_PSI);
 
-    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
-                            TYPE_PNV8_LPC, &error_abort, NULL);
+    object_initialize_child(obj, "lpc", &chip8->lpc, TYPE_PNV8_LPC);
 
-    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
-                            TYPE_PNV8_OCC, &error_abort, NULL);
+    object_initialize_child(obj, "occ", &chip8->occ, TYPE_PNV8_OCC);
 
-    object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->homer),
-                            TYPE_PNV8_HOMER, &error_abort, NULL);
+    object_initialize_child(obj, "homer", &chip8->homer, TYPE_PNV8_HOMER);
 
     for (i = 0; i < pcc->num_phbs; i++) {
-        object_initialize_child(obj, "phb[*]", &chip8->phbs[i],
-                                sizeof(chip8->phbs[i]), TYPE_PNV_PHB3,
-                                &error_abort, NULL);
+        object_initialize_child(obj, "phb[*]", &chip8->phbs[i], TYPE_PNV_PHB3);
     }
 
     /*
@@ -1320,22 +1314,17 @@ static void pnv_chip_power9_instance_init(Object *obj)
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
                               "xive-fabric");
 
-    object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi),
-                            TYPE_PNV9_PSI, &error_abort, NULL);
+    object_initialize_child(obj, "psi", &chip9->psi, TYPE_PNV9_PSI);
 
-    object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc),
-                            TYPE_PNV9_LPC, &error_abort, NULL);
+    object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
-    object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ),
-                            TYPE_PNV9_OCC, &error_abort, NULL);
+    object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
-    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->homer),
-                            TYPE_PNV9_HOMER, &error_abort, NULL);
+    object_initialize_child(obj, "homer", &chip9->homer, TYPE_PNV9_HOMER);
 
     for (i = 0; i < PNV9_CHIP_MAX_PEC; i++) {
         object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
-                                sizeof(chip9->pecs[i]), TYPE_PNV_PHB4_PEC,
-                                &error_abort, NULL);
+                                TYPE_PNV_PHB4_PEC);
     }
 
     /*
@@ -1359,8 +1348,9 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
         int core_id = CPU_CORE(pnv_core)->core_id;
 
         snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
-        object_initialize_child(OBJECT(chip), eq_name, eq, sizeof(*eq),
-                                TYPE_PNV_QUAD, &error_fatal, NULL);
+        object_initialize_child_with_props(OBJECT(chip), eq_name, eq,
+                                           sizeof(*eq), TYPE_PNV_QUAD,
+                                           &error_fatal, NULL);
 
         object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
         object_property_set_bool(OBJECT(eq), true, "realized", &error_fatal);
@@ -1586,10 +1576,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(obj);
 
-    object_initialize_child(obj, "psi",  &chip10->psi, sizeof(chip10->psi),
-                            TYPE_PNV10_PSI, &error_abort, NULL);
-    object_initialize_child(obj, "lpc",  &chip10->lpc, sizeof(chip10->lpc),
-                            TYPE_PNV10_LPC, &error_abort, NULL);
+    object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
+    object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
 }
 
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 82f0769465..20e54ad5ac 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -483,8 +483,7 @@ static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 = PNV8_PSI(obj);
 
-    object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ics),
-                            TYPE_ICS, &error_abort, NULL);
+    object_initialize_child(obj, "ics-psi", &psi8->ics, TYPE_ICS);
     object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
                               ICS_PROP_XICS);
 }
@@ -836,8 +835,7 @@ static void pnv_psi_power9_instance_init(Object *obj)
 {
     Pnv9Psi *psi = PNV9_PSI(obj);
 
-    object_initialize_child(obj, "source", &psi->source, sizeof(psi->source),
-                            TYPE_XIVE_SOURCE, &error_abort, NULL);
+    object_initialize_child(obj, "source", &psi->source, TYPE_XIVE_SOURCE);
 }
 
 static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1228aeb4b0..7ef24ea2a1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1727,9 +1727,9 @@ static void spapr_create_nvram(SpaprMachineState *spapr)
 
 static void spapr_rtc_create(SpaprMachineState *spapr)
 {
-    object_initialize_child(OBJECT(spapr), "rtc",
-                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC,
-                            &error_fatal, NULL);
+    object_initialize_child_with_props(OBJECT(spapr), "rtc", &spapr->rtc,
+                                       sizeof(spapr->rtc), TYPE_SPAPR_RTC,
+                                       &error_fatal, NULL);
     object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
                               &error_fatal);
     object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->rtc),
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 61e88e2e37..56c2be5312 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -45,9 +45,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
 {
     Error *err = NULL;
 
-    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
-                            sizeof(s->harts[idx]), cpu_type,
-                            &error_abort, NULL);
+    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     object_property_set_bool(OBJECT(&s->harts[idx]), true,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8831e6728e..0369cb5d53 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -85,9 +85,7 @@ static void riscv_sifive_e_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
-                            sizeof(s->soc), TYPE_RISCV_E_SOC,
-                            &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_E_SOC);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index bb69fd8e48..1cecd28514 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -328,9 +328,7 @@ static void sifive_u_machine_init(MachineState *machine)
     int i;
 
     /* Initialize SoC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
-                            sizeof(s->soc), TYPE_RISCV_U_SOC,
-                            &error_abort, NULL);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
     object_property_set_uint(OBJECT(&s->soc), s->serial, "serial",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
@@ -486,9 +484,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
-    object_initialize_child(obj, "e-cluster", &s->e_cluster,
-                            sizeof(s->e_cluster), TYPE_CPU_CLUSTER,
-                            &error_abort, NULL);
+    object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
 
     sysbus_init_child_obj(OBJECT(&s->e_cluster), "e-cpus",
@@ -498,9 +494,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
 
-    object_initialize_child(obj, "u-cluster", &s->u_cluster,
-                            sizeof(s->u_cluster), TYPE_CPU_CLUSTER,
-                            &error_abort, NULL);
+    object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
     qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
 
     sysbus_init_child_obj(OBJECT(&s->u_cluster), "u-cpus",
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 850fcce5e7..cc9c9dc162 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3230,8 +3230,9 @@ void virtio_instance_init_common(Object *proxy_obj, void *data,
 {
     DeviceState *vdev = data;
 
-    object_initialize_child(proxy_obj, "virtio-backend", vdev, vdev_size,
-                            vdev_name, &error_abort, NULL);
+    object_initialize_child_with_props(proxy_obj, "virtio-backend", vdev,
+                                       vdev_size, vdev_name, &error_abort,
+                                       NULL);
     qdev_alias_all_properties(vdev, proxy_obj);
 }
 
diff --git a/qom/object.c b/qom/object.c
index c02487ec1a..41848ba7eb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -529,19 +529,21 @@ void object_initialize(void *data, size_t size, const char *typename)
     object_initialize_with_type(data, size, type);
 }
 
-void object_initialize_child(Object *parentobj, const char *propname,
+void object_initialize_child_with_props(Object *parentobj,
+                             const char *propname,
                              void *childobj, size_t size, const char *type,
                              Error **errp, ...)
 {
     va_list vargs;
 
     va_start(vargs, errp);
-    object_initialize_childv(parentobj, propname, childobj, size, type, errp,
-                             vargs);
+    object_initialize_child_with_propsv(parentobj, propname,
+                                        childobj, size, type, errp, vargs);
     va_end(vargs);
 }
 
-void object_initialize_childv(Object *parentobj, const char *propname,
+void object_initialize_child_with_propsv(Object *parentobj,
+                              const char *propname,
                               void *childobj, size_t size, const char *type,
                               Error **errp, va_list vargs)
 {
@@ -582,6 +584,15 @@ out:
     error_propagate(errp, local_err);
 }
 
+void object_initialize_child_internal(Object *parent,
+                                      const char *propname,
+                                      void *child, size_t size,
+                                      const char *type)
+{
+    object_initialize_child_with_props(parent, propname, child, size, type,
+                                       &error_abort, NULL);
+}
+
 static inline bool object_property_is_child(ObjectProperty *prop)
 {
     return strstart(prop->type, "child<", NULL);
-- 
2.21.3


