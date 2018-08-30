Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvOAP-0004cp-EB
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvNum-0003ap-Vv
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:21 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fvNum-0003Z1-Mf
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:16 -0400
Received: by mail-wm0-x241.google.com with SMTP id c14-v6so2210868wmb.4
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 07:27:16 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Aug 2018 17:27:03 +0300
Message-Id: <20180830142708.14311-2-sameeh@daynix.com>
In-Reply-To: <20180830142708.14311-1-sameeh@daynix.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

This commit adds the bpf header provided by Linux to Qemu.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 MAINTAINERS                     |  5 +++++
 configure                       | 44 +++++++++++++++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh |  8 ++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb5f38f9f..bf2619239c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2126,6 +2126,11 @@ F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
 
+BPF
+M: Sameeh Jubran <sameeh@daynix.com>
+S: Maintained
+F: linux-headers/linux/bpf.h
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/configure b/configure
index a8c4094c87..21edaf59aa 100755
--- a/configure
+++ b/configure
@@ -348,6 +348,7 @@ libattr=""
 xfs=""
 tcg="yes"
 membarrier=""
+bpf="no"
 vhost_net="no"
 vhost_crypto="no"
 vhost_scsi="no"
@@ -1173,6 +1174,10 @@ for opt do
   ;;
   --enable-membarrier) membarrier="yes"
   ;;
+  --disable-bpf) bpf="no"
+  ;;
+  --enable-bpf) bpf="yes"
+  ;;
   --disable-blobs) blobs="no"
   ;;
   --with-pkgversion=*) pkgversion="$optarg"
@@ -1593,6 +1598,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   brlapi          BrlAPI (Braile)
   curl            curl connectivity
   membarrier      membarrier system call (for Linux 4.14+ or Windows)
+  bpf             bpf system calls (for Linux 3.18+)
   fdt             fdt device tree
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
@@ -5232,6 +5238,38 @@ else
 fi
 
 ##########################################
+# check for usable bpf system call
+if test "$bpf" = "yes"; then
+    have_bpf=no
+    if test "$linux" = "yes" ; then
+        cat > $TMPC << EOF
+    #include <sys/syscall.h>
+    #include "linux/bpf.h"
+    #include <unistd.h>
+    #include <stdlib.h>
+    #include <string.h>
+    int main(void) {
+        union bpf_attr * attr = NULL;
+        syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
+        exit(0);
+    }
+EOF
+        bpf_include="-Iinclude/standard-headers/linux"
+        bpf_cflags=""
+        bpf_libs=""
+        if compile_prog "$bpf_include" "$bpf_libs" ; then
+            have_bpf=yes
+        fi
+    fi
+    if test "$have_bpf" = "no"; then
+      feature_not_found "bpf" "libelf libs are not available or else \
+the bpf system call is not available"
+    fi
+else
+    bpf=no
+fi
+
+##########################################
 # check if rtnetlink.h exists and is useful
 have_rtnetlink=no
 cat > $TMPC << EOF
@@ -5871,6 +5909,7 @@ echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
 echo "fdt support       $fdt"
 echo "membarrier        $membarrier"
+echo "bpf               $bpf"
 echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
 echo "madvise           $madvise"
@@ -6365,6 +6404,11 @@ fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
 fi
+if test "$bpf" = "yes" ; then
+  echo "CONFIG_BPF=y" >> $config_host_mak
+  echo "LIBS_BPF=$bpf_libs" >> $config_host_mak
+  echo "CFLAGS_BPF=$bpf_cflags" >> $config_host_mak
+fi
 if test "$signalfd" = "yes" ; then
   echo "CONFIG_SIGNALFD=y" >> $config_host_mak
 fi
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index feb75390aa..57df8228af 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -35,6 +35,8 @@ cp_portable() {
         grep '#include' "$f" | grep -v -e 'linux/virtio' \
                                      -e 'linux/types' \
                                      -e 'stdint' \
+                                     -e 'stdio' \
+                                     -e 'stdbool' \
                                      -e 'linux/if_ether' \
                                      -e 'input-event-codes' \
                                      -e 'sys/' \
@@ -44,6 +46,7 @@ cp_portable() {
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
                                      -e 'asm-generic/kvm_para' \
+                                     -e 'linux/bpf' \
                                      > /dev/null
     then
         echo "Unexpected #include in input file $f".
@@ -58,7 +61,7 @@ cp_portable() {
         -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
-        -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
+        -e 's/<linux\/\([^>]*(?!bpf)\)>/"standard-headers\/linux\/\1"/' \
         -e 's/__bitwise//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
@@ -126,7 +129,8 @@ done
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in kvm.h vfio.h vfio_ccw.h vhost.h \
-              psci.h psp-sev.h userfaultfd.h; do
+              psci.h psp-sev.h userfaultfd.h  \
+              bpf.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
2.13.6
