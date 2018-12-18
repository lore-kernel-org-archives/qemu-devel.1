Received: from eggs.gnu.org ([2001:4830:134:3::10]:43663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK13-0003bl-3Q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZK0x-0002OU-3W
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZK0v-0002DP-8M
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:22:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 058A7653C2
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:22:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 19:22:23 +0100
Message-Id: <20181218182234.28876-5-armbru@redhat.com>
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 04/15] build-sys: move qmp-introspect
 per target
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The following patches are going to introduce per-target #ifdef in the
schemas.

The introspection data is statically generated once, and must thus be
built per-target to reflect target-specific configuration.

Drop "do_test_visitor_in_qmp_introspect(&qmp_schema_qlit)" since the
schema is no longer in a common object. It is covered by the per-target
query-qmp-schema test instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.objs                      | 2 --
 Makefile.target                    | 2 ++
 tests/test-qobject-input-visitor.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 126d0cd9b2..93dc86f2e6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -14,7 +14,6 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
 util-obj-y +=3D qapi/qapi-events-FIXME.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
-util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
=20
@@ -95,7 +94,6 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
 common-obj-y +=3D qapi/qapi-commands.o
 common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
-common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
=20
diff --git a/Makefile.target b/Makefile.target
index 44ec4b630c..c882292ae1 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,6 +156,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D qapi/qapi-introspect.o
+
 endif # CONFIG_SOFTMMU
=20
 dummy :=3D $(call unnest-vars,,obj-y)
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index caa90b3d7e..609334adf6 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1271,7 +1271,6 @@ static void test_visitor_in_qmp_introspect(TestInpu=
tVisitorData *data,
                                            const void *unused)
 {
     do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
-    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }
=20
 int main(int argc, char **argv)
--=20
2.17.2
