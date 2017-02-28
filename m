Received: from eggs.gnu.org ([2001:4830:134:3::10]:43293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNy-0001hP-D4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNx-00034y-FP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilNx-00033w-8y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:25 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNw-0003TX-9p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:24 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:16:07 +0000
Message-Id: <1488302176-19463-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/21] update-linux-headers: update for 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The linux-headers/asm-arm/unistd.h file has been split in three
sub-files, copy them along.  However, building them requires
setting ARCH rather than SRCARCH.

SRCARCH defaults to $(ARCH) anyway; to avoid future occurrence of
the same problem use ARCH for all architectures where SRCARCH=ARCH.
Currently these are all except x86, sparc, sh and tile.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170221122920.16245-2-pbonzini@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/update-linux-headers.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 72cf1fb..6a370a8 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -75,7 +75,13 @@ for arch in $ARCHLIST; do
         continue
     fi
 
-    make -C "$linux" INSTALL_HDR_PATH="$tmpdir" SRCARCH=$arch headers_install
+    if [ "$arch" = x86 ]; then
+        arch_var=SRCARCH
+    else
+        arch_var=ARCH
+    fi
+
+    make -C "$linux" INSTALL_HDR_PATH="$tmpdir" $arch_var=$arch headers_install
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
@@ -92,6 +98,11 @@ for arch in $ARCHLIST; do
         cp_portable "$tmpdir/include/asm/kvm_virtio.h" "$output/include/standard-headers/asm-s390/"
         cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
     fi
+    if [ $arch = arm ]; then
+        cp "$tmpdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
+        cp "$tmpdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
+        cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
+    fi
     if [ $arch = x86 ]; then
         cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/standard-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
-- 
2.7.4
