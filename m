Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft0nO-0003AT-3a
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 21:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft0nJ-0007jm-PM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 21:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ft0nH-0007bo-Tb
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 21:21:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Aug 2018 09:21:26 +0800
Message-Id: <20180824012126.22721-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
include SDL2.

One limitation of this patch is that we need a temporary HTTP server on
host 80 port for auto_install, because slirp cannot do guest forward on
"host addr".

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 28 ++++++++++++++--
 tests/vm/openbsd   | 81 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d7149dea7d..4080039e66 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -65,8 +65,6 @@ class BaseVM(object):
             self._stdout = self._devnull
         self._args = [ \
             "-nodefaults", "-m", "4G",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
-            "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus:
@@ -145,8 +143,10 @@ class BaseVM(object):
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
@@ -196,6 +196,28 @@ class BaseVM(object):
     def qmp(self, *args, **kwargs):
         return self._guest.qmp(*args, **kwargs)
 
+    def start_http_server(self, workdir, ports=range(8010, 8020), sudo=False):
+        p = None
+        token = "%d-%d" % (os.getpid(), time.time())
+        with open(os.path.join(workdir, token), "w") as f:
+            f.write("# QEMU VM testing HTTP server token file #")
+            f.flush()
+        for port in ports:
+            cmd = ["python3", "-m", "http.server", str(port)]
+            if sudo:
+                cmd = ["sudo", "-n"] + cmd
+            p = subprocess.Popen(cmd, cwd=workdir)
+            for retry in range(5):
+                if p.poll() != None:
+                    break
+                if subprocess.call("curl http://127.0.0.1:%d/%s &>/dev/null" % \
+                        (port, token),
+                                   shell=True) == 0:
+                    atexit.register(p.terminate)
+                    return port
+                time.sleep(0.3)
+        raise IOError("Failed to start HTTP server")
+
 def parse_args(vm_name):
     parser = optparse.OptionParser(
         description="VM test utility.  Exit codes: "
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 52500ee52b..7e118572a9 100755
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
@@ -23,22 +26,80 @@ class OpenBSDVM(basevm.BaseVM):
         rm -rf /var/tmp/qemu-test.*
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
-        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
+        ./configure {configure_opts};
         gmake --output-sync -j{jobs} {verbose};
         # XXX: "gmake check" seems to always hang or fail
         #gmake --output-sync -j{jobs} check {verbose};
     """
 
+    def _install_os(self, img):
+        tmpdir = tempfile.mkdtemp()
+        pxeboot = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.3/amd64/pxeboot",
+                sha256sum="60029919798f48ea40ecb123adfed6217f099d5ed9cd1a6c7de5b544d7b7b0f6")
+        bsd_rd = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.3/amd64/bsd.rd",
+                sha256sum="1c0adb43a02ae3aee512bcf0829dac0ccb2e4d614b161049af7ce530e5da2dfc")
+        install = self._download_with_cache("https://fastly.cdn.openbsd.org/pub/OpenBSD/6.3/amd64/install63.iso",
+                sha256sum='ee775405dd7926975befbc3fef23de8c4b5a726c3b5075e4848fcd3a2a712ea8')
+        subprocess.check_call(["qemu-img", "create", img, "32G"])
+        subprocess.check_call(["cp", pxeboot, os.path.join(tmpdir, "auto_install")])
+        subprocess.check_call(["cp", bsd_rd, os.path.join(tmpdir, "bsd")])
+
+        self._gen_install_conf(tmpdir)
+        try:
+            self.start_http_server(tmpdir, ports=[80], sudo=True)
+        except Exception:
+            sys.stdout.write("Cannot open HTTP server on port 80. Maybe use sudo?\n")
+            sys.exit(1)
+        # BOOTP filename being auto_install makes sure OpenBSD installer
+        # not prompt for "auto install mode"
+        tftp_args = ",tftp=%s,bootfile=/auto_install" % tmpdir
+        self.boot(img,
+                  extra_args=["-boot", "once=n", "-no-reboot",
+                              "-cdrom", install],
+                  extra_usernet_args=tftp_args)
+        self.wait()
+
+    def _gen_install_conf(self, tmpdir):
+        contents = """
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
2.17.1
