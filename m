Received: from eggs.gnu.org ([2001:4830:134:3::10]:43005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cTMID-0000E3-Qw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cTMIA-0000nz-NK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:26:49 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gveitmic@redhat.com>) id 1cTMIA-0000na-Ik
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 00:26:46 -0500
Received: by mail-yw0-f181.google.com with SMTP id v200so6347244ywc.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 21:26:45 -0800 (PST)
MIME-Version: 1.0
From: Germano Veit Michel <germano@redhat.com>
Date: Tue, 17 Jan 2017 15:26:45 +1000
Message-ID: <CANHSq5CmdwQUFxXGRsyWUNs-_AN19zEhXwZtj6p807Cr3Us3ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH] migration: expose qemu_announce_self() via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com

qemu_announce_self() is triggered by qemu at the end of migrations
to update the network regarding the path to the guest l2addr.

however it is also useful when there is a network change such as
an active bond slave swap. Essentially, it's the same as a migration
from a network perspective - the guest moves to a different point
in the network topology.

this exposes the function via qmp.

Signed-off-by: Germano Veit Michel <germano@redhat.com>
---
 migration/savevm.c |  5 +++++
 qapi-schema.json   | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index f9c06e9..7a817dc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -143,6 +143,11 @@ void qemu_announce_self(void)
     qemu_announce_self_once(&timer);
 }

+void qmp_announce_self(Error **errp)
+{
+    qemu_announce_self();
+}
+
 /***********************************************************/
 /* savevm/loadvm support */

diff --git a/qapi-schema.json b/qapi-schema.json
index ce20f16..6854266 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4786,3 +4786,21 @@
 # Since: 2.7
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
+
+##
+# @announce-self:
+#
+# Trigger generation of broadcast RARP frames to update network switches.
+# This can be useful when network bonds fail-over the active slave.
+#
+# Arguments: None.
+#
+# Example:
+#
+# -> { "execute": "announce-self" }
+# <- { "return": {} }
+#
+# Since: 2.9
+##
+{ 'command': 'announce-self' }
+
-- 
2.9.3
