Received: from eggs.gnu.org ([2001:4830:134:3::10]:50058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5d-0008Bt-Fa
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5c-0004jV-Mq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:19 -0300
Message-Id: <20170724182751.18261-4-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 03/35] thunk: check nb_fields is valid
 before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

thunk.c:91:32: warning: Call to 'malloc' has an allocation size of 0 bytes
        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 thunk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index 2dac36666d..d1c5e221f5 100644
--- a/thunk.c
+++ b/thunk.c
@@ -67,7 +67,6 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
     int nb_fields, offset, max_align, align, size, i, j;
 
     assert(id < max_struct_entries);
-    se = struct_entries + id;
 
     /* first we count the number of fields */
     type_ptr = types;
@@ -76,6 +75,10 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
         type_ptr = thunk_type_next(type_ptr);
         nb_fields++;
     }
+    if (!nb_fields) {
+        return;
+    }
+    se = struct_entries + id;
     se->field_types = types;
     se->nb_fields = nb_fields;
     se->name = name;
-- 
2.13.3
