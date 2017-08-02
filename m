Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dcr6X-0007bg-8k
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dcr6U-0003ee-0F
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:42:17 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed,  2 Aug 2017 12:32:59 +0200
Message-Id: <20170802103259.25940-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

With pseries machine type a negative core-id is not managed properly:
-1 gives an inaccurate error message ("core -1 already populated"),
-2 crashes QEMU (core dump)

As it seems a negative value is invalid for any architecture,
instead of checking this in spapr_core_pre_plug() I think it's better
to check this in the generic part, core_prop_set_core_id()

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/cpu/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 2bf960d..bd578ab 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -33,6 +33,11 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (value < 0) {
+        error_setg(errp, "Invalid core id %"PRId64, value);
+        return;
+    }
+
     core->core_id = value;
 }
 
-- 
2.9.4
