Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecZUg-0008A8-SK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecZUc-0008Qq-Kv
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ecZUc-0008QM-FL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:26:14 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jan 2018 17:25:54 +0100
Message-Id: <20180119162554.27270-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix python 2 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, lersek@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Python GDB support may use Python 2 or 3.

Inferior.read_memory() may return a 'buffer' with Python 2 or a
'memoryview' with Python 3 (see also
https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)

The elf.add_vmcoreinfo_note() method expects a "bytes" object. Wrap
the returned memory with bytes(), which works with both 'memoryview'
and 'buffer'.

Fixes a regression introduced with commit
d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 09bec92b50..03fbf69f8a 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -564,7 +564,7 @@ shape and this command should mostly work."""
=20
         vmcoreinfo =3D self.phys_memory_read(addr, size)
         if vmcoreinfo:
-            self.elf.add_vmcoreinfo_note(vmcoreinfo.tobytes())
+            self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))
=20
     def invoke(self, args, from_tty):
         """Handles command invocation from gdb."""
--=20
2.16.0.rc1.1.gef27df75a1
