Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2Q3i-0006JO-2j
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2Q3h-0005Bb-0Y
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d2Q3g-0005BU-Qs
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:32:44 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 24 Apr 2017 00:32:40 +0200
Message-Id: <20170423223240.17917-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

s390_virtio_hypercall can trigger IO events and interrupts, most notably
when using virtio-ccw devices.

Reviewed-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/misc_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 4946b56ab3..aec737d707 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -307,7 +307,9 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     switch (num) {
     case 0x500:
         /* KVM hypercall */
+        qemu_mutex_lock_iothread();
         r = s390_virtio_hypercall(env);
+        qemu_mutex_unlock_iothread();
         break;
     case 0x44:
         /* yield */
-- 
2.11.0
