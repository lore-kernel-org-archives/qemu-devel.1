Received: from eggs.gnu.org ([2001:4830:134:3::10]:59796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgAig-0001Ii-5Z
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgAie-0007Ci-Ji
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:15:22 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
	<20170811023759.26390-2-eblake@redhat.com>
	<29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
Date: Fri, 11 Aug 2017 09:15:08 -0500
MIME-Version: 1.0
In-Reply-To: <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2TDBDl21GqrxKiXcaacBxCTFgFPAvHVDs"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server
 is detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TDBDl21GqrxKiXcaacBxCTFgFPAvHVDs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
Subject: Re: [PATCH 1/2] nbd: Drop connection if broken server is detected
References: <20170811023759.26390-1-eblake@redhat.com>
 <20170811023759.26390-2-eblake@redhat.com>
 <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
In-Reply-To: <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 02:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.08.2017 05:37, Eric Blake wrote:
>> As soon as the server is sending us garbage, we should quit
>> trying to send further messages to the server, and allow all
>> pending coroutines for any remaining replies to error out.
>> Failure to do so can let a malicious server cause the client
>> to hang, for example, if the server sends an invalid magic
>> number in its response.

>> @@ -107,8 +108,12 @@ static coroutine_fn void
>> nbd_read_reply_entry(void *opaque)
>>           qemu_coroutine_yield();
>>       }
>>
>> +    s->reply.handle =3D 0;
>>       nbd_recv_coroutines_enter_all(s);
>>       s->read_reply_co =3D NULL;
>> +    if (ret < 0) {
>> +        nbd_teardown_connection(bs);
>> +    }
>=20
> what if it happens in parallel with nbd_co_send_request?
> nbd_teardown_connectin destroys s->ioc, nbd_co_send_requests
> checks s->ioc only once and then calls nbd_send_request (which is
> finally nbd_rwv and may yield). I think nbd_rwv is not
> prepared to sudden destruction of ioc..

The nbd_recv_coroutines_enter_all() call schedules all pending
nbd_co_send_request coroutines to fire as soon as the current coroutine
reaches a yield point. The next yield point is during the
BDRV_POLL_WHILE of nbd_teardown_connection - but this is AFTER we've
called qio_channel_shutdown() - so as long as nbd_rwv() is called with a
valid ioc, the qio code should recognize that we are shutting down the
connection and gracefully give an error on each write attempt.

I see your point about the fact that coroutines can change hands in
between our two writes for an NBD_CMD_WRITE in nbd_co_send_request()
(the first write is nbd_send_request() for the header, the second is
nbd_rwv() for the data) - if between those two writes we process a
failing read, I see your point about us risking re-reading s->ioc as
NULL for the second write call.  But maybe this is an appropriate fix -
hanging on to the ioc that we learned when grabbing the send_mutex:


diff --git a/block/nbd-client.c b/block/nbd-client.c
index 802d50b636..28b10f3fa2 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -122,6 +122,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
 {
     NBDClientSession *s =3D nbd_get_client_session(bs);
     int rc, ret, i;
+    QIOChannel *ioc;

     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
@@ -139,25 +140,26 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
     g_assert(qemu_in_coroutine());
     assert(i < MAX_NBD_REQUESTS);
     request->handle =3D INDEX_TO_HANDLE(s, i);
+    ioc =3D s->ioc;

-    if (!s->ioc) {
+    if (!ioc) {
         qemu_co_mutex_unlock(&s->send_mutex);
         return -EPIPE;
     }

     if (qiov) {
-        qio_channel_set_cork(s->ioc, true);
-        rc =3D nbd_send_request(s->ioc, request);
+        qio_channel_set_cork(ioc, true);
+        rc =3D nbd_send_request(ioc, request);
         if (rc >=3D 0) {
-            ret =3D nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len,=

false,
+            ret =3D nbd_rwv(ioc, qiov->iov, qiov->niov, request->len, fa=
lse,
                           NULL);
             if (ret !=3D request->len) {
                 rc =3D -EIO;
             }
         }
-        qio_channel_set_cork(s->ioc, false);
+        qio_channel_set_cork(ioc, false);
     } else {
-        rc =3D nbd_send_request(s->ioc, request);
+        rc =3D nbd_send_request(ioc, request);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;



But I'm really hoping Paolo will chime in on this thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2TDBDl21GqrxKiXcaacBxCTFgFPAvHVDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmNu+wACgkQp6FrSiUn
Q2oYtAf/UsBgQUYSYtNMUZP53/+zYECGQU1L53iwbMEdU4qSETWTeJbGgnCljDnH
7xrjFDCtaWeKpj6mP/CAFUwVy3LTZThjSCFoPNEolEfC1Ui8xDFDNczsQnsV1h7H
/fmKiu/+G2SridVpKcaA0N0HWmlz0urfy0j53+pZK8UCcHsFUrqFjI6ujCvx5EF5
xj3nKEQFHBa3ibDqKMXuTBvxIXCgQ0OPcvCfrU31YQd1/ORaw4fKnD56Bl52p0w3
K7GwV9bP99m0WcJnpXVUup0XiEq9rKFlVHgzBI066D4c/+Q0XCDtNW47uNZKUVIi
Gy19BckBnohJwpO4xErYKZBGxYq9sQ==
=LxRr
-----END PGP SIGNATURE-----

--2TDBDl21GqrxKiXcaacBxCTFgFPAvHVDs--
