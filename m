Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C58221D40
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Slv4xx6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C58221D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTRC-0004dG-0p
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMh-0006ws-Qi
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMg-0003k5-8h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602630353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFHqLdQ1LZr/q2BKzU1o9GdIbvc7LjYhDm97t9aU/Ro=;
 b=Slv4xx6lTN/Tt67rz9tdR63h0d29T7P1f5LbEcgD/MZCfgy4Nl1zf/mut/DBBov/t/itXL
 h2jL0bq8HQxuPWaShOjSCuhF/GOcBIltUbAl5PxDwxyfUEktjz9ZDM8XPXepEfu3cLdk4+
 32xkaJpJIRSGSTnKkTwcv9fSOEiE8Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-nDWHKgk1NNGLyyIPI98Yhw-1; Tue, 13 Oct 2020 19:05:49 -0400
X-MC-Unique: nDWHKgk1NNGLyyIPI98Yhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A531074659;
 Tue, 13 Oct 2020 23:05:47 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F5E19C71;
 Tue, 13 Oct 2020 23:05:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] i386: Don't use default_cpu_version inside
 x86_cpu_definition_entry()
Date: Tue, 13 Oct 2020 19:04:56 -0400
Message-Id: <20201013230457.150630-7-ehabkost@redhat.com>
In-Reply-To: <20201013230457.150630-1-ehabkost@redhat.com>
References: <20201013230457.150630-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

We will change query-cpu-definitions to have a new `machine`
parameter.  Move the code that reads default_cpu_version to
qmp_query_cpu_definitions() to make that easier to implement.

This patch shouldn't introduce any behavior change.  Results of
query-cpu-definition will be exactly the same.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bf4b4a4812..0807d12ffa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4990,11 +4990,16 @@ void x86_cpu_list(void)
 }
 
 #ifndef CONFIG_USER_ONLY
+typedef struct X86CPUDefinitionArgs {
+    CpuDefinitionInfoList *cpu_list;
+    X86CPUVersion default_version;
+} X86CPUDefinitionArgs;
+
 static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     X86CPUClass *cc = X86_CPU_CLASS(oc);
-    CpuDefinitionInfoList **cpu_list = user_data;
+    X86CPUDefinitionArgs *args = user_data;
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
 
@@ -5010,25 +5015,27 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
      */
-    if (cc->model && default_cpu_version != CPU_VERSION_LEGACY) {
+    if (cc->model && args->default_version != CPU_VERSION_LEGACY) {
         info->alias_of = x86_cpu_model_resolve_alias(cc->model,
-                                                     default_cpu_version);
+                                                     args->default_version);
         info->has_alias_of = !!info->alias_of;
     }
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
-    entry->next = *cpu_list;
-    *cpu_list = entry;
+    entry->next = args->cpu_list;
+    args->cpu_list = entry;
 }
 
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
+    X86CPUDefinitionArgs args = { .cpu_list = NULL };
     GSList *list = get_sorted_cpu_model_list();
-    g_slist_foreach(list, x86_cpu_definition_entry, &cpu_list);
+
+    args.default_version = default_cpu_version;
+    g_slist_foreach(list, x86_cpu_definition_entry, &args);
     g_slist_free(list);
-    return cpu_list;
+    return args.cpu_list;
 }
 #endif
 
-- 
2.28.0


