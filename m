Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01614C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 13:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FC021872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 13:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FC021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSLS8-0004K0-Ko
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 09:02:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMe-0007tU-VK
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMd-0002IU-KM
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:2555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hSLMZ-0002DD-IC; Sun, 19 May 2019 08:56:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 05:56:25 -0700
X-ExtLoop1: 1
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.98])
	by fmsmga001.fm.intel.com with ESMTP; 19 May 2019 05:56:24 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-trivial@nongnu.org
Date: Sun, 19 May 2019 04:54:24 +0800
Message-Id: <20190518205428.90532-7-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518205428.90532-1-like.xu@linux.intel.com>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v3 06/10] hw/s390x: Replace global smp
 variables with machine smp properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The global smp variables in s390x are replaced with smp machine properties.

A local variable of the same name would be introduced in the declaration
phase if it's used widely in the context OR replace it on the spot if it's
only used once. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ++-
 hw/s390x/sclp.c            | 2 +-
 target/s390x/cpu.c         | 3 +++
 target/s390x/excp_helper.c | 5 +++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ed1fe7a93e..692ad6e372 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -83,7 +83,7 @@ static void s390_init_cpus(MachineState *machine)
     /* initialize possible_cpus */
     mc->possible_cpu_arch_ids(machine);
 
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < machine->smp.cpus; i++) {
         s390x_new_cpu(machine->cpu_type, i, &error_fatal);
     }
 }
@@ -410,6 +410,7 @@ static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
 static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
+    unsigned int max_cpus = ms->smp.max_cpus;
 
     if (ms->possible_cpus) {
         g_assert(ms->possible_cpus && ms->possible_cpus->len == max_cpus);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a800cb..fac7c3bb6c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -64,7 +64,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
     read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
-    read_info->highest_cpu = cpu_to_be16(max_cpus - 1);
+    read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1df63d82c..f1e5c0d9c3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
+#include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
 #endif
@@ -193,6 +194,8 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int max_cpus = ms->smp.max_cpus;
     if (cpu->env.core_id >= max_cpus) {
         error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
                    ", maximum core-id: %d", cpu->env.core_id,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3a467b72c5..1c6938effc 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -31,6 +31,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/boards.h"
 #endif
 
 void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
@@ -300,6 +301,10 @@ static void do_ext_interrupt(CPUS390XState *env)
         g_assert(cpu_addr < S390_MAX_CPUS);
         lowcore->cpu_addr = cpu_to_be16(cpu_addr);
         clear_bit(cpu_addr, env->emergency_signals);
+#ifndef CONFIG_USER_ONLY
+        MachineState *ms = MACHINE(qdev_get_machine());
+        unsigned int max_cpus = ms->smp.max_cpus;
+#endif
         if (bitmap_empty(env->emergency_signals, max_cpus)) {
             env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
         }
-- 
2.21.0


