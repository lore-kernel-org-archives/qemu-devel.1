Received: from eggs.gnu.org ([2001:4830:134:3::10]:56970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFQ-0007AJ-NY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFO-0001Cp-TO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFL-00018i-Mc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:41 +0800
Message-Id: <20180815031248.14908-11-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/17] tests: Add centos VM testing
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

This one does docker testing in the VM. It is intended to replace the
native docker testing on patchew testers.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180712012829.20231-5-famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/Makefile.include |  3 +-
 tests/vm/centos           | 84 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100755 tests/vm/centos

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5daa2a3b73..af19b7a4e6 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,7 +2,7 @@
=20
 .PHONY: vm-build-all
=20
-IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd
+IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd centos
 IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
=20
 .PRECIOUS: $(IMAGE_FILES)
@@ -14,6 +14,7 @@ vm-test:
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
 	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
 	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
+	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, wit=
h Docker"
=20
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
=20
diff --git a/tests/vm/centos b/tests/vm/centos
new file mode 100755
index 0000000000..afd560c564
--- /dev/null
+++ b/tests/vm/centos
@@ -0,0 +1,84 @@
+#!/usr/bin/env python
+#
+# CentOS image
+#
+# Copyright 2018 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+import time
+
+class CentosVM(basevm.BaseVM):
+    name =3D "centos"
+    BUILD_SCRIPT =3D """
+        set -e;
+        cd $(mktemp -d);
+        export SRC_ARCHIVE=3D/dev/vdb;
+        sudo chmod a+r $SRC_ARCHIVE;
+        tar -xf $SRC_ARCHIVE;
+        make docker-test-block@centos7 V=3D{verbose} J=3D{jobs};
+        make docker-test-quick@centos7 V=3D{verbose} J=3D{jobs};
+        make docker-test-mingw@fedora V=3D{verbose} J=3D{jobs};
+    """
+
+    def _gen_cloud_init_iso(self):
+        cidir =3D self._tmpdir
+        mdata =3D open(os.path.join(cidir, "meta-data"), "w")
+        mdata.writelines(["instance-id: centos-vm-0\n",
+                          "local-hostname: centos-guest\n"])
+        mdata.close()
+        udata =3D open(os.path.join(cidir, "user-data"), "w")
+        udata.writelines(["#cloud-config\n",
+                          "chpasswd:\n",
+                          "  list: |\n",
+                          "    root:%s\n" % self.ROOT_PASS,
+                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_P=
ASS),
+                          "  expire: False\n",
+                          "users:\n",
+                          "  - name: %s\n" % self.GUEST_USER,
+                          "    sudo: ALL=3D(ALL) NOPASSWD:ALL\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % basevm.SSH_PUB_KEY,
+                          "  - name: root\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % basevm.SSH_PUB_KEY,
+                          "locale: en_US.UTF-8\n"])
+        udata.close()
+        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso=
",
+                               "-volid", "cidata", "-joliet", "-rock",
+                               "user-data", "meta-data"],
+                               cwd=3Dcidir,
+                               stdin=3Dself._devnull, stdout=3Dself._std=
out,
+                               stderr=3Dself._stdout)
+        return os.path.join(cidir, "cloud-init.iso")
+
+    def build_image(self, img):
+        cimg =3D self._download_with_cache("https://cloud.centos.org/cen=
tos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
+        img_tmp =3D img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
+        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
+        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
+        self.wait_ssh()
+        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
+        self.ssh_root_check("yum update -y")
+        self.ssh_root_check("yum install -y docker make git")
+        self.ssh_root_check("systemctl enable docker")
+        self.ssh_root("poweroff")
+        self.wait()
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+        return 0
+
+if __name__ =3D=3D "__main__":
+    sys.exit(basevm.main(CentosVM))
--=20
2.17.1
