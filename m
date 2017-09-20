Received: from eggs.gnu.org ([2001:4830:134:3::10]:44541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVfH-0000Vb-3F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVfF-00052v-On
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duVfF-000514-G0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:27:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 20 Sep 2017 11:25:48 +0800
Message-Id: <20170920032555.18911-7-famz@redhat.com>
In-Reply-To: <20170920032555.18911-1-famz@redhat.com>
References: <20170920032555.18911-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 06/13] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This adds a 32bit guest.

The official LTS cloud image is downloaded and initialized with
cloud-init.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/ubuntu.i386 | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100755 tests/vm/ubuntu.i386

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
new file mode 100755
index 0000000000..fc319e0e6e
--- /dev/null
+++ b/tests/vm/ubuntu.i386
@@ -0,0 +1,89 @@
+#!/usr/bin/env python
+#
+# Ubuntu i386 image
+#
+# Copyright 2017 Red Hat Inc.
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
+class UbuntuX86VM(basevm.BaseVM):
+    name = "ubuntu.i386"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d);
+        sudo chmod a+r /dev/vdb;
+        tar -xf /dev/vdb;
+        ./configure {configure_opts};
+        make -j{jobs};
+        make check;
+    """
+
+    def _gen_cloud_init_iso(self):
+        cidir = self._tmpdir
+        mdata = open(os.path.join(cidir, "meta-data"), "w")
+        mdata.writelines(["instance-id: ubuntu-vm-0\n",
+                          "local-hostname: ubuntu-guest\n"])
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
+        cimg = self._download_with_cache("https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp])
+        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
+        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
+        self.wait_ssh()
+        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
+        self.ssh_root_check("apt-get update")
+        self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
+        # Don't check the status in case the guest hang up too quickly
+        self.ssh_root("sync && reboot")
+        time.sleep(5)
+        self.wait_ssh()
+        # The previous update sometimes doesn't survive a reboot, so do it again
+        self.ssh_root_check("apt-get update")
+        self.ssh_root_check("apt-get build-dep -y qemu")
+        self.ssh_root_check("apt-get install -y libfdt-dev")
+        self.ssh_root("poweroff")
+        self.wait()
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+        return 0
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(UbuntuX86VM))
-- 
2.13.5
