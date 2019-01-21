Received: from eggs.gnu.org ([209.51.188.92]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-0004GS-Ka
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxz-00040l-Dk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxw-0003t0-Qk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:33 -0500
Received: by mail-wr1-x430.google.com with SMTP id t27so24474408wra.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:32 +0100
Message-Id: <1548093980-43088-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/49] scripts/update-linux-headers.sh: adjust
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

There are three new indirect inclusions: vhost_types.h, which we'll
shortly put to use as a portable header and thus is copied to
standard-headers; and new per-subtarget versions of MIPS unistd.h
and PowerPC unistd.h.

Because vhost.h includes vhost_types.h, we also need a proxy include
from linux/vhost.h to standard-headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190104082731.24967-2-pbonzini@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe..c933489 100755
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
1.8.3.1
