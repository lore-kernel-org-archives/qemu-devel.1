Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E238C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 17:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C8620714
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 17:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="EpJOLEkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIFXH-0006qC-2F
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 13:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jIFWG-0006Hn-7u
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 13:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jIFWF-0000sP-1J
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 13:45:15 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:40972 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jIFWE-0000nQ-QD
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 13:45:14 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id DA561412DA;
 Sat, 28 Mar 2020 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1585417509; x=
 1587231910; bh=Udyoa3LjlUgI1rSeYge8kutvebyYOeEvQGZR6iYpivw=; b=E
 pJOLEkWLWL8hxJL57dz8RygMmQtoMV5CigiyC4VAekzNE4DfzGX5z2YeE+l1Jl0G
 zvhM9rk3dKhMxJStEAkDcUPEotuPRj0jWOeDJfZLO6mKpgmWGBAs/4CzxAczehAs
 0+l5r6S9sURQk9ye9tVoc0W5tiHlUBQ5sYu6Yy4XKE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1DHzTqAqgd4; Sat, 28 Mar 2020 20:45:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 059C5412CB;
 Sat, 28 Mar 2020 20:45:08 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sat, 28
 Mar 2020 20:45:09 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] i386: hvf: Reset IRQ inhibition after moving RIP
Date: Sat, 28 Mar 2020 20:44:12 +0300
Message-ID: <20200328174411.51491-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 target/i386/hvf/vmx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 03d2c79b9c..ce2a1532d5 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -167,6 +167,8 @@ static inline void macvm_set_cr4(hv_vcpuid_t vcpu, ui=
nt64_t cr4)
=20
 static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
 {
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    CPUX86State *env =3D &x86_cpu->env;
     uint64_t val;
=20
     /* BUG, should take considering overlap.. */
@@ -176,6 +178,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint6=
4_t rip)
    val =3D rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
    if (val & (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING)) {
+        env->hflags &=3D ~HF_INHIBIT_IRQ_MASK;
         wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY,
                val & ~(VMCS_INTERRUPTIBILITY_STI_BLOCKING |
                VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
--=20
2.24.1


