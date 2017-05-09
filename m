Received: from eggs.gnu.org ([2001:4830:134:3::10]:45705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d8969-00083F-9U
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d8964-0004QQ-Ez
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d8964-0004QL-8M
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9725448D73
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:38:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:51 +0300
Message-Id: <20170509173559.31598-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/17] qnum: fix get_int() with values >
 INT64_MAX
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

Now that the visitor has been switch to use qnum_uint, fix the bad
get_int() to use get_uint() instead. Remove compatibility code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c | 2 +-
 qobject/qnum.c       | 4 ++--
 tests/check-qnum.c   | 9 ++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ec3ae7fa85..767da5d78e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2585,7 +2585,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     if (!o) {
         return false;
     }
-    mcfg->mcfg_base =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
+    mcfg->mcfg_base =3D qnum_get_uint(qobject_to_qnum(o), &error_abort);
     qobject_decref(o);
=20
     o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2f87952db8..be6307accf 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -76,8 +76,8 @@ int64_t qnum_get_int(const QNum *qn, Error **errp)
         return qn->u.i64;
     case QNUM_U64:
         if (qn->u.u64 > INT64_MAX) {
-            /* temporarily accepts to cast to i64 until visitor is switc=
hed */
-            error_report("The number is too large, use qnum_get_uint()")=
;
+            error_setg(errp, "The number is too large, use qnum_get_uint=
()");
+            return 0;
         }
         return qn->u.u64;
     case QNUM_DOUBLE:
diff --git a/tests/check-qnum.c b/tests/check-qnum.c
index 9a22af3d0e..8199546f99 100644
--- a/tests/check-qnum.c
+++ b/tests/check-qnum.c
@@ -107,11 +107,10 @@ static void qnum_get_uint_test(void)
     error_free_or_abort(&err);
     QDECREF(qn);
=20
-    /* temporarily disabled until visitor is switched */
-    /* qn =3D qnum_from_uint(-1ULL); */
-    /* qnum_get_int(qn, &err); */
-    /* error_free_or_abort(&err); */
-    /* QDECREF(qn); */
+    qn =3D qnum_from_uint(-1ULL);
+    qnum_get_int(qn, &err);
+    error_free_or_abort(&err);
+    QDECREF(qn);
=20
     /* invalid case */
     qn =3D qnum_from_double(0.42);
--=20
2.13.0.rc1.16.gd80b50c3f
