Received: from eggs.gnu.org ([2001:4830:134:3::10]:41577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYf-0007Jp-L7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYc-0004hT-St
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYc-0004fO-NQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:34 -0500
Received: by mail-wm0-x241.google.com with SMTP id x4so1969194wmc.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:36 +0100
Message-Id: <1515756676-3860-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/52] build-sys: compile with -Og or -O1 when
 --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When --enable-debug is turned on, configure doesn't set -O level, and
uses default compiler -O0 level, which is slow.

Instead, use -Og if supported by the compiler (optimize debugging
experience), or -O1 (keeps code somewhat debuggable and works around
compiler bugs).

Unfortunately, gcc has many false-positive maybe-uninitialized
errors with Og and O1 (f27 gcc 7.2.1 20170915):

/home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c: In function ‘ipmi_kcs_ioport_read’:
/home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c:279:12: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     return ret;
            ^~~
cc1: all warnings being treated as errors
make: *** [/home/elmarco/src/qemu/rules.mak:66: hw/ipmi/isa_ipmi_kcs.o] Error 1
make: *** Waiting for unfinished jobs....
/home/elmarco/src/qemu/hw/ide/ahci.c: In function ‘ahci_populate_sglist’:
/home/elmarco/src/qemu/hw/ide/ahci.c:903:58: error: ‘tbl_entry_size’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
         if ((off_idx == -1) || (off_pos < 0) || (off_pos > tbl_entry_size)) {
                                                 ~~~~~~~~~^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/elmarco/src/qemu/rules.mak:66: hw/ide/ahci.o] Error 1
/home/elmarco/src/qemu/hw/display/qxl.c: In function ‘qxl_add_memslot’:
/home/elmarco/src/qemu/hw/display/qxl.c:1397:52: error: ‘pci_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     memslot.virt_end   = virt_start + (guest_end   - pci_start);
                                       ~~~~~~~~~~~~~^~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c:1389:9: error: ‘pci_region’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
         qxl_set_guest_bug(d, "%s: pci_region = %d", __func__, pci_region);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

There seems to be a long list of related bugs in upstream GCC, some of
them are being fixed very recently:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=24639

For now, let's workaround it by using Wno-maybe-uninitialized (gcc-only).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-5-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index ac392d2..6f1b7cd 100755
--- a/configure
+++ b/configure
@@ -5194,8 +5194,19 @@ if test "$gcov" = "yes" ; then
   LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
   CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
-elif test "$debug" = "no"; then
-  CFLAGS="-O2 $CFLAGS"
+elif test "$debug" = "yes"; then
+  if compile_prog "-Og" ""; then
+      CFLAGS="-Og $CFLAGS"
+  elif compile_prog "-O1" ""; then
+      CFLAGS="-O1 $CFLAGS"
+  fi
+  # Workaround GCC false-positive Wuninitialized bugs with Og or O1:
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=24639
+  if cc_has_warning_flag "-Wno-maybe-uninitialized"; then
+      CFLAGS="-Wno-maybe-uninitialized $CFLAGS"
+  fi
+else
+    CFLAGS="-O2 $CFLAGS"
 fi
 
 ##########################################
-- 
1.8.3.1
