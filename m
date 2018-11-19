Received: from eggs.gnu.org ([2001:4830:134:3::10]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl0-00007A-8X
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkx-0002Xr-R3
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:20 -0600
Message-Id: <20181119175427.2298497-6-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] nbd/server: Ignore write errors when
 replying to NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>

Commit 37ec36f6 intentionally ignores errors when trying to reply
to an NBD_OPT_ABORT request for plaintext clients, but did not make
the same change for a TLS server.  Since NBD_OPT_ABORT is
documented as being a potential for an EPIPE when the client hangs
up without waiting for our reply, we don't need to pollute the
server's output with that failure.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181117223221.2198751-1-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 nbd/server.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 056cfa5ad47..dc04513de70 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1134,12 +1134,16 @@ static int nbd_negotiate_options(NBDClient *clien=
t, uint16_t myflags,
                 return -EINVAL;

             default:
-                ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
+                /* Let the client keep trying, unless they asked to
+                 * quit. Always try to give an error back to the
+                 * client; but when replying to OPT_ABORT, be aware
+                 * that the client may hang up before receiving the
+                 * error, in which case we are fine ignoring the
+                 * resulting EPIPE. */
+                ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD,
+                                   option =3D=3D NBD_OPT_ABORT ? NULL : =
errp,
                                    "Option 0x%" PRIx32
                                    " not permitted before TLS", option);
-                /* Let the client keep trying, unless they asked to
-                 * quit. In this mode, we've already sent an error, so
-                 * we can't ack the abort.  */
                 if (option =3D=3D NBD_OPT_ABORT) {
                     return 1;
                 }
--=20
2.17.2
