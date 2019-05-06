Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E98C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1032082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1032082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZ7E-0004SK-1L
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:36:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5P-0002qL-Ca
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5N-0007Jx-GD
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:34:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:60066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hNZ5N-0007EJ-5v
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:34:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 01:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; d="scan'208";a="155407103"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 01:34:54 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 16:33:13 +0800
Message-Id: <1557131596-25403-8-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v2 07/10] cpu/topology: add hw/s390x support
 for smp machine properties
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
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the replace rules, the global smp variables in s390x
are replaced with smp machine properties. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ++-
 hw/s390x/sclp.c            | 2 +-
 target/s390x/cpu.c         | 3 +++
 target/s390x/excp_helper.c | 5 +++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ed1fe7a..692ad6e 100644
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
index 4510a80..fac7c3b 100644
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
index b58ef0a..0601c2e 100644
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
index f84bfb1..77833e9 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -31,6 +31,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/boards.h"
 #endif
 
 void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
@@ -279,6 +280,10 @@ static void do_ext_interrupt(CPUS390XState *env)
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
1.8.3.1


