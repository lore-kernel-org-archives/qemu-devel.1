Received: from eggs.gnu.org ([2001:4830:134:3::10]:48296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIr-0005F2-Bu
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIm-0004RO-Ko
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d1RIm-0004R2-EQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 417F865CFF
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 05:40:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Apr 2017 07:40:13 +0200
Message-Id: <1492753213-26516-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1492753213-26516-1-git-send-email-armbru@redhat.com>
References: <1492753213-26516-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] qdev: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

As all users have been removed, we can remove
cannot_destroy_with_object_finalize_yet field
from the DeviceClass structure.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170414083717.13641-5-lvivier@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
