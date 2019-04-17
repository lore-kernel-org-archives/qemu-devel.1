Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE419C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE1D21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE1D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGapy-00044S-Sz
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:02:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGank-0002lb-6u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanh-0007k0-P7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGanh-0007jE-I9; Tue, 16 Apr 2019 22:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A75813084212;
	Wed, 17 Apr 2019 02:59:52 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 330C05D707;
	Wed, 17 Apr 2019 02:59:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 23:59:41 -0300
Message-Id: <20190417025944.16154-3-ehabkost@redhat.com>
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 17 Apr 2019 02:59:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/5] cpu: Extract CPU class lookup from
 parse_cpu_option()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417025941.1pXLyavceLnWW5duNt-NWMqBFjS7bBDn8oYZ2URsVdg@z>

The new function will be useful in user mode, when we already
have a CPU model and don't need to parse any extra options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h |  9 +++++++++
 exec.c            | 22 ++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index d28c690b27..e11b14d9ac 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
+/**
+ * lookup_cpu_class:
+ * @cpu_model: CPU model name
+ *
+ * Look up CPU class corresponding to a given CPU model name.
+ */
+CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);
+
+
 /**
  * cpu_has_work:
  * @cpu: The vCPU to check.
diff --git a/exec.c b/exec.c
index 840677f15f..d359e709a6 100644
--- a/exec.c
+++ b/exec.c
@@ -982,24 +982,26 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
 
+CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp)
+{
+    ObjectClass *oc = cpu_class_by_name(CPU_RESOLVING_TYPE, cpu_model);
+    if (oc == NULL) {
+        error_setg(errp, "unable to find CPU model '%s'", cpu_model);
+        return NULL;
+    }
+    return CPU_CLASS(oc);
+}
+
 const char *parse_cpu_option(const char *cpu_option)
 {
-    ObjectClass *oc;
     CPUClass *cc;
     gchar **model_pieces;
     const char *cpu_type;
 
     model_pieces = g_strsplit(cpu_option, ",", 2);
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
+    cc = lookup_cpu_class(model_pieces[0], &error_fatal);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
     cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
     g_strfreev(model_pieces);
     return cpu_type;
-- 
2.18.0.rc1.1.g3f1ff2140


