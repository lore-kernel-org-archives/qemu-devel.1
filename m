Received: from eggs.gnu.org ([209.51.188.92]:37595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grTGK-0006L3-Ud
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grTGJ-0006uD-Uu
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1grTGJ-0006s8-KW
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:53:35 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  6 Feb 2019 14:53:15 -0500
Message-Id: <20190206195316.12646-2-crosa@redhat.com>
In-Reply-To: <20190206195316.12646-1-crosa@redhat.com>
References: <20190206195316.12646-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/2] Acceptance tests: add the build
 directory to the system PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>

So that when binaries such as qemu-img are searched for, those in the
build tree will be favored.  As a clarification, SRC_ROOT_DIR is
dependent on the location from where tests are executed, so they are
equal to the build directory if one is being used.

The original motivation is that Avocado libraries such as
avocado.utils.vmimage.get() may use the matching binaries, but it may
also apply to any other binary that test code may eventually attempt
to execute.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 1e54fd5932..6f0075142f 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -42,6 +42,13 @@ def pick_default_qemu_bin():
=20
 class Test(avocado.Test):
     def setUp(self):
+        # Some utility code uses binaries from the system's PATH.  For
+        # instance, avocado.utils.vmimage.get() uses qemu-img, to
+        # create a snapshot image.  This is a transparent way of
+        # making sure those utilities find and use binaries on the
+        # build tree by default.
+        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PATH=
'])
+
         self.vm =3D None
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Dpick_default_qemu_bin(=
))
--=20
2.20.1
