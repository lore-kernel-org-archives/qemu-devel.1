Received: from eggsout.gnu.org ([209.51.188.92]:46069 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg15z-0000uu-41
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg15u-0004IP-75
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:35 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17745
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gg15r-00044p-Hx
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 00:35:29 -0500
From: Fam Zheng <fam@euphon.net>
Message-ID: <20190106053409.10712-3-fam@euphon.net>
Date: Sun,  6 Jan 2019 13:34:08 +0800
In-Reply-To: <20190106053409.10712-1-fam@euphon.net>
References: <20190106053409.10712-1-fam@euphon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] docker: Use a stable snapshot for Debian Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The Debian Sid repository is not garanteed to be stable, as his
'unstable' name suggest :)

To allow quick testing, Debian maintainers might push packages
various time a day. Sometime package dependencies might break,
which is annoying when using this repository for stable development
(which is not recommended, but Sid provides edge packages we use
for testing).

Debian provides repositories snapshots which are suitable for our
use. Pick a recent date that works. When required, update to newer
releases will be easy.

This fixes current issues with this image:

  $ make docker-image-debian-sid
  [...]
  The following packages have unmet dependencies:
   build-essential : Depends: dpkg-dev (>=3D 1.17.11) but it is not going t=
o be installed
   git : Depends: perl but it is not going to be installed
         Depends: liberror-perl but it is not going to be installed
   pkg-config : Depends: libdpkg-perl but it is not going to be installed
   texinfo : Depends: perl (>=3D 5.26.2-6) but it is not going to be instal=
led
             Depends: libtext-unidecode-perl but it is not going to be inst=
alled
             Depends: libxml-libxml-perl but it is not going to be installe=
d
  E: Unable to correct problems, you have held broken packages.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20181101183705.5422-1-philmd@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/debian-sid.docker | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dock=
erfiles/debian-sid.docker
index 9a3d168705..4e4cda0ba5 100644
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ b/tests/docker/dockerfiles/debian-sid.docker
@@ -13,6 +13,10 @@
=20
 FROM debian:sid-slim
=20
+# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20181030"
+RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [chec=
k-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_=
DATE} \2%" /etc/apt/sources.list
+
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sourc=
es.list
=20
--=20
2.11.0
