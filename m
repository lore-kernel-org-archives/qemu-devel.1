Received: from eggs.gnu.org ([209.51.188.92]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6t-0004p0-Nx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6s-0003fg-1R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6r-0003el-RD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:53 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:37 -0200
Message-Id: <20190117201743.20470-4-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] configure: keep track of Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

Some functionality is dependent on the Python version
detected/configured on configure.  While it's possible to run the
Python version later and check for the version, doing it once is
preferable.  Also, it's a relevant information to keep in build logs,
as the overall behavior of the build can be affected by it.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181109150710.31085-2-crosa@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3eee3fcf70..ca3d407d75 100755
--- a/configure
+++ b/configure
@@ -1797,6 +1797,9 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
+# Preserve python version since some functionality is dependent on it
+python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
+
 # Suppress writing compiled files
 python="$python -B"
 
@@ -6010,7 +6013,7 @@ echo "LDFLAGS           $LDFLAGS"
 echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
-echo "python            $python"
+echo "python            $python ($python_version)"
 if test "$slirp" = "yes" ; then
     echo "smbd              $smbd"
 fi
@@ -6959,6 +6962,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
 echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
+echo "PYTHON_VERSION=$python_version" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
-- 
2.18.0.rc1.1.g3f1ff2140
