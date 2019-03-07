Received: from eggs.gnu.org ([209.51.188.92]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1u0l-0004Wt-Kz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1u0j-0008B7-Ky
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1u0h-00086J-Pg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:28:37 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  7 Mar 2019 15:28:21 +0100
Message-Id: <20190307142822.8531-2-philmd@redhat.com>
In-Reply-To: <20190307142822.8531-1-philmd@redhat.com>
References: <20190307142822.8531-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] oslib-posix: Ignore fcntl("/dev/null",
 F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Previous to OpenBSD 6.3 [1], fcntl(F_SETFL) is not permitted on
memory devices.
Trying this call sets errno to ENODEV ("not a memory device"):

  19 ENODEV Operation not supported by device.
    An attempt was made to apply an inappropriate function to a device,
    for example, trying to read a write-only device such as a printer.

Do not assert fcntl failures in this specific case (errno set to ENODEV)
on OpenBSD. This fixes:

  $ lm32-softmmu/qemu-system-lm32
  assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247, func=
tion "qemu_set_nonblock"
  Abort trap (core dumped)

[1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
  "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
  the memory devices (/dev/null, /dev/zero, etc) need to permit them."

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/oslib-posix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 37c5854b9c..326d92dcd2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -244,7 +244,19 @@ void qemu_set_nonblock(int fd)
     f =3D fcntl(fd, F_GETFL);
     assert(f !=3D -1);
     f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
+#ifdef __OpenBSD__
+    if (f =3D=3D -1) {
+        /*
+         * Previous to OpenBSD 6.3, fcntl(F_SETFL) is not permitted on
+         * memory devices and sets errno to ENODEV.
+         * It's OK if we fail to set O_NONBLOCK on devices like /dev/nul=
l,
+         * because they will never block anyway.
+         */
+        assert(errno =3D=3D ENODEV);
+    }
+#else
     assert(f !=3D -1);
+#endif
 }
=20
 int socket_set_fast_reuse(int fd)
--=20
2.20.1
