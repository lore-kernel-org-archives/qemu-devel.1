Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZP-0002uN-23
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZM-0006Oj-I4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9ZM-0006Od-Bb
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:24 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:29:19 +0100
Message-Id: <20170221122920.16245-2-pbonzini@redhat.com>
In-Reply-To: <20170221122920.16245-1-pbonzini@redhat.com>
References: <20170221122920.16245-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] update-linux-headers: update for 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, mst@redhat.com

The linux-headers/asm-arm/unistd.h file has been split in three
sub-files, copy them along.  However, building them requires
setting ARCH rather than SRCARCH.

SRCARCH defaults to $(ARCH) anyway; to avoid future occurrence of
the same problem use ARCH for all architectures where SRCARCH=ARCH.
Currently these are all except x86, sparc, sh and tile.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.9.3
