Received: from eggs.gnu.org ([2001:4830:134:3::10]:57152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkO-0003GQ-U1
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkN-0004LQ-Ml
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:37 -0300
Message-Id: <20170718061005.29518-2-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/29] coccinelle: add a script to enforce
 qemu/osdep.h macros usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/use_osdep.cocci | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 scripts/coccinelle/use_osdep.cocci

diff --git a/scripts/coccinelle/use_osdep.cocci b/scripts/coccinelle/use_osdep.cocci
new file mode 100644
index 0000000000..356b36e358
--- /dev/null
+++ b/scripts/coccinelle/use_osdep.cocci
@@ -0,0 +1,60 @@
+// Use macros from qemu/osdep.h
+//
+// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
+// Confidence: High
+// Options: --macro-file scripts/cocci-macro-file.h
+//
+// docker run --rm -v `pwd`:`pwd` -w `pwd` philmd/coccinelle \
+//     --macro-file scripts/cocci-macro-file.h \
+//     --sp-file scripts/coccinelle/add_osdep.cocci \
+//     --keep-comments --in-place \
+//     --use-gitgrep --dir .
+
+// Use QEMU_IS_ALIGNED()
+@@
+typedef uintptr_t;
+uintptr_t ptr;
+expression n, m;
+@@
+(
+-ptr % m == 0
++QEMU_PTR_IS_ALIGNED(ptr, m)
+|
+-n % m == 0
++QEMU_IS_ALIGNED(n, m)
+)
+
+// Use QEMU_ALIGN_DOWN()
+@@
+expression n, m;
+@@
+-n / m * m
++QEMU_ALIGN_DOWN(n, m)
+
+// Use ARRAY_SIZE()
+@@
+expression x;
+@@
+-sizeof(x) / sizeof((x)[0])
++ARRAY_SIZE(x)
+
+// Drop superfluous parenthesis
+@@
+expression n, m;
+@@
+(
+-(QEMU_IS_ALIGNED(n, m))
++QEMU_IS_ALIGNED(n, m)
+|
+-QEMU_IS_ALIGNED((n), m)
++QEMU_IS_ALIGNED(n, m)
+|
+-(QEMU_PTR_IS_ALIGNED(n, m))
++QEMU_PTR_IS_ALIGNED(n, m)
+|
+-QEMU_ALIGN_DOWN((n), m)
++QEMU_ALIGN_DOWN(n, m)
+|
+-(ARRAY_SIZE(n))
++ARRAY_SIZE(n)
+)
-- 
2.13.2
