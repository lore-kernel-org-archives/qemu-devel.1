Received: from eggs.gnu.org ([2001:4830:134:3::10]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIY-0004AF-9B
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIX-0006QQ-DD
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:10 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:29 +0100
Message-Id: <20170120133139.31080-26-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/35] exec: Add missing rcu_read_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kapl <rka@sysgo.com>, qemu-stable@nongnu.org

From: Roman Kapl <rka@sysgo.com>

rcu_read_unlock was not called if the address_space_access_valid result is
negative.

This caused (at least) a problem when qemu on PPC/E500+TAP failed to terminate
properly and instead got stuck in a deadlock.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Message-Id: <20170109110921.4931-1-rka@sysgo.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 47835c1..c95ae33 100644
--- a/exec.c
+++ b/exec.c
@@ -2960,6 +2960,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
+                rcu_read_unlock();
                 return false;
             }
         }
-- 
2.9.3
