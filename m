Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242CCC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA8B2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA8B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLkk-000239-79
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp1-0007FR-AC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp0-0005WO-33
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKoq-0005Ki-DC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B2B386679;
 Tue,  2 Jul 2019 15:35:39 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D27F608C6;
 Tue,  2 Jul 2019 15:35:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:34:54 -0300
Message-Id: <20190702153535.9851-2-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 15:35:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 01/42] hw/boards: Add struct CpuTopology to
 MachineState
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The cpu topology property CpuTopology is added to the MachineState
and its members are initialized with the leagcy global smp variables.

From this commit, the code in the system emulation mode is supposed to
use cpu topology variables from MachineState instead of the global ones
defined in vl.c and there is no semantic change.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190518205428.90532-2-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h | 15 +++++++++++++++
 vl.c                |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index eaa050a7ab..31dab77b4b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -231,6 +231,20 @@ typedef struct DeviceMemoryState {
     MemoryRegion mr;
 } DeviceMemoryState;
 
+/**
+ * CpuTopology:
+ * @cpus: the number of present logical processors on the machine
+ * @cores: the number of cores in one package
+ * @threads: the number of threads in one core
+ * @max_cpus: the maximum number of logical processors on the machine
+ */
+typedef struct CpuTopology {
+    unsigned int cpus;
+    unsigned int cores;
+    unsigned int threads;
+    unsigned int max_cpus;
+} CpuTopology;
+
 /**
  * MachineState:
  */
@@ -273,6 +287,7 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
+    CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
 };
 
diff --git a/vl.c b/vl.c
index 99a56b5556..e9698cb1b1 100644
--- a/vl.c
+++ b/vl.c
@@ -4059,6 +4059,11 @@ int main(int argc, char **argv, char **envp)
 
     smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
+    current_machine->smp.cpus = smp_cpus;
+    current_machine->smp.max_cpus = max_cpus;
+    current_machine->smp.cores = smp_cores;
+    current_machine->smp.threads = smp_threads;
+
     /* sanity-check smp_cpus and max_cpus against machine_class */
     if (smp_cpus < machine_class->min_cpus) {
         error_report("Invalid SMP CPUs %d. The min CPUs "
-- 
2.18.0.rc1.1.g3f1ff2140


