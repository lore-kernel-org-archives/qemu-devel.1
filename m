Received: from eggs.gnu.org ([2001:4830:134:3::10]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSo-0008GH-GC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSl-0001eC-LB
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmSl-0001d0-CG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:11 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5resZ020415
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sp4hr3v1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:06 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 16:59:55 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <89c541d2bd6259c237900c3918ca0a3cfccccb90.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 02/12] scripts/update-linux-headers.sh:
 refactor extra files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

Refactor the architecture specific code to make it easier
to add new special case files.

There should be no change in functionality.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

I've factored the script to make it easier to add new files.

 scripts/update-linux-headers.sh | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index ef11a8ab42..c75c30da1b 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -76,28 +76,25 @@ for arch in $ARCHLIST; do
     fi
 
     make -C "$linux" INSTALL_HDR_PATH="$tmpdir" ARCH=$arch headers_install
+    ARCH_EXTRA=
+    ARCH_STD_EXTRA=
+    case "$arch" in
+        powerpc) ARCH_EXTRA=epapr_hcalls.h ;;
+        s390) ARCH_STD_EXTRA="kvm_virtio.h virtio-ccw.h" ;;
+        x86) ARCH_EXTRA="unistd_32.h unistd_x32.h unistd_64.h" ARCH_STD_EXTRA="hyperv.h" ;;
+    esac
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h kvm_para.h unistd.h; do
+    for header in kvm.h kvm_para.h unistd.h $ARCH_EXTRA; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
-    if [ $arch = powerpc ]; then
-        cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
-    fi
 
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
-    if [ $arch = s390 ]; then
-        cp_portable "$tmpdir/include/asm/kvm_virtio.h" "$output/include/standard-headers/asm-s390/"
-        cp_portable "$tmpdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
-    fi
-    if [ $arch = x86 ]; then
-        cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/standard-headers/asm-x86/"
-        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
-        cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
-        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
-    fi
+    for header in $ARCH_STD_EXTRA; do
+        cp_portable "$tmpdir/include/asm/$header" "$output/include/standard-headers/asm-$arch/"
+    done
 done
 
 rm -rf "$output/linux-headers/linux"
-- 
2.11.0
