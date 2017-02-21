Received: from eggs.gnu.org ([2001:4830:134:3::10]:53225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cg1Ge-0007K7-7C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cg1GZ-0001Os-CC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:37:32 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cg1GZ-0001Om-7s
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 22:37:27 -0500
Received: by mail-ot0-x244.google.com with SMTP id l26so12825325ota.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 19:37:26 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 Feb 2017 19:37:19 -0800
Message-Id: <1487648239-83616-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] spice-char: fix segfault in char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
call 'char_spice_finalize'. But as the SpiceChardev is not inserted
in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfault.
Add a detect to avoid it.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 spice-qemu-char.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 6f46f46..15dbf9c 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
     SpiceChardev *s = SPICE_CHARDEV(obj);
 
     vmc_unregister_interface(s);
-    QLIST_REMOVE(s, next);
+
+    if (spice_chars.lh_first) {
+        QLIST_REMOVE(s, next);
+    }
 
     g_free((char *)s->sin.subtype);
 #if SPICE_SERVER_VERSION >= 0x000c02
-- 
1.8.3.1
