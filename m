Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2607C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 13:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFE521872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 13:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFE521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48515 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSLUP-000629-UI
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 09:04:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMh-0007x4-FJ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hSLMg-0002K8-93
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:56:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:2557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hSLMd-0002Di-5b; Sun, 19 May 2019 08:56:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 05:56:30 -0700
X-ExtLoop1: 1
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.98])
	by fmsmga001.fm.intel.com with ESMTP; 19 May 2019 05:56:29 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-trivial@nongnu.org
Date: Sun, 19 May 2019 04:54:28 +0800
Message-Id: <20190518205428.90532-11-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518205428.90532-1-like.xu@linux.intel.com>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v3 10/10] vl.c: Replace smp global variables
 with smp machine properties
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

The global smp variables in vl.c are completely replaced with machine properties.

Form this commit, the smp_cpus/smp_cores/smp_threads/max_cpus are deprecated
and only machine properties within MachineState are fully applied and enabled.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 vl.c | 53 ++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/vl.c b/vl.c
index 15d519e371..a700c93c77 100644
--- a/vl.c
+++ b/vl.c
@@ -162,10 +162,6 @@ static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 int win2k_install_hack = 0;
 int singlestep = 0;
-int smp_cpus;
-unsigned int max_cpus;
-int smp_cores = 1;
-int smp_threads = 1;
 int acpi_enabled = 1;
 int no_hpet = 0;
 int fd_bootchk = 1;
@@ -1282,8 +1278,9 @@ static void smp_parse(QemuOpts *opts)
                 sockets = sockets > 0 ? sockets : 1;
                 cpus = cores * threads * sockets;
             } else {
-                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
-                sockets = max_cpus / (cores * threads);
+                current_machine->smp.max_cpus =
+                        qemu_opt_get_number(opts, "maxcpus", cpus);
+                sockets = current_machine->smp.max_cpus / (cores * threads);
             }
         } else if (cores == 0) {
             threads = threads > 0 ? threads : 1;
@@ -1300,34 +1297,37 @@ static void smp_parse(QemuOpts *opts)
             exit(1);
         }
 
-        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
+        current_machine->smp.max_cpus =
+                qemu_opt_get_number(opts, "maxcpus", cpus);
 
-        if (max_cpus < cpus) {
+        if (current_machine->smp.max_cpus < cpus) {
             error_report("maxcpus must be equal to or greater than smp");
             exit(1);
         }
 
-        if (sockets * cores * threads > max_cpus) {
+        if (sockets * cores * threads > current_machine->smp.max_cpus) {
             error_report("cpu topology: "
                          "sockets (%u) * cores (%u) * threads (%u) > "
                          "maxcpus (%u)",
-                         sockets, cores, threads, max_cpus);
+                         sockets, cores, threads,
+                         current_machine->smp.max_cpus);
             exit(1);
         }
 
-        if (sockets * cores * threads != max_cpus) {
+        if (sockets * cores * threads != current_machine->smp.max_cpus) {
             warn_report("Invalid CPU topology deprecated: "
                         "sockets (%u) * cores (%u) * threads (%u) "
                         "!= maxcpus (%u)",
-                        sockets, cores, threads, max_cpus);
+                        sockets, cores, threads,
+                        current_machine->smp.max_cpus);
         }
 
-        smp_cpus = cpus;
-        smp_cores = cores;
-        smp_threads = threads;
+        current_machine->smp.cpus = cpus;
+        current_machine->smp.cores = cores;
+        current_machine->smp.threads = threads;
     }
 
-    if (smp_cpus > 1) {
+    if (current_machine->smp.cpus > 1) {
         Error *blocker = NULL;
         error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
         replay_add_blocker(blocker);
@@ -4128,26 +4128,25 @@ int main(int argc, char **argv, char **envp)
     machine_class->default_cpus = machine_class->default_cpus ?: 1;
 
     /* default to machine_class->default_cpus */
-    smp_cpus = machine_class->default_cpus;
-    max_cpus = machine_class->default_cpus;
+    current_machine->smp.cpus = machine_class->default_cpus;
+    current_machine->smp.max_cpus = machine_class->default_cpus;
+    current_machine->smp.cores = 1;
+    current_machine->smp.threads = 1;
 
     smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
-    current_machine->smp.cpus = smp_cpus;
-    current_machine->smp.max_cpus = max_cpus;
-    current_machine->smp.cores = smp_cores;
-    current_machine->smp.threads = smp_threads;
-
     /* sanity-check smp_cpus and max_cpus against machine_class */
-    if (smp_cpus < machine_class->min_cpus) {
+    if (current_machine->smp.cpus < machine_class->min_cpus) {
         error_report("Invalid SMP CPUs %d. The min CPUs "
-                     "supported by machine '%s' is %d", smp_cpus,
+                     "supported by machine '%s' is %d",
+                     current_machine->smp.cpus,
                      machine_class->name, machine_class->min_cpus);
         exit(1);
     }
-    if (max_cpus > machine_class->max_cpus) {
+    if (current_machine->smp.max_cpus > machine_class->max_cpus) {
         error_report("Invalid SMP CPUs %d. The max CPUs "
-                     "supported by machine '%s' is %d", max_cpus,
+                     "supported by machine '%s' is %d",
+                     current_machine->smp.max_cpus,
                      machine_class->name, machine_class->max_cpus);
         exit(1);
     }
-- 
2.21.0


