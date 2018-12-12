Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YN-0002Gy-Oc
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YM-0000oZ-Qr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:27:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:26:55 +0100
Message-Id: <20181212132735.16080-2-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/41] block: adding lzfse decompressing support
 as a module.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Julio Faracco <jcfaracco@gmail.com>

QEMU dmg support includes zlib and bzip2, but it does not contains lzfse
support. This commit adds the source file to extend compression support
for new DMGs.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg-lzfse.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 block/dmg-lzfse.c

diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
new file mode 100644
index 0000000000..19d25bc646
--- /dev/null
+++ b/block/dmg-lzfse.c
@@ -0,0 +1,49 @@
+/*
+ * DMG lzfse uncompression
+ *
+ * Copyright (c) 2018 Julio Cesar Faracco
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "dmg.h"
+#include <lzfse.h>
+
+static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
+                                   char *next_out, unsigned int avail_ou=
t)
+{
+    size_t out_size =3D lzfse_decode_buffer((uint8_t *) next_out, avail_=
out,
+                                          (uint8_t *) next_in, avail_in,
+                                          NULL);
+
+    /* We need to decode the single chunk only. */
+    /* So, out_size =3D=3D avail_out is not an error here. */
+    if (out_size > 0) {
+        return out_size;
+    }
+    return -1;
+}
+
+__attribute__((constructor))
+static void dmg_lzfse_init(void)
+{
+    assert(!dmg_uncompress_lzfse);
+    dmg_uncompress_lzfse =3D dmg_uncompress_lzfse_do;
+}
--=20
2.19.2
