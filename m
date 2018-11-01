Received: from eggs.gnu.org ([2001:4830:134:3::10]:58808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIHqi-0004Vg-0k
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIHqd-0000jP-2J
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIHqU-0000Zs-LT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:37:32 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  1 Nov 2018 19:37:05 +0100
Message-Id: <20181101183705.5422-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The Debian Sid repository is not garanteed to be stable, as his
'unstable' name suggest :)
To allow quick testing, packages are pushed various time a day,
which my be annoying when trying to use it for stable development
(which is not recommended, but Sid provides edge packages we use
for testing).

Debian provides repositories snapshots which are suitable for our
use. Pick a recent date that works. When required, update to newer
releases will be easy.

This fixes current issues with this image:

  $ make docker-image-debian-sid
  [...]
  The following packages have unmet dependencies:
   build-essential : Depends: dpkg-dev (>=3D 1.17.11) but it is not going=
 to be installed
   git : Depends: perl but it is not going to be installed
         Depends: liberror-perl but it is not going to be installed
   pkg-config : Depends: libdpkg-perl but it is not going to be installed
   texinfo : Depends: perl (>=3D 5.26.2-6) but it is not going to be inst=
alled
             Depends: libtext-unidecode-perl but it is not going to be in=
stalled
             Depends: libxml-libxml-perl but it is not going to be instal=
led
  E: Unable to correct problems, you have held broken packages.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-sid.docker | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
index 9a3d168705..4e4cda0ba5 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -13,6 +13,10 @@
=20
 FROM debian:sid-slim
=20
+# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20181030"
+RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [ch=
eck-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPS=
HOT_DATE} \2%" /etc/apt/sources.list
+
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
=20
--=20
2.17.2
