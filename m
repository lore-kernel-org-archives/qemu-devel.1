Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF0FC31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B9F21473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B9F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcB8P-0002cj-5E
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcArL-0004Wv-AJ
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcArK-0001pX-A5
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcArH-0001eC-Sf; Sat, 15 Jun 2019 11:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 251BD37E88;
 Sat, 15 Jun 2019 15:44:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7BA21001B05;
 Sat, 15 Jun 2019 15:44:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:51 +0200
Message-Id: <20190615154352.26824-23-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sat, 15 Jun 2019 15:44:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH v2 22/23] target/arm: Restrict semi-hosting
 to TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per Peter Maydell:

  semihosting hooks either SVC or HLT instructions, and inside KVM
  both of those go to EL1, ie to the guest, and can't be trapped to
  KVM.

Let check_for_semihosting() return False when not running on TCG.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b7ce0561b..a3843a5508 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,7 +20,6 @@
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
-#include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
@@ -30,6 +29,9 @@
 #include "qapi/qapi-commands-target.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#ifdef CONFIG_TCG
+#include "arm_ldst.h"
+#endif
=20
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
=20
@@ -8270,6 +8272,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *=
cs)
=20
 static inline bool check_for_semihosting(CPUState *cs)
 {
+#ifdef CONFIG_TCG
     /* Check whether this exception is a semihosting call; if so
      * then handle it and return true; otherwise return false.
      */
@@ -8345,6 +8348,9 @@ static inline bool check_for_semihosting(CPUState *=
cs)
         env->regs[0] =3D do_arm_semihosting(env);
         return true;
     }
+#else
+    return false;
+#endif
 }
=20
 /* Handle a CPU exception for A and R profile CPUs.
--=20
2.20.1


