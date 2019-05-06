Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524DC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACAC2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACAC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZ77-0004LS-AF
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:36:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5M-0002pU-Hb
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5L-0007IQ-2D
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:34:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:60065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hNZ5K-0007DN-PX
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:34:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 01:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; d="scan'208";a="155407038"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 01:34:41 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 16:33:07 +0800
Message-Id: <1557131596-25403-2-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v2 01/10] hw/boards: add struct CpuTopology to
 MachineState
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

To remove usages of global smp variables arch by arch,
a bisect friendly way is introduced to initialize struct
CpuTopology with duplicate ones; no semantic changes.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 include/hw/boards.h | 15 +++++++++++++++
 vl.c                |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6f7916f..dc89c6d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -231,6 +231,20 @@ typedef struct DeviceMemoryState {
 } DeviceMemoryState;
 
 /**
+ * CpuTopology:
+ * @cpus: the number of logical processors on the machine
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
+/**
  * MachineState:
  */
 struct MachineState {
@@ -272,6 +286,7 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
+    CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
 };
 
diff --git a/vl.c b/vl.c
index d9fea0a..43fd247 100644
--- a/vl.c
+++ b/vl.c
@@ -4099,6 +4099,11 @@ int main(int argc, char **argv, char **envp)
 
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
1.8.3.1


