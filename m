Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD3C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407C020869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOPRyXAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407C020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaf04-0004Fu-AL
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iaeGS-00056H-Kh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iaeGN-0001wx-96
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iaeGM-0001iN-2B
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id n1so34713627wra.10
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 03:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y+JITu/sXR0tEv1HQ2+1vlvrpnR0cdQPnZCIBN6cwjA=;
 b=OOPRyXAc3Ro9oA6WLST4+OOQgDtD4dwsCAxWZp0AhRM1lVNXATlWG8vjdABp9ewPYJ
 JIlcqjudnUNSFXaGxnPYqkOYi8w4NChvIxEwrqJo1AAPUh6jyiz0S4JS49NwtVC9R/bM
 XqdTUkCbbjCcqgTHtxEUUF05ZFGJLkagAPdBogWObijGv/N707HrKj1zFgbuH85mi9au
 ANuckbEDS3ExXbk8kNhoIQVTbrnfplovaraWQdtChsUvL4ZZiny3FTvAt69LhGnFhp6i
 1MtO4KD8gXoO8BOTKBUwMcYG+Y4Gs9MqhFokEmmcI7l8hthhgVsABGSd0X/nTdujJEhi
 vmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=y+JITu/sXR0tEv1HQ2+1vlvrpnR0cdQPnZCIBN6cwjA=;
 b=b0xe8nkVWBW1h6/xQw7aP8A7nLqrU6eSJnGzReXtl2GZvdj5SRxrzWSZuuXJhfL5Zx
 xOoRbP2D2hCrESzWDKBnRHcoYKDJrPR3iJjNFnqjM2pW/J8Uy3bGBjgBFz4GilNgKqd9
 Dy3pvqon+I2GqHcN9x3YE35MEMqPx8VJTfqX/J49Zx7h/eHRzCvAqoosCemrpuNTG9BW
 J272Whg9WYkuAMnqxoCkKk4ZpZM/GH4DeTST1KGd5bWVXTHX+DYaJH+E05ME50+zOHzk
 5fUxXQyfjUHYZg0hw9uHVxsQZEA52+LIoBMPmXAdFOQN7SGNJjLU5eL2vYuq+JZNnvTm
 CKMQ==
X-Gm-Message-State: APjAAAXrN+p/v/OV7OMdswLkbrxkVpR6V/KQmHpBUVmfd3BE9o5DTL+i
 2nEflinPqgX/41D/yl0tTyZLOAmx
X-Google-Smtp-Source: APXvYqw9CvgSU9VxwILc34y0kBf8LcoD5JYSStQc+C8JFLTlvPR73eOtm6dbWmSzdtvHgZZrMdXZMw==
X-Received: by 2002:adf:8044:: with SMTP id 62mr53030115wrk.244.1575026194602; 
 Fri, 29 Nov 2019 03:16:34 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id
 i71sm29752969wri.68.2019.11.29.03.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 03:16:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
Date: Fri, 29 Nov 2019 12:16:32 +0100
Message-Id: <20191129111632.22840-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: berrange@redhat.com, dgilbert@redhat.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtfs-proxy-helper is the only user of libcap; everyone else is using
the simpler libcap-ng API.  Switch and remove the configure code to
detect libcap.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   |  18 +------
 fsdev/virtfs-proxy-helper.c | 100 ++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 72 deletions(-)

diff --git a/configure b/configure
index afe9393f04..2216662bf6 100755
--- a/configure
+++ b/configure
@@ -3863,22 +3863,6 @@ else
   mpathpersist=no
 fi
 
-##########################################
-# libcap probe
-
-if test "$cap" != "no" ; then
-  cat > $TMPC <<EOF
-#include <stdio.h>
-#include <sys/capability.h>
-int main(void) { cap_t caps; caps = cap_init(); return caps != NULL; }
-EOF
-  if compile_prog "" "-lcap" ; then
-    cap=yes
-  else
-    cap=no
-  fi
-fi
-
 ##########################################
 # pthread probe
 PTHREADLIBS_LIST="-pthread -lpthread -lpthreadGC2"
@@ -6204,7 +6188,7 @@ if test "$want_tools" = "yes" ; then
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
-    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
+    if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
       virtfs=yes
       tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
     else
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 6f132c5ff1..0d4de49dcf 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -13,7 +13,6 @@
 #include <sys/resource.h>
 #include <getopt.h>
 #include <syslog.h>
-#include <sys/capability.h>
 #include <sys/fsuid.h>
 #include <sys/vfs.h>
 #include <sys/ioctl.h>
@@ -21,6 +20,7 @@
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
 #endif
+#include <cap-ng.h>
 #include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/xattr.h"
@@ -79,49 +79,10 @@ static void do_perror(const char *string)
     }
 }
 
-static int do_cap_set(cap_value_t *cap_value, int size, int reset)
-{
-    cap_t caps;
-    if (reset) {
-        /*
-         * Start with an empty set and set permitted and effective
-         */
-        caps = cap_init();
-        if (caps == NULL) {
-            do_perror("cap_init");
-            return -1;
-        }
-        if (cap_set_flag(caps, CAP_PERMITTED, size, cap_value, CAP_SET) < 0) {
-            do_perror("cap_set_flag");
-            goto error;
-        }
-    } else {
-        caps = cap_get_proc();
-        if (!caps) {
-            do_perror("cap_get_proc");
-            return -1;
-        }
-    }
-    if (cap_set_flag(caps, CAP_EFFECTIVE, size, cap_value, CAP_SET) < 0) {
-        do_perror("cap_set_flag");
-        goto error;
-    }
-    if (cap_set_proc(caps) < 0) {
-        do_perror("cap_set_proc");
-        goto error;
-    }
-    cap_free(caps);
-    return 0;
-
-error:
-    cap_free(caps);
-    return -1;
-}
-
 static int init_capabilities(void)
 {
     /* helper needs following capabilities only */
-    cap_value_t cap_list[] = {
+    int cap_list[] = {
         CAP_CHOWN,
         CAP_DAC_OVERRIDE,
         CAP_FOWNER,
@@ -130,7 +91,34 @@ static int init_capabilities(void)
         CAP_MKNOD,
         CAP_SETUID,
     };
-    return do_cap_set(cap_list, ARRAY_SIZE(cap_list), 1);
+    int i;
+
+    capng_clear(CAPNG_SELECT_BOTH);
+    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
+        if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                         cap_list[i]) < 0) {
+            do_perror("capng_update");
+            return -1;
+        }
+    }
+    if (capng_apply(CAPNG_SELECT_BOTH) < 0) {
+        do_perror("capng_apply");
+        return -1;
+    }
+
+    /* Prepare effective set for setugid.  */
+    for (i = 0; i < ARRAY_SIZE(cap_list); i++) {
+        if (cap_list[i] == CAP_DAC_OVERRIDE) {
+            continue;
+        }
+
+        if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE,
+                         cap_list[i]) < 0) {
+            do_perror("capng_update");
+            return -1;
+        }
+    }
+    return 0;
 }
 
 static int socket_read(int sockfd, void *buff, ssize_t size)
@@ -295,14 +283,6 @@ static int setugid(int uid, int gid, int *suid, int *sgid)
 {
     int retval;
 
-    /*
-     * We still need DAC_OVERRIDE because we don't change
-     * supplementary group ids, and hence may be subjected DAC rules
-     */
-    cap_value_t cap_list[] = {
-        CAP_DAC_OVERRIDE,
-    };
-
     *suid = geteuid();
     *sgid = getegid();
 
@@ -316,11 +296,21 @@ static int setugid(int uid, int gid, int *suid, int *sgid)
         goto err_sgid;
     }
 
-    if (uid != 0 || gid != 0) {
-        if (do_cap_set(cap_list, ARRAY_SIZE(cap_list), 0) < 0) {
-            retval = -errno;
-            goto err_suid;
-        }
+    if (uid == 0 && gid == 0) {
+        /* Linux has already copied the permitted set to the effective set.  */
+        return 0;
+    }
+
+    /*
+     * All capabilities have been cleared from the effective set.  However
+     * we still need DAC_OVERRIDE because we don't change supplementary
+     * group ids, and hence may be subject to DAC rules.  init_capabilities
+     * left the set of capabilities that we want in libcap-ng's state.
+     */
+    if (capng_apply(CAPNG_SELECT_CAPS) < 0) {
+        retval = -errno;
+        do_perror("capng_apply");
+        goto err_suid;
     }
     return 0;
 
-- 
2.21.0


