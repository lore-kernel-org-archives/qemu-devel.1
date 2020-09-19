Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC2EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04456208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzeFPvP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04456208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfSC-0001uL-2I
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH6-0005Jp-9C
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGx-0007N6-KU
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvq4tCUVHx8qouuAoWhRcs5PTv3JFM540York1YwLMs=;
 b=bzeFPvP24uJnitdD9Gff4g3L7g5ZXU5SV+p3ka8hH/PBi3o57jis9jk6t/DuBxcfiASGFj
 lLO2t153K0jkspUe9YT2n2CboCS5cWOsb3YkZ7Qb5JOW9vof6TQ2RP70X7TesJ+8K7QDZM
 KBq2ZOv2wz9umbe3/MXQo6CWwqOtrX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-guJWS8ZiP1SEDfHw-hce0g-1; Sat, 19 Sep 2020 11:59:32 -0400
X-MC-Unique: guJWS8ZiP1SEDfHw-hce0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0897C1074654;
 Sat, 19 Sep 2020 15:59:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9C261975E;
 Sat, 19 Sep 2020 15:59:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/57] acpi: i386: Move VMBus DSDT entry to SB
Date: Sat, 19 Sep 2020 11:58:33 -0400
Message-Id: <20200919155916.1046398-15-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:59:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200715084326.678715-2-arilou@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7a5a8b3521..975db68c6d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -975,7 +975,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 
 static void build_isa_devices_aml(Aml *table)
 {
-    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
     Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
     Aml *scope;
@@ -986,10 +985,6 @@ static void build_isa_devices_aml(Aml *table)
     build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     isa_build_aml(ISA_BUS(obj), scope);
 
-    if (vmbus_bridge) {
-        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
-    }
-
     aml_append(table, scope);
 }
 
@@ -1485,6 +1480,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCIBus *bus = NULL;
     TPMIf *tpm = tpm_find();
     int i;
+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
 
     dsdt = init_aml_allocator();
 
@@ -1526,6 +1522,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
+    if (vmbus_bridge) {
+        sb_scope = aml_scope("_SB");
+        aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
+        aml_append(dsdt, sb_scope);
+    }
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.26.2



