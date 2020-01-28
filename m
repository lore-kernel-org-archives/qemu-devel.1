Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8276C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653B124696
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TaupwFdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653B124696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRi6-0007cN-5h
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwRaD-0003HX-DE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwRaC-0005cJ-8z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:57449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwRaC-0005bT-08
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580220651;
 bh=OoHgIpPDwZT/Pi0VaFQwgC5IRulseQbJKr5lVQNbNWg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TaupwFdqoRqEgwCuQNKONOXie4+IkKiW0lfBGwFpKBpQoz/h0kR0XuhFNEy7WHUpC
 PPhz6lvLRVzxhmtvESfZrFum9e0iNL1Hp0ezi8cgQ35R8npsTyo4o8U5cYBOk06LhR
 suVRqCB7RNesmGY9R1K362WuyUrA+VxIi1gNV+o8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MWASe-1j3aQT1xpy-00XdTt; Tue, 28 Jan 2020 15:10:51 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, philmd@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
Subject: [PATCH v2 1/4] Add the NVMM vcpu API
Date: Tue, 28 Jan 2020 15:09:42 +0100
Message-Id: <20200128140945.929-2-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128140945.929-1-n54@gmx.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rTSJ6Vi5eEuJytv/jnXdWerXHKnL14v6wdqK/Q78EBeRTUE4OHt
 VATGJSUXBkGGOABd3elCdLeANW4b6RLa1kuiCI2Ux3a4DVq4L+VfbhMj6gIZKG/cbYC+Foc
 Ob+Xz9k60SwzS4U+hPPTjT8k3VtQrcFy6xyJxJqZ0pr/TFA630gaG9x21qGq3+kZCJthINT
 a+tGOzUiCeD088aDwe+Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cxTmhJIF5Js=:GQCs/up3wwqb7ihBdo8bxf
 svvvCp8//dNbHryQi8Ji3emaJaouFbtuKoD79ES7xEDvgiG00iZuEABRbcmZ6M3FK7vCDZdO7
 DLoyIk9kW3rnAHHqdTm94vWQE8hah0fLuxnnf+o8ZL2LwbDg+BNhQjTu2rkS3aKF7mpQbn4UD
 I/q4XUbcXkC3DYAHzoHhV0Bau8cmJWFtIWTO1iAXIJw/H06oayaX/IP6bPx6q3bXWsD6XJhmA
 pyxVQhc152gym8lzcojME8wi1czW0zOLVZIQZsgHTM2vC4Q630rSGOonikSJ1hvru8/Ac5nhf
 MLGE5utiG1y+UEfUY0y9S5/amova2mB6352kLOHE7ICoklwXaiffnEC6ZuyVahPu5sOQb3JfR
 W1RXap0PqE2LtCXTS4YolZwrI4coVKtFnTFO0wl+m5jaty9TA+L1n5899CogXtNe23lziwc9Z
 yfsyVacxCQq/Pp3s8hEiBhH192PVrw0gJPftsZglUjcfrM1YdiZeaAwT+lglyy3nlxHjU5/uj
 tnMJyM3FBcdpPP+JS4BQ+qf5Va8M/vK8EvtJuSsiYih67kWIITPry12Z29lWcaNYXaCN/aAMA
 94TpcsLpQxih3UymPSogCii25Pu1PzM4Wj5KRF4Ea+Wd+SvIVlVnTb09jPLwa/s3pwmM7MvVo
 33sSknF08e/rTnoE59+N2pfFMTpxaWATWdx9f1qQwF1rqxE5sZaedLU9jqxUAoC6NukNeE836
 YCLrnMfZ/0KiTKT5Q2rRP0cArioHG0hvyTIG7AUC2132TM9cikOv+/7MZTaDEeW6REfOrlmvP
 vgG/5YBFD/7GY0kBcaIN/vmH6beW+QHE60pnWxs88uKR2mBzIij/DDRnUKioT7onyzI/nLFX3
 I0uaoSbOhq3OFQ26C7FZzdODMzK96LoS5ZKaOKzRUOuyQrLzt+OuLLJv18xV1Y7H7PvSkkBc8
 24ecZLIcFX5IU0rjYc0AQzmwg2BsVkXtpNLwIL3KsPpDAzYJnD/uftzxPv5snB3P5bOCZrMxb
 uIAFicU3D8BZhMlg83ff7QLeewq0tiXnwxujOHH9gbfFPPQB5bDLLb/vxH0M4Y/BiGY3A+BF0
 i93aiN3xS2lZaRDD2njCZNlURdTYMMhYw5cpUf1oQ9TCY7q5SEyaYyfpvoVcO2tkTv8V/sHa3
 aeMtg8SpDdUNhu/c5YVbLjyt85kdL6Hvqfp7vYEPsTmcNBWzmByZOVumwE/Xn/x7pHS34=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
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
2.24.1


