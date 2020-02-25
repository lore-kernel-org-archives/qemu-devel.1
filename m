Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C1C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D6E21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnmmijoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c6O-00068e-Ak
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bur-0001eF-DU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buq-0001bz-3j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bup-0001bj-VI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/aiv3lhOmdIPftAE4AmweEgXAxc/uZrTam4P30LF8M=;
 b=XnmmijoDTQQ31CRfeHBQILXdNarLWPP3XN49Jfd8ySSLRmKWbtMZE4f5R1tNDjNPlX7yPM
 vqGD2iV/kPc2rcmX/KsyFOb6srOi1ZR7ZlktAOv/RKucRbfRxoAZLQmjNOk6E4EnZWPvJd
 IaNtCqqpRVPQE2GMT7j9ZbKf69iasAY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-sO4nz5sKMJ-VOKqxfk8dIQ-1; Tue, 25 Feb 2020 10:14:26 -0500
X-MC-Unique: sO4nz5sKMJ-VOKqxfk8dIQ-1
Received: by mail-qv1-f69.google.com with SMTP id g9so13200646qvy.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VULHvANuJTAMzSo4WuZrwNg3YHlhkBLMkkXorsz6PrY=;
 b=PcdUsLyEQI0nUnSPqYM++YGqD1xNdRMtrQEkvEY7elU3MedOanKgw1tplaR2m3H1FJ
 +cB5UjXRXWfPeglh9iX+2K4YVYyulR+sONMK2nYIwaYX1p80IzOI8hzc63gBwCYW8byN
 Oo8ueGF8F6kaxFpq5JmTktVdBEW533N/Qsw7S+TlvFigKjWh6lx9+vpb7hlp20RMaVgm
 U9S+TAxlxEUqYJntJi9b6UMFANFXYkUOQjTZId9ooDRtVCC5ZwYriTPOX94xzOK2lf1I
 SCO/DAMAKidlFp6yMXQ4bgKA1IbVN5e7Cmca72ykqunzJsxGI1ozf/NM6Dlurdza+mwr
 UxqA==
X-Gm-Message-State: APjAAAUKshlpbxetbn6Ypp3usgQbHLljj9hueWwDey/2QNF7TkasPHtS
 qkTFozmkjw3A0yPX3BYaAJmmHpG7gopYulLDgVwxaYi5++aIuuFJmuv37PMHisHVCFZm7RSG/E4
 wcoR+u518Ew0eprI=
X-Received: by 2002:a37:2710:: with SMTP id n16mr56970424qkn.235.1582643665270; 
 Tue, 25 Feb 2020 07:14:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuzc/QbhQ1zmoOQmNmQ3c1NI7Lr53lr6I4hgaWc9wzJR8jSgiYD4a2OsjXG6ZzMByrogSKTA==
X-Received: by 2002:a37:2710:: with SMTP id n16mr56970395qkn.235.1582643665023; 
 Tue, 25 Feb 2020 07:14:25 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 q125sm2319071qke.116.2020.02.25.07.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:24 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] libvhost-user-glib: fix VugDev main fd cleanup
Message-ID: <20200225151210.647797-24-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
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


