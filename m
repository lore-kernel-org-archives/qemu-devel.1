Received: from eggs.gnu.org ([2001:4830:134:3::10]:40387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO9-0006j1-Id
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO8-0004fg-Pa
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:48:57 -0300
Message-Id: <20171006235023.11952-3-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/88] cocci: add more g_new() transformations
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
 scripts/coccinelle/g_new.cocci | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.cocci
index 1e57685a6b..c767325a21 100644
--- a/scripts/coccinelle/g_new.cocci
+++ b/scripts/coccinelle/g_new.cocci
@@ -80,6 +80,49 @@ expression p, n;
 -g_try_realloc(p, sizeof(T) * (n))
 +g_try_renew(T, p, n)
 
+@@
+type T;
+expression n;
+@@
+(
+-g_malloc_n(n, sizeof(T))
++g_new(T, n)
+|
+-g_malloc0_n(n, sizeof(T))
++g_new0(T, n)
+|
+-g_try_malloc_n(n, sizeof(T))
++g_try_new(T, n)
+|
+-g_try_malloc0_n(n, sizeof(T))
++g_try_new0(T, n)
+)
+
+@@
+type T;
+identifier m;
+@@
+T *m;
+...
+(
+-m = g_malloc(sizeof(*m));
++m = g_new(T, 1);
+|
+-m = g_malloc0(sizeof(*m));
++m = g_new0(T, 1);
+|
+-m = g_try_malloc(sizeof(*m));
++m = g_try_new(T, 1);
+|
+-m = g_try_malloc0(sizeof(*m));
++m = g_try_new0(T, 1);
+)
+
+////////////////////////////////////////
+//
+// last transformations: cleanups
+//
+
 // drop superfluous cast
 @@
 type T;
@@ -99,3 +142,33 @@ expression p, n;
 @@
 -(T *)g_renew(T, p, n)
 +g_renew(T, p, n)
+@@
+type T;
+expression n;
+@@
+(
+-(T *)g_try_new(T, n)
++g_try_new(T, n)
+|
+-(T *)g_try_new0(T, n)
++g_try_new0(T, n)
+)
+
+// drop superfluous parenthesis
+@@
+type T;
+expression c;
+@@
+(
+-g_new(T, (c))
++g_new(T, c)
+|
+-g_try_new(T, (c))
++g_try_new(T, c)
+|
+-g_new0(T, (c))
++g_new0(T, c)
+|
+-g_try_new0(T, (c))
++g_try_new0(T, c)
+)
-- 
2.14.2
