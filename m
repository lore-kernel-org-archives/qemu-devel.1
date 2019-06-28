Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4EE205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4EE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmnR-00088n-F3
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgmfb-00015X-Sm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgmfa-0001Ut-4D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48357 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hgmfU-0001M1-Er
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 04:55:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CBC091A0563;
 Fri, 28 Jun 2019 10:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id AE4C61A2203;
 Fri, 28 Jun 2019 10:55:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Fri, 28 Jun 2019 10:54:41 +0200
Message-Id: <1561712082-31441-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v15 4/5] linux-user: Introduce
 TARGET_HAVE_ARCH_STRUCT_FLOCK
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Bring target_flock definitions to be more in sync with the way
flock is defined in kernel.

Basically, the rules from the kernel are:

1. Majority of architectures have a common flock definition.

2. Architectures with 32-bit MIPS ABIs have a sligtly different
flock definition; those architectures are the only arcitectures
that have HAVE_ARCH_STRUCT_FLOCK defined, and that preprocessor
constant is used in the common header as a flag for including or
not including common flock definition.

3. Sparc architectures also have a sligtly different flock
definition, but the difference is only the padding at the end of
the structure. The presence of that padding is determined by
preprocessor constants __ARCH_FLOCK6_PAD and __ARCH_FLOCK64_PAD.

QEMU linux-user already implements rules 1. and 3. in a very
similar way as they are implemented in kernel. However, rule 2.
is implemented in a dissimilar way (for example, the constant
TARGET_HAVE_ARCH_STRUCT_FLOCK is missing), and this patch brings
QEMU implementation much closer to the kernel implementation.
TARGET_HAVE_ARCH_STRUCT_FLOCK64 constant is also introduced to
mimic HAVE_ARCH_STRUCT_FLOCK64 from kernel, but it is not defined
anywhere, however, this is the case with HAVE_ARCH_STRUCT_FLOCK64
in kernel as well.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/generic/fcntl.h     |  8 +++++---
 linux-user/mips/target_fcntl.h | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index 1b48dde..9f727d4 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -120,6 +120,7 @@ struct target_f_owner_ex {
 #define TARGET_F_SHLCK         8
 #endif
 
+#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK
 #ifndef TARGET_ARCH_FLOCK_PAD
 #define TARGET_ARCH_FLOCK_PAD
 #endif
@@ -129,13 +130,12 @@ struct target_flock {
     short l_whence;
     abi_long l_start;
     abi_long l_len;
-#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-    abi_long l_sysid;
-#endif
     int l_pid;
     TARGET_ARCH_FLOCK_PAD
 };
+#endif
 
+#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK64
 #ifndef TARGET_ARCH_FLOCK64_PAD
 #define TARGET_ARCH_FLOCK64_PAD
 #endif
@@ -149,3 +149,5 @@ struct target_flock64 {
     TARGET_ARCH_FLOCK64_PAD
 };
 #endif
+
+#endif
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 795bba7..6fc7b8a 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -28,11 +28,20 @@
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 
 #if (TARGET_ABI_BITS == 32)
-#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
-#else
-#define TARGET_ARCH_FLOCK_PAD
+
+struct target_flock {
+    short l_type;
+    short l_whence;
+    abi_long l_start;
+    abi_long l_len;
+    abi_long l_sysid;
+    int l_pid;
+    abi_long pad[4];
+};
+
+#define TARGET_HAVE_ARCH_STRUCT_FLOCK
+
 #endif
-#define TARGET_ARCH_FLOCK64_PAD
 
 #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
 #define TARGET_F_SETLK64       34
-- 
2.7.4


