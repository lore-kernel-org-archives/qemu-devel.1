Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD71C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D652F208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D652F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgen3-0002C0-3f
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36225)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgel5-0008Q3-OA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgel4-0006nl-SF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgel4-0006nI-Mu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DFFA43DE0D
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 00:28:53 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60F255D71D;
 Fri, 28 Jun 2019 00:28:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:38 -0300
Message-Id: <20190628002844.24894-4-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 28 Jun 2019 00:28:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/9] i386: Get model-id from CPU object on
 "-cpu help"
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When introducing versioned CPU models, the string at
X86CPUDefinition::model_id might not be the model-id we'll really
use.  Instantiate a CPU object and check the model-id property on
"-cpu help"

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
(New patch, added to series in v2)
---
 target/i386/cpu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1bdb906e9f..49bf92d3f9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3766,18 +3766,28 @@ static GSList *get_sorted_cpu_model_list(void)
     return list;
 }
 
+static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
+{
+    Object *obj = object_new(object_class_get_name(OBJECT_CLASS(xc)));
+    char *r = object_property_get_str(obj, "model-id", &error_abort);
+    object_unref(obj);
+    return r;
+}
+
 static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     X86CPUClass *cc = X86_CPU_CLASS(oc);
     char *name = x86_cpu_class_get_model_name(cc);
-    const char *desc = cc->model_description;
-    if (!desc && cc->cpu_def) {
-        desc = cc->cpu_def->model_id;
+    char *desc = g_strdup(cc->model_description);
+
+    if (!desc) {
+        desc = x86_cpu_class_get_model_id(cc);
     }
 
     qemu_printf("x86 %-20s  %-48s\n", name, desc);
     g_free(name);
+    g_free(desc);
 }
 
 /* list available CPU models and flags */
-- 
2.18.0.rc1.1.g3f1ff2140


