Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8r-0003Cq-TB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8q-0004x5-Un
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8q-0004wL-P7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A73A54E35B
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:43 +0800
Message-Id: <1497876588-947-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/13] trace: add qdev_global_prop_apply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Trace global property applying. Now there are machine compat properties,
accel compat properties, and user specified global properties. It
provides a way to trace those properties that really applied.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Makefile.objs             | 1 +
 hw/core/qdev-properties.c | 2 ++
 hw/core/trace-events      | 2 ++
 3 files changed, 5 insertions(+)
 create mode 100644 hw/core/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 0575802..e199f5d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -121,6 +121,7 @@ trace-events-subdirs += migration
 trace-events-subdirs += block
 trace-events-subdirs += backends
 trace-events-subdirs += chardev
+trace-events-subdirs += hw/core
 trace-events-subdirs += hw/block
 trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e9efb78..69c3f15 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char.h"
+#include "trace.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -1150,6 +1151,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
         if (strcmp(typename, prop->driver) != 0) {
             continue;
         }
+        trace_qdev_global_prop_apply(typename, prop->property, prop->value);
         prop->used = true;
         object_property_parse(OBJECT(dev), prop->value, prop->property, &err);
         if (err != NULL) {
diff --git a/hw/core/trace-events b/hw/core/trace-events
new file mode 100644
index 0000000..0a0a79f
--- /dev/null
+++ b/hw/core/trace-events
@@ -0,0 +1,2 @@
+# hw/core/qdev-properties.c
+qdev_global_prop_apply(const char *type, const char *prop, const char *value) "type '%s' prop '%s' value '%s'"
-- 
2.7.4
