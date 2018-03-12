Received: from eggs.gnu.org ([2001:4830:134:3::10]:41477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKur-00029t-Vf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKuo-0000jQ-SB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iG-NQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 200472712B5
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:36 +0100
Message-Id: <20180312104241.24965-4-kraxel@redhat.com>
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] audio: add module loading support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Make audio_driver_lookup() try load the module in case it doesn't find
the driver in the registry.  Also load all modules for -audio-help, so
the help output includes the help text for modular audio drivers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180306074053.22856-3-kraxel@redhat.com
---
 include/qemu/module.h |  1 +
 audio/audio.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 9fea75aaeb..54300ab6e5 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -54,6 +54,7 @@ typedef enum {
=20
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
+#define audio_module_load_one(lib) module_load_one("audio-", lib)
=20
 void register_module_init(void (*fn)(void), module_init_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
diff --git a/audio/audio.c b/audio/audio.c
index 2384612b87..6eccdb17ee 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -68,9 +68,26 @@ audio_driver *audio_driver_lookup(const char *name)
             return d;
         }
     }
+
+    audio_module_load_one(name);
+    QLIST_FOREACH(d, &audio_drivers, next) {
+        if (strcmp(name, d->name) =3D=3D 0) {
+            return d;
+        }
+    }
+
     return NULL;
 }
=20
+static void audio_module_load_all(void)
+{
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(audio_prio_list); i++) {
+        audio_driver_lookup(audio_prio_list[i]);
+    }
+}
+
 struct fixed_settings {
     int enabled;
     int nb_voices;
@@ -1675,6 +1692,9 @@ void AUD_help (void)
 {
     struct audio_driver *d;
=20
+    /* make sure we print the help text for modular drivers too */
+    audio_module_load_all();
+
     audio_process_options ("AUDIO", audio_options);
     QLIST_FOREACH(d, &audio_drivers, next) {
         if (d->options) {
--=20
2.9.3
