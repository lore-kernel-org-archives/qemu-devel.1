Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJV-0006Yn-LQ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJU-0008Vw-Pf
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJU-0008Vk-Lq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 388DB4001852
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:00 +0100
Message-Id: <20180321115211.17937-39-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 38/49] build-sys: move qmp-introspect per
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patches are going to introduce per-target #ifdef in the
schemas.

The introspection data is statically generated once, and must thus be
built per-target to reflect target-specific configuration.

Drop "do_test_visitor_in_qmp_introspect(&qmp_schema_qlit)" since the
schema is no longer in a common object. It is covered by the per-target
query-qmp-schema test instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qobject-input-visitor.c | 1 -
 Makefile.objs                      | 2 --
 Makefile.target                    | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 6dc59c6211..e14544fc89 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1270,7 +1270,6 @@ static void test_visitor_in_qmp_introspect(TestInpu=
tVisitorData *data,
                                            const void *unused)
 {
     do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
-    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }
=20
 int main(int argc, char **argv)
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8fc21..f0b10dbf23 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,7 +55,6 @@ util-obj-y +=3D qapi/qapi-events-tpm.o
 util-obj-y +=3D qapi/qapi-events-trace.o
 util-obj-y +=3D qapi/qapi-events-transaction.o
 util-obj-y +=3D qapi/qapi-events-ui.o
-util-obj-y +=3D qapi/qapi-introspect.o
=20
 chardev-obj-y =3D chardev/
=20
@@ -150,7 +149,6 @@ common-obj-y +=3D qapi/qapi-commands-tpm.o
 common-obj-y +=3D qapi/qapi-commands-trace.o
 common-obj-y +=3D qapi/qapi-commands-transaction.o
 common-obj-y +=3D qapi/qapi-commands-ui.o
-common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
=20
diff --git a/Makefile.target b/Makefile.target
index 6549481096..0bb18dff9e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,6 +150,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D qapi/qapi-introspect.o
+
 endif # CONFIG_SOFTMMU
=20
 # Workaround for http://gcc.gnu.org/PR55489, see configure.
--=20
2.16.2.521.g9aa15f885a
