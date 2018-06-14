Received: from eggs.gnu.org ([2001:4830:134:3::10]:53533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXi1-0001g5-6k
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTXhw-0001br-G0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:15:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 21:14:31 +0200
Message-Id: <20180614191443.14361-7-armbru@redhat.com>
In-Reply-To: <20180614191443.14361-1-armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/18] block: Fix -drive for certain
 non-string scalars
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

The previous commit fixed -blockdev breakage due to misuse of the
qobject input visitor's keyval flavor in bdrv_file_open().  The commit
message explain why using the plain flavor would be just as wrong; it
would break -drive.  Turns out we break it in three places:
nbd_open(), sd_open() and ssh_file_open().  They are even marked
FIXME.  Example breakage:

    $ qemu-system-x86 -drive node-name=n1,driver=nbd,server.type=inet,server.host=localhost,server.port=1234,server.numeric=off
    qemu-system-x86: -drive node-name=n1,driver=nbd,server.type=inet,server.host=localhost,server.port=1234,server.numeric=off: Invalid parameter type for 'numeric', expected: boolean

Fix it the same way: replace qdict_crumple() by
qdict_crumple_for_keyval_qiv(), and switch from plain to the keyval
flavor.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd.c      | 12 ++----------
 block/sheepdog.c | 12 ++----------
 block/ssh.c      | 12 ++----------
 3 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d6c4c4ddbc..614dd9fec0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -273,20 +273,12 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
         goto done;
     }
 
-    crumpled_addr = qdict_crumple(addr, errp);
+    crumpled_addr = qdict_crumple_for_keyval_qiv(addr, errp);
     if (!crumpled_addr) {
         goto done;
     }
 
-    /*
-     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
-     * server.type=inet.  .to doesn't matter, it's ignored anyway.
-     * That's because when @options come from -blockdev or
-     * blockdev_add, members are typed according to the QAPI schema,
-     * but when they come from -drive, they're all QString.  The
-     * visitor expects the former.
-     */
-    iv = qobject_input_visitor_new(crumpled_addr);
+    iv = qobject_input_visitor_new_keyval(crumpled_addr);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a93f93d360..29e3e1eaaa 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -546,20 +546,12 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
 
     qdict_extract_subqdict(options, &server, "server.");
 
-    crumpled_server = qdict_crumple(server, errp);
+    crumpled_server = qdict_crumple_for_keyval_qiv(server, errp);
     if (!crumpled_server) {
         goto done;
     }
 
-    /*
-     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
-     * server.type=inet.  .to doesn't matter, it's ignored anyway.
-     * That's because when @options come from -blockdev or
-     * blockdev_add, members are typed according to the QAPI schema,
-     * but when they come from -drive, they're all QString.  The
-     * visitor expects the former.
-     */
-    iv = qobject_input_visitor_new(crumpled_server);
+    iv = qobject_input_visitor_new_keyval(crumpled_server);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/ssh.c b/block/ssh.c
index eec37dd27c..bd85d989d5 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -623,20 +623,12 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
     }
 
     /* Create the QAPI object */
-    crumpled = qdict_crumple(options, errp);
+    crumpled = qdict_crumple_for_keyval_qiv(options, errp);
     if (crumpled == NULL) {
         goto fail;
     }
 
-    /*
-     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive.
-     * .to doesn't matter, it's ignored anyway.
-     * That's because when @options come from -blockdev or
-     * blockdev_add, members are typed according to the QAPI schema,
-     * but when they come from -drive, they're all QString.  The
-     * visitor expects the former.
-     */
-    v = qobject_input_visitor_new(crumpled);
+    v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsSsh(v, NULL, &result, &local_err);
     visit_free(v);
     qobject_unref(crumpled);
-- 
2.17.1
