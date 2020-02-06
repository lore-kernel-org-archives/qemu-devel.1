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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD11C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD67121775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UGsEVrhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD67121775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izow8-0008DW-TN
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izomT-0008QX-4D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izomR-0006bV-TA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:48093)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izomR-0006W5-Jf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581024807;
 bh=43JXsEqXoI6zRifZU5jbyKDtX8fN//Y4L0FT1Lm+1hc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UGsEVrhH+zMDyFFNCtm9UDE6S0Pz1BvLAmHOH1d4hoDKmmI7iLuYlYkwC7yCZJz8U
 E6ZaInwzf7uVr4LRH01RPMiC1uugpfk+uKlEX78hXwUo33NhLY1dc6ldCdqzzxAPh4
 2d1THvhoQrz/NfLw3DLpuJvYG9+uDqa3fbQIFVCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MpUYu-1jIR4M3NUq-00ptFi; Thu, 06 Feb 2020 22:33:26 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v4 1/4] Add the NVMM vcpu API
Date: Thu,  6 Feb 2020 22:32:29 +0100
Message-Id: <20200206213232.1918-2-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206213232.1918-1-n54@gmx.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AgzSK0caQx13eSEYxLFtblYd8SM6UX5HBNwDUW7ZkzkG9+tqdJW
 sbWaUHjvJVcRNnbB508Mp57RClxzeUei89fri4nxA/18TS9A85poms4FFeyl0kluF4u2+2p
 6WzWTZ9445hOsmmG/qE7aoGzjOHAgG0dqH8maA0HrgqcLj+0jMKDqRrBl/pyokvNw9cj0Pq
 4BoX/kl3eAA0nK7W23AKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b4Rc2p62CZc=:CDeVeIabajuyYd3rR8bFvK
 3xLEpYnsI6RldasUVhytbRYoXqC27HlQcvHlHAzT7/D9quVXDWuugyfjHlEIPqB+XETDNRIvq
 CKyTA+Sopj7dpxZxiIQQNC74vDF/93d/ZIs3Nn1swVBSk0fpG/9S3nXDtZp9Fy8LTmTJ/RKGc
 9kYEJ2eFMWgVBDrZheEPbeJle0vvO2MGX8pqo1PORzmFkZzauYvcnaMKzghfxMmvDuvqDwDxg
 igvzq4NxFZ96csiFDXZyOe6MorwgFl3sDz6bEbOPQ4Y95QZqyquHPevchsook+p9Y0mycS7mJ
 OiDYTTYHf5Q+yOUj3qLogWfHQ381MlLx5tmn5k66oVTMbhmK0yuD1IPxzAjQL5Y8xg73WCLVX
 hTdliG25n1VeGprkfqp8FFy2Bna/tIWGV9s4VGDJRJNgp6tPH2KQJez32DbRUy7OTwJFQHZ5m
 i2OIo7/X5Ukj+5WqlqRIXUqUKypjOZ8qD/wQLZvgj9Rz629EN4c66tP9LKS25MC3e3ga3dOJC
 JrNhNg6Kph9JLlJiHXrTjB/wDLR2Bpd7fSu/TZV31l9ZrB4apJ63JUGvGG6/1Z55FsRE6k+iB
 sUVunQ5rslnpUGiUMA/9uApHv8HqAGzPiVIvKAmReikWmT6EFPV6ocrtxMD+lAuw47MpSqINs
 +trAKQuvbmHDazyg0V1RSbLrH9v9hptrAw5j0CK4AH9BiQX5G9fLCpiCQSWP7IMbYtDxtvFHZ
 ub5vuRI3Z4HknlU3YJv1WWFSapsMZi+a28OtSQd8b7qW59fAxQyrAM5O3xcCzJ2zcZU85SsbR
 fvf04GfNTCYxDyWSalMtrtaJAPd+yd/XmvBbXzWKghhjU6vVc+0zjjBQWRE8bjaiA6BDvmuyg
 O4n3A2J7bqK/Nj6F/uQYZjQa/k5729ieoGoaaJh6aTQ4trOgHTPT14y1PQQ4qU4ST7jxB+vn/
 TBmGJDXmFEcbPn9RYxLSVZ6uasbiACtV0vLLzrOisHixHw0lldNWHFV0tUDANQpDt4wi628Q2
 P46E9/wUgBh/7iob0P0DETIqs7liNlvBtt6j0YwERW31W/WxnAuaHaI0RX8Xa27djvs0HRpNo
 mNYPaeEKaVcfqxpOAu2boFhlb4Oje2qrZPacC0hgnAtuxQncjj47D0Yg8kOyDedqteUNlutfh
 vXEW5H3wuaBbqv1SdmnNmj4dyALs5q5ILyFmCO1+aAmJjtJjI9jwIPeb0LUNuJ7f4lj0c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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

Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
introduces the nvmm.h sysemu API for managing the vcpu scheduling and
management.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
=2D--
 accel/stubs/Makefile.objs |  1 +
 accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index 3894caf95d..09f2d3e1dd 100644
=2D-- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
 obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
+obj-$(call lnot,$(CONFIG_NVMM)) +=3D nvmm-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 0000000000..c2208b84a3
=2D-- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator stub.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/nvmm.h"
+
+int nvmm_init_vcpu(CPUState *cpu)
+{
+    return -1;
+}
+
+int nvmm_vcpu_exec(CPUState *cpu)
+{
+    return -1;
+}
+
+void nvmm_destroy_vcpu(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_state(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
new file mode 100644
index 0000000000..10496f3980
=2D-- /dev/null
+++ b/include/sysemu/nvmm.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator support.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_NVMM_H
+#define QEMU_NVMM_H
+
+#include "config-host.h"
+#include "qemu-common.h"
+
+int nvmm_init_vcpu(CPUState *);
+int nvmm_vcpu_exec(CPUState *);
+void nvmm_destroy_vcpu(CPUState *);
+
+void nvmm_cpu_synchronize_state(CPUState *);
+void nvmm_cpu_synchronize_post_reset(CPUState *);
+void nvmm_cpu_synchronize_post_init(CPUState *);
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *);
+
+#ifdef CONFIG_NVMM
+
+int nvmm_enabled(void);
+
+#else /* CONFIG_NVMM */
+
+#define nvmm_enabled() (0)
+
+#endif /* CONFIG_NVMM */
+
+#endif /* CONFIG_NVMM */
=2D-
2.25.0


