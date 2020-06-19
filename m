Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A2C20720
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0VDOHGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A2C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGxg-0007JY-73
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu4-00021A-Jl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu2-00038O-7K
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592572673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=tt2MqH4x5xif840Q+MJPvJJfNlTyLOyjD2Lm0Z9OQVI=;
 b=K0VDOHGt1pyJde34lcvDoI+kmj7oKP13Va8IpYT0JrRChKiVF5/CrhCvYPaAuUNuDPEBVm
 iX++yzsROy3aVkUx9374Ay3Cxfigwka0RkCYXRNEOwSzsIJZ4MZa6RtiJmamntwXtNFFAe
 hWmbgBbO3BAyRALXnAOrPRGehgmg4QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-FRPllmUDOaa-G9TwGUO6Pw-1; Fri, 19 Jun 2020 09:17:51 -0400
X-MC-Unique: FRPllmUDOaa-G9TwGUO6Pw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B52FB10059A1;
 Fri, 19 Jun 2020 13:17:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54CC55C1D6;
 Fri, 19 Jun 2020 13:17:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8D68C9D92; Fri, 19 Jun 2020 15:17:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] audio/jack: honour the enable state of the audio device
Date: Fri, 19 Jun 2020 15:17:39 +0200
Message-Id: <20200619131741.10857-6-kraxel@redhat.com>
In-Reply-To: <20200619131741.10857-1-kraxel@redhat.com>
References: <20200619131741.10857-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Geoffrey McRae <geoff@hostfission.com>

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
Message-id: 20200613040518.38172-6-geoff@hostfission.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/jackaudio.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 249cbd3265c5..b2b53985ae61 100644
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
2.18.4


