Received: from eggs.gnu.org ([2001:4830:134:3::10]:44750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnM-0000jc-FW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnK-0005RV-Hq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnK-0005RC-DC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7781B80461
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:25 +0000
Message-Id: <20170124095332.23955-2-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/8] ui: fix regression handling bare
 'websocket' option to -vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -vnc argument is documented as accepting two syntaxes for
the 'websocket' option, either a bare option name, or a port
number. If using the bare option name, it is supposed to apply
the display number as an offset to base port 5700. e.g.

  -vnc localhost:3,websocket

should listen on port 5703, however, this was broken in 2.3.0 since

  commit 4db14629c38611061fc19ec6927405923de84f08
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Tue Sep 16 12:33:03 2014 +0200

    vnc: switch to QemuOpts, allow multiple servers

instead qemu tries to listen on port "on" which gets looked up in
/etc/services and fails.

Fixes bug: #1455912

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 29aa9c4..c82e476 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3586,7 +3586,13 @@ void vnc_display_open(const char *id, Error **errp)
                 wsaddr->type = SOCKET_ADDRESS_KIND_INET;
                 inet = wsaddr->u.inet.data = g_new0(InetSocketAddress, 1);
                 inet->host = g_strdup(saddr->u.inet.data->host);
-                inet->port = g_strdup(websocket);
+                if (g_str_equal(websocket, "") ||
+                    g_str_equal(websocket, "on")) {
+                    inet->port = g_strdup_printf(
+                        "%d", (int)baseport + 5700);
+                } else {
+                    inet->port = g_strdup(websocket);
+                }
 
                 if (to) {
                     inet->has_to = true;
-- 
2.9.3
