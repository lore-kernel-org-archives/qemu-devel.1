Received: from eggs.gnu.org ([2001:4830:134:3::10]:52656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqF-0001M1-CA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqE-0002zi-JJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:27 +0100
Message-Id: <20180302185448.6314-17-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/37] vdi: Avoid bitrot of debugging code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Rework the debug define so that we always get -Wformat checking,
even when debugging is disabled.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index fc1c614cb1..32b1763cde 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -87,12 +87,18 @@
 #define DEFAULT_CLUSTER_SIZE (1 * MiB)
=20
 #if defined(CONFIG_VDI_DEBUG)
-#define logout(fmt, ...) \
-                fprintf(stderr, "vdi\t%-24s" fmt, __func__, ##__VA_ARGS_=
_)
+#define VDI_DEBUG 1
 #else
-#define logout(fmt, ...) ((void)0)
+#define VDI_DEBUG 0
 #endif
=20
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
=20
--=20
2.13.6
