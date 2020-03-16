Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBADC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81FB20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEqpVH6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81FB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtxq-00037L-1d
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHf-0004dM-7X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHd-0006CX-Uu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHd-00069f-Q0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ui04JwX7OiOXq/laFXLsBkQhZYSQ3MHjobkDuHeSfV0=;
 b=CEqpVH6AccFgE6OyyCvobv1P6Su+fxjdCjaDOipj+K1FNLRVvgp9YvCfFihycQxI/Tfo6F
 xz9i3oVdcgBOA4GL/CuoQYTAkOEVTH8EQUSecp0VpqqROHpmHtc3qIb56liFb/HcBZ3w9f
 XOf/H6Wpj+6COyfhAqaOudmA1ae+h8Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49--hHRivwnPAGm3piGG9OKrA-1; Mon, 16 Mar 2020 12:08:01 -0400
X-MC-Unique: -hHRivwnPAGm3piGG9OKrA-1
Received: by mail-wr1-f69.google.com with SMTP id 94so4577757wrr.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sJ9bxuRVskXYC2aJKl03+Z9cSr20F7Dbm9JRwxmo2e4=;
 b=QyEyovdQNVYULHVvN0tHBMkbt1rWR145B9b7oYnXwh6BpOe2zWiwUEQYMcMCUte8dA
 UCoR1yhLv9JCec7VNioJsGkHj69q/MfM9N+n2op/gk2iIVA9iU5VDOYJTXjAZi6u913b
 +5WnaJKfeJ/y+huDACR8gPEcB82Mkf7ZoxGXe9HLOQNvw41W+qt9CbUq+rcPCfJrIl87
 cAv104wweUGtZG9JTMRO9uImu+OgcyVLMRnQa/Q0Eue7D+Rdrwc+OJf0wTk7RqyERpD6
 d11gwpPvOiQ95QbM4lxNaypfz0PTPz1nGmnnsH567mflcTzZlGjzUvMbbrVC/lYbqe0Q
 cX5Q==
X-Gm-Message-State: ANhLgQ0eG9/TQE1lXsM+qAxi1CCeylr+ezoVBw6OOWV0/NVcafTf2Zd+
 sk1+NZEbuwSzPdS+EfVip2zjeKuuUq66b2nmpvasNndf6WQ5xSevhNg/2Y4c/lbbt4cHTaEcCyd
 njCUjAFwPnij53M8=
X-Received: by 2002:a5d:4488:: with SMTP id j8mr96058wrq.306.1584374879941;
 Mon, 16 Mar 2020 09:07:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsZjM9PYbzB11qOc3TO2Yn7YNmN1hMQ0DyCXu0fd112HXe4vZCCLfxIEsZneEmH7TNa6quBUA==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr96041wrq.306.1584374879656;
 Mon, 16 Mar 2020 09:07:59 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id f203sm206459wmf.18.2020.03.16.09.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/19] target/arm: Make m_helper.c optional via
 CONFIG_ARM_V7M
Date: Mon, 16 Mar 2020 17:06:30 +0100
Message-Id: <20200316160634.3386-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We've already got the CONFIG_ARM_V7M switch, but it currently can
not be disabled yet. The m_helper.c code should not be compiled
into the binary if the switch is not enabled. We also have to
provide some stubs in a separate file to make sure that we still
can link the other code without CONFIG_ARM_V7M.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190903154810.27365-4-thuth@redhat.com>
[PMD: add write_v7m_exception() stub when not using TCG,
      remove CONFIG_ARM_V7M=3Dy in default-configs/arm-softmmu.mak]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |  6 ----
 target/arm/cpu.h                |  7 ++++
 target/arm/m_helper-stub.c      | 59 +++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs        |  3 +-
 4 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 target/arm/m_helper-stub.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 511d74da58..7ae8006556 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,11 +1,5 @@
 # Default configuration for arm-softmmu
=20
-# CONFIG_SEMIHOSTING is always required on this architecture
-CONFIG_SEMIHOSTING=3Dy
-
-# TODO: ARM_V7M is currently always required - make this more flexible!
-CONFIG_ARM_V7M=3Dy
-
 # CONFIG_PCI_DEVICES=3Dn
 # CONFIG_TEST_DEVICES=3Dn
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991b6f..84e14ce5a9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1278,7 +1278,14 @@ void pmu_init(ARMCPU *cpu);
 /* Write a new value to v7m.exception, thus transitioning into or out
  * of Handler mode; this may result in a change of active stack pointer.
  */
+#if !defined(CONFIG_TCG)
+static inline void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
+{
+    g_assert_not_reached();
+}
+#else
 void write_v7m_exception(CPUARMState *env, uint32_t new_exc);
+#endif
=20
 /* Map EL and handler into a PSTATE_MODE.  */
 static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handl=
er)
diff --git a/target/arm/m_helper-stub.c b/target/arm/m_helper-stub.c
new file mode 100644
index 0000000000..9316a9995b
--- /dev/null
+++ b/target/arm/m_helper-stub.c
@@ -0,0 +1,59 @@
+/*
+ * ARM V7M related stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "internals.h"
+
+void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
+{
+    abort();
+}
+
+void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
+{
+    abort();
+}
+
+uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
+{
+    abort();
+}
+
+void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
+{
+    abort();
+}
+
+uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
+{
+    abort();
+}
+
+void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
+{
+    abort();
+}
+
+void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
+{
+    abort();
+}
+
+void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
+{
+    abort();
+}
+
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    abort();
+}
+
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
+{
+    abort();
+}
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index a0df58526b..993899d731 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -66,7 +66,8 @@ obj-y +=3D tlb_helper.o debug_helper.o
 obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
 obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
-obj-y +=3D m_helper.o
+obj-$(CONFIG_ARM_V7M) +=3D m_helper.o
+obj-$(call lnot,$(CONFIG_ARM_V7M)) +=3D m_helper-stub.o
=20
 obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
 obj-$(CONFIG_ARM_V5) +=3D cpu_v5.o
--=20
2.21.1


