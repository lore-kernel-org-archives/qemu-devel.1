Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0DC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9632067C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9632067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9O4-0001uT-Uw
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinghui@sangfor.com.cn>)
 id 1kXyft-0008Ho-MV; Wed, 28 Oct 2020 23:32:29 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:43377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinghui@sangfor.com.cn>)
 id 1kXyfp-0002OH-8L; Wed, 28 Oct 2020 23:32:29 -0400
Received: from localhost.localdomain (unknown [14.154.30.22])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 069B44E13CD;
 Thu, 29 Oct 2020 11:22:46 +0800 (CST)
From: Ding Hui <dinghui@sangfor.com.cn>
To: kraxel@redhat.com
Subject: [PATCH] vnc: fix resource leak when websocket channel error
Date: Thu, 29 Oct 2020 11:22:41 +0800
Message-Id: <20201029032241.11040-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZSxofSEMeH0hJHxkfVkpNS0hCT0pMTUxJSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6CCo*ND8hQi0cMikoPQxI
 SkMwFDBVSlVKTUtIQk9KTE1MTUhCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
 QVlKT1VKTk9VSEtVSUlZV1kIAVlBTEJJTjcG
X-HM-Tid: 0a75726117c79376kuws069b44e13cd
Received-SPF: pass client-ip=59.111.176.18;
 envelope-from=dinghui@sangfor.com.cn; helo=m17618.mail.qiye.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 23:20:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2020 10:57:05 -0400
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we connect to vnc by websocket channel, and disconnect
(maybe by some network exception) before handshake,
qemu will left CLOSE_WAIT socket and never close it

After 04d2529da2 ("ui: convert VNC server to use QIOChannelSocket")
and dd154c4d9f ("io: fix handling of EOF / error conditions in websock GSource"),
the vnc call qio_channel_add_watch only care about G_IO_IN,
but mising G_IO_HUP and G_IO_ERR.
When the websocket channel get EOF or error, it cannot callback,
because the caller ignore the event, that leads to resource leak

We need handle G_IO_HUP and G_IO_ERR event, then cleanup the channel

Fixes: 04d2529da2 ("ui: convert VNC server to use QIOChannelSocket")
Fixes: dd154c4d9f ("io: fix handling of EOF / error conditions in websock GSource")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 ui/vnc-auth-sasl.c     |  3 ++-
 ui/vnc-auth-vencrypt.c |  3 ++-
 ui/vnc-jobs.c          |  3 ++-
 ui/vnc-ws.c            | 20 ++++++++++++++++----
 ui/vnc.c               | 24 ++++++++++++++++++------
 5 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 0517b2ead9..f67111a366 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -111,7 +111,8 @@ size_t vnc_client_write_sasl(VncState *vs)
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vnc_client_io, vs, NULL);
     }
 
     return ret;
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index f072e16ace..d9c212ff32 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -79,7 +79,8 @@ static void vnc_tls_handshake_done(QIOTask *task,
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
+            vnc_client_io, vs, NULL);
         start_auth_vencrypt_subauth(vs);
     }
 }
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 929391f85d..dbbfbefe56 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -151,7 +151,8 @@ void vnc_jobs_consume_buffer(VncState *vs)
             }
             if (vs->disconnecting == FALSE) {
                 vs->ioc_tag = qio_channel_add_watch(
-                    vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
+                    vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
+                    vnc_client_io, vs, NULL);
             }
         }
         buffer_move(&vs->output, &vs->jobs_buffer);
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 95c9703c72..6d79f3e5a5 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -41,13 +41,14 @@ static void vncws_tls_handshake_done(QIOTask *task,
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            QIO_CHANNEL(vs->ioc), G_IO_IN, vncws_handshake_io, vs, NULL);
+            QIO_CHANNEL(vs->ioc), G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vncws_handshake_io, vs, NULL);
     }
 }
 
 
 gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
-                                GIOCondition condition G_GNUC_UNUSED,
+                                GIOCondition condition,
                                 void *opaque)
 {
     VncState *vs = opaque;
@@ -59,6 +60,11 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
         vs->ioc_tag = 0;
     }
 
+    if (condition & (G_IO_HUP | G_IO_ERR)) {
+        vnc_client_error(vs);
+        return TRUE;
+    }
+
     tls = qio_channel_tls_new_server(
         vs->ioc,
         vs->vd->tlscreds,
@@ -105,13 +111,14 @@ static void vncws_handshake_done(QIOTask *task,
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vnc_client_io, vs, NULL);
     }
 }
 
 
 gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
-                            GIOCondition condition G_GNUC_UNUSED,
+                            GIOCondition condition,
                             void *opaque)
 {
     VncState *vs = opaque;
@@ -122,6 +129,11 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
         vs->ioc_tag = 0;
     }
 
+    if (condition & (G_IO_HUP | G_IO_ERR)) {
+        vnc_client_error(vs);
+        return TRUE;
+    }
+
     wioc = qio_channel_websock_new_server(vs->ioc);
     qio_channel_set_name(QIO_CHANNEL(wioc), "vnc-ws-server-websock");
 
diff --git a/ui/vnc.c b/ui/vnc.c
index f006aa1afd..49235056f7 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1398,7 +1398,8 @@ static size_t vnc_client_write_plain(VncState *vs)
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vnc_client_io, vs, NULL);
     }
 
     return ret;
@@ -1435,7 +1436,8 @@ static void vnc_client_write(VncState *vs)
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vnc_client_io, vs, NULL);
     }
     vnc_unlock_output(vs);
 }
@@ -1551,6 +1553,12 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
     VncState *vs = opaque;
 
     assert(vs->magic == VNC_MAGIC);
+
+    if (condition & (G_IO_HUP | G_IO_ERR)) {
+        vnc_disconnect_start(vs);
+        return TRUE;
+    }
+
     if (condition & G_IO_IN) {
         if (vnc_client_read(vs) < 0) {
             /* vs is free()ed here */
@@ -1612,7 +1620,8 @@ void vnc_write(VncState *vs, const void *data, size_t len)
             g_source_remove(vs->ioc_tag);
         }
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
+            vnc_client_io, vs, NULL);
     }
 
     buffer_append(&vs->output, data, len);
@@ -3077,14 +3086,17 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
         vs->websocket = 1;
         if (vd->tlscreds) {
             vs->ioc_tag = qio_channel_add_watch(
-                vs->ioc, G_IO_IN, vncws_tls_handshake_io, vs, NULL);
+                vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+                vncws_tls_handshake_io, vs, NULL);
         } else {
             vs->ioc_tag = qio_channel_add_watch(
-                vs->ioc, G_IO_IN, vncws_handshake_io, vs, NULL);
+                vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+                vncws_handshake_io, vs, NULL);
         }
     } else {
         vs->ioc_tag = qio_channel_add_watch(
-            vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
+            vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
+            vnc_client_io, vs, NULL);
     }
 
     vnc_client_cache_addr(vs);
-- 
2.17.1


