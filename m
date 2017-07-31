Received: from eggs.gnu.org ([2001:4830:134:3::10]:53107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7ur-0007q9-3H
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7uo-0001zC-AR
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:27:13 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:27 +0300
Message-Id: <2a4e2e4919d1fcb915f1b33f9396aad5dc4616f5.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/25] loader: check get_image_size() return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

since a negative value means it errored.

hw/core/loader.c:149:9: warning: Loss of sign in implicit conversion
    if (size > max_sz) {
        ^~~~
hw/core/loader.c:171:9: warning: Loss of sign in implicit conversion
    if (size > memory_region_size(mr)) {
        ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index e5e8cbb638..ebe574c7ea 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -146,7 +146,7 @@ int load_image_targphys_as(const char *filename,
     int size;
=20
     size =3D get_image_size(filename);
-    if (size > max_sz) {
+    if (size < 0 || size > max_sz) {
         return -1;
     }
     if (size > 0) {
@@ -168,7 +168,7 @@ int load_image_mr(const char *filename, MemoryRegion =
*mr)
=20
     size =3D get_image_size(filename);
=20
-    if (size > memory_region_size(mr)) {
+    if (size < 0 || size > memory_region_size(mr)) {
         return -1;
     }
     if (size > 0) {
--=20
2.11.0
