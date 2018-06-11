Received: from eggs.gnu.org ([2001:4830:134:3::10]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmJ-0004S3-BJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmI-0001j4-Ax
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:52 +0200
Message-Id: <20180611142611.6609-11-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 10/29] iotests: Rework 113
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This test case has been broken since 398e6ad014df261d (roughly half a
year).  qemu-img amend requires its output image to be R/W, so it opens
it as such; the node is then turned into an read-only node automatically
which is now accompanied by a warning, however.  This warning has not
been part of the reference output.

For one thing, this warning shows that we cannot keep the test case as
it is.  We would need a format that has no create_opts but that does
have write support -- we do not have such a format, though.

Another thing is that qemu now actually checks whether an image format
supports amendment instead of whether it has create_opts (since the
former always implies the latter).  So we can now use any format that
does not support amendment (even if it supports creation) and thus test
the same code path.

The reason nobody has noticed the breakage until now of course is the
fact that nobody runs the iotests for nbd+bochs.  There actually was
never any reason to set the protocol to "nbd" but because that was
technically correct; functionally it made no difference.  So that is the
first thing we are going to change: Make the protocol "file" instead so
that people might actually notice breakage here.

Secondly, now that bochs no longer works for the amend test case, we
have to change the format there anyway.  Set let us just bend the truth
a bit, declare this test a raw test.  In fact, that does not even
concern the bochs test cases, other than the output now reading 'bochs'
instead of 'IMGFMT'.

So with this test now being a raw test, we can rework the amend test
case to use raw instead.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180509210023.20283-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/113     | 19 +++++++++----------
 tests/qemu-iotests/113.out |  7 ++++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 19b68b2727..4e09810905 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -38,16 +38,17 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-# We can only test one format here because we need its sample file
-_supported_fmt bochs
-_supported_proto nbd
+# Some of these test cases use bochs, but others do use raw, so this
+# is only half a lie.
+_supported_fmt raw
+_supported_proto file
 _supported_os Linux
 
 echo
 echo '=== Unsupported image creation in qemu-img create ==='
 echo
 
-$QEMU_IMG create -f $IMGFMT nbd://example.com 2>&1 64M | _filter_imgfmt
+$QEMU_IMG create -f bochs nbd://example.com 2>&1 64M
 
 echo
 echo '=== Unsupported image creation in qemu-img convert ==='
@@ -56,17 +57,15 @@ echo
 # We could use any input image format here, but this is a bochs test, so just
 # use the bochs image
 _use_sample_img empty.bochs.bz2
-$QEMU_IMG convert -f $IMGFMT -O $IMGFMT "$TEST_IMG" nbd://example.com 2>&1 \
-    | _filter_imgfmt
+$QEMU_IMG convert -f bochs -O bochs "$TEST_IMG" nbd://example.com
 
 echo
 echo '=== Unsupported format in qemu-img amend ==='
 echo
 
-# The protocol does not matter here
-_use_sample_img empty.bochs.bz2
-$QEMU_IMG amend -f $IMGFMT -o foo=bar "$TEST_IMG" 2>&1 | _filter_imgfmt
-
+TEST_IMG="$TEST_DIR/t.$IMGFMT"
+_make_test_img 1M
+$QEMU_IMG amend -f $IMGFMT -o size=2M "$TEST_IMG" 2>&1 | _filter_imgfmt
 
 # success, all done
 echo
diff --git a/tests/qemu-iotests/113.out b/tests/qemu-iotests/113.out
index 00bdfd6887..3557e2bbf0 100644
--- a/tests/qemu-iotests/113.out
+++ b/tests/qemu-iotests/113.out
@@ -2,14 +2,15 @@ QA output created by 113
 
 === Unsupported image creation in qemu-img create ===
 
-qemu-img: nbd://example.com: Format driver 'IMGFMT' does not support image creation
+qemu-img: nbd://example.com: Format driver 'bochs' does not support image creation
 
 === Unsupported image creation in qemu-img convert ===
 
-qemu-img: Format driver 'IMGFMT' does not support image creation
+qemu-img: Format driver 'bochs' does not support image creation
 
 === Unsupported format in qemu-img amend ===
 
-qemu-img: Format driver 'IMGFMT' does not support any options to amend
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+qemu-img: Format driver 'IMGFMT' does not support option amendment
 
 *** done
-- 
2.17.1
