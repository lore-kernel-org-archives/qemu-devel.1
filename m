Received: from eggs.gnu.org ([209.51.188.92]:46459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlx-00051u-Ka
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grRlr-0002BK-ML
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grRlr-0001r5-Df
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:18:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B295C058CB0
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:17:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  6 Feb 2019 19:17:24 +0100
Message-Id: <20190206181725.14337-17-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-1-armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 16/17] qmp: Deprecate query-events in favor
 of query-qmp-schema
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
index eeec289aae..9f27621ed1 100644
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
index 82f9147353..98f59f828a 100644
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
index 9cc20b365c..3288e102d6 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -103,6 +103,11 @@ Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional
 details.
 
+@subsection query-events (since 4.0)
+
+The ``query-events'' command has been superseded by the more powerful
+and accurate ``query-qmp-schema'' command.
+
 @section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
-- 
2.17.2
