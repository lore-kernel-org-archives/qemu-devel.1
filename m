Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0B2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A2D207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKB3YyxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A2D207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgvu-0002aO-F9
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtt-00079O-Iv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtr-0004EM-Ll
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599584118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rj6tl8vJktVOIqI1vfX25IIFjgimVSwYC7WLuDLq2mA=;
 b=GKB3YyxWc4P7QDj24lb2Jb1EIdws5Oxe1X7nghNWPeBbVQxmGdat0fMkEm7ju/pdoIxuRL
 w/ryYAcIoq6P+hbs+uKiRJzLx32XGQML6UyUCjI8Jup1/bK8gunnylYI6N9onHBYMxcfK9
 vQNBqjoZbEvcwHKrAynF2ijthDzq7IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Kz7jg38ENXesN0-iMNyxNw-1; Tue, 08 Sep 2020 12:55:16 -0400
X-MC-Unique: Kz7jg38ENXesN0-iMNyxNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034D61084D63;
 Tue,  8 Sep 2020 16:55:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E101860C0F;
 Tue,  8 Sep 2020 16:55:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/smbios: use qapi for SMBIOS entry point type enum
Date: Tue,  8 Sep 2020 17:54:37 +0100
Message-Id: <20200908165438.1008942-5-berrange@redhat.com>
In-Reply-To: <20200908165438.1008942-1-berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This refactoring prepares for exposing the SMBIOS entry point type as a
machine property on x86.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c                |  2 +-
 hw/i386/pc_piix.c            |  2 +-
 hw/i386/pc_q35.c             |  2 +-
 hw/smbios/smbios.c           |  9 +++++----
 include/hw/firmware/smbios.h |  9 ++-------
 qapi/machine.json            | 12 ++++++++++++
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acf9bfbece..fd32b10f75 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1450,7 +1450,7 @@ static void virt_build_smbios(VirtMachineState *vms)
 
     smbios_set_defaults("QEMU", product,
                         vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
-                        true, SMBIOS_ENTRY_POINT_30);
+                        true, SMBIOS_ENTRY_POINT_TYPE_3_0);
 
     smbios_get_tables(MACHINE(vms), NULL, 0, &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 32b1453e6a..1c5bc6ae6e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -179,7 +179,7 @@ static void pc_init1(MachineState *machine,
         smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
-                            SMBIOS_ENTRY_POINT_21);
+                            SMBIOS_ENTRY_POINT_TYPE_2_1);
     }
 
     /* allocate ram and load rom/bios */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0cb9c18cd4..cc202407c7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -204,7 +204,7 @@ static void pc_q35_init(MachineState *machine)
         smbios_set_defaults("QEMU", "Standard PC (Q35 + ICH9, 2009)",
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
-                            SMBIOS_ENTRY_POINT_21);
+                            SMBIOS_ENTRY_POINT_TYPE_2_1);
     }
 
     /* allocate ram and load rom/bios */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3c87be6c91..c99c9b01ae 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -61,7 +61,7 @@ uint8_t *smbios_tables;
 size_t smbios_tables_len;
 unsigned smbios_table_max;
 unsigned smbios_table_cnt;
-static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_21;
+static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_2_1;
 
 static SmbiosEntryPoint ep;
 
@@ -383,7 +383,7 @@ static void smbios_validate_table(MachineState *ms)
         exit(1);
     }
 
-    if (smbios_ep_type == SMBIOS_ENTRY_POINT_21 &&
+    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_2_1 &&
         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
         error_report("SMBIOS 2.1 table length %zu exceeds %d",
                      smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
@@ -831,7 +831,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
 static void smbios_entry_point_setup(void)
 {
     switch (smbios_ep_type) {
-    case SMBIOS_ENTRY_POINT_21:
+    case SMBIOS_ENTRY_POINT_TYPE_2_1:
         memcpy(ep.ep21.anchor_string, "_SM_", 4);
         memcpy(ep.ep21.intermediate_anchor_string, "_DMI_", 5);
         ep.ep21.length = sizeof(struct smbios_21_entry_point);
@@ -854,7 +854,7 @@ static void smbios_entry_point_setup(void)
         ep.ep21.structure_table_address = cpu_to_le32(0);
 
         break;
-    case SMBIOS_ENTRY_POINT_30:
+    case SMBIOS_ENTRY_POINT_TYPE_3_0:
         memcpy(ep.ep30.anchor_string, "_SM3_", 5);
         ep.ep30.length = sizeof(struct smbios_30_entry_point);
         ep.ep30.entry_point_revision = 1;
@@ -939,6 +939,7 @@ void smbios_get_tables(MachineState *ms,
     *tables = smbios_tables;
     *tables_len = smbios_tables_len;
     *anchor = (uint8_t *)&ep;
+    g_printerr("Total len %zu\n", smbios_tables_len);
 
     /* calculate length based on anchor string */
     if (!strncmp((char *)&ep, "_SM_", 4)) {
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 02a0ced0a0..cb1299ad7a 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_SMBIOS_H
 #define QEMU_SMBIOS_H
 
+#include "qapi/qapi-types-machine.h"
+
 /*
  * SMBIOS Support
  *
@@ -23,13 +25,6 @@ struct smbios_phys_mem_area {
     uint64_t length;
 };
 
-/*
- * SMBIOS spec defined tables
- */
-typedef enum SmbiosEntryPointType {
-    SMBIOS_ENTRY_POINT_21,
-    SMBIOS_ENTRY_POINT_30,
-} SmbiosEntryPointType;
 
 /* SMBIOS Entry Point
  * There are two types of entry points defined in the SMBIOS specification
diff --git a/qapi/machine.json b/qapi/machine.json
index abc6fd0477..a58cf2694f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -937,3 +937,15 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @SmbiosEntryPointType:
+#
+# @2_1: SMBIOS version 2.1
+#
+# @3_0: SMBIOS version 3.0
+#
+# Since: 5.2
+##
+{ 'enum': 'SmbiosEntryPointType',
+  'data': [ '2_1', '3_0' ] }
-- 
2.26.2


