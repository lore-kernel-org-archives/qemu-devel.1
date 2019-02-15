Received: from eggs.gnu.org ([209.51.188.92]:41165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gubGX-0007tt-Pu
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gub33-0002Ei-St
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gub33-00028H-JM
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFF7F3656D1
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:48:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Feb 2019 10:47:45 +0000
Message-Id: <20190215104747.16770-8-dgilbert@redhat.com>
In-Reply-To: <20190215104747.16770-1-dgilbert@redhat.com>
References: <20190215104747.16770-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 7/9] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com
Cc: mst@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a qmp command that can trigger guest announcements.

It uses its own announce-timer instance, and parameters
passed to it explicitly in the command.

Like most qmp commands, it's in the main thread/bql, so
there's no racing with any outstanding timer.

Based on work of Germano Veit Michel <germano@redhat.com> and
                 Vladislav Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/announce.c |  7 +++++++
 qapi/net.json  | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/announce.c b/net/announce.c
index 070f37a7fa..91e9a6e267 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -12,6 +12,7 @@
 #include "net/net.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-net.h"
+#include "qapi/qapi-commands-net.h"
 #include "trace.h"
=20
 int64_t qemu_announce_timer_step(AnnounceTimer *timer)
@@ -131,3 +132,9 @@ void qemu_announce_self(AnnounceTimer *timer, Announc=
eParameters *params)
         qemu_announce_timer_del(timer);
     }
 }
+
+void qmp_announce_self(AnnounceParameters *params, Error **errp)
+{
+    static AnnounceTimer announce_timer;
+    qemu_announce_self(&announce_timer, params);
+}
diff --git a/qapi/net.json b/qapi/net.json
index 5face0c14b..c093087278 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -707,3 +707,23 @@
             'max': 'int',
             'rounds': 'int',
             'step': 'int' } }
+
+##
+# @announce-self:
+#
+# Trigger generation of broadcast RARP frames to update network switches=
.
+# This can be useful when network bonds fail-over the active slave.
+#
+# @params: AnnounceParameters giving timing and repetition count of anno=
unce
+#
+# Example:
+#
+# -> { "execute": "announce-self"
+#      "arguments": { "params:" {
+#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } } }
+# <- { "return": {} }
+#
+# Since: 4.0
+##
+{ 'command': 'announce-self',
+  'data' : {'params': 'AnnounceParameters'} }
--=20
2.20.1
