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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A07C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E461D20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EW93lZzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E461D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfsP-000498-UP
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izfnu-0001ex-HB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izfnt-0008Nt-BX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:34287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izfnt-0008DF-1h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580990305;
 bh=9XpfaBBPgrfZTT7J0pH7RitqavvDUG/fe8lsu1Vybrc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EW93lZzNRpXJ5SxkllWu4StEo/llLldEKVBsA3rbnSuUPYUvbBiTQLI/wxuD2NcHY
 ivJktnvRPJkQI2/av5rKMKWc/nErnjTMtQccKa2mbQhlZxDOM9ZCsPw6YoL4RR8ibn
 nk/WL8ey9jwn1g4UZPi9dEt7qTKolg1YIE8wTevc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MAONX-1innpL41U3-00Brk6; Thu, 06 Feb 2020 12:58:25 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net
Subject: [PATCH v3 1/4] Add the NVMM vcpu API
Date: Thu,  6 Feb 2020 12:57:28 +0100
Message-Id: <20200206115731.13552-2-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206115731.13552-1-n54@gmx.com>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ofN6IsIMgWBPI45Q+q/RPVDIRr6bBY3cYL2JaQW6EACANhlMk3U
 F47ho8wIg3hBpWPl02iSb9AqfFVYzxToO+h0OoLVx6BWKXHViZutAoOSTPzH/4cH15+AWaX
 tCuC2N5/ExomNqzo9VpXCiAz0Ec/w9Ldb/yYte8RZ/NOr9czZ826X/ApZlZZ9rijnnRgW8z
 03NzuhKaZD0Eqypxk2ALw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5lHER6zVqGE=:nTg9pbEiCNfjYJNuXSRN6Z
 zrTQIkflW/i6jbAXOIzveQMzpGitMBQtyUQh6PlRZTlJNYi+nbJV1rcE9QIG0nMwg38r3SRw1
 73aCFLDaEdjKMWSPeMt6NbEGG6wgYdXcI8hpLplYomr0cmW0Ef7TwLt+ZBzXi+4OQoqFXVLzl
 bpyIWsDIHg8XkpGvDhyh33m/pTnOt/Pt7ooVzIb480QrhH6g89sCRyq06cxYGGK+Tk92zcq7K
 8dhrEJJbQCjH1G/f94DH1rch1Oz2SCB1u3NtJNGj0V6mgoXfnLZX2OATcg4byV8e/v7Q5oC1T
 jn0fQPApQ4D/80fl1Ka/yHcCKcMyNpxE9N5AoymIkOX8K+38+aeSzl3ZUURNa/Vn11uObR6Ts
 XXw9aLwGNLHOnY5bkVYTK0etDssTPMF/e2YDBOyaNaHbgruJCP3wGHCpufHKZehekDbTuaLii
 pvD5eV1ho79+zbqdWNuxeAdlrhspErjvfV76KLFhFKy9PpeNeVMbil/0dhXbKKpi2RuvXbu5v
 Js9WuqqQzpUPOI0HvfkiijjGbdejuLlwbdIp4nSKXRVPVd0qWsKuiqljNGd2r+D6fHgkZ3250
 h5s6x8+5bAtIUM8ruScx1kW5pSNShBYJLfJT6kcyAETUE1gSu0KHBnkxFPtTzMi4ikKyAp1QT
 bt194SdTvb8rVfq7Da1/vhiD0PniDYnViP/hK29Wz4uBhofp8qAB5PW00bAMedm8wTXl/Nkpl
 VgdGIZuWJRpNV6kUbDXyFxzHFYp5dJXiYysyZlWgt1kIVO2mCo2dydAlYCbr+XNL7wHEvUyGo
 p7E8nHk9NSPxWIMLLc1KY28oiOEblDqkpXqUpACUfN83Gv0t4TEHB/SL07MFWJfnds/TUZDkO
 Vxi1vk1waNsK9iwx9xDqtkwyAhcXyBMhWx4pUdIr2GAUL+QyQYHN4qaTVvCYko/Vn4bcSJSid
 sS+yK+NINjQbgRLxMdZJCLYVq3KB1lDvyjUEVc3g5XVW7LWDteStfdsJzRWDmmsWwYTiMEU40
 jD7CUbD7EicIXKFQB2YHjOJEsXNhoZNHr6ONRgvzIJcaYI4TGhJn5IGtI5Ir/cCZYWYYRIJFX
 /G29y1+tJxzlfBScIQY7iiaDBimvhXiuzgrm7lDDlvmjc1d/oVRq9HVzHvYLqqdQwVlzkfzqm
 T3j2VPV9If5XMJ9+xjlhoYE8jvnPxV0k9WNbmGmfi36YoJkjhCX4j3+A8YpzL0P+afbYU=
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

Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
introduces the nvmm.h sysemu API for managing the vcpu scheduling and
management.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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

