Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952A620772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="rXCT6QKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952A620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Hcs-0006dQ-SA
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1k8HbU-0005Ej-PJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:29:44 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:32910)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1k8HbS-0003xP-Sm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:29:44 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id C08BA42730;
 Wed, 19 Aug 2020 16:29:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597818581;
 bh=Pu+NS9rLkZZPl1vLlUN9PbQd4yq0gCdDCk+RN+6r9LI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rXCT6QKaQfmrAUttJmZZXqUS/csZXUJT0dgDpfmz446bOZGv7EmHng2CEiErTQn34
 LRFBNAqP1f+rvvbtwCq+niVDfyqIusDlBGZyQNZvLAFKVZav3D8I+Lm6MvWvqgLUD9
 UqU3lOaLre4JWj+Ik+TM4T7bJi9IYNK90FXuyFXQ=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id B11E23A01BF; Wed, 19 Aug 2020 16:29:41 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>,
	kraxel@redhat.com
Subject: [PATCH v5 1/1] audio/jack: fix use after free segfault
Date: Wed, 19 Aug 2020 16:29:39 +1000
Message-Id: <20200819062940.52774-2-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819062940.52774-1-geoff@hostfission.com>
References: <20200819062940.52774-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:36:32
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
 audio/jackaudio.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 72ed7c4929..b0da5cd00b 100644
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
-    c->state = QJACK_STATE_SHUTDOWN;
+    c->state       = QJACK_STATE_SHUTDOWN;
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
@@ -417,6 +425,10 @@ static int qjack_client_init(QJackClient *c)
         options |= JackServerName;
     }
 
+    if (!c->shutdown_bh) {
+        c->shutdown_bh = qemu_bh_new(qjack_shutdown_bh, c);
+    }
+
     c->client = jack_client_open(client_name, options, &status,
       c->opt->server_name);
 
@@ -489,8 +501,6 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     QJackOut *jo  = (QJackOut *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    qjack_client_fini(&jo->c);
-
     jo->c.out       = true;
     jo->c.enabled   = false;
     jo->c.nchannels = as->nchannels;
@@ -525,8 +535,6 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
     QJackIn  *ji  = (QJackIn *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    qjack_client_fini(&ji->c);
-
     ji->c.out       = false;
     ji->c.enabled   = false;
     ji->c.nchannels = as->nchannels;
@@ -557,6 +565,8 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
 
 static void qjack_client_fini(QJackClient *c)
 {
+    qemu_bh_cancel(c->shutdown_bh);
+
     switch (c->state) {
     case QJACK_STATE_RUNNING:
         jack_deactivate(c->client);
@@ -564,6 +574,7 @@ static void qjack_client_fini(QJackClient *c)
 
     case QJACK_STATE_SHUTDOWN:
         jack_client_close(c->client);
+        c->client = NULL;
         /* fallthrough */
 
     case QJACK_STATE_DISCONNECTED:
-- 
2.20.1


