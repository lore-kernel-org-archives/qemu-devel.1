Received: from eggs.gnu.org ([209.51.188.92]:34632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXbx-00029E-OK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXbw-0000gI-2E
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:55:49 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:48 +0100
Message-Id: <20190129175403.18017-4-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/18] tests/vm/openbsd: Disable the W^X
 protection on the build partition
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

Since OpenBSD 6.0 [1], W^X is enforced by default [2].
TCG requires WX access, and QEMU binaries are now built with the WX
flag to disable the protection. However, WX allowed binaries need
to be run on a WX allowed partition.
To be able to run the QEMU test suite on the VM, mount the partition
where QEMU is built/tested as WX allowed.

[1] https://www.openbsd.org/faq/upgrade60.html
[2] https://undeadly.org/cgi?action=3Darticle&sid=3D20160527203200

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/vm/openbsd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2105c01a26..6263c8956b 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -41,6 +41,12 @@ class OpenBSDVM(basevm.BaseVM):
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
+        self.boot(img)
+        self.wait_ssh()
+        sys.stderr.write("Disabling W^X on the build partition...\n")
+        self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1 \\2,=
wxallowed_' /etc/fstab")
+        self.ssh_root("shutdown -p now")
+        self.wait()
=20
 if __name__ =3D=3D "__main__":
     sys.exit(basevm.main(OpenBSDVM))
--=20
2.20.1
