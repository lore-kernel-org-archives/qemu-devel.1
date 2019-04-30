Received: from eggs.gnu.org ([209.51.188.92]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081W-GY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00024n-A6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:29 +0200
Message-Id: <20190430154244.30083-13-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/27] iotests: Perform the correct test in 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

In the "amend" section of 082, we perform a single "convert" test
(namely "convert -o help").  That does not make sense, especially
because we have done exactly that "convert" test earlier in 082 already.

Replacing "convert" by "amend" yields an error, which is correct because
there is no point in "amend" having a default format.  The user has to
either specify the format, or give a file for qemu-img to probe.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
