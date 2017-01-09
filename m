Received: from eggs.gnu.org ([2001:4830:134:3::10]:56156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQXqi-0004p8-9N
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQXqd-0003YU-Hs
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:10:48 -0500
Received: from mail.sysgo.com ([176.9.12.79]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rka@sysgo.com>) id 1cQXqd-0003Vs-AS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:10:43 -0500
From: Roman Kapl <rka@sysgo.com>
Date: Mon,  9 Jan 2017 12:09:21 +0100
Message-Id: <20170109110921.4931-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH] exec: Add missing rcu_read_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kapl <rka@sysgo.com>

rcu_read_unlock was not called if the address_space_access_valid result is
negative.

This caused (at least) a problem when qemu on PPC/E500+TAP failed to terminate
properly and instead got stuck in a deadlock.

Signed-off-by: Roman Kapl <rka@sysgo.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 8d4bb0e..6895db5 100644
--- a/exec.c
+++ b/exec.c
@@ -2927,6 +2927,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
+                rcu_read_unlock();
                 return false;
             }
         }
-- 
2.10.1
