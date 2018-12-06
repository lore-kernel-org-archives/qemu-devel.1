Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUsgk-0000y7-4b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUsbC-0005Vg-37
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:17:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUsbB-0005VX-Tk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:17:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A7E2307D85F
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 12:17:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  6 Dec 2018 13:17:43 +0100
Message-Id: <20181206121743.20762-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] json: Fix to reject duplicate object member
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, dgilbert@redhat.com

The JSON parser happily accepts duplicate object member names.  The
last value wins.  Reproducer #1:

    $ qemu-system-x86_64 -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
    "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
    {'execute':'qmp_capabilities'}
    {"return": {}}
    {'execute':'blockdev-add','arguments':{'driver':'null-co',
     'node-name':'foo','node-name':'bar'}}
    {"return": {}}
    {'execute':'query-named-block-nodes'}
    {"return": [{ [...] "node-name": "bar" [...] }]}

Reproducer #2 is iotest 229.

Fix the parser to reject duplicates, and fix iotest 229 not to use
them.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c  | 5 +++++
 tests/qemu-iotests/229 | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 5a840dfd86..a86de3f462 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -288,6 +288,11 @@ static int parse_pair(JSONParserContext *ctxt, QDict *dict)
         goto out;
     }
 
+    if (qdict_haskey(dict, qstring_get_str(key))) {
+        parse_error(ctxt, token, "duplicate key");
+        goto out;
+    }
+        
     qdict_put_obj(dict, qstring_get_str(key), value);
 
     qobject_unref(key);
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 86602437ff..893d098ad2 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -69,7 +69,6 @@ echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{'execute': 'drive-mirror',
                  'arguments': {'device': 'testdisk',
-                               'mode':   'absolute-paths',
                                'format': '$IMGFMT',
                                'target': '$DEST_IMG',
                                'sync':   'full',
-- 
2.17.2
