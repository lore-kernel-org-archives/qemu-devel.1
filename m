Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4C020578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4C020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcB61-0003hh-14
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxc-0002am-ME
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:56688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kcAxa-0005RF-Ch
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:28:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2457CAD1E;
 Mon,  9 Nov 2020 17:28:05 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wenchao Wang <wenchao.wang@intel.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v1 08/10] module: introduce MODULE_INIT_ACCEL_CPU
Date: Mon,  9 Nov 2020 18:27:53 +0100
Message-Id: <20201109172755.16500-9-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109172755.16500-1-cfontana@suse.de>
References: <20201109172755.16500-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:17:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Claudio Fontana <cfontana@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 Bruce Rogers <brogers@suse.com>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

apply this to the registration of the cpus accel interfaces,

but this will be also in preparation for later use of this
new module init step to also defer the registration of the cpu models,
in order to make them subclasses of a per-accel cpu type.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 accel/kvm/kvm-all.c               | 11 +++++++++--
 accel/qtest/qtest.c               | 10 +++++++++-
 accel/tcg/tcg-all.c               | 11 +++++++++--
 accel/xen/xen-all.c               | 12 +++++++++---
 include/qemu/module.h             |  2 ++
 softmmu/vl.c                      |  6 ++++++
 target/i386/accel/hax/hax-all.c   | 12 +++++++++---
 target/i386/accel/hvf/hvf.c       | 10 +++++++++-
 target/i386/accel/whpx/whpx-all.c | 11 +++++++++--
 9 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9ef5daf4c5..509b249f52 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2251,8 +2251,6 @@ static int kvm_init(MachineState *ms)
         ret = ram_block_discard_disable(true);
         assert(!ret);
     }
-
-    cpus_register_accel(&kvm_cpus);
     return 0;
 
 err:
@@ -3236,3 +3234,12 @@ static void kvm_type_init(void)
 }
 
 type_init(kvm_type_init);
+
+static void kvm_accel_cpu_init(void)
+{
+    if (kvm_enabled()) {
+        cpus_register_accel(&kvm_cpus);
+    }
+}
+
+accel_cpu_init(kvm_accel_cpu_init);
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index b282cea5cf..8d14059e32 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -32,7 +32,6 @@ const CpusAccel qtest_cpus = {
 
 static int qtest_init_accel(MachineState *ms)
 {
-    cpus_register_accel(&qtest_cpus);
     return 0;
 }
 
@@ -58,3 +57,12 @@ static void qtest_type_init(void)
 }
 
 type_init(qtest_type_init);
+
+static void qtest_accel_cpu_init(void)
+{
+    if (qtest_enabled()) {
+        cpus_register_accel(&qtest_cpus);
+    }
+}
+
+accel_cpu_init(qtest_accel_cpu_init);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa1208158f..9ffedc8151 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -104,8 +104,6 @@ static int tcg_init(MachineState *ms)
 
     tcg_exec_init(s->tb_size * 1024 * 1024);
     mttcg_enabled = s->mttcg_enabled;
-    cpus_register_accel(&tcg_cpus);
-
     return 0;
 }
 
@@ -201,3 +199,12 @@ static void register_accel_types(void)
 }
 
 type_init(register_accel_types);
+
+static void tcg_accel_cpu_init(void)
+{
+    if (tcg_enabled()) {
+        cpus_register_accel(&tcg_cpus);
+    }
+}
+
+accel_cpu_init(tcg_accel_cpu_init);
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 878a4089d9..6932a9f364 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -185,9 +185,6 @@ static int xen_init(MachineState *ms)
      * opt out of system RAM being allocated by generic code
      */
     mc->default_ram_id = NULL;
-
-    cpus_register_accel(&xen_cpus);
-
     return 0;
 }
 
@@ -228,3 +225,12 @@ static void xen_type_init(void)
 }
 
 type_init(xen_type_init);
+
+static void xen_accel_cpu_init(void)
+{
+    if (xen_enabled()) {
+        cpus_register_accel(&xen_cpus);
+    }
+}
+
+accel_cpu_init(xen_accel_cpu_init);
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 944d403cbd..485eda986a 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -44,6 +44,7 @@ typedef enum {
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
     MODULE_INIT_QOM,
+    MODULE_INIT_ACCEL_CPU,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
@@ -54,6 +55,7 @@ typedef enum {
 #define block_init(function) module_init(function, MODULE_INIT_BLOCK)
 #define opts_init(function) module_init(function, MODULE_INIT_OPTS)
 #define type_init(function) module_init(function, MODULE_INIT_QOM)
+#define accel_cpu_init(function) module_init(function, MODULE_INIT_ACCEL_CPU)
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index a537a0377f..6a6363902d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4174,6 +4174,12 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     configure_accelerators(argv[0]);
 
+    /*
+     * accelerator has been chosen and initialized, now it is time to
+     * register the cpu accel interface.
+     */
+    module_call_init(MODULE_INIT_ACCEL_CPU);
+
     /*
      * Beware, QOM objects created before this point miss global and
      * compat properties.
diff --git a/target/i386/accel/hax/hax-all.c b/target/i386/accel/hax/hax-all.c
index fecfe8cd6e..3bada019f5 100644
--- a/target/i386/accel/hax/hax-all.c
+++ b/target/i386/accel/hax/hax-all.c
@@ -364,9 +364,6 @@ static int hax_accel_init(MachineState *ms)
                 !ret ? "working" : "not working",
                 !ret ? "fast virt" : "emulation");
     }
-    if (ret == 0) {
-        cpus_register_accel(&hax_cpus);
-    }
     return ret;
 }
 
@@ -1141,3 +1138,12 @@ static void hax_type_init(void)
 }
 
 type_init(hax_type_init);
+
+static void hax_accel_cpu_init(void)
+{
+    if (hax_enabled()) {
+        cpus_register_accel(&hax_cpus);
+    }
+}
+
+accel_cpu_init(hax_accel_cpu_init);
diff --git a/target/i386/accel/hvf/hvf.c b/target/i386/accel/hvf/hvf.c
index ed9356565c..249b77797f 100644
--- a/target/i386/accel/hvf/hvf.c
+++ b/target/i386/accel/hvf/hvf.c
@@ -887,7 +887,6 @@ static int hvf_accel_init(MachineState *ms)
   
     hvf_state = s;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
-    cpus_register_accel(&hvf_cpus);
     return 0;
 }
 
@@ -911,3 +910,12 @@ static void hvf_type_init(void)
 }
 
 type_init(hvf_type_init);
+
+static void hvf_accel_cpu_init(void)
+{
+    if (hvf_enabled()) {
+        cpus_register_accel(&hvf_cpus);
+    }
+}
+
+accel_cpu_init(hvf_accel_cpu_init);
diff --git a/target/i386/accel/whpx/whpx-all.c b/target/i386/accel/whpx/whpx-all.c
index f4f3e33eac..2e715e2bc6 100644
--- a/target/i386/accel/whpx/whpx-all.c
+++ b/target/i386/accel/whpx/whpx-all.c
@@ -1642,8 +1642,6 @@ static int whpx_accel_init(MachineState *ms)
 
     whpx_memory_init();
 
-    cpus_register_accel(&whpx_cpus);
-
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
@@ -1713,3 +1711,12 @@ error:
 }
 
 type_init(whpx_type_init);
+
+static void whpx_accel_cpu_init(void)
+{
+    if (whpx_enabled()) {
+        cpus_register_accel(&whpx_cpus);
+    }
+}
+
+accel_cpu_init(whpx_accel_cpu_init);
-- 
2.26.2


