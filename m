Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7902DC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5051E205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZDo-00028j-J8
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:43:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5X-0002xW-5e
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5V-0007QI-8y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:60079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hNZ5T-0007KN-I4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 01:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; d="scan'208";a="155407138"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 01:35:00 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 16:33:16 +0800
Message-Id: <1557131596-25403-11-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v2 10/10] cpu/topology: replace smp global
 variables with smp machine properties
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

At the end of this smp refactoring series, the global ones are removed
and only smp machine properties are fully applied and enabled.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 vl.c | 53 ++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/vl.c b/vl.c
index 34f05b2..a3e426c 100644
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
@@ -4094,26 +4094,25 @@ int main(int argc, char **argv, char **envp)
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
1.8.3.1


