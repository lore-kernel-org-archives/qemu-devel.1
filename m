Received: from eggs.gnu.org ([2001:4830:134:3::10]:59767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnhJ-000566-Vt
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnhE-0001II-3a
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwnhD-0001I5-Qz
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6CFF7E43A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:06:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 13:06:28 +0200
Message-Id: <20170926110628.2705-3-kraxel@redhat.com>
In-Reply-To: <20170926110628.2705-1-kraxel@redhat.com>
References: <20170926110628.2705-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] Add --firmwarepath to configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a firmware path config option to configure.  Multiple directories
are accepted, with the usual colon as separator.  Default value is
${prefix}/share/qemu-firmware.  The path is searched in addition to the
current search path (typically ${prefix}/share/qemu).

This prepares qemu for the planned split of the prebuilt firmware blobs
into a separate project.

Distributions can also use this to get rid of the firmware symlink farm
and add -- for example -- /usr/share/seabios to the firmware path
instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170914114236.25343-3-kraxel@redhat.com
---
 configure             |  6 ++++++
 vl.c                  | 12 +++++++++---
 scripts/create_config |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 133a5757ef..28312ca0f0 100755
--- a/configure
+++ b/configure
@@ -332,6 +332,7 @@ modules="no"
 prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
+firmwarepath="\${prefix}/share/qemu-firmware"
 qemu_docdir="\${prefix}/share/doc/qemu"
 bindir="\${prefix}/bin"
 libdir="\${prefix}/lib"
@@ -915,6 +916,8 @@ for opt do
   ;;
   --localstatedir=*) local_statedir="$optarg"
   ;;
+  --firmwarepath=*) firmwarepath="$optarg"
+  ;;
   --sbindir=*|--sharedstatedir=*|\
   --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
   --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
@@ -1416,6 +1419,7 @@ Advanced options (experts only):
   --libdir=PATH            install libraries in PATH
   --sysconfdir=PATH        install config in PATH$confsuffix
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
+  --firmwarepath=PATH      search PATH for firmware files
   --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
   --enable-debug           enable common debug build options
   --disable-strip          disable stripping binaries
@@ -5265,6 +5269,7 @@ libs_softmmu="$pixman_libs $libs_softmmu"
 
 echo "Install prefix    $prefix"
 echo "BIOS directory    $(eval echo $qemu_datadir)"
+echo "firmware path     $(eval echo $firmwarepath)"
 echo "binary directory  $(eval echo $bindir)"
 echo "library directory $(eval echo $libdir)"
 echo "module directory  $(eval echo $qemu_moddir)"
@@ -5456,6 +5461,7 @@ echo "mandir=$mandir" >> $config_host_mak
 echo "sysconfdir=$sysconfdir" >> $config_host_mak
 echo "qemu_confdir=$qemu_confdir" >> $config_host_mak
 echo "qemu_datadir=$qemu_datadir" >> $config_host_mak
+echo "qemu_firmwarepath=$firmwarepath" >> $config_host_mak
 echo "qemu_docdir=$qemu_docdir" >> $config_host_mak
 echo "qemu_moddir=$qemu_moddir" >> $config_host_mak
 if test "$mingw32" = "no" ; then
diff --git a/vl.c b/vl.c
index 19633423aa..3fed457921 100644
--- a/vl.c
+++ b/vl.c
@@ -3125,6 +3125,7 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
+    char **dirs;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -4309,11 +4310,16 @@ int main(int argc, char **argv, char **envp)
         qemu_set_log(0);
     }
 
-    /* If no data_dir is specified then try to find it relative to the
-       executable path.  */
+    /* add configured firmware directories */
+    dirs = g_strsplit(CONFIG_QEMU_FIRMWAREPATH, G_SEARCHPATH_SEPARATOR_S, 0);
+    for (i = 0; dirs[i] != NULL; i++) {
+        qemu_add_data_dir(dirs[i]);
+    }
+
+    /* try to find datadir relative to the executable path */
     qemu_add_data_dir(os_find_datadir());
 
-    /* If all else fails use the install path specified when building. */
+    /* add the datadir specified when building */
     qemu_add_data_dir(CONFIG_QEMU_DATADIR);
 
     /* -L help lists the data directories and exits. */
diff --git a/scripts/create_config b/scripts/create_config
index e6929dd61e..603b826886 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -15,7 +15,7 @@ case $line in
     echo "#define QEMU_VERSION_MINOR $minor"
     echo "#define QEMU_VERSION_MICRO $micro"
     ;;
- qemu_*dir=*) # qemu-specific directory configuration
+ qemu_*dir=* | qemu_*path=*) # qemu-specific directory configuration
     name=${line%=*}
     value=${line#*=}
     define_name=$(echo $name | LC_ALL=C tr '[a-z]' '[A-Z]')
-- 
2.9.3
