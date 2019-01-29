Received: from eggs.gnu.org ([209.51.188.92]:35655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXf6-0004tN-3q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXf5-0002OY-AK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:04 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:58 +0100
Message-Id: <20190129175403.18017-14-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 13/18] oslib-posix: Ignore
 fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/oslib-posix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ce1ba9ca4..2f0f27e6d9 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -244,7 +244,17 @@ void qemu_set_nonblock(int fd)
     f =3D fcntl(fd, F_GETFL);
     assert(f !=3D -1);
     f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
+#ifdef __OpenBSD__
+    if (f =3D=3D -1) {
+        /*
+         * Previous to OpenBSD 6.3, fcntl(F_SETFL) is not permitted on
+         * memory devices and sets errno to ENODEV.
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
