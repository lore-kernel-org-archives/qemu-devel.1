Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DA320738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Xxlc8UHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joESX-0006BF-Mf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO9-00081z-UK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32906 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO6-0006mU-6l
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D0DAA4C8B1;
 Wed, 24 Jun 2020 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593039659; x=1594854060; bh=5eLzJTuOmT/x7yLO7cQ7PGZ56UuXWSdJnvj
 6AQTqRfo=; b=Xxlc8UHtHofSP3SdkU26CTt1TdrFyo1B5zsDTqbTBEh3KU96fC6
 CUkFVHxMmNYoVyuQcdrf+PLAM8brlyHM8cgrpfVdlgQWodmMWKzIAB0d4a93J8c8
 dDYCbCGniZVYc/gWYJOdVX6h8tTDPf5jq4ZKIHpfAAE7CyHqc7zfWW84=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JLYubegpmftb; Thu, 25 Jun 2020 02:00:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id DF0334C8AD;
 Thu, 25 Jun 2020 02:00:57 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:57 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 4/8] i386: hvf: Implement CPU kick
Date: Thu, 25 Jun 2020 01:58:47 +0300
Message-ID: <20200624225850.16982-5-r.bolshakov@yadro.com>
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

HVF doesn't have a CPU kick and without it it's not possible to perform
an action on CPU thread until a VMEXIT happens. The kick is also needed
for timely interrupt delivery.

Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
thread, but it's different from what hv_vcpu_interrupt does. The latter
one results in invocation of mp_cpus_kick() in XNU kernel [1].

While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
compilation warnings.

1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 cpus.c                | 13 +++++++++----
 include/hw/core/cpu.h |  2 +-
 include/sysemu/hvf.h  |  1 +
 target/i386/hvf/hvf.c | 11 +++++++++++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index 26709677d3..36f38ce5c8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1783,10 +1783,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         return;
     }
     cpu->thread_kicked = true;
-    err = pthread_kill(cpu->thread->thread, SIG_IPI);
-    if (err && err != ESRCH) {
-        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
-        exit(1);
+
+    if (hvf_enabled()) {
+        hvf_vcpu_kick(cpu);
+    } else {
+        err = pthread_kill(cpu->thread->thread, SIG_IPI);
+        if (err && err != ESRCH) {
+            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
+            exit(1);
+        }
     }
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b79318..288a2bd57e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -438,7 +438,7 @@ struct CPUState {
 
     struct hax_vcpu_state *hax_vcpu;
 
-    int hvf_fd;
+    unsigned hvf_fd;
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 1d40a8ec01..aaa00cbf05 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -25,6 +25,7 @@ extern bool hvf_allowed;
 
 int hvf_init_vcpu(CPUState *);
 int hvf_vcpu_exec(CPUState *);
+void hvf_vcpu_kick(CPUState *);
 void hvf_cpu_synchronize_state(CPUState *);
 void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index efe9802962..4d254a477a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -966,6 +966,17 @@ int hvf_vcpu_exec(CPUState *cpu)
     return ret;
 }
 
+void hvf_vcpu_kick(CPUState *cpu)
+{
+    hv_return_t err;
+
+    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
+    if (err) {
+        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
+        exit(1);
+    }
+}
+
 bool hvf_allowed;
 
 static int hvf_accel_init(MachineState *ms)
-- 
2.26.1


