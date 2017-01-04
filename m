Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nathan@nathanrossi.com>) id 1cOn0B-0000Uk-97
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nathan@nathanrossi.com>) id 1cOn08-00064v-4L
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:57:19 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nathan@nathanrossi.com>)
	id 1cOn07-00064E-Up
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:57:16 -0500
Received: by mail-pg0-x241.google.com with SMTP id n5so37423302pgh.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 06:57:14 -0800 (PST)
From: Nathan Rossi <nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Jan 2017 00:56:52 +1000
Message-Id: <20170104145652.30442-1-nathan@nathanrossi.com>
Subject: [Qemu-devel] [PATCH] configure: For libgcrypt if pkg-config is
 available use it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nathan Rossi <nathan@nathanrossi.com>, Alistair Francis <alistair.francis@xilinx.com>

If libgcrypt info is available with pkg-config use it over using the
libgcrypt-config. pkg-config is preferred due to is compatibility with
cross-compilation (where you cannot execute the targets version of
libgcrypt-config).

This change makes configure check for libgcrypt in pkg-config first,
then falling back to use libgcrypt-config if available. This follows a
similar process to how libsdl is handled.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 configure | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 218df87d21..6558121de8 100755
--- a/configure
+++ b/configure
@@ -2386,9 +2386,17 @@ has_libgcrypt_config() {
 }
 
 if test "$gcrypt" != "no"; then
-    if has_libgcrypt_config; then
-        gcrypt_cflags=$(libgcrypt-config --cflags)
-        gcrypt_libs=$(libgcrypt-config --libs)
+    gcrypt_config=""
+    # If libgcrypt in pkg-config use it over using libgcrypt-config
+    if $pkg_config --exists "libgcrypt"; then
+      gcrypt_config="$pkg_config libgcrypt"
+    elif has_libgcrypt_config; then
+      gcrypt_config="libgcrypt-config"
+    fi
+
+    if test -n "$gcrypt_config"; then
+        gcrypt_cflags=$($gcrypt_config --cflags)
+        gcrypt_libs=$($gcrypt_config --libs)
         # Debian has remove -lgpg-error from libgcrypt-config
         # as it "spreads unnecessary dependencies" which in
         # turn breaks static builds...
-- 
2.11.0
