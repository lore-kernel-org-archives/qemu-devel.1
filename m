Received: from eggs.gnu.org ([2001:4830:134:3::10]:47900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawp-0003NN-7H
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawo-0000UV-9j
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:48 -0600
Message-Id: <20180105225753.30509-16-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 15/20] vdi: Avoid bitrot of debugging code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

Rework the debug define so that we always get -Wformat checking,
even when debugging is disabled.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v2-v7: no change
---
 block/vdi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 8da5dfc897..6f83221ddc 100644
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
2.14.3
