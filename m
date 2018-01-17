Received: from eggs.gnu.org ([2001:4830:134:3::10]:56255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebp0b-0005df-B5
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebp0a-00062g-9x
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ebp0a-000621-42
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:48:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jan 2018 15:47:56 +0100
Message-Id: <20180117144756.31049-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180117144756.31049-1-marcandre.lureau@redhat.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] dump-guest-memory.py: fix python 2 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Python GDB support may use Python 2 or 3.

Inferior.read_memory() may return a buffer with Python 2 or a
memoryview with Python 3 (see also
https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)

The elf.add_vmcoreinfo_note() method expect a byte string, but Python 2
buffer doesn't provide the tobyes() method. Wrap the read_memory()
result to a memoryview, available in Python 2.7. (if the return object
is already a memoryview, this adds a useless identity view on top)

Fixes a regression introduced with commit
d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 scripts/dump-guest-memory.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 09bec92b50..6f7e1a83b3 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -564,7 +564,9 @@ shape and this command should mostly work."""
=20
         vmcoreinfo =3D self.phys_memory_read(addr, size)
         if vmcoreinfo:
-            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
+            # Python 2.7 returns a buffer
+            vmciview =3D memoryview(vmcoreinfo)
+            self.elf.add_vmcoreinfo_note(vmciview.tobytes())
=20
     def invoke(self, args, from_tty):
         """Handles command invocation from gdb."""
--=20
2.16.0.rc1.1.gef27df75a1
