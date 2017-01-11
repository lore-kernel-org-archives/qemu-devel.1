Received: from eggs.gnu.org ([2001:4830:134:3::10]:45513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgl-0003TO-Rw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgk-0003UM-SH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:20 +0100
Message-Id: <1484163327-111841-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/33] exec: Add missing rcu_read_unlock
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
1.8.3.1
