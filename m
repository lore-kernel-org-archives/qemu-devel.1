Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B4820730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T8GEMMCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B4820730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfxY-0007sE-Q4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izfov-0002Yx-AK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izfot-0003zE-SK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:60137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izfot-0003t3-IY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580990307;
 bh=eNjtduKHGVLXXHlDFnENrZb9KL6AvI1/37t03wDXsJI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T8GEMMCBpfIMzqSn9Rjwz36hy07OPH9RQUv5u158Hmrff0+0dnpO3vzn9Hkb7kzfB
 R39u/m72Fh6ZOCz7pM04+VoYeWmbi1PRf7jBcsLxfzSubI1arIw/1CbBoS555kUntE
 NUiYMA/1a+SXYk337GcnzWpL26HN7l6ytfG1y//M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N1fii-1jfDnG42GW-0122YX; Thu, 06 Feb 2020 12:58:27 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net
Subject: [PATCH v3 4/4] Add the NVMM acceleration enlightenments
Date: Thu,  6 Feb 2020 12:57:31 +0100
Message-Id: <20200206115731.13552-5-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206115731.13552-1-n54@gmx.com>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oaq9lgEYDppy0H9VpgcZIpyTVO/dOwj98tXgQk+P9N8wyL3ijXY
 hU1bau0nrQbasSsjL59AeSZ9Vl+bKP/8MWNH1FUgiqZzmTw66FbcPeU+VEPJdqoevrrrdpx
 RdRfa2Ajspc/WvdOI6dY92oAXNvgZhpOF77KF5w4HMNdZDdJ33fXEZz8gbHqcX5yyjNEbAB
 zl8WcnBJn1l/p6poiCypA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CFD3d0N62+s=:CUE5W9o+W1REtRYmOjbgiK
 borgpuois+zECLt9aV8Z5q4rdxgJOIzAXyxt4KXeyIEGvlKqvkaD2+AjDEtC+v+41XTkO6G9b
 l7hf/ikTcSlyR70s0pHil8ZOdmH2GMS0UpXqC4kobt2uKBlxFtAJMfAz71oVz4f2C8A7wV12C
 ZuJdyzH7m+1j1aw4+xsil4o1tKs2OzFB1gqQkGOWbn0+FwK7UoqUm2rYs+FdyQCjMvee5FDcA
 NMNQ1Rq9oOE/UX9lTYWXvUlTarWPHBd0pFJgrzlSOLA+jN2ZNmYyWrA3YWQFXRwju0bsAexuS
 Ixet4iMPisIbwU/woWOjyXH1rUrIy8UnjyzvvOtMJ/u/wJ944KLG75HLdk3WKkw2XYwtDBWBx
 Pb3S+4tW6la5yQX58+b9GRdeaYzBclRKAxlgs+4fR0vS0OOf4SVuC9YdvqD+BuAqoHlF4ZSF9
 1S0cJ+gi7Fr8mCGJ/2E1pje4eJes2jhiwo/aWZJQGWWveS7gPOo3kEFoCybcn7dw/xXcMwvL2
 Xy4iJ4yIn0Z1JSd6OXwrQuuBnBFUvSsqO3BCZk8X7vRsKSZp3aTKuEjM9IutJ0+lyj8LXuQJX
 9PPfwhqdDyPvnmKhIQGbxjCfnhbCgKLlKwwSjv6hqfOHdChCK5m6KiS139ScKm7u7z07P1PTu
 i2W6N3KggbgpsGV6dXaHyaDnPw+znNF9Q65r1Km6wPP+KQ1eyC3llxQ+GNPqAytstGjzrVuJg
 V4cgW+MhmCbVOU6sZwXjdqAKu1qrMwvV+68QyK7qVpbL3rmRCNkZTnCWeJY0WhxZRnnYd7FTx
 6dTGfzbRJE4c5FmPIfbCZJQQyPn9liTBvE78P+F0zv542DARh0yjA/pBFwTCGf/wAjGeuellh
 h8U9NKaAu+IBr7XYRSvBJewUia7ke58ijMOsj1sYAL14sW/BZ4m03tZet2lEQfOG/AOMlullo
 5GcGJJNDZ6LPCxGNb0//bnvwhRu5pujGpHHQT2u95DaYQWfh7vMuyPktw62rbHkIMZ6HUU6r+
 PS5u1ZK2rI8eabjxT4Knw2uPb2GzYaqYj4psCSw4ry/K2S8gZk26WpW+Wr9HKbOygfesTq0Dw
 gCWBZZhhZH/WSUu4LFDGqYoEpezNq8kwIRlriiLSx+l+ehJKPA9Pa8RkoBd0+uLlQ6nr563Ds
 qDaa2BpUPEdp+q3nNkmS7BPVX+7heZxtjNhxke1S4dFIPV0p546vwP7P5DpW3uEmDSqIM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
=2D--
 cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hw_accel.h | 14 ++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b4f8b84b61..f833da4a60 100644
=2D-- a/cpus.c
+++ b/cpus.c
@@ -42,6 +42,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"

 #include "qemu/thread.h"
@@ -1670,6 +1671,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
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
@@ -2038,6 +2081,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
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
@@ -2078,6 +2134,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
+    } else if (nvmm_enabled()) {
+        qemu_nvmm_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 0ec2372477..dbfa7a02f9 100644
=2D-- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -15,6 +15,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"

 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_state(cpu);
+    }
 }

 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -40,6 +44,10 @@ static inline void cpu_synchronize_post_reset(CPUState =
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
@@ -53,6 +61,9 @@ static inline void cpu_synchronize_post_init(CPUState *c=
pu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_init(cpu);
+    }
 }

 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -66,6 +77,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *=
cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_pre_loadvm(cpu);
+    }
 }

 #endif /* QEMU_HW_ACCEL_H */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3a6e4fabe..2e79d61329 100644
=2D-- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -981,7 +981,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess=
 access)
     X86CPU *cpu =3D env_archcpu(env);
     CPUState *cs =3D env_cpu(env);

-    if (kvm_enabled() || whpx_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
         env->tpr_access_type =3D access;

         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
=2D-
2.25.0

