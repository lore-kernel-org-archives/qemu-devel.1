Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C585C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD71206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EMB+I8Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD71206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5UNQ-00057w-EY
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5Twa-0000D9-28
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:49625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5TwX-0000zu-PU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597151022;
 bh=ZQ0DzVPA2iYTtjlzNojomsX+j/smyo/M5PvfBoj6A6E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EMB+I8XoKO6BKAS2cydc2csaj6Dx60Wcd+dpvaMG8mQGiBxzTSk/g0Aup7sWSWgpc
 2Wny0L4bZ3yft60yUkwk6CqHlFSnTtr+dAYizAjchpG8sIRl8KzCOCaiqlysXdrEaw
 BmNOErkWM2fabTAjEkuVtiWJqQpedwMtJziwh+hc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M2f9h-1k8VXd1LeJ-0047rT; Tue, 11 Aug 2020 15:03:42 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 4/4] Add the NVMM acceleration enlightenments
Date: Tue, 11 Aug 2020 15:01:53 +0200
Message-Id: <20200811130153.4948-4-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811130153.4948-1-n54@gmx.com>
References: <20200206213232.1918-2-n54@gmx.com>
 <20200811130153.4948-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1m28CIjQ2yDBd7qC9MzSu3rPFL1yw0FCIsPwv899SpJW+YIpFU2
 dKUxso9VtUFBJxqtaxtPchxtJyBaph3O6GdoZ6eYtf9pl7g+34iix4b5nj5lznEzPCEAwpr
 86gOirZcnJKk3m2U4tcPGpTnFLhnSx7BfD/J+OcIHMQN9b4JRZG+WM5iWH61KJpMJ0FNAW6
 rrpq1ZH6p67ioku/utPIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7L5jsnifqI=:fKC8Nb4d4hUq/WI9x3zY76
 E8eg3m8Qupv2zKl5pgkoXWk1L4qw9h6F19mDvhXho66PiYwOTk/wrMwDAHOqkbQmw48dwf7u1
 sB4MvnE/c9BVWJcJWHt+y9SqZ2hBo2yRMXU9vora3DgYE6vL4m+aLkgt+dLzbjgPHzdLAtMkj
 fXQCA/cX3koZhkKtOtQlz9m2xp1++dyuleCghDN0inSAaF2BWnQAzkQ847hl6W4shmOFRjn2T
 EDZR5Vb1yUMF9eZtRgVaU8Ak/+lbR8DhSRcAo38WJz3TVtkW51qNB/ZPOb6FmLS6936yef5j8
 5Da2At2nSg3mUqWTNN/Y5pJ2XoE6IP5GOi3pLz535mwP6PF+grszgwoy7lmLFWZBn1rBmxr0r
 WmshQ9RfSFr9d743nk7qbaka2tnKPnfab5UqrYKg237P7xcHSFJ0nJUUUEGQ/uqTiw0Qds+9i
 DbC6gZ6+CxedDVbLCnUEF1i7FzJUOgW8nHi5APeSf1liiyOpr7t3fc50ViXbKzKHntNf7tDI2
 Xs8Mz/TTf14aGioTL8tp6ZaiRys9L0k8XFnGdPKDh6EvYIyMDJouF3pF9qZ+bi0KuyWtHfiGR
 78B9OO+oAItAu9SFHZC51VHPloxi8q69pXf92Wf7nVWeIp6Y75O35yey0J10YmCqIBlu7KufV
 9jOXnJHlgX+KXFx4hiJier/UQBjGJaolBApAquD837ZpOHKqDLHuPo9SuY3yU5UkG+x6ZS5qS
 ubZCweImMrA5iNvmqJAGcPz/Rr/dZ8TM2etYF4LK1/+YrNdLujKca+al9zSTMAVyj41+LvJ4j
 RM9SDgC7O60tiyMRkWrUS/yk5G7MfkZKl++qRjfzdkrjtBYACKSV5wLiRqtpd6LPDjNxWFeR0
 rnjO/PO3w/6xtMNUhAdADl/co9CDWVYuVpHbXT0Ma+GSvTC9DbgGupKQh5mx8NsBKt6Ll0aAO
 5B//ZrFK8NmODApoqiAkbAF1bc+vtnW1jjuDpBQoT23We2+pFnfebjVtKxYmO73Q2QQHe2/I1
 tKXRgoeVN47jnzkmCZctHJLUT8iTE9WP2fy5MGD/UamIOgJ8f30YLomEsVK1oVC6rBGg+aUt+
 zMhr71rz77C5/JYfzOVMlOMf5BR1zHWRZbuqr80ll8PlF3/HZHUPUvgi79A8ixASgolzXjrGa
 CiG8czbOOoCn3WL1BzBUXXs6r+CvjRlO+9FIh/pciks91BMBELK3DMU28aHtwXfHhan0kJKxU
 44ugDZozkRk35+T2R
Received-SPF: pass client-ip=212.227.15.18; envelope-from=n54@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:02:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Aug 2020 09:13:33 -0400
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Implements the NVMM accelerator cpu enlightenments to actually use the nvm=
m-all
accelerator on NetBSD platforms.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
=2D--
 include/sysemu/hw_accel.h | 14 ++++++++++
 softmmu/cpus.c            | 58 +++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..9e19f5794c 100644
=2D-- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -16,6 +16,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"

 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -31,6 +32,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_state(cpu);
+    }
 }

 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -47,6 +51,10 @@ static inline void cpu_synchronize_post_reset(CPUState =
*cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_reset(cpu);
+    }
+
 }

 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -63,6 +71,9 @@ static inline void cpu_synchronize_post_init(CPUState *c=
pu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_init(cpu);
+    }
 }

 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -79,6 +90,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *=
cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_pre_loadvm(cpu);
+    }
 }

 #endif /* QEMU_HW_ACCEL_H */
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..3b44b92830 100644
=2D-- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -43,6 +43,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"

 #include "qemu/thread.h"
@@ -1621,6 +1622,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     return NULL;
 }

+static void *qemu_nvmm_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu =3D arg;
+    int r;
+
+    assert(nvmm_enabled());
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id =3D qemu_get_thread_id();
+    current_cpu =3D cpu;
+
+    r =3D nvmm_init_vcpu(cpu);
+    if (r < 0) {
+        fprintf(stderr, "nvmm_init_vcpu failed: %s\n", strerror(-r));
+        exit(1);
+    }
+
+    /* signal CPU creation */
+    cpu->created =3D true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r =3D nvmm_vcpu_exec(cpu);
+            if (r =3D=3D EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    nvmm_destroy_vcpu(cpu);
+    cpu->created =3D false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -1998,6 +2041,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }

+static void qemu_nvmm_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread =3D g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -2038,6 +2094,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
+    } else if (nvmm_enabled()) {
+        qemu_nvmm_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..c2f1aef65c 100644
=2D-- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -983,7 +983,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess=
 access)
     X86CPU *cpu =3D env_archcpu(env);
     CPUState *cs =3D env_cpu(env);

-    if (kvm_enabled() || whpx_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
         env->tpr_access_type =3D access;

         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
=2D-
2.28.0


