Received: from eggs.gnu.org ([2001:4830:134:3::10]:53999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHghC-0000f0-Sc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 22:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHgh8-0004GA-5K
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 22:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gHgh7-0004EQ-TG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 22:57:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 31 Oct 2018 10:57:12 +0800
Message-Id: <20181031025712.18602-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Upgrade OpenBSD to 6.4 using auto_install. Especially, drop SDL1,
include SDL2.

Also do the build in $HOME since both /var/tmp and /tmp are tmpfs with
limited capacities.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v4: Use 6.4. [Brad]
---
 tests/vm/basevm.py |  6 ++--
 tests/vm/openbsd   | 85 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5caf77d6b8..6fb446d4c5 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -68,8 +68,6 @@ class BaseVM(object):
         self._args = [ \
             "-nodefaults", "-m", "4G",
             "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
-            "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus and vcpus > 1:
@@ -146,8 +144,10 @@ class BaseVM(object):
                             "-device",
                             "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
 
-    def boot(self, img, extra_args=[]):
+    def boot(self, img, extra_args=[], extra_usernet_args=""):
         args = self._args + [
+            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22" + extra_usernet_args,
+            "-device", "virtio-net-pci,netdev=vnet",
             "-device", "VGA",
             "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index cfe0572c59..99a7e98d80 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -14,6 +14,9 @@
 import os
 import sys
 import subprocess
+import time
+import atexit
+import tempfile
 import basevm
 
 class OpenBSDVM(basevm.BaseVM):
@@ -21,25 +24,83 @@ class OpenBSDVM(basevm.BaseVM):
     arch = "x86_64"
     BUILD_SCRIPT = """
         set -e;
-        rm -rf /var/tmp/qemu-test.*
-        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        rm -rf $HOME/qemu-test.*
+        cd $(mktemp -d $HOME/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
-        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
+        ./configure {configure_opts};
         gmake --output-sync -j{jobs} {verbose};
         # XXX: "gmake check" seems to always hang or fail
         #gmake --output-sync -j{jobs} check {verbose};
     """
 
+    def _install_os(self, img):
+        tmpdir = tempfile.mkdtemp()
+        pxeboot = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.4/amd64/pxeboot",
+                sha256sum="d87ab39d941ff926d693943a927585945456ccedb76ea504a251b4b93cd4c266")
+        bsd_rd = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.4/amd64/bsd.rd",
+                sha256sum="89505c683cbcd75582fe475e847ed53d89e2b8180c3e3d61f4eb4b76b5e11f5c")
+        install = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.4/amd64/install64.iso",
+                sha256sum='81833b79e23dc0f961ac5fb34484bca66386deb3181ddb8236870fa4f488cdd2')
+        subprocess.check_call(["qemu-img", "create", img, "32G"])
+        subprocess.check_call(["cp", pxeboot, os.path.join(tmpdir, "auto_install")])
+        subprocess.check_call(["cp", bsd_rd, os.path.join(tmpdir, "bsd")])
+
+        self._gen_install_conf(tmpdir)
+        # BOOTP filename being auto_install makes sure OpenBSD installer
+        # not prompt for "auto install mode"
+        usernet_args = ",tftp=%s,bootfile=/auto_install" % tmpdir
+        usernet_args += ",tftp-server-name=10.0.2.4"
+        usernet_args += ",guestfwd=tcp:10.0.2.4:80-cmd:cat %s" % \
+            os.path.join(tmpdir, "install.conf")
+        self.boot(img,
+                  extra_args=["-boot", "once=n", "-no-reboot",
+                              "-cdrom", install],
+                  extra_usernet_args=usernet_args)
+        self.wait()
+
+    def _gen_install_conf(self, tmpdir):
+        contents = """\
+HTTP/1.0 200 OK
+
+System hostname = qemu-openbsd
+Password for root = qemupass
+Public ssh key for root = {pub_key}
+Allow root ssh login = yes
+Network interfaces = vio0
+IPv4 address for vio0 = dhcp
+Setup a user = qemu
+Password for user = qemupass
+Public ssh key for user = {pub_key}
+What timezone are you in = US/Eastern
+Server = fastly.cdn.openbsd.org
+Use http = yes
+Default IPv4 route = 10.0.2.2
+Location of sets = cd0
+Set name(s) = all
+Continue without verification = yes
+""".format(pub_key=basevm.SSH_PUB_KEY)
+        with open(os.path.join(tmpdir, "install.conf"), "w") as f:
+            f.write(contents)
+
     def build_image(self, img):
-        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
-                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
-        img_tmp_xz = img + ".tmp.xz"
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
-        os.rename(img_tmp, img)
+
+        self._install_os(img + ".tmp")
+
+        self.boot(img + ".tmp")
+        self.wait_ssh()
+
+        self.ssh_root("usermod -G operator qemu")
+        self.ssh_root("echo https://fastly.cdn.openbsd.org/pub/OpenBSD > /etc/installurl")
+        for pkg in ["git", "gmake", "glib2", "bison", "sdl2"]:
+            self.ssh_root("pkg_add " + pkg)
+        self.ssh_root("ln -sf /usr/local/bin/python2.7 /usr/local/bin/python")
+        self.ssh_root("ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3")
+        self.ssh_root("ln -sf /usr/local/bin/python2.7-config /usr/local/bin/python-config")
+        self.ssh_root("ln -sf /usr/local/bin/pydoc2.7 /usr/local/bin/pydoc")
+        self.ssh_root("shutdown -p now")
+        self.wait()
+
+        subprocess.check_call(["mv", img + ".tmp", img])
 
 if __name__ == "__main__":
     sys.exit(basevm.main(OpenBSDVM))
-- 
2.17.2
