Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065V-Ar
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtO-00070x-QP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtO-000703-Iy
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D8538046A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 665A417D23
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:27 +0100
Message-Id: <1489645685-4750-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 11/49] qapi: Fix to reject empty union
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

Common Python pitfall: 'assert base_members' fires on [] in addition
to None.  Correct to 'assert base_members is not None'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-10-git-send-email-armbru@redhat.com>
---
 scripts/qapi.py                        |  2 +-
 tests/qapi-schema/union-base-empty.err | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 78db319..f4c8210 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -735,7 +735,7 @@ def check_union(expr, info):
             raise QAPISemError(info, "Flat union '%s' must have a base"
                                % name)
         base_members =3D find_base_members(base)
-        assert base_members
+        assert base_members is not None
=20
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index 26bfa07..7695806 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1,10 +1 @@
-Traceback (most recent call last):
-  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
-    schema =3D QAPISchema(sys.argv[1])
-  File "scripts/qapi.py", line 1487, in __init__
-    self.exprs =3D check_exprs(parser.exprs)
-  File "scripts/qapi.py", line 921, in check_exprs
-    check_union(expr, info)
-  File "scripts/qapi.py", line 738, in check_union
-    assert base_members
-AssertionError
+tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of base struct 'Empty'
--=20
2.7.4
