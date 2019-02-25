Received: from eggs.gnu.org ([209.51.188.92]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gyIVM-0006B3-1O
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gyIVL-0005RF-6K
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gyIVK-0005Q3-Gs
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:49:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 207E730039B4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 15:43:43 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Mon, 25 Feb 2019 15:43:34 +0000
Message-Id: <20190225154335.11397-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] audio: Use g_strdup_printf instead of
 manual building a string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

Instead of using lot of low level function and manually allocate
the temporary string in audio_process_options use more high
level GLib function. The function is not used in hot path but to
read some initial setting.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 audio/audio.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index d163ffbc88..472721a7a9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -454,9 +454,7 @@ static void audio_print_options (const char *prefix,
 static void audio_process_options (const char *prefix,
                                    struct audio_option *opt)
 {
-    char *optname;
-    const char qemu_prefix[] =3D "QEMU_";
-    size_t preflen, optlen;
+    gchar *prefix_upper;
=20
     if (audio_bug(__func__, !prefix)) {
         dolog ("prefix =3D NULL\n");
@@ -468,10 +466,10 @@ static void audio_process_options (const char *pref=
ix,
         return;
     }
=20
-    preflen =3D strlen (prefix);
+    prefix_upper =3D g_utf8_strup(prefix, -1);
=20
     for (; opt->name; opt++) {
-        size_t len, i;
+        char *optname;
         int def;
=20
         if (!opt->valp) {
@@ -480,21 +478,7 @@ static void audio_process_options (const char *prefi=
x,
             continue;
         }
=20
-        len =3D strlen (opt->name);
-        /* len of opt->name + len of prefix + size of qemu_prefix
-         * (includes trailing zero) + zero + underscore (on behalf of
-         * sizeof) */
-        optlen =3D len + preflen + sizeof (qemu_prefix) + 1;
-        optname =3D g_malloc (optlen);
-
-        pstrcpy (optname, optlen, qemu_prefix);
-
-        /* copy while upper-casing, including trailing zero */
-        for (i =3D 0; i <=3D preflen; ++i) {
-            optname[i + sizeof (qemu_prefix) - 1] =3D qemu_toupper(prefi=
x[i]);
-        }
-        pstrcat (optname, optlen, "_");
-        pstrcat (optname, optlen, opt->name);
+        optname =3D g_strdup_printf("QEMU_%s_%s", prefix_upper, opt->nam=
e);
=20
         def =3D 1;
         switch (opt->tag) {
@@ -532,6 +516,7 @@ static void audio_process_options (const char *prefix=
,
         *opt->overriddenp =3D !def;
         g_free (optname);
     }
+    g_free(prefix_upper);
 }
=20
 static void audio_print_settings (struct audsettings *as)
--=20
2.20.1
