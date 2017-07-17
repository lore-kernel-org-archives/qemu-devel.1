Received: from eggs.gnu.org ([2001:4830:134:3::10]:39400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Sk-0005fQ-LB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Si-0005wf-EO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:30 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Si-0005wP-75
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:28 -0400
Received: by mail-wm0-x235.google.com with SMTP id b134so50934164wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:57:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:45 +0100
Message-Id: <20170717144848.11793-21-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 20/23] docker: add 'apt-fake' script which
 generate fake debian packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-apt-fake.sh | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh

diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
new file mode 100755
index 0000000000..387522c174
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-apt-fake.sh
@@ -0,0 +1,46 @@
+#! /bin/sh
+#
+# Generate fake debian package to resolve unimportant unmet dependencies held
+# by upstream multiarch broken packages.
+#
+# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+test $1 = "install" && shift 1
+
+fake_install()
+{
+    echo "Generating fake $2 $1 $3 ..."
+    (cd /var/cache/apt/archives
+        (cat << 'EOF'
+Section: misc
+Priority: optional
+Standards-Version: 3.9.2
+
+Package: NAME
+Version: VERSION
+Maintainer: qemu-devel@nongnu.org
+Architecture: any
+Multi-Arch: same
+Description: fake NAME
+EOF
+        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
+        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
+        dpkg -i $2_$3_$1.deb
+    )
+}
+
+try_install()
+{
+    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
+    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
+    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
+    apt-get install -q -yy $1 || fake_install $arch $name $vers
+}
+
+for package in $*; do
+    try_install $package
+done
-- 
2.13.0
