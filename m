Received: from eggs.gnu.org ([2001:4830:134:3::10]:58257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiP-0007E5-Q7
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiO-00037G-Rn
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:45 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:40807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiO-00036Z-NZ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:44 -0400
Received: by mail-qk0-x241.google.com with SMTP id o64so14721007qkl.7
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 16:05:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:05:20 -0300
Message-Id: <20180415230522.24404-3-f4bug@amsat.org>
In-Reply-To: <20180415230522.24404-1-f4bug@amsat.org>
References: <20180415230522.24404-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] configure: Display if libfdt is from
 system or git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, YunQiang Su <syq@debian.org>

The configure script outputs "yes" regardless which libfdt is used:

  ./configure
  [...]
  fdt support       yes

Sometimes you can have both system and local git version available,
change the configure script to display which library got selected:

  debian8$ dpkg-query --showformat='${Version}\n' --show libfdt-dev
  1.4.0+dfsg-1

  debian8$ ./configure
  [...]
  fdt support       git

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 162e804b49..056b391f22 100755
--- a/configure
+++ b/configure
@@ -3758,15 +3758,14 @@ int main(void) { fdt_first_subnode(0, 0); return 0; }
 EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
-    fdt=yes
+    fdt=system
   else
       # have GIT checkout, so activate dtc submodule
       if test -e "${source_path}/.git" ; then
           git_submodules="${git_submodules} dtc"
       fi
       if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
-          fdt=yes
-          dtc_internal="yes"
+          fdt=git
           mkdir -p dtc
           if [ "$pwd_is_source_path" != "y" ] ; then
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
@@ -6307,7 +6306,7 @@ fi
 if test "$preadv" = "yes" ; then
   echo "CONFIG_PREADV=y" >> $config_host_mak
 fi
-if test "$fdt" = "yes" ; then
+if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
@@ -7109,7 +7108,7 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
 
-if [ "$dtc_internal" = "yes" ]; then
+if [ "$fdt" = "git" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
-- 
2.17.0
