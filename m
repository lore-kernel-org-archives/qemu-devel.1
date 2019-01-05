Received: from eggsout.gnu.org ([209.51.188.92]:56548 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVs-0003qb-4o
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVn-0007j2-QL
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:19 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 08:00:56 -0600
Message-Id: <20190105140100.26913-5-eblake@redhat.com>
In-Reply-To: <20190105140100.26913-1-eblake@redhat.com>
References: <20190105140100.26913-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/8] qemu-nbd: Use program name in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This changes output from:

$ qemu-nbd nosuch
Failed to blk_new_open 'nosuch': Could not open 'nosuch': No such file or=
 directory

to something more consistent with qemu-img and qemu:

$ qemu-nbd nosuch
qemu-nbd: Failed to blk_new_open 'nosuch': Could not open 'nosuch': No su=
ch file or directory

Update the lone affected test to match.  (Hmm - is it sad that we don't
do much testing of expected failures?)

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181215135324.152629-2-eblake@redhat.com>
---
 qemu-nbd.c                 | 1 +
 tests/qemu-iotests/233.out | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index ca7109652e5..e169b839ece 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -571,6 +571,7 @@ int main(int argc, char **argv)
 #endif

     module_call_init(MODULE_INIT_TRACE);
+    error_set_progname(argv[0]);
     qcrypto_init(&error_fatal);

     module_call_init(MODULE_INIT_QOM);
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 94acd9b9479..5f416721b03 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -27,7 +27,7 @@ virtual size: 64M (67108864 bytes)
 disk size: unavailable

 =3D=3D check TLS with different CA fails =3D=3D
-option negotiation failed: Verify failed: No certificate was found.
+qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': The certificate hasn't got a known issuer

 =3D=3D perform I/O over TLS =3D=3D
--=20
2.20.1
