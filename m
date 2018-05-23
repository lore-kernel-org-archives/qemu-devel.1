Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyi-0001e4-Me
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyf-0000lE-H4
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyf-0000lA-Ac
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:57 -0400
Date: Wed, 23 May 2018 17:42:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-6-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/28] update-linux-headers.sh: drop kvm_para.h
 hacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Brijesh Singh <brijesh.singh@amd.com>

It turns out (as will be clear from follow-up patches)
we do not really need any kvm para macros host side
for now, except on x86, and there we need it
unconditionally whether we run on kvm or we don't.

Import the x86 asm/kvm_para.h into standard-headers,
follow-up patches remove a bunch of code using this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index b65c03f..4fa08d3 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -43,6 +43,7 @@ cp_portable() {
                                      -e 'limits' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
+                                     -e 'asm-generic/kvm_para' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -98,13 +99,9 @@ for arch in $ARCHLIST; do
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h kvm_para.h unistd.h; do
+    for header in kvm.h unistd.h; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
-    if [ $arch = powerpc ]; then
-        cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
-    fi
-
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
     if [ $arch = s390 ]; then
@@ -121,20 +118,17 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
+        cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
     fi
 done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
+for header in kvm.h vfio.h vfio_ccw.h vhost.h \
               psci.h psp-sev.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-rm -rf "$output/linux-headers/asm-generic"
-mkdir -p "$output/linux-headers/asm-generic"
-for header in kvm_para.h; do
-    cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
-done
+
 if [ -L "$linux/source" ]; then
     cp "$linux/source/COPYING" "$output/linux-headers"
 else
-- 
MST
