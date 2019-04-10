Received: from eggs.gnu.org ([209.51.188.92]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hECSP-00011c-5O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hECSO-0004jT-80
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hECSN-0004iA-WE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 10 Apr 2019 14:35:50 +0200
Message-Id: <20190410123550.2362-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1] gitlab-ci.yml: Test the TCG
 interpreter in a CI pipeline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, berrange@redhat.com, deller@gmx.de

So far we do not have any test coverage for TCI (the TCG interpreter) yet=
.
Thus let's add a CI pipeline that runs at least some basic TCG tests with
a TCI build, to make sure that there are no further regressions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: I did not include the sparc and sparc64 targets here since they are
 currently broken with TCI. Also "make check-tcg" does not work with
 x86_64-linux-user yet ... in case someone wants to fix that...

 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 79d02cf740..c63bf2f822 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,3 +71,18 @@ build-clang:
                      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-=
user"
  - make -j2
  - make -j2 check
+
+build-tci:
+ script:
+ - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x=
86_64"
+ - ./configure --enable-tcg-interpreter
+      --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '=
; done)"
+ - make -j2
+ - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
+ - for tg in $TARGETS ; do
+     export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
+     ./tests/boot-serial-test || exit 1 ;
+     ./tests/cdrom-test || exit 1 ;
+   done
+ - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/pxe-t=
est
+ - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-tes=
t -m slow
--=20
2.21.0
