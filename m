Received: from eggs.gnu.org ([2001:4830:134:3::10]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp5-0006eA-Ox
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp3-0008LD-Bs
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRoy-0008EX-CU
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BBD77A7EA
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 12:01:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:33 +0200
Message-Id: <20180822120050.12694-4-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/20] docs/migration: Clarify pre_load in
 subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clarify that the pre_load function in a subsection is only called if
the subsection is found; to handle a missing subsection you may
set values in the pre_load of the parent vmsd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/migration.rst | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 6ed3fce061..687570754d 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -240,10 +240,13 @@ should succeed even with the data missing.  To support this the
 subsection can be connected to a device property and from there
 to a versioned machine type.
 
-One important note is that the post_load() function is called "after"
-loading all subsections, because a newer subsection could change same
-value that it uses.  A flag, and the combination of pre_load and post_load
-can be used to detect whether a subsection was loaded, and to
+The 'pre_load' and 'post_load' functions on subsections are only
+called if the subsection is loaded.
+
+One important note is that the outer post_load() function is called "after"
+loading all subsections, because a newer subsection could change the same
+value that it uses.  A flag, and the combination of outer pre_load and
+post_load can be used to detect whether a subsection was loaded, and to
 fall back on default behaviour when the subsection isn't present.
 
 Example:
@@ -315,8 +318,8 @@ For example:
       the property to false.
    c) Add a static bool  support_foo function that tests the property.
    d) Add a subsection with a .needed set to the support_foo function
-   e) (potentially) Add a pre_load that sets up a default value for 'foo'
-      to be used if the subsection isn't loaded.
+   e) (potentially) Add an outer pre_load that sets up a default value
+      for 'foo' to be used if the subsection isn't loaded.
 
 Now that subsection will not be generated when using an older
 machine type and the migration stream will be accepted by older
-- 
2.17.1
