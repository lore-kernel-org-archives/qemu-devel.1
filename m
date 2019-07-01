Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65711C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE482184C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE482184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwqx-0007LV-Cg
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41225)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKl-0002SE-Ak
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKk-0002V6-2O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKb-000257-F7; Mon, 01 Jul 2019 09:26:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BDCC308624A;
 Mon,  1 Jul 2019 13:26:35 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3CA06085B;
 Mon,  1 Jul 2019 13:26:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:06 +0200
Message-Id: <20190701132516.26392-18-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 01 Jul 2019 13:26:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 17/27] target/arm/vfp_helper: Restrict the
 SoftFloat use to TCG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code is specific to the SoftFloat floating-point
implementation, which is only used by TCG.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/vfp_helper.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 838f7d25fd..46041e3294 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -18,17 +18,20 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "fpu/softfloat.h"
 #include "internals.h"
-
+#ifdef CONFIG_TCG
+#include "qemu/log.h"
+#include "fpu/softfloat.h"
+#endif
=20
 /* VFP support.  We follow the convention used for VFP instructions:
    Single precision routines have a "s" suffix, double precision a
    "d" suffix.  */
=20
+#ifdef CONFIG_TCG
+
 /* Convert host exception flags to vfp form.  */
 static inline int vfp_exceptbits_from_host(int host_bits)
 {
@@ -145,6 +148,19 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, =
uint32_t val)
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
 }
=20
+#else
+
+static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+{
+    return 0;
+}
+
+static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
+{
+}
+
+#endif
+
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
     uint32_t i, fpscr;
@@ -210,6 +226,8 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val)
     HELPER(vfp_set_fpscr)(env, val);
 }
=20
+#ifdef CONFIG_TCG
+
 #define VFP_HELPER(name, p) HELPER(glue(glue(vfp_,name),p))
=20
 #define VFP_BINOP(name) \
@@ -1303,3 +1321,5 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
 {
     return frint_d(f, fpst, 64);
 }
+
+#endif
--=20
2.20.1


