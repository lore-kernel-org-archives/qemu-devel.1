Received: from eggs.gnu.org ([209.51.188.92]:46144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzh9m-0007FM-0d
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzh9l-00009g-3I
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:20:49 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  1 Mar 2019 13:20:29 +0100
Message-Id: <1551442829-32359-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/qemu-iotests/235: Allow fallback to tcg
 and remove it from quick group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

iotest 235 currently only works with KVM - this is bad for systems where
it is not available, e.g. CI pipelines. The test also works when using
"tcg" as accelerator, so we can simply add that to the list of accelerators,
too. But still, there might be the case that someone compiled their
QEMU with --disable-tcg and still try to run the iotests in a CI pipeline
where KVM is not available - in that case it would be best to use the
"qtest" accelerator for this test. However, that currently hangs and I
did not succeed to get it working with "accel=qtest" yet. Thus, as long
as this is not fixed, it's likely better to remove this test from the
"quick" group so that it does not fail on CI pipelines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/235   | 2 +-
 tests/qemu-iotests/group | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d6edd97..90ef785 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,7 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
                 str(size))
 
 vm = QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'accel=kvm')
+vm.add_args('-machine', 'accel=kvm:tcg')
 if iotests.qemu_default_machine == 's390-ccw-virtio':
         vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=src,file=' + disk)
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b5ca63c..12ebeba 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -234,7 +234,7 @@
 232 auto quick
 233 auto quick
 234 auto quick migration
-235 auto quick
+235 auto
 236 auto quick
 237 rw auto quick
 238 auto quick
-- 
1.8.3.1
