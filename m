Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AB92073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY8Teg0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTIC-0005RN-GJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8c-0007cC-Lk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24568
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8a-0000w6-5Y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8CCQCgktXrkBHo81PhmgZOSOA7dyv1hYupPwxhHiIg=;
 b=CY8Teg0o9AUjcroRMXb9O/nvRpyQ9pm8xdqJd15tn2XxcFJMl3Z7BNGX/5+B9poKPULnAQ
 gjUqpYCr/TXnYPUw8kTiTVoxvUQOnUHhnpey3yuTXcPJEa+TSmfFQbAhoX6cJWC+39Ojy2
 o1NLLn2HTQSyxvTZ8tHRAZX+L22QS+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-ma5VKT5UPlGT_bAm3s80sw-1; Thu, 11 Jun 2020 15:45:16 -0400
X-MC-Unique: ma5VKT5UPlGT_bAm3s80sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81F5461;
 Thu, 11 Jun 2020 19:45:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 736F85D9DC;
 Thu, 11 Jun 2020 19:45:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 028/115] hw/i386/vmport: Set EAX to -1 on failed and
 unsupported commands
Date: Thu, 11 Jun 2020 15:43:22 -0400
Message-Id: <20200611194449.31468-29-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is used as a signal for VMware Tools to know if a command it
attempted to invoke, failed or is unsupported. As a result, VMware Tools
will either report failure to user or fallback to another backdoor command
in attempt to perform some operation.

A few examples:
* open-vm-tools TimeSyncReadHost() function fallbacks to
CMD_GETTIMEFULL command when CMD_GETTIMEFULL_WITH_LAG
fails/unsupported.
* open-vm-tools Hostinfo_NestingSupported() function verifies
EAX != -1 to check for success.
* open-vm-tools Hostinfo_VCPUInfoBackdoor() functions checks
if reserved-bit is set to indicate command is unimplemented.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200312165431.82118-5-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 83f0fe5c91..fc209d711b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "qxl-vga", "revision", "4" },
     { "fw_cfg", "acpi-mr-restore", "false" },
     { "vmport", "x-read-set-eax", "off" },
+    { "vmport", "x-signal-unsupported-cmd", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 3bb420a245..730b61fcaa 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -44,9 +44,12 @@
 #define VMPORT_MAGIC   0x564D5868
 
 /* Compatibility flags for migration */
-#define VMPORT_COMPAT_READ_SET_EAX_BIT      0
-#define VMPORT_COMPAT_READ_SET_EAX          \
+#define VMPORT_COMPAT_READ_SET_EAX_BIT              0
+#define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
+#define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
+#define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
+    (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -87,17 +90,23 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
 
     eax = env->regs[R_EAX];
     if (eax != VMPORT_MAGIC) {
-        goto out;
+        goto err;
     }
 
     command = env->regs[R_ECX];
     trace_vmport_command(command);
     if (command >= VMPORT_ENTRIES || !s->func[command]) {
         qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
-        goto out;
+        goto err;
     }
 
     eax = s->func[command](s->opaque[command], addr);
+    goto out;
+
+err:
+    if (s->compat_flags & VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD) {
+        eax = UINT32_MAX;
+    }
 
 out:
     /*
@@ -168,6 +177,8 @@ static Property vmport_properties[] = {
     /* Used to enforce compatibility for migration */
     DEFINE_PROP_BIT("x-read-set-eax", VMPortState, compat_flags,
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
+    DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
+                    VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2



