Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7BAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7A320720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egwZe2cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7A320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTlB-0005N0-QB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9x-000130-Jy
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21617
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9v-0001Jo-MQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29AlYbIXVBIeOwrHqg3LZpvYsZ2xsGsqiqZLm2UcVxg=;
 b=egwZe2cPIgIfg72fpIYq+TLpgoDnCDjuPiJ3Zp0GJMU0InKwp7/QMwpIP0RvO7X0rjiOf1
 HyEdM3MLL/ymxqLbo/DYT0EBKrbKR6oR3DcVFxDSqyHQgG8Lr+lN3fgtKBIqey8uwPlkvG
 EZ/ZUR+co2Whc5kW6LvoHfHIHJXuVPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-U950Cc47Mm2BJra5LfFzoA-1; Thu, 11 Jun 2020 15:45:31 -0400
X-MC-Unique: U950Cc47Mm2BJra5LfFzoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 102AC107ACCA;
 Thu, 11 Jun 2020 19:45:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFD35C1B2;
 Thu, 11 Jun 2020 19:45:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 047/115] i386/kvm: fix a use-after-free when vcpu plug/unplug
Date: Thu, 11 Jun 2020 15:43:41 -0400
Message-Id: <20200611194449.31468-48-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

When we hotplug vcpus, cpu_update_state is added to vm_change_state_head
in kvm_arch_init_vcpu(). But it forgot to delete in kvm_arch_destroy_vcpu() after
unplug. Then it will cause a use-after-free access. This patch delete it in
kvm_arch_destroy_vcpu() to fix that.

Reproducer:
    virsh setvcpus vm1 4 --live
    virsh setvcpus vm1 2 --live
    virsh suspend vm1
    virsh resume vm1

The UAF stack:
==qemu-system-x86_64==28233==ERROR: AddressSanitizer: heap-use-after-free on address 0x62e00002e798 at pc 0x5573c6917d9e bp 0x7fff07139e50 sp 0x7fff07139e40
WRITE of size 1 at 0x62e00002e798 thread T0
    #0 0x5573c6917d9d in cpu_update_state /mnt/sdb/qemu/target/i386/kvm.c:742
    #1 0x5573c699121a in vm_state_notify /mnt/sdb/qemu/vl.c:1290
    #2 0x5573c636287e in vm_prepare_start /mnt/sdb/qemu/cpus.c:2144
    #3 0x5573c6362927 in vm_start /mnt/sdb/qemu/cpus.c:2150
    #4 0x5573c71e8304 in qmp_cont /mnt/sdb/qemu/monitor/qmp-cmds.c:173
    #5 0x5573c727cb1e in qmp_marshal_cont qapi/qapi-commands-misc.c:835
    #6 0x5573c7694c7a in do_qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:132
    #7 0x5573c7694c7a in qmp_dispatch /mnt/sdb/qemu/qapi/qmp-dispatch.c:175
    #8 0x5573c71d9110 in monitor_qmp_dispatch /mnt/sdb/qemu/monitor/qmp.c:145
    #9 0x5573c71dad4f in monitor_qmp_bh_dispatcher /mnt/sdb/qemu/monitor/qmp.c:234

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200513132630.13412-1-pannengyuan@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/kvm.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 00d1f4f013..37572bd437 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1634,6 +1634,7 @@ struct X86CPU {
 
     CPUNegativeOffsetState neg;
     CPUX86State env;
+    VMChangeStateEntry *vmsentry;
 
     uint64_t ucode_rev;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 95bbeb424b..ef2e0a81dd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1741,7 +1741,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    qemu_add_vm_change_state_handler(cpu_update_state, env);
+    cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
 
     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
     if (c) {
@@ -1852,6 +1852,8 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
         env->nested_state = NULL;
     }
 
+    qemu_del_vm_change_state_handler(cpu->vmsentry);
+
     return 0;
 }
 
-- 
2.26.2



