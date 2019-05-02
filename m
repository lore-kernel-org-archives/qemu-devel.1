Received: from eggs.gnu.org ([209.51.188.92]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7MB-0004XR-Gy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7M7-0003kv-OO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:18 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 10:45:00 +0200
Message-Id: <20190502084506.8009-2-thuth@redhat.com>
In-Reply-To: <20190502084506.8009-1-thuth@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/7] tests/qemu-iotests/005: Add a sanity
 check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

"check -raw 005" fails when running on certain filesystems - these do not
support such large sparse files. Use the same check as in test 220 to
skip the test in this case.

Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/005 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 2fef63af88..9c7681c19b 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
     _notrun "image protocol $IMGPROTO does not support large image sizes=
"
 fi
=20
+# Sanity check: For raw, we require a file system that permits the creat=
ion
+# of a HUGE (but very sparse) file. Check we can create it before contin=
uing.
+if [ "$IMGFMT" =3D "raw" ]; then
+    if ! truncate --size=3D5T "$TEST_IMG"; then
+        _notrun "file system on $TEST_DIR does not support large enough =
files"
+    fi
+    rm "$TEST_IMG"
+fi
+
 echo
 echo "creating large image"
 _make_test_img 5000G
--=20
2.21.0
