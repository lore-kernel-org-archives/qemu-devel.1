Received: from eggs.gnu.org ([2001:4830:134:3::10]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyr-0001la-8X
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyo-0000n3-45
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyn-0000mx-Va
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:06 -0400
Date: Wed, 23 May 2018 17:43:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-10-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/28] update-linux-headers.sh: unistd.h,
 kvm consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Brijesh Singh <brijesh.singh@amd.com>, Gerd Hoffmann <kraxel@redhat.com>

Rework the update script slightly, add the unistd.h header and its
dependencies on all architectures.

This also removes the IA64 and MIPS from a KVM blacklist:
Linux dropped IA64, and there was never a reason to
exclude MIPS from kvm specifically - it was
excluded due to dependency of its unistd.h on sgidefs.h,
which we also import.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 scripts/update-linux-headers.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
index 4fa08d3..947dec2 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -84,11 +84,6 @@ for arch in $ARCHLIST; do
         continue
     fi
=20
-    # Blacklist architectures which have KVM headers but are actually de=
ad
-    if [ "$arch" =3D "ia64" -o "$arch" =3D "mips" ]; then
-        continue
-    fi
-
     if [ "$arch" =3D x86 ]; then
         arch_var=3DSRCARCH
     else
@@ -99,9 +94,14 @@ for arch in $ARCHLIST; do
=20
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h unistd.h; do
+    for header in kvm.h unistd.h bitsperlong.h; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arc=
h"
     done
+
+    if [ $arch =3D mips ]; then
+        cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mi=
ps/"
+    fi
+
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
     if [ $arch =3D s390 ]; then
@@ -129,6 +129,12 @@ for header in kvm.h vfio.h vfio_ccw.h vhost.h \
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
=20
+rm -rf "$output/linux-headers/asm-generic"
+mkdir -p "$output/linux-headers/asm-generic"
+for header in unistd.h bitsperlong.h; do
+    cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-=
generic"
+done
+
 if [ -L "$linux/source" ]; then
     cp "$linux/source/COPYING" "$output/linux-headers"
 else
--=20
MST
