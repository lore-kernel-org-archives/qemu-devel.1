Received: from eggs.gnu.org ([2001:4830:134:3::10]:57846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1dfiH6-00051i-Rb
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chaojianhu@hotmail.com>) id 1dfiH5-0003yW-QC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:53:00 -0400
From: Hu Chaojian <chaojianhu@hotmail.com>
Date: Thu, 10 Aug 2017 07:52:37 +0000
Message-ID: <DM5PR17MB1451D437FA7145AEBE4688CFDB880@DM5PR17MB1451.namprd17.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] block/qcow2-snapshot: Fix a null pointer
 dereference in qcow2_free_snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "ppandit@redhat.com" <ppandit@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Hu Chaojian <chaojianhu@hotmail.com>

From: chaojianhu <chaojianhu@hotmail.com>

In function qcow2_do_open, if "go fail;" before calling qcow2_read_snapshot=
s, then snapshots=20
will always be NULL. When dealing with "fail:", qcow2_free_snapshots will b=
e called, and=20
s->snapshots will be dereferenced without checked.

Reported-by: chaojianhu <chaojianhu@hotmail.com>
Signed-off-by: chaojianhu <chaojianhu@hotmail.com>

---
 block/qcow2-snapshot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 44243e0..4a8128c 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -35,6 +35,10 @@ void qcow2_free_snapshots(BlockDriverState *bs)
     BDRVQcow2State *s =3D bs->opaque;
     int i;
=20
+    if (NULL =3D=3D s->snapshots) {
+        return;
+    }
+
     for(i =3D 0; i < s->nb_snapshots; i++) {
         g_free(s->snapshots[i].name);
         g_free(s->snapshots[i].id_str);
--=20
1.9.1
