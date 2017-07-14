Received: from eggs.gnu.org ([2001:4830:134:3::10]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVj-00048h-4I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVi-0004Da-BB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:52 -0500
Message-Id: <20170714121457.10322-16-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/20] vdi: Avoid bitrot of debugging code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

Rework the debug define so that we always get -Wformat checking,
even when debugging is disabled.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
v2: no change
---
 block/vdi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 2b6e8fa..dc36685 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -86,12 +86,18 @@
 #define DEFAULT_CLUSTER_SIZE (1 * MiB)

 #if defined(CONFIG_VDI_DEBUG)
-#define logout(fmt, ...) \
-                fprintf(stderr, "vdi\t%-24s" fmt, __func__, ##__VA_ARGS_=
_)
+#define VDI_DEBUG 1
 #else
-#define logout(fmt, ...) ((void)0)
+#define VDI_DEBUG 0
 #endif

+#define logout(fmt, ...) \
+    do {                                                                =
\
+        if (VDI_DEBUG) {                                                =
\
+            fprintf(stderr, "vdi\t%-24s" fmt, __func__, ##__VA_ARGS__); =
\
+        }                                                               =
\
+    } while (0)
+
 /* Image signature. */
 #define VDI_SIGNATURE 0xbeda107f

--=20
2.9.4
