Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErE-0008TJ-1w
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErC-0005YR-1J
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cmErB-0005Y8-HD
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:20:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 10 Mar 2017 15:20:50 +0800
Message-Id: <20170310072051.15704-2-famz@redhat.com>
In-Reply-To: <20170310072051.15704-1-famz@redhat.com>
References: <20170310072051.15704-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] tests/docker: support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

if ftp_proxy/http_proxy/https_proxy standard environment variables availa=
ble,
pass them to the docker daemon to build images.
this is required when building behind corporate proxy/firewall, but also =
help
when using local cache server (ie: apt/yum).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170306205520.32311-1-f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9fd32ab..8747f6a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -28,6 +28,9 @@ from shutil import copy, rmtree
 from pwd import getpwuid
=20
=20
+FILTERED_ENV_NAMES =3D ['ftp_proxy', 'http_proxy', 'https_proxy']
+
+
 DEVNULL =3D open(os.devnull, 'wb')
=20
=20
@@ -272,6 +275,9 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable,
                                        docker_dir)
=20
+            argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
+                        for k, v in os.environ.iteritems()
+                        if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=3Dargs.quiet, user=3Dargs.user, argv=3D=
argv)
=20
--=20
2.9.3
