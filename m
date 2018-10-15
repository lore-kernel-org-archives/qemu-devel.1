Received: from eggs.gnu.org ([2001:4830:134:3::10]:40934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC95R-0004ui-SK
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC95R-0001xf-1U
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:03:33 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Mon, 15 Oct 2018 16:03:19 -0400
Message-Id: <20181015200319.23076-1-crosa@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] iotests: make 083 specific to raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

While testing the Python 3 changes which touch the 083 test, I noticed
that it would fail with qcow2.  Expanding the testing, I noticed it
had nothing to do with the Python 3 changes, and in fact, it would not
pass on anything but raw:

 raw: pass
 bochs: not generic
 cloop: not generic
 parallels: fail
 qcow: fail
 qcow2: fail
 qed: fail
 vdi: fail
 vhdx: fail
 vmdk: fail
 vpc: fail
 luks: fail

The errors are a mixture I/O and "image not in xxx format", such as:

  === Check disconnect before data ===

  Unexpected end-of-file before all bytes were read
 -read failed: Input/output error
 +can't open device nbd+tcp://127.0.0.1:PORT/foo: Could not open 'nbd://127.0.0.1:PORT/foo': Input/output error

  === Check disconnect after data ===

 -read 512/512 bytes at offset 0
 -512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 +can't open device nbd+tcp://127.0.0.1:PORT/foo: Image not in qcow format

I'm not aware if there's a quick fix, so, for the time being, it looks
like the honest approach is to make the test known to work on raw
only.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/083 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 3c1adbf0fb..9f92317b0a 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt generic
+_supported_fmt raw
 _supported_proto nbd
 _supported_os Linux
 
-- 
2.17.1
