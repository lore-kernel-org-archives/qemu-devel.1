Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D526A21D46
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi4NdtTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D526A21D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrVf-0000Ka-Ue
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMX-0008Ju-OC
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMT-0007w0-IG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIWwRjJFUT/NqBREKg7yfmtN/GKOBor8yF9qjrT88xU=;
 b=Yi4NdtTtF7zkbbsj3RPrFK2wBl2qh8JdB47QDCM6cNmDHpbA+rdKG6eb06Ct8V2rFdmkmq
 rhcEHeSe9iWfOUL1n2yqqCPCOoManktiknDEvboqQVPpPmQNwDkQQkEEE0vzZvxSruduqb
 F9t3zRUDUBU4XIs9eoA3mVaq7JC2kiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-wJTgVq1JO5aS1qeMEVY65g-1; Fri, 09 Oct 2020 08:18:59 -0400
X-MC-Unique: wJTgVq1JO5aS1qeMEVY65g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B7F21029D20
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:18:58 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E105C1BB;
 Fri,  9 Oct 2020 12:18:56 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 06/23] i386: move hyperv_version_id initialization to
 x86_cpu_realizefn()
Date: Fri,  9 Oct 2020 14:18:25 +0200
Message-Id: <20201009121842.1938010-7-vkuznets@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
hyperv_version_id initialization to x86_cpu_realizefn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  4 ++++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52e050a7785c..a8992b0c1c75 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6513,6 +6513,10 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
     cpu->hyperv_interface_id[1] = 0;
     cpu->hyperv_interface_id[2] = 0;
     cpu->hyperv_interface_id[3] = 0;
+
+    /* Hypervisor system identity */
+    cpu->hyperv_version_id[0] = 0x00001bbc;
+    cpu->hyperv_version_id[1] = 0x00060001;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d49e34a80a34..da1fdfd7a9fd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1662,6 +1662,7 @@ struct X86CPU {
     OnOffAuto hyperv_no_nonarch_cs;
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
+    uint32_t hyperv_version_id[4];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index eec0a7e31315..cce07f412d2f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1224,6 +1224,14 @@ static int hyperv_handle_properties(CPUState *cs,
             cpu->hyperv_interface_id[3] = c->edx;
         }
 
+        c = cpuid_find_entry(cpuid, HV_CPUID_VERSION, 0);
+        if (c) {
+            cpu->hyperv_version_id[0] = c->eax;
+            cpu->hyperv_version_id[1] = c->ebx;
+            cpu->hyperv_version_id[2] = c->ecx;
+            cpu->hyperv_version_id[3] = c->edx;
+        }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
         if (c) {
             env->features[FEAT_HYPERV_EAX] = c->eax;
@@ -1313,8 +1321,10 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VERSION;
-    c->eax = 0x00001bbc;
-    c->ebx = 0x00060001;
+    c->eax = cpu->hyperv_version_id[0];
+    c->ebx = cpu->hyperv_version_id[1];
+    c->ecx = cpu->hyperv_version_id[2];
+    c->edx = cpu->hyperv_version_id[3];
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_FEATURES;
-- 
2.25.4


