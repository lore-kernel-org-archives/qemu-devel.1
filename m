Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD6D20771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Pmq09oI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD6D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDYk-0006yY-KW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVF-0001jw-PE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:39 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58114 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVD-0000WB-3G
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:37 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 5749B4C89A;
 Tue, 30 Jun 2020 10:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593512911; x=1595327312; bh=mc5EETSvNJkKYQCiUzu9RpiV7bYmTNQc+eO
 rchr6x10=; b=Pmq09oI1rE2mwqzn7HJI4QjFSsXnrUKzE276zQm0LHAr1JMLnrB
 DBflq9sXjj2/LKsk9JhcUgRa4kbdmWjDEHnZ8a9tmA/a6GIvx1i+rkXySEwNXn+O
 rx4ZMmfUH3oEtEpZkLY1OxRETF/MDO1wFb1rkPyJnbC0pFsp22j5whCQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 218jw2FH4Lbt; Tue, 30 Jun 2020 13:28:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 3AEAE4C84A;
 Tue, 30 Jun 2020 13:28:31 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:28:31 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 3/9] i386: hvf: Add hvf_cpu_synchronize_pre_loadvm()
Date: Tue, 30 Jun 2020 13:28:18 +0300
Message-ID: <20200630102824.77604-4-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200630102824.77604-1-r.bolshakov@yadro.com>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:12:32
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

hvf lacks an implementation of cpu_synchronize_pre_loadvm().

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/sysemu/hvf.h      |  1 +
 include/sysemu/hw_accel.h |  3 +++
 target/i386/hvf/hvf.c     | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 5214ed5202..1d40a8ec01 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -28,6 +28,7 @@ int hvf_vcpu_exec(CPUState *);
 void hvf_cpu_synchronize_state(CPUState *);
 void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
+void hvf_cpu_synchronize_pre_loadvm(CPUState *);
 void hvf_vcpu_destroy(CPUState *);
 void hvf_reset_vcpu(CPUState *);
 
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 80bce75921..e128f8b06b 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -73,6 +73,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_pre_loadvm(cpu);
+    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index be016b951a..efe9802962 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -325,6 +325,17 @@ void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
     run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
+static void do_hvf_cpu_synchronize_pre_loadvm(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    cpu->vcpu_dirty = true;
+}
+
+void hvf_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
+}
+
 static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 {
     int read, write;
-- 
2.26.1


