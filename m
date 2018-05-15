Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIdja-0007A3-GP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIdjZ-000487-D8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:27:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIdjZ-00046Q-67
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:27:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 18:27:29 +0100
Message-Id: <20180515172729.24564-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] memfd: Avoid Coverity warning about integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Coverity complains about qemu_memfd_create() (CID 1385858) because
we calculate a bit position htsize which could be up to 63, but
then use it in "1 << htsize" which is a 32-bit integer calculation
and could push the 1 off the top of the value.

Silence the complaint bu using "1ULL"; this isn't a bug in
practice since a hugetlbsize of 4GB is not very plausible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/memfd.c b/util/memfd.c
index b3ecbac19e..d248a53c3c 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -66,7 +66,7 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
 {
     int htsize = hugetlbsize ? ctz64(hugetlbsize) : 0;
 
-    if (htsize && 1 << htsize != hugetlbsize) {
+    if (htsize && 1ULL << htsize != hugetlbsize) {
         error_setg(errp, "Hugepage size must be a power of 2");
         return -1;
     }
-- 
2.17.0
