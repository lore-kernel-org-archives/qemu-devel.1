Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK16-0003dc-U4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0002jf-Ur
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK13-0002RK-Dr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC36089ADD
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:33 +0100
Message-Id: <20181218182234.28876-15-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 14/15] qmp: Deprecate query-events in
 favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

query-events doesn't reflect compile-time configuration.  Instead of
fixing that, deprecate the command in favor of query-qmp-schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c            | 5 +++++
 qapi/misc.json       | 7 +++++--
 qemu-deprecated.texi | 5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 967abebcaf..202989fe17 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1099,6 +1099,11 @@ CommandInfoList *qmp_query_commands(Error **errp)
 
 EventInfoList *qmp_query_events(Error **errp)
 {
+    /*
+     * TODO This deprecated command is the only user of
+     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,
+     * they should go, too.
+     */
     EventInfoList *info, *ev_list = NULL;
     QAPIEvent e;
 
diff --git a/qapi/misc.json b/qapi/misc.json
index c981008bac..91d5bf6a8a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -318,12 +318,15 @@
 ##
 # @query-events:
 #
-# Return a list of supported QMP events by this server
+# Return information on QMP events.
 #
-# Returns: A list of @EventInfo for all supported events
+# Returns: A list of @EventInfo.
 #
 # Since: 1.2.0
 #
+# Note: This command is deprecated, because its output doesn't reflect
+# compile-time configuration.  Use query-qmp-schema instead.
+#
 # Example:
 #
 # -> { "execute": "query-events" }
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index e362d37225..110dfd7a59 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -106,6 +106,11 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
 
+@subsection query-events
+
+The ``query-events'' command has been superseded by the more powerful
+and accurate ``query-qmp-schema'' command.
+
 @section System emulator human monitor commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
-- 
2.17.2
