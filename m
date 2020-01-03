Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5278C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB04227BF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB04227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inVMx-0005hB-S8
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 17:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1inVHq-0006yp-O6
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1inVHp-00087W-9Z
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53922 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1inVHp-00081c-0f
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7B8991A1F94;
 Fri,  3 Jan 2020 23:18:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 44C6D1A221D;
 Fri,  3 Jan 2020 23:18:10 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] configure: Detect kcov support and introduce
 CONFIG_KCOV
Date: Fri,  3 Jan 2020 23:18:00 +0100
Message-Id: <1578089882-3587-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578089882-3587-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1578089882-3587-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

kcov is kernel code coverage tracing tool. It requires kernel 4.4+
compiled with certain kernel options. Its interface consists of
three ioctls.

This patch checks if kcov support is present on build machine, and
stores the result in variable CONFIG_KCOV, meant to be used in
linux-user code related to the support for above mentioned ioctls.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 configure | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/configure b/configure
index 940bf9e..bf162d4 100755
--- a/configure
+++ b/configure
@@ -4752,6 +4752,24 @@ if compile_prog "" "" ; then
   syncfs=yes
 fi
 
+# check for kcov support (kernel must be 4.4+, compiled with certain options)
+kcov=no
+cat > $TMPC << EOF
+#include <sys/kcov.h>
+
+int main(void)
+{
+    ioctl(-1, KIOENABLE, NULL);
+    ioctl(-1, KIODISABLE, NULL);
+    ioctl(-1, KIOSETBUFSIZE, NULL);
+
+    return 0;
+}
+EOF
+if compile_prog "" "" ; then
+  kcov=yes
+fi
+
 # Check we have a new enough version of sphinx-build
 has_sphinx_build() {
     # This is a bit awkward but works: create a trivial document and
@@ -6874,6 +6892,9 @@ fi
 if test "$syncfs" = "yes" ; then
   echo "CONFIG_SYNCFS=y" >> $config_host_mak
 fi
+if test "$kcov" = "yes" ; then
+  echo "CONFIG_KCOV=y" >> $config_host_mak
+fi
 if test "$inotify" = "yes" ; then
   echo "CONFIG_INOTIFY=y" >> $config_host_mak
 fi
-- 
2.7.4


