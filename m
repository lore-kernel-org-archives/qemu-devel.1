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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1811A2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PgfsCV+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1811A2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5U8n-0007eX-35
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5Tvp-00005T-NB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:38781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5Tvj-0000v8-6t
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597150967;
 bh=UQC8hbt7Y63znu/ljFuJ4oYlMH3w497UZ5X8j02VolI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PgfsCV+LgzEuCZMbOQWoWMlQfddX652fsk3UO0AYILRbtwnAlDCZb6YAz6we7tZ0B
 XhFYV0UvBFuz8H8zcdGSOF+DDb82o5EO7xCPmcr+hfIPiCDazZOGKEVjlpbGsRSXkb
 cP2ikBJ+VvsotKH6d6dIns5g7+UQfRkCHThLAXm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MoO2E-1kTZGB0BAW-00on8q; Tue, 11 Aug 2020 15:02:47 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 1/4] Add the NVMM vcpu API
Date: Tue, 11 Aug 2020 15:01:50 +0200
Message-Id: <20200811130153.4948-1-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200206213232.1918-2-n54@gmx.com>
References: <20200206213232.1918-2-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FU/Bc3r7McX3ycozbLrXHSAtWOz3DLt96ut2qPnHS+A/wHcZeF3
 tOYlloFxUG02zfj25s7Oaqzx3c5SXMZrBDZ6lKj0WgjCDuPMUkkxsKNCYLKsaqqIt22KTTi
 8y3QuCvZmRMLD7ABvclj0c65MLYu4Azde3vgoxgZwoQRlsokdU+VhpMo1bI+JLEOL5XM9Wz
 N1UkKKftDkaldJ4bY2vYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+6XTk8fVRTE=:4uv+Vz8132UryYHd/EITCT
 UDSPhJA/A41c8aAamjX9rHHe5ZnVra59vM9GqWtCXPzfxwnq2CaaqLIJlvDK6/ZEOhVei9/wl
 PZhSXotCgAsWEmm3s/x5TbC3VROqK+Vidh1tr9Dv8f4M+ch3NwLDi+9L8UDsQ8sPStg8wIK0l
 uS+AvAca1t2zbCjlH9n5WF2MKS1i7v9zJfpiHItaQEQCEFDb6kaJ6+jVkXm67E4H71f+Ta0ST
 LTVTzxeOpCEo2yLENPCoD/NI/ssO8YTXdQvwfEOAvcEpKi5H3BIs8qPgRzmBOBL6klmfXG8YB
 cekA+9fJjgPyL0a9Qb5q88G9T8cVSFeLq0KSCLyFZ7myxoOR/JSfPc66pdiHMJAadlji65p5E
 x0xxkQgi2yoozn6khHe5yQWIEE27BnctiWWD1wddE7MTaUiRnDPphxmLPMa4knvde6I1L9sCR
 a1tFIMtcipApfppZd/dDYv7ejXE59OJqqBVhPfxOo5Gw9LQCqXpLvRFE7P5uTM6NE+fPCrfvv
 xe82CnyNIaVY2N7IvRy1oaiqcsEMGdZdY0CVPPgi4GlxzadE+fEvmhA5P+3pLEE9vfU32v73m
 qFxyBQfynqvsW/8IWG/C8c+AHYFo+kk88h3E1C+H1f614AuTm694h6lMwCMOcRGlvUtVOAu10
 8plA2Kj23RU+Xv45NZrxq3JMkuY+YI3gGK/5ozQtEnhhiBDQFmPBdIQiWUnMQAAStg1vxkrX5
 uSLlY8iqzLjk655e2nF5wOYC33FSO6KvevTl1U1P0A7sf0absl1L7OfEdJshzrq6ns/5LH5uY
 dnGyt6qwPj9UXg2Oc0Zb4yvkkMkQGk1LctqjlXSul5nnS2G7UlBl7BNhgspDz5g31RjfLGkNC
 +1WOZuZi10JL6lBU9yk+xaU61bsZ/gl5JRKk9O0ecyuP9rpnIFy2xoUGaXpnIM4QklubLGfBX
 Q+jiEnv+RaCMiJrToUTxT4cRmv03hJuwqx7hTXRbAxeU3L7Z89MLEa0cC4D65CsqQS9CY37bx
 H3Q+Jvwz/26QlE0N0dtgfvWxH8iw7zzKMDwXGhnsmNXvUxvG0k5X38ADu9gugbZPZwPhuwU7N
 DY54LFm+4d4tkuF5d3vfU9Sm1Al/kOQGCTMrydzuM+Ar/kt6dNUD1BjWzrB+T0KshGNDj8PTm
 EWK53YrlKbk4W5y00xgEt5fsGfQ5iAZdtAKlSVXZAjB9E78HGcXnhWccjWlRNIm4pahNX1SxK
 bO56TrWnmMpczVuBt
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
X-Mailman-Approved-At: Tue, 11 Aug 2020 09:13:32 -0400
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
index bbd14e71fb..38660a0b9b 100644
=2D-- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,6 +1,7 @@
 obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
 obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
+obj-$(call lnot,$(CONFIG_NVMM)) +=3D nvmm-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
 obj-$(call lnot,$(CONFIG_XEN))  +=3D xen-stub.o
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
2.28.0


