Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1252227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWdmkOxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1252227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxtU-0001gH-HR
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxri-0000Mc-Nf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQxrh-0000PC-4t
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602270939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1ignAfKpKJCiV6u91zNVKq8+uBU6mixfWejHGHxevs=;
 b=BWdmkOxRHUjjiltuuzNxmvM3iQmZvWoyn+oiSgGd7p4uNaSYViF0ApOxLC/hM5Lt7ZJNdF
 40KOqz1vJGlcRjazU35xSWVIOG7KNB7/VEEq1olDEtVV+sUSlqF3TwrPToqx+WI3AfCjgh
 sFsdk81Cs/QG9tXCxHg+Y2LC7e14VT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-2F4pFr1XODeEkK-zld0x1A-1; Fri, 09 Oct 2020 15:15:35 -0400
X-MC-Unique: 2F4pFr1XODeEkK-zld0x1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CF5318A8230;
 Fri,  9 Oct 2020 19:15:34 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7D360BFA;
 Fri,  9 Oct 2020 19:15:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] acpi: Don't pass const pointers to
 object_property_add_uint*_ptr()
Date: Fri,  9 Oct 2020 15:15:18 -0400
Message-Id: <20201009191520.1799419-2-ehabkost@redhat.com>
In-Reply-To: <20201009191520.1799419-1-ehabkost@redhat.com>
References: <20201009191520.1799419-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_add_uint*_ptr() will be changed to get non-const
pointers.  Adapt the ACPI code to that.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/acpi/ich9.c    |  2 +-
 hw/acpi/piix4.c   | 10 +++++-----
 hw/isa/lpc_ich9.c |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 95cb0f935b..9bb8d1b155 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -371,7 +371,7 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
+    static uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
     pm->cpu_hotplug_legacy = true;
     pm->disable_s3 = 0;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 894d357f8c..1e8a15676d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -439,11 +439,11 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 
 static void piix4_pm_add_propeties(PIIX4PMState *s)
 {
-    static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
-    static const uint32_t gpe0_blk = GPE_BASE;
-    static const uint32_t gpe0_blk_len = GPE_LEN;
-    static const uint16_t sci_int = 9;
+    static uint8_t acpi_enable_cmd = ACPI_ENABLE;
+    static uint8_t acpi_disable_cmd = ACPI_DISABLE;
+    static uint32_t gpe0_blk = GPE_BASE;
+    static uint32_t gpe0_blk_len = GPE_LEN;
+    static uint16_t sci_int = 9;
 
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 04e5323140..b9dc01f654 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -638,8 +638,8 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+    static uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
 
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
                                   &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-- 
2.26.2


