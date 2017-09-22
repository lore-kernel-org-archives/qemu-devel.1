Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIg1-0007pF-Sd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIg1-0000qL-2U
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIg0-0000po-S9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:25 +0800
Message-Id: <20170922074659.30097-3-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/36] docker: docker.py make --no-cache skip
 checksum test
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

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

If you invoke with NOCACHE=3D1 we pass --no-cache in the argv to
docker.py but may still not force a rebuild if the dockerfile checksum
hasn't changed. By testing for its presence we can force builds
without having to manually remove the docker image.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20170725133425.436-5-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 81c87ee329..08122ca17d 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -263,7 +263,8 @@ class BuildCommand(SubCommand):
         tag =3D args.tag
=20
         dkr =3D Docker()
-        if dkr.image_matches_dockerfile(tag, dockerfile):
+        if "--no-cache" not in argv and \
+           dkr.image_matches_dockerfile(tag, dockerfile):
             if not args.quiet:
                 print "Image is up to date."
         else:
--=20
2.13.5
