Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83922073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83922073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QWD-0008J8-3E
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QVM-0007AN-Bn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QVL-0001Sz-6z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:39:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QVL-0001SM-1Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:39:51 -0500
Received: from 2.general.paelzer.uk.vpn ([10.172.196.173]
 helo=Keschdeichel.fritz.box) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1j9QVK-0007Rn-3G; Wed, 04 Mar 2020 09:39:50 +0000
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] modules: load modules from versioned /var/run dir
Date: Wed,  4 Mar 2020 10:39:46 +0100
Message-Id: <20200304093946.18682-1-christian.ehrhardt@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAATJJ0L+jdk3ggWx61=AGoTd-FZ64tJ1tzPK8Frgg9Ez+dv6XQ@mail.gmail.com>
References: <CAATJJ0L+jdk3ggWx61=AGoTd-FZ64tJ1tzPK8Frgg9Ez+dv6XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On upgrades the old .so files usually are replaced. But on the other
hand since a qemu process represents a guest instance it is usually kept
around.

That makes late addition of dynamic features e.g. 'hot-attach of a ceph
disk' fail by trying to load a new version of e.f. block-rbd.so into an
old still running qemu binary.

This adds a fallback to also load modules from a versioned directory in the
temporary /var/run path. That way qemu is providing a way for packaging
to store modules of an upgraded qemu package as needed until the next reboot.

An example how that can then be used in packaging can be seen in:
https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=bug-1847361-miss-old-so-on-upgrade-UBUNTU

Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 util/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/module.c b/util/module.c
index 236a7bb52a..d2446104be 100644
--- a/util/module.c
+++ b/util/module.c
@@ -19,6 +19,7 @@
 #endif
 #include "qemu/queue.h"
 #include "qemu/module.h"
+#include "qemu-version.h"
 
 typedef struct ModuleEntry
 {
@@ -170,6 +171,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
 #ifdef CONFIG_MODULES
     char *fname = NULL;
     char *exec_dir;
+    char *version_dir;
     const char *search_dir;
     char *dirs[4];
     char *module_name;
@@ -201,6 +203,11 @@ bool module_load_one(const char *prefix, const char *lib_name)
     dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
     dirs[n_dirs++] = g_strdup_printf("%s/..", exec_dir ? : "");
     dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
+    version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
+                             G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
+                             '_');
+    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+
     assert(n_dirs <= ARRAY_SIZE(dirs));
 
     g_free(exec_dir);
-- 
2.25.1


