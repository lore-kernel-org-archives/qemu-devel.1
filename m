Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2K4Z-0007aL-LL
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 12:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2K4Y-0002fh-KJ
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 12:09:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d2K4Y-0002eR-EB
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 12:09:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 23 Apr 2017 18:08:53 +0200
Message-Id: <20170423160854.3478-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH] s390x/misc_helper.c: wrap
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
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

s390_virtio_hypercall can trigger IO events and interrupts, most notably
when using virtio-ccw devices.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 roms/qemu-palcode          | 2 +-
 roms/seabios               | 2 +-
 target/s390x/misc_helper.c | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/roms/qemu-palcode b/roms/qemu-palcode
index f3c7e44c70..c87a92639b 160000
--- a/roms/qemu-palcode
+++ b/roms/qemu-palcode
@@ -1 +1 @@
-Subproject commit f3c7e44c70254975df2a00af39701eafbac4d471
+Subproject commit c87a92639b28ac42bc8f6c67443543b405dc479b
diff --git a/roms/seabios b/roms/seabios
index 5f4c7b13cd..e2fc41e24e 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
+Subproject commit e2fc41e24ee0ada60fc511d60b15a41b294538be
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
