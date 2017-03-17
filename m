Received: from eggs.gnu.org ([2001:4830:134:3::10]:35761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotsv-0001CL-93
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotsq-0001Rt-Br
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cotsq-0001Ro-5B
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:33:40 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 16:33:37 +0100
Message-Id: <20170317153337.19532-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9] configure: remove Cygwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org

The Cygwin target is really compiling for native Win32 with -mno-cygwin.
Except, GCC 4.7.0 has finally removed the long deprecated -mno-cygwin
option, and that happened about five years ago.

Let it rest in peace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/mmap.c | 5 -----
 configure       | 8 +-------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index ee59073..1ad018a 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -199,12 +199,7 @@ static int mmap_frag(abi_ulong real_start,
     return 0;
 }
 
-#if defined(__CYGWIN__)
-/* Cygwin doesn't have a whole lot of address space.  */
-static abi_ulong mmap_next_start = 0x18000000;
-#else
 static abi_ulong mmap_next_start = 0x40000000;
-#endif
 
 unsigned long last_brk;
 
diff --git a/configure b/configure
index 0b74d18..963d171 100755
--- a/configure
+++ b/configure
@@ -553,12 +553,6 @@ fi
 HOST_VARIANT_DIR=""
 
 case $targetos in
-CYGWIN*)
-  mingw32="yes"
-  QEMU_CFLAGS="-mno-cygwin $QEMU_CFLAGS"
-  audio_possible_drivers="sdl"
-  audio_drv_list=""
-;;
 MINGW32*)
   mingw32="yes"
   hax="yes"
@@ -5234,7 +5228,7 @@ if test "$cap_ng" = "yes" ; then
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
-    def=CONFIG_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
+    def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     echo "$def=y" >> $config_host_mak
 done
 if test "$audio_pt_int" = "yes" ; then
-- 
2.9.3
