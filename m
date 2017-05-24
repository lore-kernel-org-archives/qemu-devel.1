Received: from eggs.gnu.org ([2001:4830:134:3::10]:52191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafU-0003qu-Ii
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafT-0001LU-8L
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafS-0001LC-Np
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE5D180C12
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:53 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:22 -0400
Message-Id: <1495649128-10529-7-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a qmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Add a qmp command that can trigger guest announcements.

Based on work of Germano Veit Michel <germano@redhat.com>

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 migration/savevm.c | 14 ++++++++++++++
 qapi-schema.json   | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index a4097c9..b55ce6a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -265,6 +265,20 @@ void qemu_announce_self(AnnounceParameters *params)
     qemu_announce_self_once(timer);
 }
 
+void qmp_announce_self(bool has_params, AnnounceParameters *params,
+                       Error **errp)
+{
+    AnnounceParameters announce_params;
+
+    memcpy(&announce_params, qemu_get_announce_params(),
+           sizeof(announce_params));
+
+    if (has_params)
+        qemu_set_announce_parameters(&announce_params, params);
+
+    qemu_announce_self(&announce_params);
+}
+
 /***********************************************************/
 /* savevm/loadvm support */
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 2030087..126b09d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -654,6 +654,25 @@
   'returns': 'AnnounceParameters' }
 
 ##
+# @announce-self:
+#
+# Trigger generation of broadcast RARP frames to update network switches.
+# This can be useful when network bonds fail-over the active slave.
+#
+# Arguments: None.
+#
+# Example:
+#
+# -> { "execute": "announce-self"
+#      "arguments": { "announce-rounds": 5 } }
+# <- { "return": {} }
+#
+# Since: 2.10
+##
+{ 'command': 'announce-self',
+  'data' : {'*params': 'AnnounceParameters'} }
+
+##
 # @MigrationStats:
 #
 # Detailed migration status.
-- 
2.7.4
