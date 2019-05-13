Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEFC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC7F208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC7F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6CP-00061v-Li
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:20:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ6Ac-0004ea-Ms
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ6Ab-0007dn-74
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQ6Aa-0007cj-Th
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FFFB307D91E
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:18:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBA5219C70
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 08:18:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DA4221138407; Mon, 13 May 2019 10:18:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 10:18:40 +0200
Message-Id: <20190513081844.26699-6-armbru@redhat.com>
In-Reply-To: <20190513081844.26699-1-armbru@redhat.com>
References: <20190513081844.26699-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 08:18:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/9] target/xtensa: Clean up core-isa.h header
 guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

scripts/clean-header-guards.pl warns these headers use reserved
identifier _XTENSA_CORE_CONFIGURATION_H as header guard symbol.  It
additionally warns the guard doesn't match the file name.

Reuse of the same guard symbol in multiple headers is okay as long as
they cannot be included together.

Since we can avoid guard symbol reuse easily, do so: use the guard
symbol scripts/clean-header-guards.pl picks, less the TARGET_ prefix.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-5-armbru@redhat.com>
---
 target/xtensa/core-de212/core-isa.h             | 8 +++-----
 target/xtensa/core-sample_controller/core-isa.h | 8 +++-----
 target/xtensa/core-test_kc705_be/core-isa.h     | 8 +++-----
 target/xtensa/core-test_mmuhifi_c3/core-isa.h   | 8 +++-----
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/xtensa/core-de212/core-isa.h b/target/xtensa/core-de212/core-isa.h
index 78e7f38310..90ac329230 100644
--- a/target/xtensa/core-de212/core-isa.h
+++ b/target/xtensa/core-de212/core-isa.h
@@ -28,9 +28,8 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#ifndef _XTENSA_CORE_CONFIGURATION_H
-#define _XTENSA_CORE_CONFIGURATION_H
-
+#ifndef XTENSA_CORE_DE212_CORE_ISA_H
+#define XTENSA_CORE_DE212_CORE_ISA_H
 
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
@@ -618,5 +617,4 @@
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
 
-#endif /* _XTENSA_CORE_CONFIGURATION_H */
-
+#endif /* XTENSA_CORE_DE212_CORE_ISA_H */
diff --git a/target/xtensa/core-sample_controller/core-isa.h b/target/xtensa/core-sample_controller/core-isa.h
index e681e43209..d53dca8665 100644
--- a/target/xtensa/core-sample_controller/core-isa.h
+++ b/target/xtensa/core-sample_controller/core-isa.h
@@ -28,9 +28,8 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#ifndef _XTENSA_CORE_CONFIGURATION_H
-#define _XTENSA_CORE_CONFIGURATION_H
-
+#ifndef XTENSA_CORE_SAMPLE_CONTROLLER_CORE_ISA_H
+#define XTENSA_CORE_SAMPLE_CONTROLLER_CORE_ISA_H
 
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
@@ -640,5 +639,4 @@
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
 
-#endif /* _XTENSA_CORE_CONFIGURATION_H */
-
+#endif /* XTENSA_CORE_SAMPLE_CONTROLLER_CORE_ISA_H */
diff --git a/target/xtensa/core-test_kc705_be/core-isa.h b/target/xtensa/core-test_kc705_be/core-isa.h
index a4ebdf7197..408fed871d 100644
--- a/target/xtensa/core-test_kc705_be/core-isa.h
+++ b/target/xtensa/core-test_kc705_be/core-isa.h
@@ -28,9 +28,8 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#ifndef _XTENSA_CORE_CONFIGURATION_H
-#define _XTENSA_CORE_CONFIGURATION_H
-
+#ifndef XTENSA_CORE_TEST_KC705_BE_CORE_ISA_H
+#define XTENSA_CORE_TEST_KC705_BE_CORE_ISA_H
 
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
@@ -571,5 +570,4 @@
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
 
-#endif /* _XTENSA_CORE_CONFIGURATION_H */
-
+#endif /* XTENSA_CORE_TEST_KC705_BE_CORE_ISA_H */
diff --git a/target/xtensa/core-test_mmuhifi_c3/core-isa.h b/target/xtensa/core-test_mmuhifi_c3/core-isa.h
index 309caa1a32..704a31f7c8 100644
--- a/target/xtensa/core-test_mmuhifi_c3/core-isa.h
+++ b/target/xtensa/core-test_mmuhifi_c3/core-isa.h
@@ -7,9 +7,8 @@
  * Copyright (c) 1999-2009 Tensilica Inc.
  */
 
-#ifndef _XTENSA_CORE_CONFIGURATION_H
-#define _XTENSA_CORE_CONFIGURATION_H
-
+#ifndef XTENSA_CORE_TEST_MMUHIFI_C3_CORE_ISA_H
+#define XTENSA_CORE_TEST_MMUHIFI_C3_CORE_ISA_H
 
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
@@ -380,5 +379,4 @@
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
 
-#endif /* _XTENSA_CORE_CONFIGURATION_H */
-
+#endif /* XTENSA_CORE_TEST_MMUHIFI_C3_CORE_ISA_H */
-- 
2.17.2


