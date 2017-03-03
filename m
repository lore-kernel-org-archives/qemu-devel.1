Received: from eggs.gnu.org ([2001:4830:134:3::10]:59399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6H-0003v2-Oa
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6F-0002Pt-Hi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjq6F-0002Pl-B2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id z63so1735255wmg.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:30:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:30:27 +0100
Message-Id: <1488558630-21522-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
References: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/21] spice-char: fix segfault in
 char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liq3ea@gmail.com>

In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
call 'char_spice_finalize'. But as the SpiceChardev is not inserted
in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfault.
Add a detect to avoid it.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-Id: <1487665107-88004-1-git-send-email-liqiang6-s@360.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 spice-qemu-char.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 6f46f46..4d1c76e 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
     SpiceChardev *s = SPICE_CHARDEV(obj);
 
     vmc_unregister_interface(s);
-    QLIST_REMOVE(s, next);
+
+    if (s->next.le_prev) {
+        QLIST_REMOVE(s, next);
+    }
 
     g_free((char *)s->sin.subtype);
 #if SPICE_SERVER_VERSION >= 0x000c02
-- 
1.8.3.1
