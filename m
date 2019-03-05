Received: from eggs.gnu.org ([209.51.188.92]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1BvI-00065C-Og
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1BvI-0002Ja-1c
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:24:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h1BvH-0002Dj-Ps
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:24:03 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  5 Mar 2019 16:15:00 +0100
Message-Id: <20190305151500.25038-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] linux-user: fix "may be used uninitialized"
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Fixes:

/home/elmarco/src/qemu/linux-user/syscall.c: In function =E2=80=98do_ioct=
l_rt=E2=80=99:
/home/elmarco/src/qemu/linux-user/syscall.c:4773:9: error: =E2=80=98host_=
rt_dev_ptr=E2=80=99 may be used uninitialized in this function [-Werror=3D=
maybe-uninitialized]
     if (*host_rt_dev_ptr !=3D 0) {
         ^~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/linux-user/syscall.c:4774:9: error: =E2=80=98targe=
t_rt_dev_ptr=E2=80=99 may be used uninitialized in this function [-Werror=
=3Dmaybe-uninitialized]
         unlock_user((void *)*host_rt_dev_ptr,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     *target_rt_dev_ptr, 0);
                     ~~~~~~~~~~~~~~~~~~~~~~

Based on previous discussion from patch "linux-users/syscall: make
do_ioctl_rt safer" by Alex Benn=C3=A9e.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 linux-user/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5bbb72f3d5..a15340b302 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4723,8 +4723,8 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, u=
int8_t *buf_temp,
     const int *dst_offsets, *src_offsets;
     int target_size;
     void *argptr;
-    abi_ulong *target_rt_dev_ptr;
-    unsigned long *host_rt_dev_ptr;
+    abi_ulong *target_rt_dev_ptr =3D NULL;
+    unsigned long *host_rt_dev_ptr =3D NULL;
     abi_long ret;
     int i;
=20
@@ -4770,6 +4770,9 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, u=
int8_t *buf_temp,
     unlock_user(argptr, arg, 0);
=20
     ret =3D get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+
+    assert(host_rt_dev_ptr !=3D NULL);
+    assert(target_rt_dev_ptr !=3D NULL);
     if (*host_rt_dev_ptr !=3D 0) {
         unlock_user((void *)*host_rt_dev_ptr,
                     *target_rt_dev_ptr, 0);
--=20
2.21.0
