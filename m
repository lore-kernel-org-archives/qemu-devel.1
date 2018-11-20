Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPEwk-00088u-5u
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 17:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPEt2-0002g0-5z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 17:52:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 20 Nov 2018 16:52:41 -0600
Message-Id: <20181120225241.2371769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Skip 233 if certtool not installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

The use of TLS while building qemu is optional. While the
'certtool' binary should be available on every platform that
supports building against TLS, that does not imply that the
developer has installed it.  Make the test gracefully skip
in that case.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

On Fedora, libvirt requires libtls-utils to be present, but not qemu.

I'm fine if Kevin wants to pick this up in a pull request related
to iotests in general; if not, I'll do a pull request through my
NBD tree in time for -rc3.

 tests/qemu-iotests/common.tls | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tls
index 39f17c1b999..eae81789bbc 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -31,6 +31,9 @@ tls_x509_cleanup()

 tls_x509_init()
 {
+    (certtool --help) >/dev/null 2>&1 || \
+	_notrun "certtool utility not found, skipping test"
+
     mkdir -p "${tls_dir}"

     # use a fixed key so we don't waste system entropy on
-- 
2.17.2
