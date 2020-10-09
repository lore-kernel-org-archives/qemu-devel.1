Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FCAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4150F22284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BK8xLWAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4150F22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrY5-0003cq-4w
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMe-0008KM-Tl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMX-0007wS-Fw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KX8WF/p7qQT0rQD3w6aNDaZLClnEUMrJKD9j0lEu768=;
 b=BK8xLWAtpRf/OEk7gkQCQgFoFh4MiGjCdFCuZSm+xU3Ju3JqtwFqclM3jxKzXuK5n30mUe
 ZNjl1hQJMcDyjWYMSXsjrj/G8tVaOBR467ojk77wOUVtPqw9qIK+s27sSjeavCO9/OUSA9
 kWBRyjbM8uDxGLPihjUntJ97eRPeM20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-FlhajIUgPiqBGJxzu_cDVg-1; Fri, 09 Oct 2020 08:19:03 -0400
X-MC-Unique: FlhajIUgPiqBGJxzu_cDVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685CC108E1A3
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:19:02 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABD9D5C1BB;
 Fri,  9 Oct 2020 12:19:00 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 08/23] i386: keep hyperv_vendor string up-to-date
Date: Fri,  9 Oct 2020 14:18:27 +0200
Message-Id: <20201009121842.1938010-9-vkuznets@redhat.com>
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

When cpu->hyperv_vendor is not set manually we default to "Microsoft Hv"
and in 'hv_passthrough' mode we get the information from the host. This
information is stored in cpu->hyperv_vendor_id[] array but we don't update
cpu->hyperv_vendor string so e.g. QMP's query-cpu-model-expansion output
is incorrect.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 20 ++++++++++----------
 target/i386/kvm.c |  4 ++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 45644f063947..c12d53938970 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6495,18 +6495,18 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
 {
     size_t len;
 
+    /* Hyper-V vendor id */
     if (!cpu->hyperv_vendor) {
-        memcpy(cpu->hyperv_vendor_id, "Microsoft Hv", 12);
-    } else {
-        len = strlen(cpu->hyperv_vendor);
-
-        if (len > 12) {
-            warn_report("hv-vendor-id truncated to 12 characters");
-            len = 12;
-        }
-        memset(cpu->hyperv_vendor_id, 0, 12);
-        memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
+        object_property_set_str(OBJECT(cpu), "hv-vendor-id", "Microsoft Hv",
+                                &error_abort);
+    }
+    len = strlen(cpu->hyperv_vendor);
+    if (len > 12) {
+        warn_report("hv-vendor-id truncated to 12 characters");
+        len = 12;
     }
+    memset(cpu->hyperv_vendor_id, 0, 12);
+    memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
 
     /* 'Hv#1' interface identification*/
     cpu->hyperv_interface_id[0] = 0x31237648;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d2fee220d653..67e650d1e810 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1214,6 +1214,10 @@ static int hyperv_handle_properties(CPUState *cs,
             cpu->hyperv_vendor_id[0] = c->ebx;
             cpu->hyperv_vendor_id[1] = c->ecx;
             cpu->hyperv_vendor_id[2] = c->edx;
+            cpu->hyperv_vendor = g_realloc(cpu->hyperv_vendor,
+                                           sizeof(cpu->hyperv_vendor_id) + 1);
+            memcpy(cpu->hyperv_vendor, cpu->hyperv_vendor_id,
+                   sizeof(cpu->hyperv_vendor_id));
         }
 
         c = cpuid_find_entry(cpuid, HV_CPUID_INTERFACE, 0);
-- 
2.25.4


