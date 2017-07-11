Received: from eggs.gnu.org ([2001:4830:134:3::10]:46850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxm7-0001vN-TX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxm6-00077v-SZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:57 +0200
Message-Id: <20170711160814.20941-69-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 68/85] qemu-iotests: support per-format golden
 output files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Some tests produce format-dependent output.  Either the difference is
filtered out and ignored, or the test case is format-specific so we
don't need to worry about per-format output differences.

There is a third case: the test script is the same for all image formats
and the format-dependent output is relevant.  An ugly workaround is to
copy-paste the test into multiple per-format test cases.  This
duplicates code and is not maintainable.

This patch allows test cases to add per-format golden output files so a
single test case can work correctly when format-dependent output must be
checked:

  123.out.qcow2
  123.out.raw
  123.out.vmdk
  ...

This naming scheme is not composable with 123.out.nocache or 123.pc.out,
two other scenarios where output files are split.  I don't think it
matters since few test cases need these features.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170705125738.8777-9-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 9ded37c..2a55ec9 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -338,6 +338,11 @@ do
                 reference="$reference_machine"
             fi
 
+            reference_format="$source_iotests/$seq.out.$IMGFMT"
+            if [ -f "$reference_format" ]; then
+                reference="$reference_format"
+            fi
+
             if [ "$CACHEMODE" = "none" ]; then
                 [ -f "$source_iotests/$seq.out.nocache" ] && reference="$source_iotests/$seq.out.nocache"
             fi
-- 
2.9.4
