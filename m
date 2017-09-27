Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0h-0000yS-Bv
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0d-0006kc-8b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxC0d-0006kK-2L
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:37 -0300
Message-Id: <20170927130339.21444-4-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-1-ehabkost@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] basevm: Call logging.basicConfig()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Just setting level=3DDEBUG when debug is enabled is not enough: we
need to set up a log handler if we want debug messages generated
using logging.getLogger(...).debug() to be printed.

This was not a problem before because logging.debug() calls
logging.basicConfig() implicitly, but it's safer to not rely on
that.

Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>
Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/vm/basevm.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3c863bc237..686d88decf 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -227,8 +227,8 @@ def main(vmcls):
         if not argv and not args.build_qemu and not args.build_image:
             print "Nothing to do?"
             return 1
-        if args.debug:
-            logging.getLogger().setLevel(logging.DEBUG)
+        logging.basicConfig(level=3D(logging.DEBUG if args.debug
+                                   else logging.WARN))
         vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
--=20
2.13.5
