Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7AC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0A7206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLk1pIlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0A7206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5KQ-0008F2-Ni
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0002V3-Dn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0000Rb-Er
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0000Qf-BB
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nHVcHcfWe51+/F45Sy6N9CFUeM4/arakR0i0s8GPLo=;
 b=MLk1pIlvCRo9Ti5x9gPTeRWoxe0A6tdVAQErka2M6Hf+Ki9Gmh3XKLZXKQ1Rnb/CFQiuRU
 zdO1NY7UkKbnfj7p22wFxXJN3GXJAQLH3O/2gU2kmHBDzW7vsn5GY0UWyJc8FcTH+bXMAe
 NdAvnPkfwC8kgxyJiqcBSShIL98QQSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-tRmVu9sEPqSjiFsQbK0i2Q-1; Thu, 02 Apr 2020 15:06:51 -0400
X-MC-Unique: tRmVu9sEPqSjiFsQbK0i2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1ED107ACCA;
 Thu,  2 Apr 2020 19:06:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6899CDA0F2;
 Thu,  2 Apr 2020 19:06:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] i386: hvf: Reset IRQ inhibition after moving RIP
Date: Thu,  2 Apr 2020 15:06:34 -0400
Message-Id: <20200402190640.1693-10-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

The sequence of instructions exposes an issue:
  sti
  hlt

Interrupts cannot be delivered to hvf after hlt instruction cpu because
HF_INHIBIT_IRQ_MASK is set just before hlt is handled and never reset
after moving instruction pointer beyond hlt.

So, after hvf_vcpu_exec() returns, CPU thread gets locked up forever in
qemu_wait_io_event() (cpu_thread_is_idle() evaluates inhibition
flag and considers the CPU idle if the flag is set).

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200328174411.51491-1-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/vmx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 03d2c79b9c..ce2a1532d5 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -167,6 +167,8 @@ static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint=
64_t cr4)
=20
 static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
 {
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    CPUX86State *env =3D &x86_cpu->env;
     uint64_t val;
=20
     /* BUG, should take considering overlap.. */
@@ -176,6 +178,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint64_=
t rip)
    val =3D rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
    if (val & (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING)) {
+        env->hflags &=3D ~HF_INHIBIT_IRQ_MASK;
         wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY,
                val & ~(VMCS_INTERRUPTIBILITY_STI_BLOCKING |
                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
--=20
2.18.2



