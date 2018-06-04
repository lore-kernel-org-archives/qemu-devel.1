Received: from eggs.gnu.org ([2001:4830:134:3::10]:47498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0Y-0004Rb-9v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPh0X-00077c-9s
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPh0X-00077E-5r
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:22:13 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  4 Jun 2018 06:21:55 +0200
Message-Id: <20180604042156.13812-5-quintela@redhat.com>
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] migration: remove unnecessary variables len
 in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoked
by different threads concurrently, this patch removes unnecessary variabl=
es
len in QIOChannelRDMA and use local variable instead.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
---
 migration/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7d233b0820..60779221b1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -400,7 +400,6 @@ struct QIOChannelRDMA {
     QIOChannel parent;
     RDMAContext *rdma;
     QEMUFile *file;
-    size_t len;
     bool blocking; /* XXX we don't actually honour this yet */
 };
=20
@@ -2608,6 +2607,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
     int ret;
     ssize_t done =3D 0;
     size_t i;
+    size_t len =3D 0;
=20
     CHECK_ERROR_STATE();
=20
@@ -2627,10 +2627,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel=
 *ioc,
         while (remaining) {
             RDMAControlHeader head;
=20
-            rioc->len =3D MIN(remaining, RDMA_SEND_INCREMENT);
-            remaining -=3D rioc->len;
+            len =3D MIN(remaining, RDMA_SEND_INCREMENT);
+            remaining -=3D len;
=20
-            head.len =3D rioc->len;
+            head.len =3D len;
             head.type =3D RDMA_CONTROL_QEMU_FILE;
=20
             ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL, NUL=
L, NULL);
@@ -2640,8 +2640,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
                 return ret;
             }
=20
-            data +=3D rioc->len;
-            done +=3D rioc->len;
+            data +=3D len;
+            done +=3D len;
         }
     }
=20
@@ -2736,8 +2736,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *i=
oc,
             }
         }
     }
-    rioc->len =3D done;
-    return rioc->len;
+    return done;
 }
=20
 /*
--=20
2.17.0
