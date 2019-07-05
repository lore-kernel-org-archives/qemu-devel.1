Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF08EC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F6C20659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F6C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjX4k-0003I4-1c
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWV8-00084S-9c
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWV6-0003iU-MD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWV6-0003i9-6K
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B7748A004;
 Fri,  5 Jul 2019 22:16:15 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD3332B597;
 Fri,  5 Jul 2019 22:16:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Fri,  5 Jul 2019 19:14:50 -0300
Message-Id: <20190705221504.25166-29-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 05 Jul 2019 22:16:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 28/42] vl.c: Add -smp,
 dies=* command line support and update doc
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

For PC target, users could configure the number of dies per one package
via command line with this patch, such as "-smp dies=2,cores=4".

The parsing rules of new cpu-topology model obey the same restrictions/logic
as the legacy socket/core/thread model especially on missing values computing.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190620054525.37188-4-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c    | 30 +++++++++++++++++-------------
 vl.c            |  3 +++
 qemu-options.hx | 17 +++++++++--------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 894084c4e1..b9c55301a2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1540,9 +1540,12 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
  */
 void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 {
+    PCMachineState *pcms = PC_MACHINE(ms);
+
     if (opts) {
         unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
         unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
+        unsigned dies = qemu_opt_get_number(opts, "dies", 1);
         unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
         unsigned threads = qemu_opt_get_number(opts, "threads", 0);
 
@@ -1552,24 +1555,24 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
             threads = threads > 0 ? threads : 1;
             if (cpus == 0) {
                 sockets = sockets > 0 ? sockets : 1;
-                cpus = cores * threads * sockets;
+                cpus = cores * threads * dies * sockets;
             } else {
                 ms->smp.max_cpus =
                         qemu_opt_get_number(opts, "maxcpus", cpus);
-                sockets = ms->smp.max_cpus / (cores * threads);
+                sockets = ms->smp.max_cpus / (cores * threads * dies);
             }
         } else if (cores == 0) {
             threads = threads > 0 ? threads : 1;
-            cores = cpus / (sockets * threads);
+            cores = cpus / (sockets * dies * threads);
             cores = cores > 0 ? cores : 1;
         } else if (threads == 0) {
-            threads = cpus / (cores * sockets);
+            threads = cpus / (cores * dies * sockets);
             threads = threads > 0 ? threads : 1;
-        } else if (sockets * cores * threads < cpus) {
+        } else if (sockets * dies * cores * threads < cpus) {
             error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) < "
+                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) < "
                          "smp_cpus (%u)",
-                         sockets, cores, threads, cpus);
+                         sockets, dies, cores, threads, cpus);
             exit(1);
         }
 
@@ -1581,26 +1584,27 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
             exit(1);
         }
 
-        if (sockets * cores * threads > ms->smp.max_cpus) {
+        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
             error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) > "
+                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
                          "maxcpus (%u)",
-                         sockets, cores, threads,
+                         sockets, dies, cores, threads,
                          ms->smp.max_cpus);
             exit(1);
         }
 
-        if (sockets * cores * threads != ms->smp.max_cpus) {
+        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
             warn_report("Invalid CPU topology deprecated: "
-                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
                         "!= maxcpus (%u)",
-                        sockets, cores, threads,
+                        sockets, dies, cores, threads,
                         ms->smp.max_cpus);
         }
 
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        pcms->smp_dies = dies;
     }
 
     if (ms->smp.cpus > 1) {
diff --git a/vl.c b/vl.c
index 96d2456f70..280e709e2c 100644
--- a/vl.c
+++ b/vl.c
@@ -1231,6 +1231,9 @@ static QemuOptsList qemu_smp_opts = {
         }, {
             .name = "sockets",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "dies",
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "cores",
             .type = QEMU_OPT_NUMBER,
diff --git a/qemu-options.hx b/qemu-options.hx
index af850923f7..9621e934c0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -138,25 +138,26 @@ no incompatible TCG features have been enabled (e.g. icount/replay).
 ETEXI
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-    "-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]\n"
+    "-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,dies=dies][,sockets=sockets]\n"
     "                set the number of CPUs to 'n' [default=1]\n"
     "                maxcpus= maximum number of total cpus, including\n"
     "                offline CPUs for hotplug, etc\n"
-    "                cores= number of CPU cores on one socket\n"
+    "                cores= number of CPU cores on one socket (for PC, it's on one die)\n"
     "                threads= number of threads on one CPU core\n"
+    "                dies= number of CPU dies on one socket (for PC only)\n"
     "                sockets= number of discrete sockets in the system\n",
         QEMU_ARCH_ALL)
 STEXI
-@item -smp [cpus=]@var{n}[,cores=@var{cores}][,threads=@var{threads}][,sockets=@var{sockets}][,maxcpus=@var{maxcpus}]
+@item -smp [cpus=]@var{n}[,cores=@var{cores}][,threads=@var{threads}][,dies=dies][,sockets=@var{sockets}][,maxcpus=@var{maxcpus}]
 @findex -smp
 Simulate an SMP system with @var{n} CPUs. On the PC target, up to 255
 CPUs are supported. On Sparc32 target, Linux limits the number of usable CPUs
 to 4.
-For the PC target, the number of @var{cores} per socket, the number
-of @var{threads} per cores and the total number of @var{sockets} can be
-specified. Missing values will be computed. If any on the three values is
-given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
-specifies the maximum number of hotpluggable CPUs.
+For the PC target, the number of @var{cores} per die, the number of @var{threads}
+per cores, the number of @var{dies} per packages and the total number of
+@var{sockets} can be specified. Missing values will be computed.
+If any on the three values is given, the total number of CPUs @var{n} can be omitted.
+@var{maxcpus} specifies the maximum number of hotpluggable CPUs.
 ETEXI
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-- 
2.18.0.rc1.1.g3f1ff2140


