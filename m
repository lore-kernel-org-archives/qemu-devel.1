Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95442C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA712073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekvPw2f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA712073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTIH-0005ap-ED
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8f-0007eF-20
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8a-0000vi-66
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNn3Gkj8eEfhoQRSqPAZgsCZ/OMlwZDfPyXZbMYK4G8=;
 b=ekvPw2f1JJti0PANIW1nPLl8K0sPvfrPexC0U7pyyrr9MM0Zd2WKOVrna0XHFkZ1nsoCva
 VqhLpcJCPlcVMF85WZtUE8c1xIj5aH+Cm+bfcBV1nh1HnskY4pl7STb/HXDhO4aW5dzUJ0
 nTx528PGzuc/gfzmyr0Liaicyd0leOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-fetYdvshP5yMK4nIpBvCuw-1; Thu, 11 Jun 2020 15:45:16 -0400
X-MC-Unique: fetYdvshP5yMK4nIpBvCuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5604D1800D41;
 Thu, 11 Jun 2020 19:45:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 009515D9DC;
 Thu, 11 Jun 2020 19:45:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 027/115] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
Date: Thu, 11 Jun 2020 15:43:21 -0400
Message-Id: <20200611194449.31468-28-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

vmport_ioport_read() returns the value that should propagate to vCPU EAX
register when guest reads VMPort IOPort (i.e. By x86 IN instruction).

However, because vmport_ioport_read() calls cpu_synchronize_state(), the
returned value gets overridden by the value in QEMU vCPU EAX register.
i.e. cpu->env.regs[R_EAX].

To fix this issue, change vmport_ioport_read() to explicitly override
cpu->env.regs[R_EAX] with the value it wish to propagate to vCPU EAX
register.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200312165431.82118-4-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index bb3a7b18b1..83f0fe5c91 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
     { "fw_cfg", "acpi-mr-restore", "false" },
+    { "vmport", "x-read-set-eax", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 5985167dcf..3bb420a245 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -43,6 +43,11 @@
 #define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
+/* Compatibility flags for migration */
+#define VMPORT_COMPAT_READ_SET_EAX_BIT      0
+#define VMPORT_COMPAT_READ_SET_EAX          \
+    (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
+
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
 typedef struct VMPortState {
@@ -51,6 +56,8 @@ typedef struct VMPortState {
     MemoryRegion io;
     VMPortReadFunc *func[VMPORT_ENTRIES];
     void *opaque[VMPORT_ENTRIES];
+
+    uint32_t compat_flags;
 } VMPortState;
 
 static VMPortState *port_state;
@@ -80,17 +87,33 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
     eax = env->regs[R_EAX];
     if (eax != VMPORT_MAGIC) {
-        return eax;
+        goto out;
     }
 
     command = env->regs[R_ECX];
     trace_vmport_command(command);
     if (command >= VMPORT_ENTRIES || !s->func[command]) {
         qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
-        return eax;
+        goto out;
+    }
+
+    eax = s->func[command](s->opaque[command], addr);
+
+out:
+    /*
+     * The call above to cpu_synchronize_state() gets vCPU registers values
+     * to QEMU but also cause QEMU to write QEMU vCPU registers values to
+     * vCPU implementation (e.g. Accelerator such as KVM) just before
+     * resuming guest.
+     *
+     * Therefore, in order to make IOPort return value propagate to
+     * guest EAX, we need to explicitly update QEMU EAX register value.
+     */
+    if (s->compat_flags & VMPORT_COMPAT_READ_SET_EAX) {
+        cpu->env.regs[R_EAX] = eax;
     }
 
-    return s->func[command](s->opaque[command], addr);
+    return eax;
 }
 
 static void vmport_ioport_write(void *opaque, hwaddr addr,
@@ -142,6 +165,9 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
 }
 
 static Property vmport_properties[] = {
+    /* Used to enforce compatibility for migration */
+    DEFINE_PROP_BIT("x-read-set-eax", VMPortState, compat_flags,
+                    VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2



