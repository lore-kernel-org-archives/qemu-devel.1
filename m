Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCD720720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1CwaySq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCD720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjToJ-0002HU-Dw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9I-0008AB-Ii
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9F-0001Ca-1P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1F3nfkmKEdCTdED+n1i08y1sAXEB2o5OWQH399iTe9w=;
 b=J1CwaySqzUuOaP8wWW7LVZLntBfI1uHJKF3ZSBf/jUQwn75Riez2xld9hQR0idzoe31c4G
 GzJ0fd68e7/nzufJrG00iEakJ3RcYn1KeC2UsYMNTbwUZMYQQi/TF1K4OmcshYwsPJLSr+
 7gFyBpET0E+B9OF/oSxzKBtjK/wHWr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-2tDgYAk8O0mKOT4zMIWi2A-1; Thu, 11 Jun 2020 15:45:18 -0400
X-MC-Unique: 2tDgYAk8O0mKOT4zMIWi2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A60A0C04;
 Thu, 11 Jun 2020 19:45:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDE2E7E591;
 Thu, 11 Jun 2020 19:45:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 030/115] hw/i386/vmport: Report vmware-vmx-type in
 CMD_GETVERSION
Date: Thu, 11 Jun 2020 15:43:24 -0400
Message-Id: <20200611194449.31468-31-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

As can be seen from VmCheck_GetVersion() in open-vm-tools code,
CMD_GETVERSION should return vmware-vmx-type in ECX register.

Default is to fake host as VMware ESX server. But user can control
this value by "-global vmport.vmware-vmx-type=X".

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200312165431.82118-7-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c |  1 +
 hw/i386/vmport.c  | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fc209d711b..9a07e9333a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -45,6 +45,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "fw_cfg", "acpi-mr-restore", "false" },
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
+    { "vmport", "x-report-vmx-type", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index dfebaf5b73..dabb443367 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -46,10 +46,13 @@
 /* Compatibility flags for migration */
 #define VMPORT_COMPAT_READ_SET_EAX_BIT              0
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
+#define VMPORT_COMPAT_REPORT_VMX_TYPE_BIT           2
 #define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
     (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
+#define VMPORT_COMPAT_REPORT_VMX_TYPE           \
+    (1 << VMPORT_COMPAT_REPORT_VMX_TYPE_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -61,6 +64,7 @@ typedef struct VMPortState {
     void *opaque[VMPORT_ENTRIES];
 
     uint32_t vmware_vmx_version;
+    uint8_t vmware_vmx_type;
 
     uint32_t compat_flags;
 } VMPortState;
@@ -140,6 +144,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     X86CPU *cpu = X86_CPU(current_cpu);
 
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
+    if (port_state->compat_flags & VMPORT_COMPAT_REPORT_VMX_TYPE) {
+        cpu->env.regs[R_ECX] = port_state->vmware_vmx_type;
+    }
     return port_state->vmware_vmx_version;
 }
 
@@ -181,10 +188,30 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
     DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_flags,
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
+    DEFINE_PROP_BIT("x-report-vmx-type", VMPortState, compat_flags,
+                    VMPORT_COMPAT_REPORT_VMX_TYPE_BIT, true),
 
     /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
     DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
                        vmware_vmx_version, 6),
+    /*
+     * Value determines which VMware product type host report itself to guest.
+     *
+     * Most guests are fine with exposing host as VMware ESX server.
+     * Some legacy/proprietary guests hard-code a given type.
+     *
+     * For a complete list of values, refer to enum VMXType at open-vm-tools
+     * project (Defined at lib/include/vm_vmx_type.h).
+     *
+     * Reasonable options:
+     * 0 - Unset
+     * 1 - VMware Express (deprecated)
+     * 2 - VMware ESX Server
+     * 3 - VMware Server (Deprecated)
+     * 4 - VMware Workstation
+     * 5 - ACE 1.x (Deprecated)
+     */
+    DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_vmx_type, 2),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.26.2



