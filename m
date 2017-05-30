Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFfy0-00063T-Sq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFfxx-0002o8-OB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:09:40 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFfxx-0002o0-IP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:09:37 -0400
Received: by mail-oi0-x241.google.com with SMTP id h4so15494897oib.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 05:09:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 30 May 2017 09:09:19 -0300
Message-Id: <20170530120919.8874-1-f4bug@amsat.org>
In-Reply-To: <149604983117.777.3318402617001973219@750cb16fd6f2>
References: <149604983117.777.3318402617001973219@750cb16fd6f2>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] char: cast ARRAY_SIZE() as signed to silent
 warning on empty array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

chardev/char.c: In function 'chardev_name_foreach':
chardev/char.c:546:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
     for (i = 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
                   ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 chardev/char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 4e3808aefc..7aa0210765 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -543,7 +543,7 @@ chardev_name_foreach(void (*fn)(const char *name, void *opaque), void *opaque)
 
     object_class_foreach(chardev_class_foreach, TYPE_CHARDEV, false, &fe);
 
-    for (i = 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+    for (i = 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
         fn(chardev_alias_table[i].alias, opaque);
     }
 }
@@ -589,7 +589,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
         return NULL;
     }
 
-    for (i = 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
+    for (i = 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
         if (g_strcmp0(chardev_alias_table[i].alias, name) == 0) {
             name = chardev_alias_table[i].typename;
             break;
-- 
2.11.0
