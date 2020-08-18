Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A4E20772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="LBmpVi6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8CaS-0008TH-6V
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 21:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8CZt-00081s-TK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:07:45 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:57478)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8CZr-0007Eb-NY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:07:45 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id AD96C42719;
 Wed, 19 Aug 2020 11:07:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597799261;
 bh=0OZFoMxA3cbR57XLu8N6UZGRUGpyr7W/DLHLqjR+Yq8=;
 h=From:Date:Subject:To:Cc:From;
 b=LBmpVi6En4ec8uLrZ3L0f2LUaqnmv4cboF3igmQjrKXs83yP8WjSKUhtO27PDRec7
 Tv8mdOaIs5mRmTlvO870PJiTRJkcNCTvbdDKlS+dee/5vrrycKTwo9IPVQGuCqCwF+
 L5mWnKm0ZkpLB90PPOkAotA2fDu9l0iyDAqUbks0=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 91DAE3A0788; Wed, 19 Aug 2020 11:07:41 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
Date: Tue, 18 Aug 2020 22:40:36 +1000
Subject: [PATCH v2] audio/jack: fix use after free segfault
To: <qemu-devel@nongnu.org>
Cc: <kraxel@redhat.com>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20200819010741.91DAE3A0788@moya.office.hostfission.com>
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 21:07:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The client may have been freed already by a secondary audio device
recovering its session as JACK2 has some cleanup code to work around
broken clients, which doesn't account for well behaved clients.

https://github.com/jackaudio/jack2/issues/627

As JACK1 and JACK2 are interchangeable and JACK2 has "cleanup" routine
that JACK1 does not have, we need to determine which version is in use
at runtime. Unfortunatly there is no way to determine which is in use
other then to look for symbols that are missing in JACK1, which in this
case is `jack_get_version`.

An issue has been raised over this, but to be compatible with older
versions we must use this method to determine which library is in use.
If at some time the jack developers implement `jack_get_version` in
JACK1, this code will need to be revisited.

At worst the workaround will be enabled and this will introduce a small
memory leak if the jack server is restarted. This however is better then
the alternative which would be a use after free segfault.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 audio/jackaudio.c | 37 ++++++++++++++++++++++++++++++++++++-
 configure         |  5 +++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 72ed7c4929..d1685999c3 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -31,6 +31,7 @@
 #define AUDIO_CAP "jack"
 #include "audio_int.h"
 
+#include <dlfcn.h>
 #include <jack/jack.h>
 #include <jack/thread.h>
 
@@ -84,6 +85,7 @@ typedef struct QJackIn {
 }
 QJackIn;
 
+static int QJackWorkaroundCloseBug;
 static int qjack_client_init(QJackClient *c);
 static void qjack_client_connect_ports(QJackClient *c);
 static void qjack_client_fini(QJackClient *c);
@@ -563,7 +565,10 @@ static void qjack_client_fini(QJackClient *c)
         /* fallthrough */
 
     case QJACK_STATE_SHUTDOWN:
-        jack_client_close(c->client);
+        if (!QJackWorkaroundCloseBug) {
+            jack_client_close(c->client);
+        }
+        c->client = NULL;
         /* fallthrough */
 
     case QJACK_STATE_DISCONNECTED:
@@ -662,6 +667,36 @@ static void qjack_info(const char *msg)
 
 static void register_audio_jack(void)
 {
+    void *handle;
+
+    /*
+     * As JACK1 and JACK2 are interchangeable and JACK2 has "cleanup" routine
+     * that JACK1 does not have, we need to determine which version is in use at
+     * runtime. Unfortunatly there is no way to determine which is in use other
+     * then to look for symbols that are missing in JACK1, which in this case is
+     * `jack_get_version`. An issue has been raised over this, but to be
+     * compatible with older versions we must use this method to determine which
+     * library is in use. If at some time the jack developers implement
+     * `jack_get_version` in JACK1, this code will need to be revisited.
+     *
+     * At worst the workaround will be enabled and we will introduce a small
+     * memory leak if the jack server is restarted. This is better then the
+     * alternative which would be a use after free segfault.
+     */
+
+    handle = dlopen("libjack.so", RTLD_LAZY | RTLD_NOLOAD);
+    if (!handle) {
+        dolog("unable to open libjack.so to determine version\n");
+        dolog("assuming JACK2 and enabling the close bug workaround\n");
+        QJackWorkaroundCloseBug = 1;
+    } else {
+        if (dlsym(handle, "jack_get_version")) {
+            dolog("JACK2 detected, enabling close bug workaround\n");
+            QJackWorkaroundCloseBug = 1;
+        }
+        dlclose(handle);
+    }
+
     audio_driver_register(&jack_driver);
     jack_set_thread_creator(qjack_thread_creator);
     jack_set_error_function(qjack_error);
diff --git a/configure b/configure
index 2acc4d1465..e65ec5c5e3 100755
--- a/configure
+++ b/configure
@@ -3754,7 +3754,8 @@ for drv in $audio_drv_list; do
 
     jack | try-jack)
     if $pkg_config jack --exists; then
-        jack_libs=$($pkg_config jack --libs)
+        # dl is needed to check at runtime if jack1 or jack2 is in use
+        jack_libs="$($pkg_config jack --libs) -ldl"
         if test "$drv" = "try-jack"; then
             audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-jack/jack/')
         fi
@@ -8644,4 +8645,4 @@ printf " '%s'" "$0" "$@" >>config.status
 echo ' "$@"' >>config.status
 chmod +x config.status
 
-rm -r "$TMPDIR1"
+rm -r "$TMPDIR1"
\ No newline at end of file
-- 
2.20.1


