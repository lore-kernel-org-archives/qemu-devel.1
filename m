Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSV-0006fI-W5
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKSU-0000bo-UR
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:20:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 13 Apr 2019 17:20:36 +0200
Message-Id: <20190413152037.6817-2-mreitz@redhat.com>
In-Reply-To: <20190413152037.6817-1-mreitz@redhat.com>
References: <20190413152037.6817-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-next 1/2] iotests: Perform the correct test
 in 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

In the "amend" section of 082, we perform a single "convert" test
(namely "convert -o help").  That does not make sense, especially
because we have done exactly that "convert" test earlier in 082 already.

Replacing "convert" by "amend" yields an error, which is correct because
there is no point in "amend" having a default format.  The user has to
either specify the format, or give a file for qemu-img to probe.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/082     | 5 ++++-
 tests/qemu-iotests/082.out | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d0afa46e9a..278511dba4 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -212,7 +212,10 @@ run_qemu_img amend -f $IMGFMT -o backing_file=3D"$TE=
ST_IMG" -o ,, -o help "$TEST_I
=20
 # Leave out everything that isn't needed
 run_qemu_img amend -f $IMGFMT -o help
-run_qemu_img convert -o help
+
+# amend requires specifying either a format explicitly, or a file
+# which it can probe
+run_qemu_img amend -o help
=20
 # Try help option for a format that does not support amendment
 run_qemu_img amend -f bochs -o help
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d36938da9b..9a23b68511 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -831,9 +831,8 @@ Creation options for 'qcow2':
=20
 Note that not all of these options may be amendable.
=20
-Testing: convert -o help
-Supported options:
-  size=3D<size>            - Virtual disk size
+Testing: amend -o help
+qemu-img: Expecting one image file name
=20
 Testing: amend -f bochs -o help
 qemu-img: Format driver 'bochs' does not support option amendment
--=20
2.20.1
