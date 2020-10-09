Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D077C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3A922284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Y2Bizx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3A922284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrQu-00050a-Oo
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMV-0008Jf-SF
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMR-0007vm-KO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tT6pTTej2yatf8fMzxJfzoh3zO+2aZRpKmOqKc2NEI=;
 b=E1Y2Bizxfz5yGhWK6U06tCg6Jdm62PLnEXYV59A+5Pk8haW3w24ZNhzyqwwi8edTie5l/q
 Vnwl1K6QeQD1ST+XOVfwbeybKzmaHrZMQx1oZRMYqbF146QG+80nAdcibqARLEQLoWkMyT
 1RftfB/9pSr5OXw78jwmHWNVJWwEz3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-YTlNrsZcPoyRQjVv2YomWA-1; Fri, 09 Oct 2020 08:18:56 -0400
X-MC-Unique: YTlNrsZcPoyRQjVv2YomWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFFA7196C900
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:18:55 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 524365C1BB;
 Fri,  9 Oct 2020 12:18:54 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 05/23] i386: move hyperv_interface_id initialization to
 x86_cpu_realizefn()
Date: Fri,  9 Oct 2020 14:18:24 +0200
Message-Id: <20201009121842.1938010-6-vkuznets@redhat.com>
In-Reply-To: <20201009121842.1938010-1-vkuznets@redhat.com>
References: <20201009121842.1938010-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a preparation to expanding Hyper-V CPU features early, move
hyperv_interface_id initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  6 ++++++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 18 ++++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ce485dd9afd9..52e050a7785c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6507,6 +6507,12 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
         memset(cpu->hyperv_vendor_id, 0, 12);
         memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
     }
+
+    /* 'Hv#1' interface identification*/
+    cpu->hyperv_interface_id[0] = 0x31237648;
+    cpu->hyperv_interface_id[1] = 0;
+    cpu->hyperv_interface_id[2] = 0;
+    cpu->hyperv_interface_id[3] = 0;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2e7ee40372de..d49e34a80a34 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1661,6 +1661,7 @@ struct X86CPU {
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
     uint32_t hyperv_vendor_id[3];
+    uint32_t hyperv_interface_id[4];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 75d4cb17a5ba..eec0a7e31315 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1173,7 +1173,6 @@ static int hyperv_handle_properties(CPUState *cs,
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
     struct kvm_cpuid_entry2 *c;
-    uint32_t signature[3];
     uint32_t cpuid_i = 0;
     int r;
 
@@ -1217,6 +1216,14 @@ static int hyperv_handle_properties(CPUState *cs,
             cpu->hyperv_vendor_id[2] = c->edx;
         }
 
+        c = cpuid_find_entry(cpuid, HV_CPUID_INTERFACE, 0);
+        if (c) {
+            cpu->hyperv_interface_id[0] = c->eax;
+            cpu->hyperv_interface_id[1] = c->ebx;
+            cpu->hyperv_interface_id[2] = c->ecx;
+            cpu->hyperv_interface_id[3] = c->edx;
+        }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
         if (c) {
             env->features[FEAT_HYPERV_EAX] = c->eax;
@@ -1299,11 +1306,10 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_INTERFACE;
-    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
-    c->eax = signature[0];
-    c->ebx = 0;
-    c->ecx = 0;
-    c->edx = 0;
+    c->eax = cpu->hyperv_interface_id[0];
+    c->ebx = cpu->hyperv_interface_id[1];
+    c->ecx = cpu->hyperv_interface_id[2];
+    c->edx = cpu->hyperv_interface_id[3];
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VERSION;
-- 
2.25.4


