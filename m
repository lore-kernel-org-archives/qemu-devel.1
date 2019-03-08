Received: from eggs.gnu.org ([209.51.188.92]:36998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf5-0005pY-Tu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf5-0000OY-8t
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bf5-0000NL-27
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:43 +0100
Message-Id: <1552036723-1949-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

cirrus-ci.com also has the possibility to run CI tasks on macOS.
Since most of the QEMU developers do not have access to macOS yet,
let's add a CI pipeline for this operating system here, too.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 303fe72..47ef5bc 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,10 +1,11 @@
+env:
+  CIRRUS_CLONE_DEPTH: 1
+
 freebsd_12_task:
   freebsd_instance:
     image: freebsd-12-0-release-amd64
     cpu: 8
     memory: 8G
-  env:
-    CIRRUS_CLONE_DEPTH: 1
   install_script: pkg install -y
     bison curl cyrus-sasl git glib gmake gnutls
     nettle perl5 pixman pkgconf png usbredir
@@ -14,3 +15,13 @@ freebsd_12_task:
     - ../configure || { cat config.log; exit 1; }
     - gmake -j8
     - gmake -j8 V=3D1 check
+
+macos_task:
+  osx_instance:
+    image: mojave-base
+  install_script:
+    - brew install pkg-config python glib pixman make sdl2
+  script:
+    - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
+    - gmake -j$(sysctl -n hw.ncpu)
+    - gmake check -j$(sysctl -n hw.ncpu)
--=20
1.8.3.1
