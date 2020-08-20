Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00B1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B506D2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="PF1V6gwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B506D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YkO-0005fZ-QA
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1k8YOQ-0001qw-IE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:25:22 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:46480)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1k8YOO-0003bd-Ew
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:25:22 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id BDBEC42773;
 Thu, 20 Aug 2020 10:25:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597883116;
 bh=X6CIhxR1widW+lKAtGoVijCvwyIgBekd2uMq/7WCwEU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PF1V6gwYllJZW0u8SkgDDCmsGO7xvDuslRH7IDi4i4XKDFmGhniCd0YzZ+hdluCgV
 92VV/TKjtTzWyDWhgJ+Qa5C1qe8RolNyKOHVzkOL/jxU1Ng4UjVY0PVBEPS/7otJuK
 CGbfEeM/UYGk6vcsKEKH02o/GpaFq9qDBdaDTdno=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id A02B63A02DD; Thu, 20 Aug 2020 10:25:16 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>,
	kraxel@redhat.com
Subject: [PATCH v6 1/1] audio/jack: fix use after free segfault
Date: Thu, 20 Aug 2020 10:25:15 +1000
Message-Id: <20200820002515.75576-2-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200820002515.75576-1-geoff@hostfission.com>
References: <20200820002515.75576-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:25:17
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

This change registers a bottom handler to close the JACK client
connection when a server shutdown signal is recieved. Without this
libjack2 attempts to "clean up" old clients and causes a use after free
segfault.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 audio/jackaudio.c | 51 +++++++++++++++++++++++++++++++++--------------
 ui/spice-input.c  |  2 ++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 72ed7c4929..3492c6b63b 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/atomic.h"
+#include "qemu/main-loop.h"
 #include "qemu-common.h"
 #include "audio.h"
 
@@ -63,6 +64,7 @@ typedef struct QJackClient {
     QJackState      state;
     jack_client_t  *client;
     jack_nframes_t  freq;
+    QEMUBH         *shutdown_bh;
 
     struct QJack   *j;
     int             nchannels;
@@ -306,21 +308,27 @@ static int qjack_xrun(void *arg)
     return 0;
 }
 
+static void qjack_shutdown_bh(void *opaque)
+{
+    QJackClient *c = (QJackClient *)opaque;
+    qjack_client_fini(c);
+}
+
 static void qjack_shutdown(void *arg)
 {
     QJackClient *c = (QJackClient *)arg;
     c->state = QJACK_STATE_SHUTDOWN;
+    qemu_bh_schedule(c->shutdown_bh);
 }
 
 static void qjack_client_recover(QJackClient *c)
 {
-    if (c->state == QJACK_STATE_SHUTDOWN) {
-        qjack_client_fini(c);
+    if (c->state != QJACK_STATE_DISCONNECTED) {
+        return;
     }
 
     /* packets is used simply to throttle this */
-    if (c->state == QJACK_STATE_DISCONNECTED &&
-        c->packets % 100 == 0) {
+    if (c->packets % 100 == 0) {
 
         /* if enabled then attempt to recover */
         if (c->enabled) {
@@ -417,6 +425,7 @@ static int qjack_client_init(QJackClient *c)
         options |= JackServerName;
     }
 
+    c->shutdown_bh = qemu_bh_new(qjack_shutdown_bh, c);
     c->client = jack_client_open(client_name, options, &status,
       c->opt->server_name);
 
@@ -489,8 +498,6 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     QJackOut *jo  = (QJackOut *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    qjack_client_fini(&jo->c);
-
     jo->c.out       = true;
     jo->c.enabled   = false;
     jo->c.nchannels = as->nchannels;
@@ -525,8 +532,6 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
     QJackIn  *ji  = (QJackIn *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    qjack_client_fini(&ji->c);
-
     ji->c.out       = false;
     ji->c.enabled   = false;
     ji->c.nchannels = as->nchannels;
@@ -563,29 +568,45 @@ static void qjack_client_fini(QJackClient *c)
         /* fallthrough */
 
     case QJACK_STATE_SHUTDOWN:
+        qemu_bh_delete(c->shutdown_bh);
+        c->shutdown_bh = NULL;
+
         jack_client_close(c->client);
+        c->client = NULL;
+
+        qjack_buffer_free(&c->fifo);
+        g_free(c->port);
+
+        c->state = QJACK_STATE_DISCONNECTED;
         /* fallthrough */
 
     case QJACK_STATE_DISCONNECTED:
         break;
     }
-
-    qjack_buffer_free(&c->fifo);
-    g_free(c->port);
-
-    c->state = QJACK_STATE_DISCONNECTED;
 }
 
 static void qjack_fini_out(HWVoiceOut *hw)
 {
     QJackOut *jo = (QJackOut *)hw;
-    qjack_client_fini(&jo->c);
+
+    qemu_mutex_lock_iothread();
+    if (jo->c.state != QJACK_STATE_DISCONNECTED) {
+        qemu_bh_cancel(jo->c.shutdown_bh);
+        qjack_client_fini(&jo->c);
+    }
+    qemu_mutex_unlock_iothread();
 }
 
 static void qjack_fini_in(HWVoiceIn *hw)
 {
     QJackIn *ji = (QJackIn *)hw;
-    qjack_client_fini(&ji->c);
+
+    qemu_mutex_lock_iothread();
+    if (ji->c.state != QJACK_STATE_DISCONNECTED) {
+        qemu_bh_cancel(ji->c.shutdown_bh);
+        qjack_client_fini(&ji->c);
+    }
+    qemu_mutex_unlock_iothread();
 }
 
 static void qjack_enable_out(HWVoiceOut *hw, bool enable)
diff --git a/ui/spice-input.c b/ui/spice-input.c
index cd4bb0043f..82c74fdf58 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -123,6 +123,8 @@ static void spice_update_buttons(QemuSpicePointer *pointer,
         [INPUT_BUTTON_RIGHT]       = 0x02,
         [INPUT_BUTTON_WHEEL_UP]    = 0x10,
         [INPUT_BUTTON_WHEEL_DOWN]  = 0x20,
+        [INPUT_BUTTON_SIDE]        = 0x40,
+        [INPUT_BUTTON_EXTRA]       = 0x80
     };
 
     if (wheel < 0) {
-- 
2.20.1


