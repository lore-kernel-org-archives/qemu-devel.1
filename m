Received: from eggs.gnu.org ([2001:4830:134:3::10]:57024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywje-0006qz-7I
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cywjd-0008T2-AB
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:37:42 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 14 Apr 2017 10:37:17 +0200
Message-Id: <20170414083717.13641-5-lvivier@redhat.com>
In-Reply-To: <20170414083717.13641-1-lvivier@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] qdev: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>, Antony Pavlov <antonynpavlov@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>

As all users have been removed, we can remove
cannot_destroy_with_object_finalize_yet field
from the DeviceClass structure.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/hw/qdev-core.h | 13 -------------
 qmp.c                  |  5 -----
 2 files changed, 18 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b476..ac682a6 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -113,19 +113,6 @@ typedef struct DeviceClass {
      * TODO remove once we're there
      */
     bool cannot_instantiate_with_device_add_yet;
-    /*
-     * Does this device model survive object_unref(object_new(TNAME))?
-     * All device models should, and this flag shouldn't exist.  Some
-     * devices crash in object_new(), some crash or hang in
-     * object_unref().  Makes introspecting properties with
-     * qmp_device_list_properties() dangerous.  Bad, because it's used
-     * by -device FOO,help.  This flag serves to protect that code.
-     * It should never be set without a comment explaining why it is
-     * set.
-     * TODO remove once we're there
-     */
-    bool cannot_destroy_with_object_finalize_yet;
-
     bool hotpluggable;
 
     /* callbacks */
diff --git a/qmp.c b/qmp.c
index a744e44..ab74cd7 100644
--- a/qmp.c
+++ b/qmp.c
@@ -548,11 +548,6 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    if (DEVICE_CLASS(klass)->cannot_destroy_with_object_finalize_yet) {
-        error_setg(errp, "Can't list properties of device '%s'", typename);
-        return NULL;
-    }
-
     obj = object_new(typename);
 
     object_property_iter_init(&iter, obj);
-- 
2.9.3
