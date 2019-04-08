Received: from eggs.gnu.org ([209.51.188.92]:37999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9e-0000y3-B2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9d-0001p0-Dv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDS9b-0001n7-FJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  8 Apr 2019 13:09:20 +0200
Message-Id: <20190408110920.30119-4-thuth@redhat.com>
In-Reply-To: <20190408110920.30119-1-thuth@redhat.com>
References: <20190408110920.30119-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] test qgraph.c: Fix segs due to out of scope
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jafar Abdi <cafer.abdi@gmail.com>, dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The test uses the trick:
   if (!opts) {
     opts =3D &(QOSGraph...Options) { };
   }

  in a couple of places, however the temporary created
by the &() {}  goes out of scope at the bottom of the if,
and results in a seg or assert when opts-> fields are
used (on fedora 30's gcc 9).

Fixes: fc281c802022cb3a73a5
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190405184037.16799-1-dgilbert@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/qgraph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
index 122efc1b7b..b149caaaa9 100644
--- a/tests/libqos/qgraph.c
+++ b/tests/libqos/qgraph.c
@@ -77,6 +77,7 @@ static void add_edge(const char *source, const char *de=
st,
 {
     char *key;
     QOSGraphEdgeList *list =3D g_hash_table_lookup(edge_table, source);
+    QOSGraphEdgeOptions def_opts =3D { };
=20
     if (!list) {
         list =3D g_new0(QOSGraphEdgeList, 1);
@@ -85,7 +86,7 @@ static void add_edge(const char *source, const char *de=
st,
     }
=20
     if (!opts) {
-        opts =3D &(QOSGraphEdgeOptions) { };
+        opts =3D &def_opts;
     }
=20
     QOSGraphEdge *edge =3D g_new0(QOSGraphEdge, 1);
@@ -590,9 +591,10 @@ void qos_add_test(const char *name, const char *inte=
rface,
 {
     QOSGraphNode *node;
     char *test_name =3D g_strdup_printf("%s-tests/%s", interface, name);=
;
+    QOSGraphTestOptions def_opts =3D { };
=20
     if (!opts) {
-        opts =3D &(QOSGraphTestOptions) { };
+        opts =3D &def_opts;
     }
     node =3D create_node(test_name, QNODE_TEST);
     node->u.test.function =3D test_func;
--=20
2.21.0
