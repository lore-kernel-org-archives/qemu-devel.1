Received: from eggs.gnu.org ([2001:4830:134:3::10]:48542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxb-0001jK-V4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxb-0000hI-1K
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlxa-0000gx-Ra
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:33:28 +0100
Message-Id: <20170613133329.23653-9-stefanha@redhat.com>
In-Reply-To: <20170613133329.23653-1-stefanha@redhat.com>
References: <20170613133329.23653-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v7 8/9] qemu-iotests: support per-format golden
 output files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 tests/qemu-iotests/check | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4b1c674..29553cf 100755
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
