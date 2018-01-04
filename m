Received: from eggs.gnu.org ([2001:4830:134:3::10]:37333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX82z-0007KL-Un
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX82w-0003Qp-43
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX82v-0003PA-SE
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F72A5FD76
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:07:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:09 +0100
Message-Id: <20180104160523.22995-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/18] build-sys: compile with -Og or -O1
 when --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When --enable-debug is turned on, configure doesn't set -O level, and
uses default compiler -O0 level, which is slow.

Instead, use -Og if supported by the compiler (optimize debugging
experience), or -O1 (keeps code somewhat debuggable and works around
compiler bugs).

Unfortunately, gcc has many false-positive maybe-uninitialized
errors with Og and O1 (f27 gcc 7.2.1 20170915):

/home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c: In function =E2=80=98ipmi_=
kcs_ioport_read=E2=80=99:
/home/elmarco/src/qemu/hw/ipmi/isa_ipmi_kcs.c:279:12: error: =E2=80=98ret=
=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-uni=
nitialized]
     return ret;
            ^~~
cc1: all warnings being treated as errors
make: *** [/home/elmarco/src/qemu/rules.mak:66: hw/ipmi/isa_ipmi_kcs.o] E=
rror 1
make: *** Waiting for unfinished jobs....
/home/elmarco/src/qemu/hw/ide/ahci.c: In function =E2=80=98ahci_populate_=
sglist=E2=80=99:
/home/elmarco/src/qemu/hw/ide/ahci.c:903:58: error: =E2=80=98tbl_entry_si=
ze=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-u=
ninitialized]
         if ((off_idx =3D=3D -1) || (off_pos < 0) || (off_pos > tbl_entry=
_size)) {
                                                 ~~~~~~~~~^~~~~~~~~~~~~~~=
~~
cc1: all warnings being treated as errors
make: *** [/home/elmarco/src/qemu/rules.mak:66: hw/ide/ahci.o] Error 1
/home/elmarco/src/qemu/hw/display/qxl.c: In function =E2=80=98qxl_add_mem=
slot=E2=80=99:
/home/elmarco/src/qemu/hw/display/qxl.c:1397:52: error: =E2=80=98pci_star=
t=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-un=
initialized]
     memslot.virt_end   =3D virt_start + (guest_end   - pci_start);
                                       ~~~~~~~~~~~~~^~~~~~~~~~~~
/home/elmarco/src/qemu/hw/display/qxl.c:1389:9: error: =E2=80=98pci_regio=
n=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-un=
initialized]
         qxl_set_guest_bug(d, "%s: pci_region =3D %d", __func__, pci_regi=
on);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
cc1: all warnings being treated as errors

There seems to be a long list of related bugs in upstream GCC, some of
them are being fixed very recently:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D24639

For now, let's workaround it by using Wno-maybe-uninitialized (gcc-only).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index de1f939a28..3953859314 100755
--- a/configure
+++ b/configure
@@ -5160,8 +5160,19 @@ if test "$gcov" =3D "yes" ; then
   LDFLAGS=3D"-fprofile-arcs -ftest-coverage $LDFLAGS"
 elif test "$fortify_source" =3D "yes" ; then
   CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
-elif test "$debug" =3D "no"; then
-  CFLAGS=3D"-O2 $CFLAGS"
+elif test "$debug" =3D "yes"; then
+  if compile_prog "-Og" ""; then
+      CFLAGS=3D"-Og $CFLAGS"
+  elif compile_prog "-O1" ""; then
+      CFLAGS=3D"-O1 $CFLAGS"
+  fi
+  # Workaround GCC false-positive Wuninitialized bugs with Og or O1:
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D24639
+  if cc_has_warning_flag "-Wno-maybe-uninitialized"; then
+      CFLAGS=3D"-Wno-maybe-uninitialized $CFLAGS"
+  fi
+else
+    CFLAGS=3D"-O2 $CFLAGS"
 fi
=20
 ##########################################
--=20
2.15.1.355.g36791d7216
