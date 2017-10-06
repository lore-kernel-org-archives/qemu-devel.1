Received: from eggs.gnu.org ([2001:4830:134:3::10]:40357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO6-0006is-Jq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO5-0004e8-1k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:48:56 -0300
Message-Id: <20171006235023.11952-2-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/88] cocci: script to use g_new() & friends
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

Imported from Markus Armbruster commit b45c03f

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Signed-off-by: Markus Armbruster <armbru@redhat.com>?

 scripts/coccinelle/g_new.cocci | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 scripts/coccinelle/g_new.cocci

diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.cocci
new file mode 100644
index 0000000000..1e57685a6b
--- /dev/null
+++ b/scripts/coccinelle/g_new.cocci
@@ -0,0 +1,101 @@
+/* transform g_new*() alloc with size arguments of the form sizeof(T) [* N]
+ *
+ *   g_new(T, n) is neater than g_malloc(sizeof(T) * n).  It's also safer,
+ *   for two reasons.  One, it catches multiplication overflowing size_t.
+ *   two, it returns T * rather than void *, which lets the compiler catch
+ *   more type errors.
+ *
+ *    Copyright: (C) 2017 Markus Armbruster <armbru@redhat.com>. GPLv2+.
+ *    (Imported from b45c03f585ea9bb1af76c73e82195418c294919d)
+ *
+ * See http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00908.html:
+ *
+ *   g_new() advantages (from glib doc):
+ *   - the returned pointer is cast to a pointer to the given type.
+ *   - care is taken to avoid overflow when calculating the size of the
+ *   allocated block.
+ *
+ *   p = g_malloc(sizeof(*p)) is idiomatic, and not obviously inferior to
+ *   p = g_new(T, 1), where T is the type of *p.
+ *   But once you add multiplication, g_new() adds something useful: overflow
+ *   protection.  Conversion to g_new() might make sense then.
+ */
+
+@@
+type T;
+@@
+-g_malloc(sizeof(T))
++g_new(T, 1)
+@@
+type T;
+@@
+-g_try_malloc(sizeof(T))
++g_try_new(T, 1)
+@@
+type T;
+@@
+-g_malloc0(sizeof(T))
++g_new0(T, 1)
+@@
+type T;
+@@
+-g_try_malloc0(sizeof(T))
++g_try_new0(T, 1)
+
+@@
+type T;
+expression n;
+@@
+-g_malloc(sizeof(T) * (n))
++g_new(T, n)
+@@
+type T;
+expression n;
+@@
+-g_try_malloc(sizeof(T) * (n))
++g_try_new(T, n)
+@@
+type T;
+expression n;
+@@
+-g_malloc0(sizeof(T) * (n))
++g_new0(T, n)
+@@
+type T;
+expression n;
+@@
+-g_try_malloc0(sizeof(T) * (n))
++g_try_new0(T, n)
+
+@@
+type T;
+expression p, n;
+@@
+-g_realloc(p, sizeof(T) * (n))
++g_renew(T, p, n)
+@@
+type T;
+expression p, n;
+@@
+-g_try_realloc(p, sizeof(T) * (n))
++g_try_renew(T, p, n)
+
+// drop superfluous cast
+@@
+type T;
+expression n;
+@@
+-(T *)g_new(T, n)
++g_new(T, n)
+@@
+type T;
+expression n;
+@@
+-(T *)g_new0(T, n)
++g_new0(T, n)
+@@
+type T;
+expression p, n;
+@@
+-(T *)g_renew(T, p, n)
++g_renew(T, p, n)
-- 
2.14.2
