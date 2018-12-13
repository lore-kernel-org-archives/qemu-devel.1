Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVy6-00061l-7U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxv-0002yj-Iu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxr-0001PZ-Mc
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E54FC308FF0C
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B32284530
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:19 +0100
Message-Id: <20181213184340.24037-12-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/32] json: Fix to reject duplicate object
 member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Message-Id: <20181206121743.20762-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[Trailing whitespace tidied up]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c  | 5 +++++
 tests/qemu-iotests/229 | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 5a840dfd86..7a7ae9e8d1 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -288,6 +288,11 @@ static int parse_pair(JSONParserContext *ctxt, QDict=
 *dict)
         goto out;
     }
=20
+    if (qdict_haskey(dict, qstring_get_str(key))) {
+        parse_error(ctxt, token, "duplicate key");
+        goto out;
+    }
+
     qdict_put_obj(dict, qstring_get_str(key), value);
=20
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
--=20
2.17.2
