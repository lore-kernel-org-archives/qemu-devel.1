Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE008C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99812065E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="cbVhX6Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99812065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKvPW-0000Ov-K5
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 23:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kKvOe-0008OS-LM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:24:45 -0400
Received: from us-smtp-delivery-162.mimecast.com ([216.205.24.162]:23058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kKvOb-0000cu-Ga
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1600831479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFzubtP6NCNJ7WgIc2SLQGcneRkzxeIf1U9SqeX520w=;
 b=cbVhX6TjnC0RKKvmG+IMVnx7Gg6zWndhr2s+e4CSGhgo5gzE3bgR0TPkg3AAHIe06jlSUy
 uA1Lv9uvX4mfXLPLdt7hDQuKadc0lTHMuPDQe30WvujD03iRCzPvgWWfPdLAvP7ZrLrVWR
 YQRVWqjUQDGqcyNWx6+HshCboEgR1Ac=
Received: from g2t4623.austin.hp.com (g2t4623.austin.hp.com [15.73.212.78])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-_nxqT8YZMH-rXIDFtbIQcg-1; Tue, 22 Sep 2020 23:24:37 -0400
X-MC-Unique: _nxqT8YZMH-rXIDFtbIQcg-1
Received: from g2t4689.austin.hpicorp.net (g2t4689.austin.hpicorp.net
 [15.94.10.175])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by g2t4623.austin.hp.com (Postfix) with ESMTPS id 594431C7;
 Wed, 23 Sep 2020 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.75.17.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by g2t4689.austin.hpicorp.net (Postfix) with ESMTPS id 0ECD8143;
 Wed, 23 Sep 2020 03:24:35 +0000 (UTC)
From: Erich Mcmillan <erich.mcmillan@hp.com>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, dgilbert@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 Erich McMillan <erich.mcmillan@hp.com>
Subject: [PATCH] add maximum combined fw size as machine configuration option
Date: Wed, 23 Sep 2020 03:24:33 +0000
Message-Id: <20200923032433.3799-1-erich.mcmillan@hp.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:24:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
 hw/i386/pc.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_sysfw.c   | 13 ++----------
 include/hw/i386/pc.h |  2 ++
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d11daacc23..89775e7d5b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1869,6 +1869,49 @@ static void pc_machine_set_max_ram_below_4g(Object *=
obj, Visitor *v,
     pcms->max_ram_below_4g =3D value;
 }
=20
+static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    PCMachineState *pcms =3D PC_MACHINE(obj);
+    uint64_t value =3D pcms->max_fw_size;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
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
+    /*
+    * We don't have a theoretically justifiable exact lower bound on the b=
ase
+    * address of any flash mapping. In practice, the IO-APIC MMIO range is
+    * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving =
free
+    * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to =
8MB in
+    * size.
+    */
+    if (value > 16 * MiB) {
+        error_setg(errp,
+                   "User specified max allowed firmware size %" PRIu64 " i=
s "
+                   "greater than 16MiB. If combined firwmare size exceeds =
"
+                   "16MiB the system may not boot, or experience intermitt=
ent"
+                   "stability issues.",
+                   value);
+    }
+
+    pcms->max_fw_size =3D value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
@@ -1884,6 +1927,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled =3D true;
     pcms->sata_enabled =3D true;
     pcms->pit_enabled =3D true;
+    pcms->max_fw_size =3D 8 * MiB; /* use default */
=20
     pc_system_flash_create(pcms);
     pcms->pcspk =3D isa_new(TYPE_PC_SPEAKER);
@@ -2004,6 +2048,12 @@ static void pc_machine_class_init(ObjectClass *oc, v=
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
index b6c0822fe3..22450ba0ef 100644
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
index fe52e165b2..f7c8e7cbfe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -43,6 +43,7 @@ struct PCMachineState {
     bool smbus_enabled;
     bool sata_enabled;
     bool pit_enabled;
+    uint64_t max_fw_size;
=20
     /* NUMA information: */
     uint64_t numa_nodes;
@@ -59,6 +60,7 @@ struct PCMachineState {
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
+#define PC_MACHINE_MAX_FW_SIZE      "max-fw-size"
=20
 /**
  * PCMachineClass:
--=20
2.25.1


