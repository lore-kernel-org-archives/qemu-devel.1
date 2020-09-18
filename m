Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F80C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4322073A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="HYtFhS/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4322073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ7wt-0004Mr-Ms
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 00:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kJ7w6-0003v8-6V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:23:50 -0400
Received: from us-smtp-delivery-162.mimecast.com ([216.205.24.162]:38137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kJ7w3-00053c-D1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1600403024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkR0HmWOpPgQZzNbupknKwluQh5PzJgLUpl91aFl1Fo=;
 b=HYtFhS/8XGyiXoG7Q/HQyN0XpCWPzLKjRw3xrjPFXTcQXrJUG+tKfLc99K2P+hLWNALnzj
 KILEqNUR0y0zCITztD6ecAhciBaufBBp1seR1/0TmoNri2ZOJur86uKa1jL4DcPJuNsA7T
 goGQTOS6GB6rfKLHBRMas43BsxjZwfE=
Received: from g1t6214.austin.hp.com (g1t6214.austin.hp.com [15.73.96.122])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-iV9C2QvvM9aaacP2yYUftw-1; Fri, 18 Sep 2020 00:23:43 -0400
X-MC-Unique: iV9C2QvvM9aaacP2yYUftw-1
Received: from g1t6217.austin.hpicorp.net (g1t6217.austin.hpicorp.net
 [15.67.1.144])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by g1t6214.austin.hp.com (Postfix) with ESMTPS id 0CB2D244;
 Fri, 18 Sep 2020 04:23:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.75.29.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by g1t6217.austin.hpicorp.net (Postfix) with ESMTPS id AA455126;
 Fri, 18 Sep 2020 04:23:41 +0000 (UTC)
From: Erich Mcmillan <erich.mcmillan@hp.com>
To: lersek@redhat.com, dgilbert@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org,
	Erich McMillan <erich.mcmillan@hp.com>
Subject: [PATCH 2/2] add maximum combined fw size as machine configuration
 option
Date: Fri, 18 Sep 2020 04:23:39 +0000
Message-Id: <20200918042339.3477-1-erich.mcmillan@hp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.162;
 envelope-from=erich.mcmillan@hp.com; helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:23:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Erich McMillan <erich.mcmillan@hp.com>

Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
---
 hw/i386/pc.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_sysfw.c   | 13 ++-----------
 include/hw/i386/pc.h | 22 ++++++++++++----------
 3 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d11daac..b304988 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1869,6 +1869,39 @@ static void pc_machine_set_max_ram_below_4g(Object *=
obj, Visitor *v,
     pcms->max_ram_below_4g =3D value;
 }
=20
+static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
+                                             const char *name, void *opaqu=
e,
+                                             Error **errp)
+{
+    PCMachineState *pcms =3D PC_MACHINE(obj);
+    uint64_t value =3D pcms->max_fw_size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
+                                             const char *name, void *opaqu=
e,
+                                             Error **errp)
+{
+    PCMachineState *pcms =3D PC_MACHINE(obj);
+    Error *error =3D NULL;
+    uint64_t value;
+
+    visit_type_size(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    if (value > 16 * MiB) {
+        warn_report("User specifed max allowed firmware size %" PRIu64 " i=
s greater than 16MiB,"
+                    "if combined firwmare size exceeds 16MiB system may no=
t boot,"
+                    "or experience intermittent stability issues.", value)=
;
+    }
+
+    pcms->max_fw_size =3D value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
@@ -1884,6 +1917,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled =3D true;
     pcms->sata_enabled =3D true;
     pcms->pit_enabled =3D true;
+    pcms->max_fw_size =3D 8 * MiB;
=20
     pc_system_flash_create(pcms);
     pcms->pcspk =3D isa_new(TYPE_PC_SPEAKER);
@@ -2004,6 +2038,12 @@ static void pc_machine_class_init(ObjectClass *oc, v=
oid *data)
=20
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit);
+
+    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
+        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
+        NULL, NULL);
+    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
+        "Maximum combined firmware size");
 }
=20
 static const TypeInfo pc_machine_info =3D {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b6c0822..22450ba 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -39,15 +39,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
=20
-/*
- * We don't have a theoretically justifiable exact lower bound on the base
- * address of any flash mapping. In practice, the IO-APIC MMIO range is
- * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving fre=
e
- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
- * size.
- */
-#define FLASH_SIZE_LIMIT (8 * MiB)
-
 #define FLASH_SECTOR_SIZE 4096
=20
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
@@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
         }
         if ((hwaddr)size !=3D size
             || total_size > HWADDR_MAX - size
-            || total_size + size > FLASH_SIZE_LIMIT) {
+            || total_size + size > pcms->max_fw_size) {
             error_report("combined size of system firmware exceeds "
                          "%" PRIu64 " bytes",
-                         FLASH_SIZE_LIMIT);
+                         pcms->max_fw_size);
             exit(1);
         }
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fe52e16..cae213d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,10 +39,11 @@ struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
=20
-    bool acpi_build_enabled;
-    bool smbus_enabled;
-    bool sata_enabled;
-    bool pit_enabled;
+    bool     acpi_build_enabled;
+    bool     smbus_enabled;
+    bool     sata_enabled;
+    bool     pit_enabled;
+    uint64_t max_fw_size;
=20
     /* NUMA information: */
     uint64_t numa_nodes;
@@ -52,13 +53,14 @@ struct PCMachineState {
     hwaddr memhp_io_base;
 };
=20
-#define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
+#define PC_MACHINE_ACPI_DEVICE_PROP   "acpi-device"
+#define PC_MACHINE_MAX_RAM_BELOW_4G   "max-ram-below-4g"
 #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
-#define PC_MACHINE_VMPORT           "vmport"
-#define PC_MACHINE_SMBUS            "smbus"
-#define PC_MACHINE_SATA             "sata"
-#define PC_MACHINE_PIT              "pit"
+#define PC_MACHINE_VMPORT             "vmport"
+#define PC_MACHINE_SMBUS              "smbus"
+#define PC_MACHINE_SATA               "sata"
+#define PC_MACHINE_PIT                "pit"
+#define PC_MACHINE_MAX_FW_SIZE        "max-fw-size"
=20
 /**
  * PCMachineClass:
--=20
2.25.1


