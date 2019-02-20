Received: from eggs.gnu.org ([209.51.188.92]:34192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwFTS-0006kF-Ge
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwFTK-0000zZ-Tf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:10:49 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 01:05:53 +0100
Message-Id: <20190220000553.28438-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block/iscsi: Restrict Linux-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Some Linux specific code is missing guards, leading to
build failure on OSX:

  $ sudo brew install libiscsi
  $ ./configure && make
  [...]
    CC      block/iscsi.o
  qemu/block/iscsi.c:338:24: error: 'iscsi_aiocb_info' defined but not us=
ed [-Werror=3Dunused-const-variable=3D]
   static const AIOCBInfo iscsi_aiocb_info =3D {
                          ^~~~~~~~~~~~~~~~
  qemu/block/iscsi.c:168:1: error: 'iscsi_schedule_bh' defined but not us=
ed [-Werror=3Dunused-function]
   iscsi_schedule_bh(IscsiAIOCB *acb)
   ^~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Add guards to restrict this code for Linux.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
There are various Linux specific code, we could split it out to
another file such block/iscsi-lnx.o and guard with Makefile,
but that's another patch.

 block/iscsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index ff473206e6..85daa9a481 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -145,6 +145,8 @@ static const unsigned iscsi_retry_times[] =3D {8, 32,=
 128, 512, 2048, 8192, 32768}
  * unallocated. */
 #define ISCSI_CHECKALLOC_THRES 64
=20
+#ifdef __linux__
+
 static void
 iscsi_bh_cb(void *p)
 {
@@ -172,6 +174,8 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
     qemu_bh_schedule(acb->bh);
 }
=20
+#endif
+
 static void iscsi_co_generic_bh_cb(void *opaque)
 {
     struct IscsiTask *iTask =3D opaque;
@@ -290,6 +294,8 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilu=
n, struct IscsiTask *iTask)
     };
 }
=20
+#ifdef __linux__
+
 /* Called (via iscsi_service) with QemuMutex held. */
 static void
 iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *comma=
nd_data,
@@ -338,6 +344,7 @@ static const AIOCBInfo iscsi_aiocb_info =3D {
     .cancel_async       =3D iscsi_aio_cancel,
 };
=20
+#endif
=20
 static void iscsi_process_read(void *arg);
 static void iscsi_process_write(void *arg);
--=20
2.20.1
