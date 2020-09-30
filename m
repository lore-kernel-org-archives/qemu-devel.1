Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E45C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7948A20706
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCPZzaZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7948A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcVZ-00080x-Hi
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMM-00068s-Bj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMF-0005bx-Qd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRKCvAJzbGC4n/pGjCuBkh9xgOAleZcJhxYpNzpXK+Y=;
 b=WCPZzaZsrCqMFAZgSshmthYTi8FO9z86G3rcHJ1cqJ4Oxd/8Ge6eczSZ6Ud6i074vAl2TT
 bfiaLj9HH9C26peo/lqYSm0lbKyRPPlLna3epuIO99hJ+6ZDQKlHf/eo90TsXgE5npLczo
 dLWIdBpwgPCiQs7afhtAuJ2yDpCRsxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-3dloJli-O4-ckWikIGL1HA-1; Wed, 30 Sep 2020 09:41:19 -0400
X-MC-Unique: 3dloJli-O4-ckWikIGL1HA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57A81040C2F
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3D9260C05;
 Wed, 30 Sep 2020 13:41:12 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 06/19] i386: move hyperv_version_id initialization to
 x86_cpu_realizefn()
Date: Wed, 30 Sep 2020 15:40:14 +0200
Message-Id: <20200930134027.1348021-7-vkuznets@redhat.com>
In-Reply-To: <20200930134027.1348021-1-vkuznets@redhat.com>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
 Eduardo Habkost <ehabkost@redhat.com>
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
index 9e77d9579b5c..99bcfcbb448a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6511,6 +6511,10 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
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
index 702949462ab9..077c19c5642b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1661,6 +1661,7 @@ struct X86CPU {
     OnOffAuto hyperv_no_nonarch_cs;
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
+    uint32_t hyperv_version_id[4];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6dde7c97deb3..b335b3a3d1c7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1239,6 +1239,14 @@ static int hyperv_handle_properties(CPUState *cs,
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
@@ -1328,8 +1336,10 @@ static int hyperv_handle_properties(CPUState *cs,
 
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


