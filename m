Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fzHLi-0000Cx-7D
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fzHGa-00040m-UT
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:09:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 10 Sep 2018 10:09:39 +0200
Message-Id: <1536566979-6868-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/qdev-core: Fix description of instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

The part of the documentation of DeviceClass that talks about instance_init
is partly wrong: instance_init() functions must not abort or exit, since
the function is also called during introspection of the device already.
So if a device calls exit() during its instance_init() function, QEMU
terminates unexpectedly if somebody tries to just have a look at the
interfaces from the device with "device_add xyz,help" or with the
"device-list-properties" QOM command. This should never happen.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/qdev-core.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8..a24d0dd 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -51,8 +51,9 @@ struct VMStateDescription;
  * Devices are constructed in two stages,
  * 1) object instantiation via object_initialize() and
  * 2) device realization via #DeviceState:realized property.
- * The former may not fail (it might assert or exit), the latter may return
- * error information to the caller and must be re-entrant.
+ * The former may not fail (and must not abort or exit, since it is called
+ * during device introspection already), and the latter may return error
+ * information to the caller and must be re-entrant.
  * Trivial field initializations should go into #TypeInfo.instance_init.
  * Operations depending on @props static properties should go into @realize.
  * After successful realization, setting static properties will fail.
-- 
1.8.3.1
