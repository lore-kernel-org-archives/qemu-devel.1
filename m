Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehCqq-0004kJ-2A
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ehCql-0003cr-BH
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ehCql-0003cU-5a
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:16:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Feb 2018 12:16:05 +0100
Message-Id: <20180201111605.7392-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180201111605.7392-1-marcandre.lureau@redhat.com>
References: <20180201111605.7392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] dump-guest-memory.py: skip vmcoreinfo
 section if not available
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

On some architectures, qemu doesn't support vmcoreinfo device,
and dump-guest-memory fails:

(gdb) dump-guest-memory /tmp/vmcore  ppc64-le
guest RAM blocks:
target_start     target_end       host_addr        message count
---------------- ---------------- ---------------- ------- -----
0000000000000000 0000000200000000 00003ffd86980000 added       1
0000200080000000 0000200080800000 00003ffd86170000 added       2
Python Exception <class 'gdb.error'> No symbol "vmcoreinfo_realize" in cu=
rrent context.:
Error occurred in Python command: No symbol "vmcoreinfo_realize" in curre=
nt context.

Check that vmcoreinfo_realize symbol exists before evaluating an
expression with it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 scripts/dump-guest-memory.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 03fbf69f8a..51acfcd0c0 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -546,6 +546,8 @@ shape and this command should mostly work."""
         return None
=20
     def add_vmcoreinfo(self):
+        if gdb.lookup_symbol("vmcoreinfo_realize")[0] is None:
+            return
         vmci =3D 'vmcoreinfo_realize::vmcoreinfo_state'
         if not gdb.parse_and_eval("%s" % vmci) \
            or not gdb.parse_and_eval("(%s)->has_vmcoreinfo" % vmci):
--=20
2.16.0.rc1.1.gef27df75a1
