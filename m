Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063DE206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNshZF23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063DE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpOk-0005D7-2j
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIq-0002FH-Ql
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIp-0007au-Ef
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIp-0007am-BF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DE2UszUNbiBVXoqbZD/Azq3pCR41ajOgVbw26AFRtxk=;
 b=aNshZF23DJvKtg+XykDa1MkCTeJrROTfRypMhClbMDgR1FfXBP8qrpa4t3bxCL1NNrNMc6
 +v0m/Yhkdlz6PLTLrEfG6OdjoNEyzqDyVqZtcG/ax1vesiVH1xiD+c0NZJ0YqCvplxKRwk
 8cIErT+y+MvJDrzn0bzkw4L98CroMBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-_9tcNk31Nr-HVTmvWKOcUQ-1; Thu, 24 Oct 2019 22:26:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D76D107AD31;
 Fri, 25 Oct 2019 02:26:06 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FF8B608C1;
 Fri, 25 Oct 2019 02:26:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] i386: Remove x86_cpu_set_default_version() function
Date: Thu, 24 Oct 2019 23:25:51 -0300
Message-Id: <20191025022553.25298-6-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _9tcNk31Nr-HVTmvWKOcUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will introduce code that will return machine-type-specific
from other machines (not the current one), so we'll need a helper
for getting the default CPU version from a machine class.

With the new helper, we don't need the machine init function to
call x86_cpu_set_default_version() anymore: we can just look at
the machine class of the current machine.  Replace the
default_cpu_version static variable with a default_cpu_version()
function that will look at qdev_get_machine().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  5 ++++-
 target/i386/cpu.h    |  6 ------
 hw/i386/pc.c         |  3 ---
 target/i386/cpu.c    | 28 ++++++++++++++++++++--------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 37bfd95113..00ac726ebc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -113,7 +113,10 @@ typedef struct PCMachineClass {
=20
     /* Compat options: */
=20
-    /* Default CPU model version.  See x86_cpu_set_default_version(). */
+    /*
+     * Default CPU model version for CPU models having
+     * version =3D=3D CPU_VERSION_AUTO.
+     */
     int default_cpu_version;
=20
     /* ACPI compat: */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cedb5bc205..aa17c79b43 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2168,12 +2168,6 @@ void x86_cpu_change_kvm_default(const char *prop, co=
nst char *value);
=20
 typedef int X86CPUVersion;
=20
-/*
- * Set default CPU model version for CPU models having
- * version =3D=3D CPU_VERSION_AUTO.
- */
-void x86_cpu_set_default_version(X86CPUVersion version);
-
 /* Return name of 32-bit register, from a R_* constant */
 const char *get_register_name_32(unsigned int reg);
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b1904237e..64ec995172 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1503,9 +1503,6 @@ void pc_cpus_init(PCMachineState *pcms)
     const CPUArchIdList *possible_cpus;
     MachineState *ms =3D MACHINE(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
-
-    x86_cpu_set_default_version(pcmc->default_cpu_version);
=20
     /* Calculates the limit to CPU APIC ID values
      *
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8cecc669b3..5dbd379331 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -57,6 +57,7 @@
 #include "hw/xen/xen.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
+#include "hw/i386/pc.h"
 #endif
=20
 #include "disas/capstone.h"
@@ -3165,14 +3166,25 @@ static PropValue tcg_default_props[] =3D {
 };
=20
=20
-X86CPUVersion default_cpu_version =3D CPU_VERSION_LATEST;
+#ifdef CONFIG_USER_ONLY
+static X86CPUVersion default_cpu_version(void)
+{
+    return CPU_VERSION_LATEST;
+}
+#else
+static X86CPUVersion default_cpu_version_for_machine(MachineClass *mc)
+{
+    PCMachineClass *pcmc =3D
+        (PCMachineClass *)object_class_dynamic_cast(OBJECT_CLASS(mc), TYPE=
_PC_MACHINE);
+    return pcmc ? pcmc->default_cpu_version : CPU_VERSION_LATEST;
+}
=20
-void x86_cpu_set_default_version(X86CPUVersion version)
+static X86CPUVersion default_cpu_version(void)
 {
-    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense=
 */
-    assert(version !=3D CPU_VERSION_AUTO);
-    default_cpu_version =3D version;
+    return default_cpu_version_for_machine(MACHINE_GET_CLASS(qdev_get_mach=
ine()));
 }
+#endif
+
=20
 static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
 {
@@ -4047,8 +4059,8 @@ static void x86_cpu_definition_entry(gpointer data, g=
pointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
-        info->alias_of =3D x86_cpu_class_get_alias_of(cc, default_cpu_vers=
ion);
+    if (default_cpu_version() !=3D CPU_VERSION_LEGACY) {
+        info->alias_of =3D x86_cpu_class_get_alias_of(cc, default_cpu_vers=
ion());
         info->has_alias_of =3D !!info->alias_of;
     }
=20
@@ -4119,7 +4131,7 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValu=
e *props)
 static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
-    X86CPUVersion version =3D x86_cpu_model_resolve_version(model, default=
_cpu_version);
+    X86CPUVersion version =3D x86_cpu_model_resolve_version(model, default=
_cpu_version());
=20
     if (version =3D=3D CPU_VERSION_LEGACY) {
         return;
--=20
2.21.0


