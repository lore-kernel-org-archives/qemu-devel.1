Received: from eggs.gnu.org ([2001:4830:134:3::10]:48612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7D-00057F-K5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7A-0006NA-JD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:31 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ7A-0006Mn-Cf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:28 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a10so23700304wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:02 +0100
Message-Id: <20170718104513.23947-22-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/32] docker: add 'apt-fake' script which
 generate fake debian packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
new file mode 100755
index 0000000000..2ec0fdf47a
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
+        dpkg -i --force-overwrite $2_$3_$1.deb
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
