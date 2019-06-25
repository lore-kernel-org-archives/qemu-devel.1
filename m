Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B20C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FFE2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FFE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfdbY-0007pF-EM
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 01:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZ8-0006gw-8R
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZ7-0002OL-7l
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfdZ7-0002Mk-27
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FDB881F35
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 05:00:14 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E14C25C231;
 Tue, 25 Jun 2019 05:00:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 02:00:03 -0300
Message-Id: <20190625050008.12789-2-ehabkost@redhat.com>
In-Reply-To: <20190625050008.12789-1-ehabkost@redhat.com>
References: <20190625050008.12789-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 05:00:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/6] i386: Add x-force-features option for
 testing
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

Add a new option that can be used to disable feature flag
filtering.  This will allow CPU model compatibility test cases to
work without host hardware dependencies.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 6 ++++++
 target/i386/cpu.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index df99d70c43..25544fdaaa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1414,6 +1414,12 @@ struct X86CPU {
 
     bool check_cpuid;
     bool enforce_cpuid;
+    /*
+     * Force features to be enabled even if the host doesn't support them.
+     * This is dangerous and should be done only for testing CPUID
+     * compatibility.
+     */
+    bool force_features;
     bool expose_kvm;
     bool expose_tcg;
     bool migratable;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f8d8f779c1..1bad957f6e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5140,8 +5140,11 @@ static int x86_cpu_filter_features(X86CPU *cpu)
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        env->features[w] &= host_feat;
-        cpu->filtered_features[w] = requested_features & ~env->features[w];
+        uint32_t available_features = requested_features & host_feat;
+        if (!cpu->force_features) {
+            env->features[w] = available_features;
+        }
+        cpu->filtered_features[w] = requested_features & ~available_features;
         if (cpu->filtered_features[w]) {
             rv = 1;
         }
@@ -5866,6 +5869,7 @@ static Property x86_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
+    DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
-- 
2.18.0.rc1.1.g3f1ff2140


