Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXJ-0008KC-Dw
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXI-0006kC-BM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkXI-0006hg-5S
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:42 +0100
Message-Id: <20180111213250.16511-44-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 43/51] build-sys: move qmp-introspect per
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

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
 Makefile.objs                      | 3 +--
 Makefile.target                    | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 7c1d10e274..ad4c99a4c7 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -1267,7 +1267,6 @@ static void test_visitor_in_qmp_introspect(TestInpu=
tVisitorData *data,
                                            const void *unused)
 {
     do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
-    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
 }
=20
 int main(int argc, char **argv)
diff --git a/Makefile.objs b/Makefile.objs
index c8b1bba593..1b4d0ecfbc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,7 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
-util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y +=3D qapi-types.o qapi-visit.o qapi-event.o
=20
 chardev-obj-y =3D chardev/
=20
@@ -79,7 +79,6 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 # qapi
=20
 common-obj-y +=3D qmp-marshal.o
-common-obj-y +=3D qmp-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif
=20
diff --git a/Makefile.target b/Makefile.target
index f9a9da7e7c..35108c6caf 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,6 +150,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D qmp-introspect.o
+
 endif # CONFIG_SOFTMMU
=20
 # Workaround for http://gcc.gnu.org/PR55489, see configure.
--=20
2.16.0.rc1.1.gef27df75a1
