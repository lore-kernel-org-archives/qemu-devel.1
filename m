Received: from eggs.gnu.org ([2001:4830:134:3::10]:50540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKJ4-0007uF-9J
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZKJ1-0000pM-MH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:36:54 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 10 Jan 2018 20:36:32 +0300
Message-Id: <20180110173635.28255-3-klim.kireev@virtuozzo.com>
In-Reply-To: <20180110173635.28255-1-klim.kireev@virtuozzo.com>
References: <20180110173635.28255-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/5] configure: add dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, qemu-block@nongnu.org

This dependency is required for adequate Parallels images support.
Typically the disk consists of several images which are glued by
XML disk descriptor. Also XML hides inside several important parameters
which are not available in the image header.

The patch also adds clause to checkpatch.pl to understand libxml2 types.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/Makefile.objs   |  2 ++
 configure             | 27 +++++++++++++++++++++++++++
 scripts/checkpatch.pl |  1 +
 3 files changed, 30 insertions(+)

diff --git a/block/Makefile.objs b/block/Makefile.objs
index 6eaf78a046..a73387f1bf 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -47,3 +47,5 @@ block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
 dmg-bz2.o-libs     := $(BZIP2_LIBS)
 qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
+parallels.o-cflags := $(LIBXML2_CFLAGS)
+parallels.o-libs   := $(LIBXML2_LIBS)
diff --git a/configure b/configure
index 6a040821c6..790fa635d1 100755
--- a/configure
+++ b/configure
@@ -435,6 +435,7 @@ tcmalloc="no"
 jemalloc="no"
 replication="yes"
 vxhs=""
+libxml2=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1298,6 +1299,10 @@ for opt do
   ;;
   --enable-numa) numa="yes"
   ;;
+  --disable-libxml2) libxml2="no"
+  ;;
+  --enable-libxml2) libxml2="yes"
+  ;;
   --disable-tcmalloc) tcmalloc="no"
   ;;
   --enable-tcmalloc) tcmalloc="yes"
@@ -1573,6 +1578,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tpm             TPM support
   libssh2         ssh block device support
   numa            libnuma support
+  libxml2         for Parallels image format
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
@@ -3747,6 +3753,20 @@ EOF
   fi
 fi
 
+##########################################
+# libxml2 probe
+if test "$libxml2" != "no" ; then
+    if $pkg_config --exists libxml-2.0; then
+        libxml2="yes"
+        libxml2_cflags=$($pkg_config --cflags libxml-2.0)
+        libxml2_libs=$($pkg_config --libs libxml-2.0)
+    else
+        if test "$libxml2" = "yes"; then
+            feature_not_found "libxml2" "Install libxml2 devel"
+        fi
+        libxml2="no"
+    fi
+fi
 
 ##########################################
 # glusterfs probe
@@ -5618,6 +5638,7 @@ echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
 echo "NUMA host support $numa"
+echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
@@ -6281,6 +6302,12 @@ if test "$have_rtnetlink" = "yes" ; then
   echo "CONFIG_RTNETLINK=y" >> $config_host_mak
 fi
 
+if test "$libxml2" = "yes" ; then
+  echo "CONFIG_LIBXML2=y" >> $config_host_mak
+  echo "LIBXML2_CFLAGS=$libxml2_cflags" >> $config_host_mak
+  echo "LIBXML2_LIBS=$libxml2_libs" >> $config_host_mak
+fi
+
 if test "$replication" = "yes" ; then
   echo "CONFIG_REPLICATION=y" >> $config_host_mak
 fi
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3dc27d9656..9bfe2b58e1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -265,6 +265,7 @@ our @typeList = (
 	qr{${Ident}_handler_fn},
 	qr{target_(?:u)?long},
 	qr{hwaddr},
+	qr{xml${Ident}},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
-- 
2.14.3
