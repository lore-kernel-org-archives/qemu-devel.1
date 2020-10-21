Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A2C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F48220870
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtFAfj61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F48220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLFY-0002St-Ps
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAv-0005UW-Lc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAh-0006ei-Jq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bk7OcrGv2Bhi0vHJasD1ougOCtytCjn0scl9nnODkDg=;
 b=YtFAfj61ir8r1zaLGhL6GlBJ3Li0I/ZUBSQAmjnmdH+bB/rRxvXu4+B5AqfOkHIIM5KOLA
 Q9etWYtImlEUvMt+04EYU/c6TCBhKIAuxOPbsd1aoRrfDeOihibGHj12wGPaK3WGY+q1wY
 TEoHUwWVcXb35ExRPy9zpm62Fz3/m0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-f2KVkNySMQK-kTyEs2icIg-1; Wed, 21 Oct 2020 16:57:20 -0400
X-MC-Unique: f2KVkNySMQK-kTyEs2icIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 498AA800050
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D04CD6EF62;
 Wed, 21 Oct 2020 20:57:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/22] machine: remove deprecated -machine
 enforce-config-section option
Date: Wed, 21 Oct 2020 16:56:56 -0400
Message-Id: <20201021205716.2359430-3-pbonzini@redhat.com>
In-Reply-To: <20201021205716.2359430-1-pbonzini@redhat.com>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecated since 3.1 and complicates the initialization sequence,
remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst | 12 ++++++------
 hw/core/machine.c          | 24 +-----------------------
 include/hw/boards.h        |  1 -
 migration/migration.c      | 10 ----------
 qemu-options.hx            |  8 --------
 5 files changed, 7 insertions(+), 48 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 895433c356..0ebce37a19 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -21,12 +21,6 @@ deprecated.
 System emulator command line arguments
 --------------------------------------
 
-``-machine enforce-config-section=on|off`` (since 3.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``enforce-config-section`` parameter is replaced by the
-``-global migration.send-configuration={on|off}`` option.
-
 ``-usbdevice`` (since 2.10.0)
 '''''''''''''''''''''''''''''
 
@@ -689,6 +683,12 @@ Support for invalid topologies is removed, the user must ensure
 topologies described with -smp include all possible cpus, i.e.
 *sockets* * *cores* * *threads* = *maxcpus*.
 
+``-machine enforce-config-section=on|off`` (removed 5.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``enforce-config-section`` property was replaced by the
+``-global migration.send-configuration={on|off}`` option.
+
 Block devices
 -------------
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d740a7e963..80a918895a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -26,6 +26,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "migration/misc.h"
 #include "migration/vmstate.h"
 
 GlobalProperty hw_compat_5_1[] = {
@@ -411,24 +412,6 @@ static bool machine_get_suppress_vmdesc(Object *obj, Error **errp)
     return ms->suppress_vmdesc;
 }
 
-static void machine_set_enforce_config_section(Object *obj, bool value,
-                                             Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    warn_report("enforce-config-section is deprecated, please use "
-                "-global migration.send-configuration=on|off instead");
-
-    ms->enforce_config_section = value;
-}
-
-static bool machine_get_enforce_config_section(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->enforce_config_section;
-}
-
 static char *machine_get_memory_encryption(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -857,11 +840,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "suppress-vmdesc",
         "Set on to disable self-describing migration");
 
-    object_class_property_add_bool(oc, "enforce-config-section",
-        machine_get_enforce_config_section, machine_set_enforce_config_section);
-    object_class_property_set_description(oc, "enforce-config-section",
-        "Set on to enforce configuration section migration");
-
     object_class_property_add_str(oc, "memory-encryption",
         machine_get_memory_encryption, machine_set_memory_encryption);
     object_class_property_set_description(oc, "memory-encryption",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index bf53e8a16e..a49e3a6b44 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -268,7 +268,6 @@ struct MachineState {
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
-    bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
     char *ram_memdev_id;
diff --git a/migration/migration.c b/migration/migration.c
index 0575ecb379..deb6005b8d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -145,7 +145,6 @@ static void migrate_fd_cancel(MigrationState *s);
 
 void migration_object_init(void)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     Error *err = NULL;
 
     /* This can only be called once. */
@@ -170,15 +169,6 @@ void migration_object_init(void)
         error_report_err(err);
         exit(1);
     }
-
-    /*
-     * We cannot really do this in migration_instance_init() since at
-     * that time global properties are not yet applied, then this
-     * value will be definitely replaced by something else.
-     */
-    if (ms->enforce_config_section) {
-        current_migration->send_configuration = true;
-    }
 }
 
 void migration_shutdown(void)
diff --git a/qemu-options.hx b/qemu-options.hx
index 9e1ace04f7..2c83390504 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -34,7 +34,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n",
     QEMU_ARCH_ALL)
@@ -91,13 +90,6 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
-    ``enforce-config-section=on|off``
-        If ``enforce-config-section`` is set to on, force migration code
-        to send configuration section even if the machine-type sets the
-        ``migration.send-configuration`` property to off. NOTE: this
-        parameter is deprecated. Please use ``-global``
-        ``migration.send-configuration``\ =on\|off instead.
-
     ``memory-encryption=``
         Memory encryption object to use. The default is none.
 
-- 
2.26.2



