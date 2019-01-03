Received: from eggs.gnu.org ([208.118.235.92]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf4dO-0002yw-Kc
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf4dN-0004Ep-LF
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:10:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf4dN-0004Eb-83
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:10:09 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 16:09:51 +0100
Message-Id: <20190103150951.17592-3-philmd@redhat.com>
In-Reply-To: <20190103150951.17592-1-philmd@redhat.com>
References: <20190103150951.17592-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] tests: Disable qht-bench parallel test
 when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This test is failing on the Travis CI [*] since some time now,
disable it until it get fixed.

[*] https://travis-ci.org/qemu/qemu/builds/474821674

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Use CONFIG_GPROF via config_host_mak (check-unit isn't target)
---
 configure              | 1 +
 tests/Makefile.include | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index fa5c079f98..69a125814d 100755
--- a/configure
+++ b/configure
@@ -7470,6 +7470,7 @@ alpha)
 esac
=20
 if test "$gprof" =3D "yes" ; then
+  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
   echo "TARGET_GPROF=3Dy" >> $config_target_mak
   if test "$target_linux_user" =3D "yes" ; then
     cflags=3D"-p $cflags"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f5a1d0c30..b8f91fdd97 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -88,7 +88,8 @@ check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
 check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
 check-unit-y +=3D tests/test-qdist$(EXESUF)
 check-unit-y +=3D tests/test-qht$(EXESUF)
-check-unit-y +=3D tests/test-qht-par$(EXESUF)
+# FIXME: {test-qht-par + gprof} often break on Travis CI
+check-unit-$(call lnot,$(CONFIG_GPROF)) +=3D tests/test-qht-par$(EXESUF)
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
 check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
--=20
2.17.2
