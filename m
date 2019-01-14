Received: from eggs.gnu.org ([209.51.188.92]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3Yr-00062S-PX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3Yq-0007Gt-Rf
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:49:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 15:49:48 +0100
Message-Id: <1547477388-22494-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, berrange@redhat.com
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
"inline" prototype definitions which GCC refuses to compile in its
gnu99 mode:

In file included from block/iscsi.c:52:0:
/usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
=E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint16(unsigned char *c, uint16_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
=E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint32(unsigned char *c, uint32_t val);
             ^

This has been fixed by upstream libiscsi in version 1.10.0 (see
https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
have to work-around the issue by compiling with "-Wno-error"
in this case instead.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use "-Wno-error" instead of "-fgnu89-inline"

 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index 2b9ba7d..9514533 100755
--- a/configure
+++ b/configure
@@ -4562,6 +4562,11 @@ if test "$libiscsi" !=3D "no" ; then
     libiscsi=3D"yes"
     libiscsi_cflags=3D$($pkg_config --cflags libiscsi)
     libiscsi_libs=3D$($pkg_config --libs libiscsi)
+    if $pkg_config --exact-version=3D1.9.0 libiscsi; then
+      # There are some bad inline declarations in scsi-lowlevel.h of
+      # libiscsi 1.9.0 which don't work in gnu99 mode, so we need this:
+      libiscsi_cflags=3D"-Wno-error $libiscsi_cflags"
+    fi
   else
     if test "$libiscsi" =3D "yes" ; then
       feature_not_found "libiscsi" "Install libiscsi >=3D 1.9.0"
--=20
1.8.3.1
