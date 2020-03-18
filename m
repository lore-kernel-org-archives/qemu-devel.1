Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF76CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDACF2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cITuwTKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDACF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENOj-00006a-Uf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLM-0003sx-0K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLK-0000da-Rv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLK-0000cG-O0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sdTixl3XvFiBYSntPyXi7dFn3qA9pvkmLi2kk9CoQg=;
 b=cITuwTKQIz44GO7g0LnFgroVnItXo7LBlaTZdOmPvEeHzjfVRfpC2TkOe/ojUAkEZK2ax5
 rCF8Wo6nC+BcfTJUHr5IATFKX45fcOVJsh2REUkgckiiyddNdc6e9z5v+YwNBHWTyPlyQi
 MSGB4iBW/mhg6Em0steD7QdNIorikRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-qkcd4dzvMgqcR21qo2gXCQ-1; Tue, 17 Mar 2020 21:17:56 -0400
X-MC-Unique: qkcd4dzvMgqcR21qo2gXCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F7C2107ACC7;
 Wed, 18 Mar 2020 01:17:55 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D335B8FBE9;
 Wed, 18 Mar 2020 01:17:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/13] target/i386: Add new property note to versioned CPU
 models
Date: Tue, 17 Mar 2020 21:17:37 -0400
Message-Id: <20200318011748.2104336-3-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Add additional information for -cpu help to indicate the changes in this
version of CPU model.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20200212081328.7385-4-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c3b5cf1369..dc78494167 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1690,6 +1690,7 @@ typedef struct PropValue {
 typedef struct X86CPUVersionDefinition {
     X86CPUVersion version;
     const char *alias;
+    const char *note;
     PropValue *props;
 } X86CPUVersionDefinition;
=20
@@ -1720,6 +1721,7 @@ struct X86CPUModel {
     X86CPUDefinition *cpudef;
     /* CPU model version */
     X86CPUVersion version;
+    const char *note;
     /*
      * If true, this is an alias CPU model.
      * This matters only for "-cpu help" and query-cpu-definitions
@@ -4861,6 +4863,7 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
     g_autofree char *name =3D x86_cpu_class_get_model_name(cc);
     g_autofree char *desc =3D g_strdup(cc->model_description);
     g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc);
+    g_autofree char *model_id =3D x86_cpu_class_get_model_id(cc);
=20
     if (!desc && alias_of) {
         if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
@@ -4869,11 +4872,14 @@ static void x86_cpu_list_entry(gpointer data, gpoin=
ter user_data)
             desc =3D g_strdup_printf("(alias of %s)", alias_of);
         }
     }
+    if (!desc && cc->model && cc->model->note) {
+        desc =3D g_strdup_printf("%s [%s]", model_id, cc->model->note);
+    }
     if (!desc) {
-        desc =3D x86_cpu_class_get_model_id(cc);
+        desc =3D g_strdup_printf("%s", model_id);
     }
=20
-    qemu_printf("x86 %-20s  %-48s\n", name, desc);
+    qemu_printf("x86 %-20s  %-58s\n", name, desc);
 }
=20
 /* list available CPU models and flags */
@@ -5350,6 +5356,7 @@ static void x86_register_cpudef_types(X86CPUDefinitio=
n *def)
             x86_cpu_versioned_model_name(def, vdef->version);
         m->cpudef =3D def;
         m->version =3D vdef->version;
+        m->note =3D vdef->note;
         x86_register_cpu_model_type(name, m);
=20
         if (vdef->alias) {
--=20
2.24.1


