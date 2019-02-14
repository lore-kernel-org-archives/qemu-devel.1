Received: from eggs.gnu.org ([209.51.188.92]:54813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqu-0007Ys-FB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqr-0001Y0-Kn
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guIqp-0001TN-OZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FE4FC0624A0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:22:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 16:22:40 +0100
Message-Id: <20190214152251.2073-8-armbru@redhat.com>
In-Reply-To: <20190214152251.2073-1-armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 07/18] build: Deal with all of QAPI's .o in
 qapi/Makefile.objs
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

Adding QAPI's .o to util-obj-y, common-obj-y and obj-y is spread over
three places: Makefile.objs takes care of target-independent generated
code, Makefile.target of target-dependent generated code, and
qapi/Makefile.objs of (target-independent) hand-written code.

Do everything in qapi/Makefile.objs.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile           |  1 -
 Makefile.objs      | 16 +---------------
 Makefile.target    |  3 +--
 qapi/Makefile.objs | 19 +++++++++++++++++++
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 53d161b65f..a6de28677f 100644
--- a/Makefile
+++ b/Makefile
@@ -89,7 +89,6 @@ include $(SRC_PATH)/rules.mak
=20
 GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
=20
-#see Makefile.objs for the definition of QAPI_MODULES
 GENERATED_QAPI_FILES =3D qapi/qapi-builtin-types.h qapi/qapi-builtin-typ=
es.c
 GENERATED_QAPI_FILES +=3D qapi/qapi-types.h qapi/qapi-types.c
 GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.h)
diff --git a/Makefile.objs b/Makefile.objs
index bc78e26f55..5fb022d7ad 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,20 +1,7 @@
-QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
-QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
-QAPI_MODULES +=3D ui
-
 #######################################################################
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
-util-obj-y +=3D qapi/qapi-builtin-types.o
-util-obj-y +=3D qapi/qapi-types.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.o)
-util-obj-y +=3D qapi/qapi-builtin-visit.o
-util-obj-y +=3D qapi/qapi-visit.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
-util-obj-y +=3D qapi/qapi-emit-events.o
-util-obj-y +=3D qapi/qapi-events.o
-util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
=20
 chardev-obj-y =3D chardev/
 slirp-obj-$(CONFIG_SLIRP) =3D slirp/
@@ -92,9 +79,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 ######################################################################
 # qapi
=20
-common-obj-y +=3D qapi/qapi-commands.o
-common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
 common-obj-y +=3D qmp.o hmp.o
+common-obj-y +=3D qapi/
 endif
=20
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index d8af835890..d6ce549388 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,6 +148,7 @@ ifdef CONFIG_SOFTMMU
 obj-y +=3D arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o num=
a.o
 obj-y +=3D qtest.o
 obj-y +=3D hw/
+obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
 obj-y +=3D dump.o
@@ -164,8 +165,6 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
-obj-y +=3D qapi/qapi-introspect.o
-
 endif # CONFIG_SOFTMMU
=20
 dummy :=3D $(call unnest-vars,,obj-y)
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 33906ff321..05bb0564f2 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -4,3 +4,22 @@ util-obj-y +=3D string-input-visitor.o string-output-vis=
itor.o
 util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
+
+QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
+QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
+QAPI_MODULES +=3D ui
+
+util-obj-y +=3D qapi-builtin-types.o
+util-obj-y +=3D qapi-types.o
+util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-types-%.o)
+util-obj-y +=3D qapi-builtin-visit.o
+util-obj-y +=3D qapi-visit.o
+util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-visit-%.o)
+util-obj-y +=3D qapi-emit-events.o
+util-obj-y +=3D qapi-events.o
+util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-events-%.o)
+
+common-obj-y =3D qapi-commands.o
+common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi-commands-%.o)
+
+obj-y =3D qapi-introspect.o
--=20
2.17.2
