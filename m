Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB781C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29522073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKRLA2+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29522073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTP3-0007fJ-NV
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8j-0007kq-NL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8g-0000yn-Na
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLwSIiMBjs4NqM2XF+HJcz2FQ6/HNQCBfwuxpCEIsCY=;
 b=bKRLA2+5nsyPVx9khtGa+7gB4gM3uhcPUGN2ycGBcbr7HhRyg1iWINT2o+5XhcS4rL3I6L
 u5Yu+Bh4d2xtLrW9ZGk9LNjbTImCrXayT1Cc9NxBsePkIDR3O5MAUCPXiMJ3mEqNQlJOUQ
 7O0YSLBfWWGxP94XZtc6+gj9p8mtpwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-g_Y8B4l9OzCFEvsJpvjxcw-1; Thu, 11 Jun 2020 15:45:23 -0400
X-MC-Unique: g_Y8B4l9OzCFEvsJpvjxcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147D01800D41;
 Thu, 11 Jun 2020 19:45:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD665EE0E;
 Thu, 11 Jun 2020 19:45:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 033/115] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Date: Thu, 11 Jun 2020 15:43:27 -0400
Message-Id: <20200611194449.31468-34-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
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

This is VMware documented functionallity that some guests rely on.
Returns the BIOS UUID of the current virtual machine.

Note that we also introduce a new compatability flag "x-cmds-v2" to
make sure to expose new VMPort commands only to new machine-types.
This flag will also be used by the following patches that will introduce
additional VMPort commands.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200312165431.82118-10-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c        |  1 +
 hw/i386/vmport.c         | 22 ++++++++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a07e9333a..5460e62294 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
     { "vmport", "x-report-vmx-type", "off" },
+    { "vmport", "x-cmds-v2", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 359cdef1e0..8006ff91d4 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -32,6 +32,7 @@
 #include "hw/isa/isa.h"
 #include "hw/i386/vmport.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "cpu.h"
@@ -43,12 +44,15 @@
 #define VMPORT_COMPAT_READ_SET_EAX_BIT              0
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
 #define VMPORT_COMPAT_REPORT_VMX_TYPE_BIT           2
+#define VMPORT_COMPAT_CMDS_V2_BIT                   3
 #define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
     (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
 #define VMPORT_COMPAT_REPORT_VMX_TYPE           \
     (1 << VMPORT_COMPAT_REPORT_VMX_TYPE_BIT)
+#define VMPORT_COMPAT_CMDS_V2                   \
+    (1 << VMPORT_COMPAT_CMDS_V2_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -143,6 +147,18 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     return port_state->vmware_vmx_version;
 }
 
+static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    uint32_t *uuid_parts = (uint32_t *)(qemu_uuid.data);
+
+    cpu->env.regs[R_EAX] = le32_to_cpu(uuid_parts[0]);
+    cpu->env.regs[R_EBX] = le32_to_cpu(uuid_parts[1]);
+    cpu->env.regs[R_ECX] = le32_to_cpu(uuid_parts[2]);
+    cpu->env.regs[R_EDX] = le32_to_cpu(uuid_parts[3]);
+    return cpu->env.regs[R_EAX];
+}
+
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
@@ -170,9 +186,13 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &s->io, 0x5658);
 
     port_state = s;
+
     /* Register some generic port commands */
     vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
+    if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
+        vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
+    }
 }
 
 static Property vmport_properties[] = {
@@ -183,6 +203,8 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
     DEFINE_PROP_BIT("x-report-vmx-type", VMPortState, compat_flags,
                     VMPORT_COMPAT_REPORT_VMX_TYPE_BIT, true),
+    DEFINE_PROP_BIT("x-cmds-v2", VMPortState, compat_flags,
+                    VMPORT_COMPAT_CMDS_V2_BIT, true),
 
     /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
     DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index bbe2c58bf9..7f566ccc02 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -8,6 +8,7 @@ typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
 typedef enum {
     VMPORT_CMD_GETVERSION       = 10,
+    VMPORT_CMD_GETBIOSUUID      = 19,
     VMPORT_CMD_GETRAMSIZE       = 20,
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
-- 
2.26.2



