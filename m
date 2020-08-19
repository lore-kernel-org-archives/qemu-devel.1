Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FA5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F522075E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="pK97cODa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F522075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Cue-0003ET-CW
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 21:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1k8Ctp-0002Oc-AW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:28:21 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:57766)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1k8Ctn-0001RL-2n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 21:28:21 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id 2BB7F42720;
 Wed, 19 Aug 2020 11:19:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597799943;
 bh=5ifiP1h8lcjbNWL7b1g5XlXGEu5J/udt53maSvaNMz0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pK97cODaYobxZWRZ+UpXGVKP18ccoaNBToLnRX88XkzeH6aaFTA+DcM3ulkeCF8jB
 j9BFJvjDMijT+7ODT6lAEGzaXNK00YSOTScN73jvEIBnv46hPo1kfSAAmUmukcuaCq
 no7Ak+erZqALXAluZrKbdQnoWmqIL9uWnH74Uiew=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 1C9043A098A; Wed, 19 Aug 2020 11:19:02 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>,
	kraxel@redhat.com
Subject: [PATCH v3 1/1] audio/jack: fix use after free segfault
Date: Wed, 19 Aug 2020 11:18:35 +1000
Message-Id: <20200819011835.92737-2-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819011835.92737-1-geoff@hostfission.com>
References: <20200819011835.92737-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 21:07:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
 configure         |  4 +++-
 2 files changed, 39 insertions(+), 2 deletions(-)

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
index 2acc4d1465..43d2893fbb 100755
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
-- 
2.20.1


