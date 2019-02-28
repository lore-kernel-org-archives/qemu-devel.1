Received: from eggs.gnu.org ([209.51.188.92]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcq-00033A-Qg
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIco-0000yb-UH
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIco-0000rP-Me
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A3648E3EF
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:54 +0100
Message-Id: <20190228100858.28397-2-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
References: <20190228100858.28397-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] audio: Use g_strdup_printf instead of
 manual building a string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

Instead of using lot of low level function and manually allocate
the temporary string in audio_process_options use more high
level GLib function. The function is not used in hot path but to
read some initial setting.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Message-id: 20190225154335.11397-1-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index d163ffbc88f4..472721a7a9f0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -454,9 +454,7 @@ static void audio_print_options (const char *prefix,
 static void audio_process_options (const char *prefix,
                                    struct audio_option *opt)
 {
-    char *optname;
-    const char qemu_prefix[] = "QEMU_";
-    size_t preflen, optlen;
+    gchar *prefix_upper;
 
     if (audio_bug(__func__, !prefix)) {
         dolog ("prefix = NULL\n");
@@ -468,10 +466,10 @@ static void audio_process_options (const char *prefix,
         return;
     }
 
-    preflen = strlen (prefix);
+    prefix_upper = g_utf8_strup(prefix, -1);
 
     for (; opt->name; opt++) {
-        size_t len, i;
+        char *optname;
         int def;
 
         if (!opt->valp) {
@@ -480,21 +478,7 @@ static void audio_process_options (const char *prefix,
             continue;
         }
 
-        len = strlen (opt->name);
-        /* len of opt->name + len of prefix + size of qemu_prefix
-         * (includes trailing zero) + zero + underscore (on behalf of
-         * sizeof) */
-        optlen = len + preflen + sizeof (qemu_prefix) + 1;
-        optname = g_malloc (optlen);
-
-        pstrcpy (optname, optlen, qemu_prefix);
-
-        /* copy while upper-casing, including trailing zero */
-        for (i = 0; i <= preflen; ++i) {
-            optname[i + sizeof (qemu_prefix) - 1] = qemu_toupper(prefix[i]);
-        }
-        pstrcat (optname, optlen, "_");
-        pstrcat (optname, optlen, opt->name);
+        optname = g_strdup_printf("QEMU_%s_%s", prefix_upper, opt->name);
 
         def = 1;
         switch (opt->tag) {
@@ -532,6 +516,7 @@ static void audio_process_options (const char *prefix,
         *opt->overriddenp = !def;
         g_free (optname);
     }
+    g_free(prefix_upper);
 }
 
 static void audio_print_settings (struct audsettings *as)
-- 
2.9.3
