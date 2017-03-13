Received: from eggs.gnu.org ([2001:4830:134:3::10]:52166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007Wu-EO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJj-0003YW-SG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003XX-Ks
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:09 +0100
Message-Id: <1489385927-6735-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 09/47] qapi: Fix to reject empty union
 base gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Common Python pitfall: 'assert base_members' fires on [] in addition
to None.  Correct to 'assert base_members is not None'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                        |  2 +-
 tests/qapi-schema/union-base-empty.err | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e98fd0c..eec7bfb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -731,7 +731,7 @@ def check_union(expr, info):
             raise QAPISemError(info, "Flat union '%s' must have a base"
                                % name)
         base_members = find_base_members(base)
-        assert base_members
+        assert base_members is not None
 
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/union-base-empty.err
index 61e6ec6..7695806 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1,10 +1 @@
-Traceback (most recent call last):
-  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
-    schema = QAPISchema(sys.argv[1])
-  File "scripts/qapi.py", line 1483, in __init__
-    self.exprs = check_exprs(parser.exprs)
-  File "scripts/qapi.py", line 917, in check_exprs
-    check_union(expr, info)
-  File "scripts/qapi.py", line 734, in check_union
-    assert base_members
-AssertionError
+tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a member of base struct 'Empty'
-- 
2.7.4
