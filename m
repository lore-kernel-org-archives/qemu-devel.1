Received: from eggs.gnu.org ([2001:4830:134:3::10]:49834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPW9-0002IH-E7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dkPW8-0007Yd-Nt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dkPW8-0007Y6-HA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:51:56 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 Aug 2017 14:51:09 +0800
Message-Id: <1503471071-2233-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 6/8] migration: qmp: migrate_incoming don't
 need BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Let "migrate-incoming" command be run without BQL.  Then even if any
thread hanged with BQL held, we can still run this command.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53..b55e73b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3259,7 +3259,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
+  'without-bql': 'true' }
 
 ##
 # @xen-save-devices-state:
-- 
2.7.4
