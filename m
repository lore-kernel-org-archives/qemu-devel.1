Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fn0QK-0005jd-8O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 07:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fn0QJ-0002FJ-G0
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 07:45:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fn0QJ-0002F6-8I
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 07:45:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Aug 2018 12:45:01 +0100
Message-Id: <20180807114501.12370-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, liqsub1 <liqsub1@163.com>

The data in an mbuf buffer is not necessarily at the start of the
allocated buffer. (For instance m_adj() allows data to be trimmed
from the start by just advancing the pointer and reducing the length.)
This means that the allocated buffer size (m->m_size) and the
amount of space from the m_data pointer to the end of the
buffer (M_ROOM(m)) are not necessarily the same.

Commit 864036e251f54c9 tried to change the m_inc() function from
taking the new allocated-buffer-size to taking the new room-size,
but forgot to change the initial "do we already have enough space"
check. This meant that if we were trying to extend a buffer which
had a leading gap between the buffer start and the data, we might
incorrectly decide it didn't need to be extended, and then
overrun the end of the buffer, causing memory corruption and
an eventual crash.

Change the "already big enough?" condition from checking the
argument against m->m_size to checking against M_ROOM().
This only makes a difference for the callsite in m_cat();
the other three callsites all start with a freshly allocated
mbuf from m_get(), which will have m->m_size == M_ROOM(m).

Fixes: 864036e251f54c9
Fixes: https://bugs.launchpad.net/qemu/+bug/1785670
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/mbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 0c189e1a7bf..1b7868355a3 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -154,7 +154,7 @@ m_inc(struct mbuf *m, int size)
     int datasize;
 
     /* some compilers throw up on gotos.  This one we can fake. */
-    if (m->m_size > size) {
+    if (M_ROOM(m) > size) {
         return;
     }
 
-- 
2.17.1
