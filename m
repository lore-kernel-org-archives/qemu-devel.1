Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3146C55179
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A76B2080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQBWitMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A76B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL5a-0002hn-69
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaL00-0003sy-5k
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:47:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaKzx-0003OH-NC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604504816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjNTknoDW/b/Fa2Vm/42x1FIT5Fo8X9YnZGkdmVXxYk=;
 b=iQBWitMNVNr7nKzCXsOLWkzyQHLEBWroYBI0MPam/8X9rVQ3GpyppobdIHsIgHJnkhHuNX
 y1WZaUGmN6ug2G2xcsDSXyXHc1ehK58bFHS5OOJnEBeI2PG8veoSuLCV/jO7MqpJLcoZD+
 +5qPiox+8ygWo0Y0FQthpNIZ0VW7GSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-yxMp0iNWNR-60yLynXB2Kg-1; Wed, 04 Nov 2020 10:46:53 -0500
X-MC-Unique: yxMp0iNWNR-60yLynXB2Kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766418049C3;
 Wed,  4 Nov 2020 15:46:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA3825D9CC;
 Wed,  4 Nov 2020 15:46:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 000ED9D0F; Wed,  4 Nov 2020 16:46:45 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] vnc: fix resource leak when websocket channel error
Date: Wed,  4 Nov 2020 16:46:43 +0100
Message-Id: <20201104154645.15877-2-kraxel@redhat.com>
In-Reply-To: <20201104154645.15877-1-kraxel@redhat.com>
References: <20201104154645.15877-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ding Hui <dinghui@sangfor.com.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ding Hui <dinghui@sangfor.com.cn>

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
Message-id: 20201029032241.11040-1-dinghui@sangfor.com.cn
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-auth-sasl.c     |  3 ++-
 ui/vnc-auth-vencrypt.c |  3 ++-
 ui/vnc-jobs.c          |  3 ++-
 ui/vnc-ws.c            | 20 ++++++++++++++++----
 ui/vnc.c               | 24 ++++++++++++++++++------
 5 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 0517b2ead9ce..f67111a3662a 100644
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
index f072e16aceb1..d9c212ff3286 100644
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
index 929391f85d69..dbbfbefe5619 100644
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
index 95c9703c7240..6d79f3e5a5d8 100644
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
index f006aa1afdb2..49235056f7a8 100644
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
2.27.0


