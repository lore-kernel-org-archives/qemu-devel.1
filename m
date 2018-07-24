Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29N-0008WH-Ad
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29M-0002qB-IC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29M-0002py-DC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:08 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:53 +0100
Message-Id: <20180724183454.120276-7-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] tests: only update last_byte when at the
 edge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: Peter Xu <peterx@redhat.com>

The only possible change of last_byte is when it reaches the edge.
Setting it every time might let last_byte contain an invalid data when
memory corruption is detected, then the check of the next byte will be
incorrect.  For example, a single page corruption at address 0x14ad000
will also lead to a "fake" corruption at 0x14ae000:

  Memory content inconsistency at 14ad000 first_byte = 44 last_byte = 44 current = ef hit_edge = 0
  Memory content inconsistency at 14ae000 first_byte = 44 last_byte = ef current = 44 hit_edge = 0

After the patch, it'll only report the corrputed page:

  Memory content inconsistency at 14ad000 first_byte = 44 last_byte = 44 current = ef hit_edge = 0

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180723123305.24792-4-peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 086f727b34..e079e0bdb6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -300,6 +300,7 @@ static void check_guests_ram(QTestState *who)
                  * to us yet.
                  */
                 hit_edge = true;
+                last_byte = b;
             } else {
                 fprintf(stderr, "Memory content inconsistency at %x"
                                 " first_byte = %x last_byte = %x current = %x"
@@ -308,7 +309,6 @@ static void check_guests_ram(QTestState *who)
                 bad = true;
             }
         }
-        last_byte = b;
     }
     g_assert_false(bad);
 }
-- 
2.17.1
