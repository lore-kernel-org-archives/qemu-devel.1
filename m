Received: from eggs.gnu.org ([2001:4830:134:3::10]:38007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqInl-0006Bs-Ay
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqInj-0000GO-NS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:00 -0400
From: Julio Faracco <jcfaracco@gmail.com>
Date: Thu, 16 Aug 2018 10:58:35 -0300
Message-Id: <20180816135837.13149-3-jcfaracco@gmail.com>
In-Reply-To: <20180816135837.13149-1-jcfaracco@gmail.com>
References: <20180816135837.13149-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/4] configure: adding support to lzfse
 library.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

This commit includes the support to lzfse opensource library. With this
library dmg block driver can decompress images with this type of
compression inside.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/Makefile.objs |  2 ++
 configure           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/block/Makefile.objs b/block/Makefile.objs
index c8337bf186..f4ddbb9c7b 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -47,6 +47,8 @@ ssh.o-cflags       := $(LIBSSH2_CFLAGS)
 ssh.o-libs         := $(LIBSSH2_LIBS)
 block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
 dmg-bz2.o-libs     := $(BZIP2_LIBS)
+block-obj-$(if $(CONFIG_LZFSE),m,n) += dmg-lzfse.o
+dmg-lzfse.o-libs   := $(LZFSE_LIBS)
 qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
 parallels.o-cflags := $(LIBXML2_CFLAGS)
diff --git a/configure b/configure
index 2a7796ea80..c5a4628f98 100755
--- a/configure
+++ b/configure
@@ -432,6 +432,7 @@ capstone=""
 lzo=""
 snappy=""
 bzip2=""
+lzfse=""
 guest_agent=""
 guest_agent_with_vss="no"
 guest_agent_ntddscsi="no"
@@ -1300,6 +1301,10 @@ for opt do
   ;;
   --enable-bzip2) bzip2="yes"
   ;;
+  --enable-lzfse) lzfse="yes"
+  ;;
+  --disable-lzfse) lzfse="no"
+  ;;
   --enable-guest-agent) guest_agent="yes"
   ;;
   --disable-guest-agent) guest_agent="no"
@@ -1689,6 +1694,8 @@ disabled with --disable-FEATURE, default is enabled if available:
   snappy          support of snappy compression library
   bzip2           support of bzip2 compression library
                   (for reading bzip2-compressed dmg images)
+  lzfse           support of lzfse compression library
+                  (for reading lzfse-compressed dmg images)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2213,6 +2220,24 @@ EOF
     fi
 fi
 
+##########################################
+# lzfse check
+
+if test "$lzfse" != "no" ; then
+    cat > $TMPC << EOF
+#include <lzfse.h>
+int main(void) { lzfse_decode_scratch_size(); return 0; }
+EOF
+    if compile_prog "" "-llzfse" ; then
+        lzfse="yes"
+    else
+        if test "$lzfse" = "yes"; then
+            feature_not_found "lzfse" "Install lzfse devel"
+        fi
+        lzfse="no"
+    fi
+fi
+
 ##########################################
 # libseccomp check
 
@@ -6001,6 +6026,7 @@ echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
+echo "lzfse support     $lzfse"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -6525,6 +6551,11 @@ if test "$bzip2" = "yes" ; then
   echo "BZIP2_LIBS=-lbz2" >> $config_host_mak
 fi
 
+if test "$lzfse" = "yes" ; then
+  echo "CONFIG_LZFSE=y" >> $config_host_mak
+  echo "LZFSE_LIBS=-llzfse" >> $config_host_mak
+fi
+
 if test "$libiscsi" = "yes" ; then
   echo "CONFIG_LIBISCSI=m" >> $config_host_mak
   echo "LIBISCSI_CFLAGS=$libiscsi_cflags" >> $config_host_mak
-- 
2.17.1
