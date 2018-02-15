Received: from eggs.gnu.org ([2001:4830:134:3::10]:45932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emN9B-0003Bz-Ll
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emN97-0006p2-Gs
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emN97-0006ov-CG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:16:33 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:16:11 +0000
Message-Id: <20180215171611.11962-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: dump config.log when configure fails in
 docker job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When configure fails inside a docker job it is not easy to get access to
the config.log file. It is nicer for developers if we just splatter the
contents of config.log to stdout upon failure

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/common.rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 7951555e3f..ecbea13443 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -30,7 +30,8 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts || cat config.log
+    make $MAKEFLAGS
 }
=20
 test_fail()
--=20
2.14.3
