Received: from eggs.gnu.org ([2001:4830:134:3::10]:41612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtG-0003Hi-LJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtF-0001c2-K6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:22 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:55004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtF-0001bV-DH
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:21 -0400
Received: by mail-wm0-x236.google.com with SMTP id f6so21244003wmc.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:43 +0200
Message-Id: <1525817687-34620-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/30] configure: Display if libfdt is from
 system or git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-Id: <20180415230522.24404-3-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 43756dc..407bf84 100755
--- a/configure
+++ b/configure
@@ -3785,15 +3785,14 @@ int main(void) { fdt_first_subnode(0, 0); return 0; }
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
@@ -6334,7 +6333,7 @@ fi
 if test "$preadv" = "yes" ; then
   echo "CONFIG_PREADV=y" >> $config_host_mak
 fi
-if test "$fdt" = "yes" ; then
+if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
@@ -7136,7 +7135,7 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
 
-if [ "$dtc_internal" = "yes" ]; then
+if [ "$fdt" = "git" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
-- 
1.8.3.1
