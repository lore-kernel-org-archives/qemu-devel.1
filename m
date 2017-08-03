Received: from eggs.gnu.org ([2001:4830:134:3::10]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddKPU-0000Vf-08
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddKPT-0004yd-2t
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:59:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  3 Aug 2017 14:59:37 -0300
Message-Id: <20170803175937.22225-2-ehabkost@redhat.com>
In-Reply-To: <20170803175937.22225-1-ehabkost@redhat.com>
References: <20170803175937.22225-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org

From: Laurent Vivier <lvivier@redhat.com>

With pseries machine type a negative core-id is not managed properly:
-1 gives an inaccurate error message ("core -1 already populated"),
-2 crashes QEMU (core dump)

As it seems a negative value is invalid for any architecture,
instead of checking this in spapr_core_pre_plug() I think it's better
to check this in the generic part, core_prop_set_core_id()

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170802103259.25940-1-lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
