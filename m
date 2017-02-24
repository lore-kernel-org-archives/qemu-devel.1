Received: from eggs.gnu.org ([2001:4830:134:3::10]:36246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrE-0007rG-9i
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrD-0002FP-F4
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:40 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrD-0002FH-8T
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:39 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so4056920wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:39 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	s26sm8814533wra.66.2017.02.24.09.40.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 09:40:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:17 +0100
Message-Id: <1487958030-51417-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] update-linux-headers: update for 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
1.8.3.1
