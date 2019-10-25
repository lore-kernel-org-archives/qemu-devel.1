Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BE9206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MT+fGoom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BE9206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpOm-0005I1-8U
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIs-0002JD-Qo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIr-0007bV-If
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIr-0007bL-FA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbB5R4thUE5Gt4DY003mthYNBru3RU5to81ayHIC/6M=;
 b=MT+fGoomE7YMgONFLfjCE1pnv7ZcWWltd9aOBLJBReDiUDDrxrifMagjeA4pU9A/hOi7eX
 12/bQjgxY0Oda59KbabU8PsvbA19yKnVLlq2g4vBwf5eH8ZxTDGNGFliRQ3AebnExPl7xs
 j7F6g0Qo8BToKxmXwgQ32w+Uh4Bk2Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-A0qb6TAJNZ-04Y3SQS7j5A-1; Thu, 24 Oct 2019 22:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CB2B800D49;
 Fri, 25 Oct 2019 02:26:08 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1DA660600;
 Fri, 25 Oct 2019 02:26:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] i386: Don't use default_cpu_version() inside
 query-cpu-definitions
Date: Thu, 24 Oct 2019 23:25:52 -0300
Message-Id: <20191025022553.25298-7-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: A0qb6TAJNZ-04Y3SQS7j5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

We will change query-cpu-definitions to have a new `machine`
parameter.  Make the machine-specific parts of that code explicit
instead of calling default_cpu_version(), so we can change it to
use the new parameter later.

As the code now has a dependency on MachineClass, wrap it inside
a !CONFIG_USER_ONLY ifdef.  The function was never used by
*-user, anyway.

This patch shouldn't introduce any behavior change.  Results of
query-cpu-definition will be exactly the same.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5dbd379331..67d1eca4ed 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3877,6 +3877,7 @@ static void x86_cpu_get_unavailable_features(Object *=
obj, Visitor *v,
     visit_type_strList(v, "unavailable-features", &result, errp);
 }
=20
+#ifndef CONFIG_USER_ONLY
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
  */
@@ -3914,6 +3915,7 @@ static void x86_cpu_class_check_missing_features(X86C=
PUClass *xcc,
=20
     object_unref(OBJECT(xc));
 }
+#endif
=20
 /* Print all cpuid feature names in featureset
  */
@@ -4039,11 +4041,17 @@ void x86_cpu_list(void)
     g_list_free(names);
 }
=20
+#ifndef CONFIG_USER_ONLY
+typedef struct X86CPUDefinitionArgs {
+    CpuDefinitionInfoList *cpu_list;
+    X86CPUVersion default_version;
+} X86CPUDefinitionArgs;
+
 static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc =3D data;
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
-    CpuDefinitionInfoList **cpu_list =3D user_data;
+    X86CPUDefinitionArgs *args =3D user_data;
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
=20
@@ -4059,25 +4067,30 @@ static void x86_cpu_definition_entry(gpointer data,=
 gpointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (default_cpu_version() !=3D CPU_VERSION_LEGACY) {
-        info->alias_of =3D x86_cpu_class_get_alias_of(cc, default_cpu_vers=
ion());
+    if (args->default_version !=3D CPU_VERSION_LEGACY) {
+        info->alias_of =3D x86_cpu_class_get_alias_of(cc, args->default_ve=
rsion);
         info->has_alias_of =3D !!info->alias_of;
     }
=20
     entry =3D g_malloc0(sizeof(*entry));
     entry->value =3D info;
-    entry->next =3D *cpu_list;
-    *cpu_list =3D entry;
+    entry->next =3D args->cpu_list;
+    args->cpu_list =3D entry;
 }
=20
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list =3D NULL;
-    GSList *list =3D get_sorted_cpu_model_list();
-    g_slist_foreach(list, x86_cpu_definition_entry, &cpu_list);
+    X86CPUDefinitionArgs args =3D { .cpu_list =3D NULL };
+    GSList *list;
+    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
+
+    args.default_version =3D default_cpu_version_for_machine(mc);
+    list =3D get_sorted_cpu_model_list();
+    g_slist_foreach(list, x86_cpu_definition_entry, &args);
     g_slist_free(list);
-    return cpu_list;
+    return args.cpu_list;
 }
+#endif
=20
 static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
--=20
2.21.0


