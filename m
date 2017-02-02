Received: from eggs.gnu.org ([2001:4830:134:3::10]:55602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJn2-0001YN-2c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJn0-00032m-3s
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZJmz-00032O-U5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:14 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  2 Feb 2017 15:59:08 +0000
Message-Id: <20170202155909.31784-2-dgilbert@redhat.com>
In-Reply-To: <20170202155909.31784-1-dgilbert@redhat.com>
References: <20170202155909.31784-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] Postcopy: Reset state to avoid cleanup
 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: zhang.zhanghailiang@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On a destination host with no userfault support an incoming
postcopy would cause the state to enter ADVISE before
it realised there was no support, and because it was in ADVISE
state it would perform a cleanup at the end.  Since there
was no support the cleanup function should be unreachable,
but ends up being called and asserting.

Reset the state when we realise we have no support, thus the
cleanup doesn't happen.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index e8e5ff5..de86db0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1355,6 +1355,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
     }
 
     if (!postcopy_ram_supported_by_host()) {
+        postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
 
-- 
2.9.3
