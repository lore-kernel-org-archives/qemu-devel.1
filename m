Received: from eggs.gnu.org ([2001:4830:134:3::10]:60902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6Zq-0008QB-6J
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6Zm-0006Md-Vl
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:10:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ef6Zm-0006Ly-R1
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E5CBC068382
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 16:04:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:05 -0600
Message-Id: <20180126160411.4033-3-eblake@redhat.com>
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] hmp: Add name parameter to nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Extend the flexibility of the previous QMP patch to also work
in HMP.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180109192802.17167-1-eblake@redhat.com>
---
 hmp.c           | 3 ++-
 hmp-commands.hx | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hmp.c b/hmp.c
index 5bcfc36de10..7a64dd59c5c 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2221,10 +2221,11 @@ exit:
 void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
+    const char *name = qdict_get_try_str(qdict, "name");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;

-    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
+    qmp_nbd_server_add(device, !!name, name, true, writable, &local_err);

     if (local_err != NULL) {
         hmp_handle_error(mon, &local_err);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 6d5ebdf6ab1..b8b6fb91848 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1553,17 +1553,18 @@ ETEXI

     {
         .name       = "nbd_server_add",
-        .args_type  = "writable:-w,device:B",
-        .params     = "nbd_server_add [-w] device",
+        .args_type  = "writable:-w,device:B,name:s?",
+        .params     = "nbd_server_add [-w] device [name]",
         .help       = "export a block device via NBD",
         .cmd        = hmp_nbd_server_add,
     },
 STEXI
-@item nbd_server_add @var{device}
+@item nbd_server_add @var{device} [ @var{name} ]
 @findex nbd_server_add
 Export a block device through QEMU's NBD server, which must be started
 beforehand with @command{nbd_server_start}.  The @option{-w} option makes the
-exported device writable too.
+exported device writable too.  The export name is controlled by @var{name},
+defaulting to @var{device}.
 ETEXI

     {
-- 
2.14.3
