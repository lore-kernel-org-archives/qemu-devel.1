Received: from eggs.gnu.org ([209.51.188.92]:56673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMl-0003el-IS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMN-0003PG-Jx
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDMN-0002mF-4s
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD62EC05D3EE
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:52 +0100
Message-Id: <20190214093053.1400-18-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/18] qmp: Deprecate query-events in favor
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

query-events doesn't reflect compile-time configuration.  Instead of
fixing that, deprecate the command in favor of query-qmp-schema.

Libvirt prefers query-qmp-schema as of commit 22d7222ec0 "qemu: caps:
Don't call 'query-events' when we probe events from QMP schema".
It'll be in the next release.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c            | 5 +++++
 qapi/misc.json       | 7 +++++--
 qemu-deprecated.texi | 5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1673db7015..33ccbf3957 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1099,6 +1099,11 @@ CommandInfoList *qmp_query_commands(Error **errp)
=20
 EventInfoList *qmp_query_events(Error **errp)
 {
+    /*
+     * TODO This deprecated command is the only user of
+     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,
+     * they should go, too.
+     */
     EventInfoList *info, *ev_list =3D NULL;
     QAPIEvent e;
=20
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
index 80b0702ad5..fe1a914cae 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -99,6 +99,11 @@ Use ``device_add'' for hotplugging vCPUs instead of ``=
cpu-add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional
 details.
=20
+@subsection query-events (since 4.0)
+
+The ``query-events'' command has been superseded by the more powerful
+and accurate ``query-qmp-schema'' command.
+
 @section Human Monitor Protocol (HMP) commands
=20
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
--=20
2.17.2
