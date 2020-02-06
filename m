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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C3C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4A5214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iR0Q0QqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4A5214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp9O-000701-9Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izome-0000Q4-5d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izomc-0007ho-Ls
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:34:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:41359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izomc-0007Zb-BT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581024809;
 bh=VRV1PLovQkLA2qojKHfddY9U+AMu/FeCVYXqj8PmJxM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iR0Q0QqTYtX/XFK4+azsps5SYYtwkrgtyi2XIpmYxHD+bOVJOJEKF4Qk7kX0Z1hMf
 BDUGxtiiUJkQbYxoCA6BQrnY82zLvwTvfnsoKayMvT5xm8JTmfs5jK7NLEtVjQlytd
 VTBN0UaR1hliRxdYB3h84/nJ5TV/GXIHbpdi9tMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M3lYB-1j0dr803b1-000prB; Thu, 06 Feb 2020 22:33:29 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v4 4/4] Add the NVMM acceleration enlightenments
Date: Thu,  6 Feb 2020 22:32:32 +0100
Message-Id: <20200206213232.1918-5-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206213232.1918-1-n54@gmx.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OdBHL44EfDbSDZKlcbBmW0xhsojvD2OKhQPP1npKozZsxRfPcF5
 FSwhU6xtCyRgghT3HzLqj82ZF9qTnGPe/GZv00Lm/WgGbYUjO5ryEfhiF9vBIW2CO6w7ETC
 wMqZL1T9LBQXXwLh3Z0cxtcNHgU6te0Ye23GDMsfLsrNR9heCGIy+6X5qQ0Uwy40/ltaHvq
 KOMG5zqIdvlRYcd78Q6dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ld6lYGcVUk=:ML9y4oRUTByKeYDHhBcnus
 P0/JTHpJ2jrYLpxH8VLlCXF6gYMXImKcGcpE+nDINAbZy0vowwVKvurX9enhfYFyEgFSpppzv
 gSFjAwz+SXOcBIZX+f1flJl3StacY64hzkEgRN4+iVr9b5uyd7w3kPdIxbIyeBW6xLCwxD0W5
 0tBiVxKNNI/CO4/+FgvqDv4YzVnpNrtATYw2WFiv6FqnT3AcVHrQWQLKHhTE41I7PefupLj1N
 PyjBya9hsC396bMuGJ2B6CVwjBHP3ax/Q/zSCwYEM53upPSZRWMCmFk2vjVJ0Ls1XAl5CW+cm
 ei7k7LXw+HbxV+Aeljwk/+Rf9yVR0aEkiHMZui5m9/szTIZKgIKlLxx/qPjiPdkDP7OKMS/mt
 c1wDORBfGLhLLHT98DG+K4N4tGmGJ8g446xxfDuPwlbzTWCuYB/xQJZXlw0IXvKtJswIJrQrb
 kffWgiYAFlN1mVsm62ULyQRkpmTku1Umzx+35+GgSpRae0OZA3Jpa3jkfySm87LssiEMQ7vlU
 24V6+XeuZ+zpRqUAZSr6swsAiqKY9YeET0L7V0MmqXtaj9pi2lYR67xQTXmi6+uPxZ7ZEAhO4
 vSxvBtk5Ownjjiq+FJNk00SyeyOLKl70pxCeZLpazfy482S2Yk4JwnM6t7MvwJE5V3K5whaJb
 uSsqY+uES+WiCO+LDkyL+G2ZmV8eSOj8zZKhzuSy15/6NvnWtQLGuXjYrCnz/9eNVfwWkuGNf
 VU8lLudGMDDKrsuLClkTZio0K5Osq6sVGLGrDSitlK2jdsBFSa8qJBneAlMzkMb2QsxbfYgbD
 y3udzA1/lt4q8OP7pdIme2SF+fWrNkFemZPnjkjEbBdbQp7j79z5jI2HdcXbsTV28/yUQ6Gbt
 aS/xP5BTrOVruN9LAbZ31364b1qp3/n7hWL9sGvJ77AJp5EOEg3Q1WZ4PUjWRJ1VNSf2qJYDA
 jJKUSL8lWIEFcBvi/r/2DPTSFQ2L5tD9ctzjlhuAG6LhBU7AL2XHsGUldq+befEvmRWh3T0Wm
 nzIUuk9ZFHxkKt5VDKfWyqmrmA2Xi2EtXcFYQ1abW1DN33/NDRAxZQdUX7R7uEuPEfliCJWs4
 5+EFqDl768cyMw09y95r3lEaP3I4JPCuHzJxa7f8a6p2+OSXFBwXbuXkqMo2C9Qy6ZCkczQ3b
 H5RFeXTlM8b0G1NuqTGH+Irwh/iY47NhKRFFQaLjN7y4Vc5fn3awLMFJ4NkuG2xZh9gVk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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


