Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA912C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867992468E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D44TzvlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867992468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRdc-0004p8-H4
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwRaX-0003PF-2E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwRaV-0005uV-OI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:50553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwRaV-0005u8-F6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580220653;
 bh=cRgESy6sLo0BIQ+50LV01B/uYevHPkdheIzJwHdtPko=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D44TzvlCRJnuB1HFk4BUy/QoczmbTbvDYu/CXT4iXojKMzkly1ZU0J+adTC3zwIBH
 WUqTbm3N5ERAeZ6ZASuzPCqtWBA26sjQig8rUUj+sGmF0l0UlHq/q/LImAp0DbqZs/
 Vv/GDN31PUfD+gJYAh/yUrdhMlVDXTP3F6bV86hE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M9Wys-1itAKH0eIO-005Z1T; Tue, 28 Jan 2020 15:10:53 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, philmd@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
Subject: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
Date: Tue, 28 Jan 2020 15:09:45 +0100
Message-Id: <20200128140945.929-5-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128140945.929-1-n54@gmx.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WsZiGyDicBKO/T4XoU9HxVVmPgMXCvdft7rDaRfjFwvAQJDmEc4
 00HmYR3R/F+GzhZ/DCNmIls7RGKYqrdc2D32JpVU4hjse6KxouSKx3RbHUWgNolHo6yNUed
 i9Eby4TN/sMaRKjAlePiHqEpokRWtljU7ZW67qaW4wTJnqDTditeoI3C8Y/WdMypGCb58wy
 p3doh3dhtm3Kkj1yu1QcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LA6O0mCUXvM=:ADet+3e3fLTsQZ3rK/6uTR
 88adevBRofzb/Hs0f45L5h/QK/MxxjkryrN2LaDF5NAHzRIZbrJiqS4bVKhBcvqmJdmpSd/cP
 fyasCGjCz/JWE30W9ieynh43jQIVKeTOTJy0IrpzwpOBERSf2F7jRq47YHomqNG4bJHebsskz
 J8SYccmIPS+kluW2Wu71/1TCihKNp5wToTyzxElOh8bHnjAsXWY9W1urmZ69jGbM1A9ryTK/S
 jyaa6WatvsEQtIYZr2yj9z+9IdxiDaYaBLh+k4u1iP6HPswz4P2ITJTmmmtkvYs/fkSAXCtiL
 5z43pg7iRgMfl9NpxLyAUeZkh5rjbtqd/rpfbeLQfCFMm70Wa6zujD2SHzl7RDMFp0M6iCTcX
 npUnMrei4kVpxrARkc1RO0JyE31zrBtqM5zXHzBiG1/b9pxO1rp44zxOhzYCuXe39RRQv3H/u
 ez58/cEUYNdIlgqKwmKFGYK31gDM2iVB6vSlLyt+Axmstp3zOWZWdNb3vY/JSLL+NZX+zRbD2
 AXjbRdiZuIWpNFknBl0aK4AyKE8zb551j6GMcJp9cARtwlavKsmN/IEXd5KgMdQAqnKzM9kRb
 BEsMuj2DCxL+8mHgFlu3nCwGy7AkTTdAA85iC3EYbN77vGS/9DAXswbp5i59qdIwPgcjcTY10
 rRKjz3SHFLvBlDHOYSbdZVQfkUllPkw8tT66otNhxi1t3bNM5ZFDuO/OO5P7yh3Y6f05+8Yk9
 4Yvpupqj/yX0k5t3B4n6b47cy62/9hNGFzLz95tGJB+dVKG4psxlAaPVpGhBAH2mxu6lMuDTt
 9/jn4F1IbekqY9vigUcOmDo9X1i3uLVgX7a8HQk7em2ZOVAXXXuU7LfOxp4Vo7cPn8Hsxsrdo
 THwR1v8WiUfNkJfCu9uQE/PUohgZDgGDn9icBWd/HP5m0u0t0JATuiU5ciiRZsfhtjSA07cyc
 PfSF+cPXC/jdq/iOzpXpidgVD+/RrkI2sPD48yHKVSthI36vd9VcmmF0pXsZYRj99rPZ7OPWu
 m3Tf/gNgG0N4Pc4A/UDv1985ASWhIywCRj1BJYqcnqP5HiVxYCJT3TCSXnkSd5Bck1dxuClH+
 U+GcjyyCQ15BhLufoUDTyML7goSDt4JUEq+f07MRURwjrldagkbWwS8FB+PJBx9ExUZGqpna/
 IvxdixMxGUOz9olxCGaRoVbo7+e/GuD4V6yRRkyFt79Z5LGO7/5bwfQPqFRUF5a+irgy8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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
=2D--
 cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hw_accel.h | 14 ++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b472378b70..3c3f63588c 100644
=2D-- a/cpus.c
+++ b/cpus.c
@@ -42,6 +42,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"

 #include "qemu/thread.h"
@@ -1666,6 +1667,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
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
@@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
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
@@ -2069,6 +2125,8 @@ void qemu_init_vcpu(CPUState *cpu)
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
2.24.1


