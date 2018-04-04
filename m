Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YXF-0001Wc-9A
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YXE-0003ep-49
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3YXD-0003ej-U0
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Apr 2018 10:52:01 +0800
Message-Id: <20180404025201.11921-4-famz@redhat.com>
In-Reply-To: <20180404025201.11921-1-famz@redhat.com>
References: <20180404025201.11921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tests: Add centos VM testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This one does docker testing in the VM. It is intended to replace the
native docker testing on patchew testers.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/centos | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 tests/vm/centos

diff --git a/tests/vm/centos b/tests/vm/centos
new file mode 100755
index 0000000000..1a0d1fc0a2
--- /dev/null
+++ b/tests/vm/centos
@@ -0,0 +1,82 @@
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
+    name = "centos"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar -xf /dev/vdb;
+        make docker-test-mingw@fedora V=1 J=8;
+        make docker-test-build@min-glib V=1 J=8;
+    """
+
+    def _gen_cloud_init_iso(self):
+        cidir = self._tmpdir
+        mdata = open(os.path.join(cidir, "meta-data"), "w")
+        mdata.writelines(["instance-id: centos-vm-0\n",
+                          "local-hostname: centos-guest\n"])
+        mdata.close()
+        udata = open(os.path.join(cidir, "user-data"), "w")
+        udata.writelines(["#cloud-config\n",
+                          "chpasswd:\n",
+                          "  list: |\n",
+                          "    root:%s\n" % self.ROOT_PASS,
+                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
+                          "  expire: False\n",
+                          "users:\n",
+                          "  - name: %s\n" % self.GUEST_USER,
+                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % basevm.SSH_PUB_KEY,
+                          "  - name: root\n",
+                          "    ssh-authorized-keys:\n",
+                          "    - %s\n" % basevm.SSH_PUB_KEY,
+                          "locale: en_US.UTF-8\n"])
+        udata.close()
+        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
+                               "-volid", "cidata", "-joliet", "-rock",
+                               "user-data", "meta-data"],
+                               cwd=cidir,
+                               stdin=self._devnull, stdout=self._stdout,
+                               stderr=self._stdout)
+        return os.path.join(cidir, "cloud-init.iso")
+
+    def build_image(self, img):
+        cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
+        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
+        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
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
+if __name__ == "__main__":
+    sys.exit(basevm.main(CentosVM))
-- 
2.14.3
