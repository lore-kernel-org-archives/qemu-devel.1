Received: from eggs.gnu.org ([209.51.188.92]:49466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPNa-0000ZJ-3c
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPNX-0002YN-Tk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwPNW-0002X3-PL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:27 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 11:45:22 +0100
Message-Id: <20190220104523.22059-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

It looks like something in netmap has changed and compilation fails:

   install -D libnetmap.a //usr/local/lib/libnetmap.a
   install: cannot stat libnetmap.a: No such file or directory

Add an explicit "make" step to fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
index 954fcf9606..df79f35a46 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -33,7 +33,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         linux-headers-amd64
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ker=
nel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
+RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ker=
nel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
=20
 RUN ldconfig
--=20
2.20.1
