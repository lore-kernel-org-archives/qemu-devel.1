Received: from eggs.gnu.org ([2001:4830:134:3::10]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7pj-0000cf-V1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7pg-0003Fy-QB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:31:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7pg-0003Fd-FK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:31:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id 63-v6so15089575wra.11
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:31:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:30:57 +0200
Message-Id: <20181013003058.3349-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests/vm: Use subprocess.Popen() with to
 uncompress XZ files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Avoiding the file copy greatly speeds the process up.

Comparison with network file already cached, stopping after build_image():

Before:
  $ time make vm-build-freebsd
  real    1m38.153s
  user    1m16.871s
  sys     0m19.325s

After:
  $ time make vm-build-freebsd
  real    0m13.512s
  user    0m9.520s
  sys     0m3.685s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/centos  | 5 ++---
 tests/vm/freebsd | 9 ++-------
 tests/vm/netbsd  | 9 ++-------
 tests/vm/openbsd | 9 ++-------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index afd560c564..fa653c1650 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -63,9 +63,8 @@ class CentosVM(basevm.BaseVM):
 
     def build_image(self, img):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
-        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
+        with open(img, 'wb', 0644) as output:
+            subprocess.Popen(["xz", "--threads=0", "--decompress", "--force", "--to-stdout", cimg], stdout=output)
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
         self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
         self.wait_ssh()
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b6983127d0..7ec43a4c5c 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -31,13 +31,8 @@ class FreeBSDVM(basevm.BaseVM):
     def build_image(self, img):
         cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
                 sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
-        img_tmp_xz = img + ".tmp.xz"
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
-        os.rename(img_tmp, img)
+        with open(img, 'wb', 0644) as output:
+            subprocess.Popen(["xz", "--threads=0", "--decompress", "--force", "--to-stdout", cimg], stdout=output)
 
 if __name__ == "__main__":
     sys.exit(basevm.main(FreeBSDVM))
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index a4e25820d5..99023344b7 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,13 +31,8 @@ class NetBSDVM(basevm.BaseVM):
     def build_image(self, img):
         cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
                                          sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
-        img_tmp_xz = img + ".tmp.xz"
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
-        os.rename(img_tmp, img)
+        with open(img, 'wb', 0644) as output:
+            subprocess.Popen(["xz", "--threads=0", "--decompress", "--force", "--to-stdout", cimg], stdout=output)
 
 if __name__ == "__main__":
     sys.exit(basevm.main(NetBSDVM))
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 52500ee52b..57604bb43d 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -32,13 +32,8 @@ class OpenBSDVM(basevm.BaseVM):
     def build_image(self, img):
         cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
                 sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
-        img_tmp_xz = img + ".tmp.xz"
-        img_tmp = img + ".tmp"
-        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
-        if os.path.exists(img):
-            os.remove(img)
-        os.rename(img_tmp, img)
+        with open(img, 'wb', 0644) as output:
+            subprocess.Popen(["xz", "--threads=0", "--decompress", "--force", "--to-stdout", cimg], stdout=output)
 
 if __name__ == "__main__":
     sys.exit(basevm.main(OpenBSDVM))
-- 
2.19.1
