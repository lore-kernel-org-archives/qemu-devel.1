Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6DC2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="NrWuDIZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6DC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEPV-0001K0-7f
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO9-00081d-Ox
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32950 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO7-0006nj-Ib
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 3000D4C8AF;
 Wed, 24 Jun 2020 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593039661; x=1594854062; bh=22wHRyTsBRe+6CKxRp3j1EgsD5Q4dokkEn8
 iGFdtGvA=; b=NrWuDIZG/1wEd7PirLoyCUY1w+7j5VfXgVIDsp1Zya/xT/rq46L
 MYyYNAruNosMCEoPg8meWSrbVIASKLiKpTzYr7p62GWhhQRqAwjFsuEe/e9K3W5f
 wb3qYtRgSRNbWjhXp1OSqFhoq+40H4TEzkEDQSO5eOf+wJtLFm9gSa7Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id it99qvdGabhf; Thu, 25 Jun 2020 02:01:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 87AEE4C8AB;
 Thu, 25 Jun 2020 02:00:59 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:59 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 7/8] i386: hvf: Clean up synchronize functions
Date: Thu, 25 Jun 2020 01:58:50 +0300
Message-ID: <20200624225850.16982-8-r.bolshakov@yadro.com>
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

Make them more concise and consitent with the rest of the code in the
file and drop non-relevant TODO.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/hvf.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0b2be8de47..18fe843834 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -282,27 +282,24 @@ void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
     }
 }
 
-/* TODO: synchronize vcpu state */
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
-    if (cpu_state->vcpu_dirty == 0) {
-        hvf_get_registers(cpu_state);
+    if (!cpu->vcpu_dirty) {
+        hvf_get_registers(cpu);
+        cpu->vcpu_dirty = true;
     }
-
-    cpu_state->vcpu_dirty = 1;
 }
 
-void hvf_cpu_synchronize_state(CPUState *cpu_state)
+void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (cpu_state->vcpu_dirty == 0) {
-        run_on_cpu(cpu_state, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    if (!cpu->vcpu_dirty) {
+        run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
 
-static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu,
+                                              run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
     uint64_t pdpte[4] = {0, 0, 0, 0};
     int i;
 
@@ -314,26 +311,25 @@ static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg
         wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
     }
 
-    hvf_put_registers(cpu_state);
-    cpu_state->vcpu_dirty = false;
+    hvf_put_registers(cpu);
+    cpu->vcpu_dirty = false;
 }
 
-void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
+void hvf_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
 }
 
 static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
-    CPUState *cpu_state = cpu;
-    hvf_put_registers(cpu_state);
-    cpu_state->vcpu_dirty = false;
+    hvf_put_registers(cpu);
+    cpu->vcpu_dirty = false;
 }
 
-void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
+void hvf_cpu_synchronize_post_init(CPUState *cpu)
 {
-    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
 static void do_hvf_cpu_synchronize_pre_loadvm(CPUState *cpu,
-- 
2.26.1


