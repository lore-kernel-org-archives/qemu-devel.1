Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn7Ae-0006A3-WE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn78g-0005bW-UB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn78g-0005bD-Ow
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 25 Jan 2019 20:27:18 +0100
Message-Id: <20190125192719.15339-3-philmd@redhat.com>
In-Reply-To: <20190125192719.15339-1-philmd@redhat.com>
References: <20190125192719.15339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] XXX oslib-posix: Ignore fcntl("/dev/null",
 F_SETFL, O_NONBLOCK) failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>

Previous to OpenBSD 6.3 [1], fcntl(F_SETFL) is not permitted on memory
devices. Do not assert fcntl failures on OpenBSD.
This fixes:

  $ lm32-softmmu/qemu-system-lm32
  assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247, func=
tion "qemu_set_nonblock"
  Abort trap (core dumped)

[1] The fix seems https://github.com/openbsd/src/commit/c2a35b387f9d3c
  "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
  the memory devices (/dev/null, /dev/zero, etc) need to permit them."

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/oslib-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ce1ba9ca4..064c3ae2f7 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -244,7 +244,9 @@ void qemu_set_nonblock(int fd)
     f =3D fcntl(fd, F_GETFL);
     assert(f !=3D -1);
     f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
+#ifndef __OpenBSD__
     assert(f !=3D -1);
+#endif
 }
=20
 int socket_set_fast_reuse(int fd)
--=20
2.20.1
