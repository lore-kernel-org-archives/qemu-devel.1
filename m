Received: from eggs.gnu.org ([209.51.188.92]:48516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzcrD-0006W5-ER
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzcrB-0001HN-O3
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:45:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:17678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gzcrA-0001GL-Ke
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:45:20 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri,  1 Mar 2019 15:44:48 +0800
Message-Id: <20190301074448.8926-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qom: remove type_initialize() in
 object_new_with_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: afaerber@suse.de, Wei Yang <richardw.yang@linux.intel.com>

Here is the abstraction of current call flow of object_new_with_type()

    object_initialize_with_type
        type_initialize
	object_initialize_with_type
	    type_initialize

This is not necessary to spread type_initialize in two places.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 qom/object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index b8c732063b..6252cca418 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -585,7 +585,6 @@ static Object *object_new_with_type(Type type)
     Object *obj;
 
     g_assert(type != NULL);
-    type_initialize(type);
 
     obj = g_malloc(type->instance_size);
     object_initialize_with_type(obj, type->instance_size, type);
-- 
2.19.1
