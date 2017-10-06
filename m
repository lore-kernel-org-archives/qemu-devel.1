Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOI-0006pJ-2w
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOG-0004im-6E
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:48:59 -0300
Message-Id: <20171006235023.11952-5-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/88] cocci: avoid use of g_new0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/g_new.cocci | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.cocci
index 368f0c5651..9643ce3f23 100644
--- a/scripts/coccinelle/g_new.cocci
+++ b/scripts/coccinelle/g_new.cocci
@@ -127,6 +127,52 @@ T **m;
 - *m = g_malloc0(sizeof(**m));
 + *m = g_new0(T *, 1);
 
+////////////////////////////////////////
+//
+// no point in zeroing the allocation
+//
+
+// the loop right afterwards fully initializes the memory
+@@
+type T;
+identifier a, i;
+expression c, e;
+@@
+(
+-a = g_new0(T, c);
+    ... when != a, c
++a = g_new(T, c);
+    for (i = 0; i < c; i++) {
+        a[i] = e;
+    }
+|
+-a = g_try_new0(T, c);
+    ... when != a, c
++a = g_try_new(T, c);
+    for (i = 0; i < c; i++) {
+        a[i] = e;
+    }
+)
+
+// compound literals
+@@
+type T;
+identifier p;
+expression s, e;
+@@
+(
+- p = g_malloc0(s);
++ p = g_malloc(s);
+|
+- p = g_try_malloc0(s);
++ p = g_try_malloc(s);
+|
+- p = g_new0(T, 1);
++ p = g_new(T, 1);
+)
+  ... when != p
+  *p = e;
+
 ////////////////////////////////////////
 //
 // last transformations: cleanups
-- 
2.14.2
