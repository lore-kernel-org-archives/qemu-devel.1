Received: from eggs.gnu.org ([209.51.188.92]:54710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqr-0007WT-MO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqq-0001Wv-D8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guIqp-0001Ru-LV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:22:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63D5B81F11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:22:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 16:22:39 +0100
Message-Id: <20190214152251.2073-7-armbru@redhat.com>
In-Reply-To: <20190214152251.2073-1-armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 06/18] build-sys: move qmp-introspect per
 target
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The following patches are going to introduce per-target #ifdef in the
schemas.

The introspection data is statically generated once, and must thus be
built per-target to reflect target-specific configuration.

Drop "do_test_visitor_in_qmp_introspect(&qmp_schema_qlit)" since the
schema is no longer in a common object. It is covered by the per-target
query-qmp-schema test instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile.objs                      | 2 --
 Makefile.target                    | 2 ++
 tests/test-qobject-input-visitor.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index ec11a0f55b..bc78e26f55 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -15,7 +15,6 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
 util-obj-y +=3D qapi/qapi-emit-events.o
 util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
-util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
 slirp-obj-$(CONFIG_SLIRP) =3D slirp/
@@ -95,7 +94,6 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
 common-obj-y +=3D qapi/qapi-commands.o
 common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
-common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
=20
diff --git a/Makefile.target b/Makefile.target
index 401dc1ea6f..d8af835890 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -164,6 +164,8 @@ endif
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
