Received: from eggs.gnu.org ([2001:4830:134:3::10]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gIvYv-00058a-KX
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 09:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gIvYq-0006ZH-K5
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 09:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gIvYq-0006Ug-DW
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 09:01:56 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  3 Nov 2018 17:01:43 +0400
Message-Id: <20181103130143.7179-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qga-win: fix leaks of build_guest_disk_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tgolembi@redhat.com, mdroth@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Introduced in commit b1ba8890e63ce9432c41c5c3fc229f54c87c9c99, vol_h
handle should be closed, and "out" cleanup should be done after
DeviceIoControl() fails.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index ef1d7d48d2..62e1b51dfe 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -797,7 +797,7 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
                     0, extents, size, NULL, NULL)) {
                 error_setg_win32(errp, GetLastError(),
                     "failed to get disk extents");
-                return NULL;
+                goto out;
             }
         } else if (last_err =3D=3D ERROR_INVALID_FUNCTION) {
             /* Possibly CD-ROM or a shared drive. Try to pass the volume=
 */
@@ -855,6 +855,9 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)
=20
=20
 out:
+    if (vol_h !=3D INVALID_HANDLE_VALUE) {
+        CloseHandle(vol_h);
+    }
     qapi_free_GuestDiskAddress(disk);
     g_free(extents);
     g_free(name);
--=20
2.19.1.708.g4ede3d42df
