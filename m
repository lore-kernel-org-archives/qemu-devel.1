Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA29C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF6B2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Xwf9qjNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF6B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEPQ-0001Bd-6S
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO6-0007xp-GJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:02 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32864 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO4-0006kf-PX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:02 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id C834D4C8A5;
 Wed, 24 Jun 2020 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593039656; x=1594854057; bh=oeWDG+WWzJ1ddsNbdkQSnBzk7CCguEOTiGP
 81HTc41Y=; b=Xwf9qjNIRZOlojOtE4pFELU6gZrQRyl6kxUq3a9c0WL591g7Vbe
 2NywKILBe+YAM4FpHhBDkJ0jI9ECx4RPYurlKicHD3oFL/OIcZnxWXm8vGYbyPot
 CSmROhr9aevHwJVJ29s+Ip9a8Ney9TC4mogjhPPJ7eX+gNJ5t2drBTzo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mShg5_6uawVf; Thu, 25 Jun 2020 02:00:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 48D334C8A8;
 Thu, 25 Jun 2020 02:00:56 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:56 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/8] i386: hvf: Set env->eip in macvm_set_rip()
Date: Thu, 25 Jun 2020 01:58:44 +0300
Message-ID: <20200624225850.16982-2-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200624225850.16982-1-r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 19:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_synchronize_state() is currently no-op for hvf but BIOS will hang in
vAPIC option ROM when cpu_synchronize_state() is wired to
hvf_cpu_synchronize_state().

cpu_synchronize_state() state is called from vapic_write() during option
ROM initialization. It sets dirty flag on the cpu. macvm_set_rip() is
then invoked to advance IP after the I/O write to vAPIC port.

macvm_set_rip() only modifies VMCS, it doesn't change env->eip.
Therefore on the next iteration of vCPU loop, vcpu_dirty flag is checked
and hvf_put_registers() overwrites correct RIP in VMCS with the value of
env->eip that points to the I/O write instruction. Execution of the CPU
gets stuck on the instruction.

The issue can be avoided if eip doesn't contain stale value when dirty
flag is set on cpu.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index ce2a1532d5..1e8b29bf7d 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -173,6 +173,7 @@ static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
 
     /* BUG, should take considering overlap.. */
     wreg(cpu->hvf_fd, HV_X86_RIP, rip);
+    env->eip = rip;
 
     /* after moving forward in rip, we need to clean INTERRUPTABILITY */
    val = rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
-- 
2.26.1


