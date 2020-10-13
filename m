Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6548EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070DA21D40
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaENz9A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070DA21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTR0-0004BC-4Y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMU-0006Y3-33
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMM-0003bv-4e
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602630332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTbX0B1zV000QcV8Vb8x3NBiMAjzCCHPhHUOANP/BZE=;
 b=PaENz9A0vsy13LhuDZHo+0HizNxFTw6l1i3ZG38AfwChjg9K6Q2swybVBlIJNCW5PMFavl
 GDdGijSP5hyCiO8O5R01oL8B8OwGwWQPZVcqRpxloTxEG+qKtutCl5rqPs4mPsUmZkXN5C
 nnhcnWNjWhtRvUafdANM8EAMJrNhG2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-q1vk8DkEMYWJraXRdFxkiA-1; Tue, 13 Oct 2020 19:05:30 -0400
X-MC-Unique: q1vk8DkEMYWJraXRdFxkiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F9EF1074657;
 Tue, 13 Oct 2020 23:05:28 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFD797666A;
 Tue, 13 Oct 2020 23:05:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] i386: Replace x86_cpu_class_get_alias_of() with
 x86_cpu_model_resolve_alias()
Date: Tue, 13 Oct 2020 19:04:53 -0400
Message-Id: <20201013230457.150630-4-ehabkost@redhat.com>
In-Reply-To: <20201013230457.150630-1-ehabkost@redhat.com>
References: <20201013230457.150630-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New function is very similar to the old function, but it just
takes a X86CPUModel as argument, and its name makes its purpose
clearer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 43e633ddd3..2c8dd3fa32 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4170,6 +4170,21 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
     return v;
 }
 
+/* Resolve CPU model alias to actual CPU model name */
+static char *x86_cpu_model_resolve_alias(const X86CPUModel *model)
+{
+    X86CPUVersion version;
+
+    if (!model->is_alias) {
+        return NULL;
+    }
+    version = x86_cpu_model_resolve_version(model);
+    if (version <= 0) {
+        return NULL;
+    }
+    return x86_cpu_versioned_model_name(model->cpudef, version);
+}
+
 void x86_cpu_change_kvm_default(const char *prop, const char *value)
 {
     PropValue *pv;
@@ -4913,20 +4928,6 @@ static char *x86_cpu_class_get_model_id(X86CPUClass *xc)
     return r;
 }
 
-static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
-{
-    X86CPUVersion version;
-
-    if (!cc->model || !cc->model->is_alias) {
-        return NULL;
-    }
-    version = x86_cpu_model_resolve_version(cc->model);
-    if (version <= 0) {
-        return NULL;
-    }
-    return x86_cpu_versioned_model_name(cc->model->cpudef, version);
-}
-
 static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
@@ -5002,8 +5003,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (default_cpu_version != CPU_VERSION_LEGACY) {
-        info->alias_of = x86_cpu_class_get_alias_of(cc);
+    if (cc->model && default_cpu_version != CPU_VERSION_LEGACY) {
+        info->alias_of = x86_cpu_model_resolve_alias(cc->model);
         info->has_alias_of = !!info->alias_of;
     }
 
-- 
2.28.0


