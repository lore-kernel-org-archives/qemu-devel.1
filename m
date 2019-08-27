Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B2DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0802077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0802077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2avC-0001Rn-Sq
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i2auU-0000wc-5A
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i2auS-00016u-Ts
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:49:18 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:45912
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i2auS-000163-NH
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:49:16 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i2auN-0008R3-Gk; Tue, 27 Aug 2019 14:49:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 15:49:09 +0300
Message-Id: <20190827124909.16824-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [PATCH v3] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Johannes Berg <johannes.berg@intel.com>
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 contrib/libvhost-user/libvhost-user-glib.c | 15 ++++++++++++---
 contrib/libvhost-user/libvhost-user-glib.h |  1 +
 contrib/vhost-user-input/main.c            |  6 ++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
index 99edd2f3de45..eaf88b8aa749 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -91,7 +91,6 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
     g_source_add_poll(gsrc, &src->gfd);
     id = g_source_attach(gsrc, NULL);
     g_assert(id);
-    g_source_unref(gsrc);
 
     return gsrc;
 }
@@ -131,6 +130,16 @@ static void vug_watch(VuDev *dev, int condition, void *data)
     }
 }
 
+void vug_source_destroy(GSource *src)
+{
+    if (!src) {
+        return;
+    }
+
+    g_source_unref(src);
+    g_source_destroy(src);
+}
+
 bool
 vug_init(VugDev *dev, uint16_t max_queues, int socket,
          vu_panic_cb panic, const VuDevIface *iface)
@@ -144,7 +153,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
     }
 
     dev->fdmap = g_hash_table_new_full(NULL, NULL, NULL,
-                                       (GDestroyNotify) g_source_destroy);
+                                       (GDestroyNotify) vug_source_destroy);
 
     dev->src = vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
 
@@ -157,5 +166,5 @@ vug_deinit(VugDev *dev)
     g_assert(dev);
 
     g_hash_table_unref(dev->fdmap);
-    g_source_unref(dev->src);
+    vug_source_destroy(dev->src);
 }
diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
index 64d539d93aba..1a79a4916ef2 100644
--- a/contrib/libvhost-user/libvhost-user-glib.h
+++ b/contrib/libvhost-user/libvhost-user-glib.h
@@ -31,5 +31,6 @@ void vug_deinit(VugDev *dev);
 
 GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
                         vu_watch_cb vu_cb, gpointer data);
+void vug_source_destroy(GSource *src);
 
 #endif /* LIBVHOST_USER_GLIB_H */
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 449fd2171a5a..7d6b0f9d80cc 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -187,7 +187,7 @@ vi_queue_set_started(VuDev *dev, int qidx, bool started)
     }
 
     if (!started && vi->evsrc) {
-        g_source_destroy(vi->evsrc);
+        vug_source_destroy(vi->evsrc);
         vi->evsrc = NULL;
     }
 }
@@ -401,9 +401,7 @@ main(int argc, char *argv[])
 
     vug_deinit(&vi.dev);
 
-    if (vi.evsrc) {
-        g_source_unref(vi.evsrc);
-    }
+    vugg_source_destroy(vi.evsrc);
     g_array_free(vi.config, TRUE);
     g_free(vi.queue);
     return 0;
-- 
2.23.0


