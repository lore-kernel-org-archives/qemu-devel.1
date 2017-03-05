Received: from eggs.gnu.org ([2001:4830:134:3::10]:50788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdyS-00047C-9f
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdyP-0005Uo-3G
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:52 -0500
Received: from mail.kernel.org ([198.145.29.136]:56552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <krzk@kernel.org>) id 1ckdyO-0005TF-Pa
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:45:49 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  5 Mar 2017 23:45:29 +0200
Message-Id: <20170305214530.19733-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 1/2] char: Constify data pointed by few
 arguments and local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

In few places the function arguments and local variables are not
modifying data passed through pointers so this can be made const for
code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 chardev/char.c        | 18 +++++++++---------
 include/sysemu/char.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 54cd5f408150..a2571409bf65 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -102,7 +102,7 @@ static void qemu_chr_fe_write_log(Chardev *s,
 static int qemu_chr_fe_write_buffer(Chardev *s,
                                     const uint8_t *buf, int len, int *offset)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(s);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(s);
     int res = 0;
     *offset = 0;
 
@@ -129,7 +129,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
     return res;
 }
 
-static bool qemu_chr_replay(Chardev *chr)
+static bool qemu_chr_replay(const Chardev *chr)
 {
     return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
 }
@@ -137,7 +137,7 @@ static bool qemu_chr_replay(Chardev *chr)
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     Chardev *s = be->chr;
-    ChardevClass *cc;
+    const ChardevClass *cc;
     int ret;
 
     if (!s) {
@@ -369,7 +369,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
 static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(chr);
     /* Any ChardevCommon member would work */
     ChardevCommon *common = backend ? backend->u.null.data : NULL;
 
@@ -513,10 +513,10 @@ unavailable:
     return false;
 }
 
-static bool qemu_chr_is_busy(Chardev *s)
+static bool qemu_chr_is_busy(const Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
-        MuxChardev *d = MUX_CHARDEV(s);
+        const MuxChardev *d = MUX_CHARDEV(s);
         return d->mux_cnt >= 0;
     } else {
         return s->be != NULL;
@@ -549,7 +549,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     Chardev *s;
-    ChardevClass *cc;
+    const ChardevClass *cc;
     int fe_open;
 
     s = b->chr;
@@ -603,7 +603,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
 
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    const ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
     if (cc->chr_wait_connected) {
         return cc->chr_wait_connected(chr, errp);
@@ -1223,7 +1223,7 @@ QemuOptsList qemu_chardev_opts = {
     },
 };
 
-bool qemu_chr_has_feature(Chardev *chr,
+bool qemu_chr_has_feature(const Chardev *chr,
                           ChardevFeature feature)
 {
     return test_bit(feature, chr->features);
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 450881d42cb5..2b11bbc40692 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -432,7 +432,7 @@ void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
 
-bool qemu_chr_has_feature(Chardev *chr,
+bool qemu_chr_has_feature(const Chardev *chr,
                           ChardevFeature feature);
 void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
-- 
2.9.3
