Received: from eggs.gnu.org ([209.51.188.92]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXb6-0001Lj-Fm
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXb5-00006q-Kw
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:54:56 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:46 +0100
Message-Id: <20190129175403.18017-2-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/18] tests/vm: Be verbose while extracting
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Depending of the host hardware, copying and extracting VM images can
take up to few minutes. Add verbosity to avoid the user to worry about
VMs hanging.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/vm/centos  | 3 ++-
 tests/vm/freebsd | 3 ++-
 tests/vm/netbsd  | 3 ++-
 tests/vm/openbsd | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/vm/centos b/tests/vm/centos
index daa2dbca03..ba133ea429 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -65,8 +65,9 @@ class CentosVM(basevm.BaseVM):
     def build_image(self, img):
         cimg =3D self._download_with_cache("https://cloud.centos.org/cen=
tos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
         img_tmp =3D img + ".tmp"
+        sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
-        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
+        subprocess.check_call(["xz", "-dvf", img_tmp + ".xz"])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
         self.boot(img_tmp, extra_args =3D ["-cdrom", self._gen_cloud_ini=
t_iso()])
         self.wait_ssh()
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 19a3729172..2007c495a8 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -34,8 +34,9 @@ class FreeBSDVM(basevm.BaseVM):
                 sha256sum=3D'adcb771549b37bc63826c501f05121a206ed3d9f55f=
49145908f7e1432d65891')
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
+        sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index fac6a7ce51..93b267c292 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -34,8 +34,9 @@ class NetBSDVM(basevm.BaseVM):
                                          sha256sum=3D'b633d565b0eac3d020=
15cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
+        sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index cfe0572c59..2105c01a26 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -35,8 +35,9 @@ class OpenBSDVM(basevm.BaseVM):
                 sha256sum=3D'8c6cedc483e602cfee5e04f0406c64eb99138495e8c=
a580bc0293bcf0640c1bf')
         img_tmp_xz =3D img + ".tmp.xz"
         img_tmp =3D img + ".tmp"
+        sys.stderr.write("Extracting the image...\n")
         subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
-        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        subprocess.check_call(["xz", "-dvf", img_tmp_xz])
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
--=20
2.20.1
