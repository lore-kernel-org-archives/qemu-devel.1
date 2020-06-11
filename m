Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8C62074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHppnoVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8C62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTlT-0005gm-IH
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT98-00086t-9B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT90-00018y-Cf
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsno5tlvM6Jk1Psxj6i69cWNRmy6+Mz9lMv8WAnRyrc=;
 b=YHppnoVaNuMD51WyKZ+hwnAQSvKXBbXDYLAcWFVVQlk/hqA6P0SZNaQScB/ugafX01MyDT
 LLHM1NBl/0BgvZs9U47ngwdPVTLZSGdVlh5FfP3DR0eDA1D+568RyasLvNWsLpzUReJyTT
 k2Psetwv1qHZfjHPXHztK+Q1hbdIhNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-uav9ZJblO_681N0rq2gBvA-1; Thu, 11 Jun 2020 15:45:43 -0400
X-MC-Unique: uav9ZJblO_681N0rq2gBvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 703768015CE;
 Thu, 11 Jun 2020 19:45:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02ED562509;
 Thu, 11 Jun 2020 19:45:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 065/115] hw/i386/vmport: Allow QTest use without crashing
Date: Thu, 11 Jun 2020 15:43:59 -0400
Message-Id: <20200611194449.31468-66-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Trying libFuzzer on the vmport device, we get:

  AddressSanitizer:DEADLYSIGNAL
  =================================================================
  ==29476==ERROR: AddressSanitizer: SEGV on unknown address 0x000000008840 (pc 0x56448bec4d79 bp 0x7ffeec9741b0 sp 0x7ffeec9740e0 T0)
  ==29476==The signal is caused by a READ memory access.
    #0 0x56448bec4d78 in vmport_ioport_read (qemu-fuzz-i386+0x1260d78)
    #1 0x56448bb5f175 in memory_region_read_accessor (qemu-fuzz-i386+0xefb175)
    #2 0x56448bb30c13 in access_with_adjusted_size (qemu-fuzz-i386+0xeccc13)
    #3 0x56448bb2ea27 in memory_region_dispatch_read1 (qemu-fuzz-i386+0xecaa27)
    #4 0x56448bb2e443 in memory_region_dispatch_read (qemu-fuzz-i386+0xeca443)
    #5 0x56448b961ab1 in flatview_read_continue (qemu-fuzz-i386+0xcfdab1)
    #6 0x56448b96336d in flatview_read (qemu-fuzz-i386+0xcff36d)
    #7 0x56448b962ec4 in address_space_read_full (qemu-fuzz-i386+0xcfeec4)

This is easily reproducible using:

  $ echo inb 0x5658 | qemu-system-i386 -M isapc,accel=qtest -qtest stdio
  [I 1589796572.009763] OPENED
  [R +0.008069] inb 0x5658
  Segmentation fault (core dumped)

  $ coredumpctl gdb -q
  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
  77          eax = env->regs[R_EAX];
  (gdb) p cpu
  $1 = (X86CPU *) 0x0
  (gdb) bt
  #0  0x00005605b54d0f21 in vmport_ioport_read (opaque=0x5605b7531ce0, addr=0, size=4) at hw/i386/vmport.c:77
  #1  0x00005605b53db114 in memory_region_read_accessor (mr=0x5605b7531d80, addr=0, value=0x7ffc9d261a30, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:434
  #2  0x00005605b53db5d4 in access_with_adjusted_size (addr=0, value=0x7ffc9d261a30, size=1, access_size_min=4, access_size_max=4, access_fn=
      0x5605b53db0d2 <memory_region_read_accessor>, mr=0x5605b7531d80, attrs=...) at memory.c:544
  #3  0x00005605b53de156 in memory_region_dispatch_read1 (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, size=1, attrs=...) at memory.c:1396
  #4  0x00005605b53de228 in memory_region_dispatch_read (mr=0x5605b7531d80, addr=0, pval=0x7ffc9d261a30, op=MO_8, attrs=...) at memory.c:1424
  #5  0x00005605b537c80a in flatview_read_continue (fv=0x5605b7650290, addr=22104, attrs=..., ptr=0x7ffc9d261b4b, len=1, addr1=0, l=1, mr=0x5605b7531d80) at exec.c:3200
  #6  0x00005605b537c95d in flatview_read (fv=0x5605b7650290, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3239
  #7  0x00005605b537c9e6 in address_space_read_full (as=0x5605b5f74ac0 <address_space_io>, addr=22104, attrs=..., buf=0x7ffc9d261b4b, len=1) at exec.c:3252
  #8  0x00005605b53d5a5d in address_space_read (len=1, buf=0x7ffc9d261b4b, attrs=..., addr=22104, as=0x5605b5f74ac0 <address_space_io>) at include/exec/memory.h:2401
  #9  0x00005605b53d5a5d in cpu_inb (addr=22104) at ioport.c:88

X86CPU is NULL because QTest accelerator does not use CPU.
Fix by returning default values when QTest accelerator is used.

Reported-by: Clang AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vmport.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 79ef25d223..89bda9108e 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -34,6 +34,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/qtest.h"
 #include "qemu/log.h"
 #include "cpu.h"
 #include "trace.h"
@@ -94,10 +95,14 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
     VMPortState *s = opaque;
     CPUState *cs = current_cpu;
     X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    CPUX86State *env;
     unsigned char command;
     uint32_t eax;
 
+    if (qtest_enabled()) {
+        return -1;
+    }
+    env = &cpu->env;
     cpu_synchronize_state(cs);
 
     eax = env->regs[R_EAX];
@@ -142,6 +147,9 @@ static void vmport_ioport_write(void *opaque, hwaddr addr,
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return;
+    }
     cpu->env.regs[R_EAX] = vmport_ioport_read(opaque, addr, 4);
 }
 
@@ -149,6 +157,9 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return -1;
+    }
     cpu->env.regs[R_EBX] = VMPORT_MAGIC;
     if (port_state->compat_flags & VMPORT_COMPAT_REPORT_VMX_TYPE) {
         cpu->env.regs[R_ECX] = port_state->vmware_vmx_type;
@@ -172,6 +183,9 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
 
+    if (qtest_enabled()) {
+        return -1;
+    }
     cpu->env.regs[R_EBX] = 0x1177;
     return ram_size;
 }
-- 
2.26.2



