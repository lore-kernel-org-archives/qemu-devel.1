Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1CC282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53CA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53CA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIioZ-0006iw-NQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 19:57:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimi-00058J-9N
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIifB-0005jO-L5
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif9-0005ih-N9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 957297CDEA;
	Mon, 22 Apr 2019 23:47:50 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0B51062224;
	Mon, 22 Apr 2019 23:47:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 20:47:42 -0300
Message-Id: <20190422234742.15780-3-ehabkost@redhat.com>
In-Reply-To: <20190422234742.15780-1-ehabkost@redhat.com>
References: <20190422234742.15780-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 22 Apr 2019 23:47:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] i386: "unavailable-features" QOM property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422234742.X2HbUqYZ4Ub157fCl_YkHl_H3PlYsJOwvysBOF6uCAw@z>

Add a "unavailable-features" QOM property to X86CPU objects that
have the same semantics of "unavailable-features" on
query-cpu-definitions.  The new property has the same goal of
"filtered-features", but is generic enough to let any kind of CPU
feature to be listed there without relying on low level details
like CPUID leaves or MSR numbers.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 23e55a9ef2..042d09a1bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3640,6 +3640,17 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     }
 }
 
+static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    X86CPU *xc = X86_CPU(obj);
+    strList *result = NULL;
+
+    x86_cpu_list_feature_names(xc->filtered_features, &result);
+    visit_type_strList(v, "unavailable-features", &result, errp);
+}
+
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
  */
@@ -5580,6 +5591,15 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features, NULL);
+    /*
+     * The "unavailable-features" property has the same semantics as
+     * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
+     * QMP command: they list the features that would have prevented the
+     * CPU from running if the "enforce" flag was set.
+     */
+    object_property_add(obj, "unavailable-features", "strList",
+                        x86_cpu_get_unavailable_features,
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
-- 
2.18.0.rc1.1.g3f1ff2140


