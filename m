Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B4C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F316B2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="es+9G+Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F316B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sjc-00060d-U5
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfO-0006NT-Lw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfK-0000nK-Qs
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfK-0000mE-LG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/aiv3lhOmdIPftAE4AmweEgXAxc/uZrTam4P30LF8M=;
 b=es+9G+GxFQhrMX1rqhL1OzQ8o9lQ+xOGKRuDFD1WYng+eCmjst4/ve07fm+21yx94O1DO0
 dPMX+D5USjV3GGTTUH7ITNyQ05fyZvrAQ/wJ8eltnzz75DSuCyaUQKwAlw3PjAT6Q139Ny
 EXFNAwReACRX7PioxyZGCUXsM681jzo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-FC7aCu5BP8-NwQDuyC_VkQ-1; Wed, 26 Feb 2020 04:07:32 -0500
X-MC-Unique: FC7aCu5BP8-NwQDuyC_VkQ-1
Received: by mail-wr1-f69.google.com with SMTP id n23so1173330wra.20
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VULHvANuJTAMzSo4WuZrwNg3YHlhkBLMkkXorsz6PrY=;
 b=h6TWDSQIEA+XgeSM2Il/kGyjGiDq2wrxAHzx4OWug7O3aZGHrw9mgpHgy3Z0SRFS8Z
 ztgGFvOd4SCzb1pyxDk1rk40MBJoTA/aNCBPF5rtYOIwg5Whlhs05oeVA74LQH4D4gZz
 avSQUN1Z+Hcm3p6byjiPcU+mrF4jRa01kQ4QR0049FtSR6mneK2YlBu/xAHGSRjvMkmN
 5dVjRI2iHE25XanmWTHhu3edxTcmS/kZ6E/gJR2jprSd80NttTT9nO7YO6SYgDuA/zuw
 oD+MaXQMQ6HQT/2Oawpy3T5uxl4/KfTtma+LuZKzI4qrhYW0+2qtpL3dRFVITcliXSgP
 HPdg==
X-Gm-Message-State: APjAAAVbNPiv98jceWvDDB66xlcuu8/18HkLUiKYlkfsCbci5+TMNT3c
 ncPzd/Cx+gRpmlvlmXWXjoV/mmPWHQVXLLsgfN1mbOQ6S1RCQmE/a0IxIp4ti5bRDQ35f1XAk5l
 V8eIXtww4GxplCvk=
X-Received: by 2002:adf:f60b:: with SMTP id t11mr1481831wrp.344.1582708051168; 
 Wed, 26 Feb 2020 01:07:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXkr4gHZe2N8+1EBATNt7Lf7XXB8UHJjdY8DoDQrgjrz3fORXwreuUQdvaV2Hm5MDETbba+g==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr1481771wrp.344.1582708050488; 
 Wed, 26 Feb 2020 01:07:30 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 b7sm2093431wrs.97.2020.02.26.01.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:29 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/30] libvhost-user-glib: fix VugDev main fd cleanup
Message-ID: <20200226090010.708934-24-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Johannes Berg <johannes.berg@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

If you try to make a device implementation that can handle multiple
connections and allow disconnections (which requires overriding the
VHOST_USER_NONE handling), then glib will warn that we remove a src
while it's still on the mainloop, and will poll() an FD that doesn't
exist anymore.

Fix this by making vug_source_new() require pairing with the new
vug_source_destroy() so we can keep the GSource referenced in the
meantime.

Note that this requires calling the new API in vhost-user-input.
vhost-user-gpu also uses vug_source_new(), but never seems to free
the result at all, so I haven't changed anything there.

Fixes: 8bb7ddb78a1c ("libvhost-user: add glib source helper")
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-3-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user-glib.h |  1 +
 contrib/libvhost-user/libvhost-user-glib.c | 15 ++++++++++++---
 contrib/vhost-user-input/main.c            |  6 ++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-=
user/libvhost-user-glib.h
index 64d539d93a..1a79a4916e 100644
--- a/contrib/libvhost-user/libvhost-user-glib.h
+++ b/contrib/libvhost-user/libvhost-user-glib.h
@@ -31,5 +31,6 @@ void vug_deinit(VugDev *dev);
=20
 GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
                         vu_watch_cb vu_cb, gpointer data);
+void vug_source_destroy(GSource *src);
=20
 #endif /* LIBVHOST_USER_GLIB_H */
diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-=
user/libvhost-user-glib.c
index 99edd2f3de..824c7780de 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -91,7 +91,6 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
     g_source_add_poll(gsrc, &src->gfd);
     id =3D g_source_attach(gsrc, NULL);
     g_assert(id);
-    g_source_unref(gsrc);
=20
     return gsrc;
 }
@@ -131,6 +130,16 @@ static void vug_watch(VuDev *dev, int condition, void =
*data)
     }
 }
=20
+void vug_source_destroy(GSource *src)
+{
+    if (!src) {
+        return;
+    }
+
+    g_source_destroy(src);
+    g_source_unref(src);
+}
+
 bool
 vug_init(VugDev *dev, uint16_t max_queues, int socket,
          vu_panic_cb panic, const VuDevIface *iface)
@@ -144,7 +153,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
     }
=20
     dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
-                                       (GDestroyNotify) g_source_destroy);
+                                       (GDestroyNotify) vug_source_destroy=
);
=20
     dev->src =3D vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
=20
@@ -157,5 +166,5 @@ vug_deinit(VugDev *dev)
     g_assert(dev);
=20
     g_hash_table_unref(dev->fdmap);
-    g_source_unref(dev->src);
+    vug_source_destroy(dev->src);
 }
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/mai=
n.c
index ef4b7769f2..6020c6f33a 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -187,7 +187,7 @@ vi_queue_set_started(VuDev *dev, int qidx, bool started=
)
     }
=20
     if (!started && vi->evsrc) {
-        g_source_destroy(vi->evsrc);
+        vug_source_destroy(vi->evsrc);
         vi->evsrc =3D NULL;
     }
 }
@@ -401,9 +401,7 @@ main(int argc, char *argv[])
=20
     vug_deinit(&vi.dev);
=20
-    if (vi.evsrc) {
-        g_source_unref(vi.evsrc);
-    }
+    vug_source_destroy(vi.evsrc);
     g_array_free(vi.config, TRUE);
     g_free(vi.queue);
     return 0;
--=20
MST


