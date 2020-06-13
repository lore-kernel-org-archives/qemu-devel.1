Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A782065D
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="EQ6RRkbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A782065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkK1C-0005xx-Rr
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 00:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1jkK0b-0005ZT-TX
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:12:37 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:57166)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1jkK0Z-0000Wv-6g
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:12:37 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id F40CE445F5;
 Sat, 13 Jun 2020 14:06:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1592021164;
 bh=OdRJm45Q4UNv6+P+Ib6qm82RVr++vAH8VUG3t1Sh9As=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EQ6RRkbTradms1c0z8CjTkJwEhZCGlifW+0zK7nIftNw4xvLHlCAfgzq1RoPUTVXA
 +AAEe3GSWdDPDt0h3FwlCRAoXG5Jt9dxHGER6X9MCCVn7I5JvCtWo7dcIb0xImPQKU
 HxNYSfgxKO6bsuFxtME/KslpjAOgduxzOMlJb5P0=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id DEEF23A0A09; Sat, 13 Jun 2020 14:06:03 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	geoff@hostfission.com
Subject: [PATCH 5/6] audio/jack: honour the enable state of the audio device
Date: Sat, 13 Jun 2020 14:05:17 +1000
Message-Id: <20200613040518.38172-6-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613040518.38172-1-geoff@hostfission.com>
References: <20200613040518.38172-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 00:05:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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

When the guest closes the audio device we must start dropping input
samples from JACK and zeroing the output buffer samples. Failure to do
so causes sound artifacts during operations such as guest OS reboot, and
causes a hang of the input pipeline breaking it until QEMU is restated.

Closing and reconnecting to JACK was tested during these enable/disable
calls which works well for Linux guests, however Windows re-opens the
audio hardware repeatedly even when doing simple tasks like playing a
system sounds. As such it was decided it is better to feed silence to
JACK while the device is disabled.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 audio/jackaudio.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 249cbd3265..b2b53985ae 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -56,7 +56,7 @@ typedef struct QJackClient {
     AudiodevJackPerDirectionOptions *opt;
 
     bool out;
-    bool finished;
+    bool enabled;
     bool connect_ports;
     int  packets;
 
@@ -271,9 +271,17 @@ static int qjack_process(jack_nframes_t nframes, void *arg)
     }
 
     if (c->out) {
-        qjack_buffer_read_l(&c->fifo, buffers, nframes);
+        if (likely(c->enabled)) {
+            qjack_buffer_read_l(&c->fifo, buffers, nframes);
+        } else {
+            for(int i = 0; i < c->nchannels; ++i) {
+                memset(buffers[i], 0, nframes * sizeof(float));
+            }
+        }
     } else {
-        qjack_buffer_write_l(&c->fifo, buffers, nframes);
+        if (likely(c->enabled)) {
+            qjack_buffer_write_l(&c->fifo, buffers, nframes);
+        }
     }
 
     return 0;
@@ -314,8 +322,8 @@ static void qjack_client_recover(QJackClient *c)
     if (c->state == QJACK_STATE_DISCONNECTED &&
         c->packets % 100 == 0) {
 
-        /* if not finished then attempt to recover */
-        if (!c->finished) {
+        /* if enabled then attempt to recover */
+        if (c->enabled) {
             dolog("attempting to reconnect to server\n");
             qjack_client_init(c);
         }
@@ -387,7 +395,6 @@ static int qjack_client_init(QJackClient *c)
     char client_name[jack_client_name_size()];
     jack_options_t options = JackNullOption;
 
-    c->finished      = false;
     c->connect_ports = true;
 
     snprintf(client_name, sizeof(client_name), "%s-%s",
@@ -483,8 +490,10 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     jo->c.out       = true;
+    jo->c.enabled   = false;
     jo->c.nchannels = as->nchannels;
     jo->c.opt       = dev->u.jack.out;
+
     int ret = qjack_client_init(&jo->c);
     if (ret != 0) {
         return ret;
@@ -519,8 +528,10 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
     }
 
     ji->c.out       = false;
+    ji->c.enabled   = false;
     ji->c.nchannels = as->nchannels;
     ji->c.opt       = dev->u.jack.in;
+
     int ret = qjack_client_init(&ji->c);
     if (ret != 0) {
         return ret;
@@ -568,23 +579,25 @@ static void qjack_client_fini(QJackClient *c)
 static void qjack_fini_out(HWVoiceOut *hw)
 {
     QJackOut *jo = (QJackOut *)hw;
-    jo->c.finished = true;
     qjack_client_fini(&jo->c);
 }
 
 static void qjack_fini_in(HWVoiceIn *hw)
 {
     QJackIn *ji = (QJackIn *)hw;
-    ji->c.finished = true;
     qjack_client_fini(&ji->c);
 }
 
 static void qjack_enable_out(HWVoiceOut *hw, bool enable)
 {
+    QJackOut *jo = (QJackOut *)hw;
+    jo->c.enabled = enable;
 }
 
 static void qjack_enable_in(HWVoiceIn *hw, bool enable)
 {
+    QJackIn *ji = (QJackIn *)hw;
+    ji->c.enabled = enable;
 }
 
 static int qjack_thread_creator(jack_native_thread_t *thread,
-- 
2.20.1


