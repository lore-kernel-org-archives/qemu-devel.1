Received: from eggs.gnu.org ([2001:4830:134:3::10]:46820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxeh-0001eL-79
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxeg-0005Qw-ID
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dIxeg-0005Qm-By
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65DF9796FE
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:39:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  8 Jun 2017 10:39:05 -0300
Message-Id: <20170608133906.12737-5-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] migration: Don't try to set *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Assigning directly to *errp is not valid, as errp may be NULL,
&error_fatal, or &error_abort.  Use error_propagate() instead.

Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 48c94c9ca1..5a8bef3ef5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1188,7 +1188,7 @@ bool migration_is_blocked(Error **errp)
     }
 
     if (migration_blockers) {
-        *errp = error_copy(migration_blockers->data);
+        error_propagate(errp, error_copy(migration_blockers->data));
         return true;
     }
 
-- 
2.11.0.259.g40922b1
