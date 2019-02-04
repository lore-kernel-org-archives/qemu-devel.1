Received: from eggs.gnu.org ([209.51.188.92]:45802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfag-00066J-Bu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfT7-0005EE-77
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfT5-0005B6-7s
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so94803qtb.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:27 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-4-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/25] scripts/update-linux-headers.sh: adjust
 for Linux 4.21-rc1 (or 5.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, =?utf-8?B?TWFyYy1BbmRyw4PCqQ==?= Lureau <marcandre.lureau@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

There are three new indirect inclusions: vhost_types.h, which we'll
shortly put to use as a portable header and thus is copied to
standard-headers; and new per-subtarget versions of MIPS unistd.h
and PowerPC unistd.h.

Because vhost.h includes vhost_types.h, we also need a proxy include
from linux/vhost.h to standard-headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe240..c933489cbc 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -101,6 +101,13 @@ for arch in $ARCHLIST; do
 
     if [ $arch = mips ]; then
         cp "$tmpdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
+        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
+        cp "$tmpdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
+        cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
+    fi
+    if [ $arch = powerpc ]; then
+        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
+        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
     fi
 
     rm -rf "$output/include/standard-headers/asm-$arch"
@@ -162,6 +169,9 @@ EOF
 cat <<EOF >$output/linux-headers/linux/virtio_ring.h
 #include "standard-headers/linux/virtio_ring.h"
 EOF
+cat <<EOF >$output/linux-headers/linux/vhost_types.h
+#include "standard-headers/linux/vhost_types.h"
+EOF
 
 rm -rf "$output/include/standard-headers/linux"
 mkdir -p "$output/include/standard-headers/linux"
@@ -171,6 +181,7 @@ for i in "$tmpdir"/include/linux/*virtio*.h \
          "$tmpdir/include/linux/input-event-codes.h" \
          "$tmpdir/include/linux/pci_regs.h" \
          "$tmpdir/include/linux/ethtool.h" "$tmpdir/include/linux/kernel.h" \
+         "$tmpdir/include/linux/vhost_types.h" \
          "$tmpdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
-- 
MST
