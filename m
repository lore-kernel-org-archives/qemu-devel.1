Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csYv8-0001M0-SP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csYv7-00050O-L9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:59:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1csYv7-0004wz-Du
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:59:09 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 18:59:04 +0100
Message-Id: <1490637544-15650-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9] tests/virtio-9p-test: Don't call
 le*_to_cpus on fields of packed struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

For a packed struct like 'P9Hdr' the fields within it may not be
aligned as much as the natural alignment for their types.  This means
it is not valid to pass the address of such a field to a function
like le32_to_cpus() which operate on uint32_t* and assume alignment.
Doing this results in a SIGBUS on hosts like SPARC which have strict
alignment requirements.

Use ldl_le_p() instead, which is specified to correctly handle
unaligned pointers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Sadly gcc doesn't warn about this:
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51628
clang supposedly was fixed to do so:
 https://bugs.llvm.org//show_bug.cgi?id=22821
but I think that commit was reverted without the bug being
reopened; at least my clang doesn't have that warning flag.
---
 tests/virtio-9p-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 43a1ad8..ad33d96 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -256,8 +256,8 @@ static void v9fs_req_recv(P9Req *req, uint8_t id)
         qvirtio_wait_queue_isr(v9p->dev, v9p->vq, 1000 * 1000);
 
         v9fs_memread(req, &hdr, 7);
-        le32_to_cpus(&hdr.size);
-        le16_to_cpus(&hdr.tag);
+        hdr.size = ldl_le_p(&hdr.size);
+        hdr.tag = lduw_le_p(&hdr.tag);
         if (hdr.size >= 7) {
             break;
         }
-- 
2.7.4
