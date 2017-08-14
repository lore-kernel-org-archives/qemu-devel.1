Received: from eggs.gnu.org ([2001:4830:134:3::10]:42926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNj-0001ur-Pu
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNj-0002Xt-42
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNi-0002Xa-Ty
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8781883D4
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:40 -0300
Message-Id: <20170814215748.5158-6-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 05/13] query-device-slots: Collapse similar
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

Use slot_list_collapse() on the final list returned by
query-device-slots.  This way we combine similar entries from
different buses.

For example, a machine with multiple IDE buses with no devices
would return a single entry like this:

  {
    "available":true,
    "count":10,
    "device-types":["ide-device"],
    "hotpluggable":false,
    "opts":[
      {"option":"unit","values":[[0,1]]},
      {"option":"bus","values":["ide.4","ide.3","ide.5","ide.0","ide.1"]}
    ],
    "opts-complete":true
  }

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qdev-monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 785f4af..edc6e34 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -673,7 +673,8 @@ DeviceSlotInfoList *qmp_query_device_slots(Error **errp)
     SlotListState s = { .next = &s.result };
 
     object_child_foreach_recursive(qdev_get_machine(), enumerate_bus, &s);
-    return s.result;
+
+    return slot_list_collapse(s.result);
 }
 
 
-- 
2.9.4
