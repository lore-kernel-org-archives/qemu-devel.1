Received: from eggs.gnu.org ([209.51.188.92]:52069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj4k1-0007OL-NN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj4jm-00009y-J4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:05:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 17:04:32 +0100
Message-Id: <1547481872-17870-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] configure: Work-around a bug in libiscsi
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
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

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
[...]

This has been fixed by upstream libiscsi in version 1.10.0 (see
https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
have to work-around the issue by redefining the "inline" keyword
to use the old "gnu89" mode behavior via "gnu_inline" instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/iscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index a7e8c1f..ff47320 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -49,7 +49,9 @@
 /* Conflict between scsi/utils.h and libiscsi! :( */
 #define SCSI_XFER_NONE ISCSI_XFER_NONE
 #include <iscsi/iscsi.h>
+#define inline __attribute__((gnu_inline))  /* required for libiscsi v1.=
9.0 */
 #include <iscsi/scsi-lowlevel.h>
+#undef inline
 #undef SCSI_XFER_NONE
 QEMU_BUILD_BUG_ON((int)SCSI_XFER_NONE !=3D (int)ISCSI_XFER_NONE);
=20
--=20
1.8.3.1
