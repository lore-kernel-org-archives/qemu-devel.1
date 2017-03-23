Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cr2ne-00021E-Tp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cr2nY-0006V1-Uv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:29:10 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2918 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cr2nY-0006Tt-Jy
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:29:04 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu, 23 Mar 2017 16:28:59 +0300
Message-Id: <1490275739-14940-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [RFC 1/1] qcow2: add ZSTD compression feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

ZSDT compression algorithm consumes 3-5 times less CPU power with a
comparable comression ratio with zlib. It would be wise to use it for
data compression f.e. for backups.

The patch adds incompatible ZSDT feature into QCOW2 header that indicates
that compressed clusters must be decoded using ZSTD.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <famz@redhat.com>
---
Actually this is very straightforward. May be we should implement 2 stage
scheme, i.e. add bit that indicates presence of the "compression
extension", which will actually define the compression algorithm. Though
at my opinion we will not have too many compression algorithms and proposed
one tier scheme is good enough.

 docs/specs/qcow2.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
index 80cdfd0..eb5c41b 100644
--- a/docs/specs/qcow2.txt
+++ b/docs/specs/qcow2.txt
@@ -85,7 +85,10 @@ in the description of a field.
                                 be written to (unless for regaining
                                 consistency).
 
-                    Bits 2-63:  Reserved (set to 0)
+                    Bits 2:     ZSDT compression bit. ZSDT algorithm is used
+                                for cluster compression/decompression.
+
+                    Bits 3-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
-- 
2.7.4
