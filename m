Received: from eggs.gnu.org ([2001:4830:134:3::10]:39463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e32cJ-0007uy-Ul
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e32cI-0007hk-Lt
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:15:19 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-10-vsementsov@virtuozzo.com>
	<46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2eebcfdc-0d81-da33-230e-4443712f9fc3@redhat.com>
Date: Fri, 13 Oct 2017 11:15:01 -0500
MIME-Version: 1.0
In-Reply-To: <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0uMvD783qWUNWXq5T59odujknDe71Xgm7"
Subject: Re: [Qemu-devel] [PATCH v3 09/13] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0uMvD783qWUNWXq5T59odujknDe71Xgm7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <2eebcfdc-0d81-da33-230e-4443712f9fc3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/13] nbd: Minimal structured read for
 server
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-10-vsementsov@virtuozzo.com>
 <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
In-Reply-To: <46e3f2c3-695d-3fe2-eefb-fcbf4a2a0555@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/13/2017 11:00 AM, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation of structured read: one structured reply chunk,=

>> no segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
>>
>> @@ -1304,10 +1375,17 @@ static int nbd_co_receive_request(NBDRequestDa=
ta *req, NBDRequest *request,
>>                     (uint64_t)client->exp->size);
>>          return request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL=
;
>>      }
>> -    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) =
{
>> +    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
>> +                           NBD_CMD_FLAG_DF))
>=20
> This says we accept the client sending NBD_CMD_FLAG_DF, but where did w=
e
> advertise it?  I see no reason to advertise it unless a client
> negotiates structured replies, at which point the obvious place to set
> it is when we reply to the negotiation (and NBD_OPT_INFO prior to that
> point won't see the flag, but the NBD_OPT_GO will see it).

Oh, one more tweak: if we didn't advertise the flag, the client
shouldn't be sending it.

>=20
> So, here's what I'm squashing, before adding:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'm also adding:

diff --git i/nbd/server.c w/nbd/server.c
index b4966ed8b1..acad2ceb59 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -1315,6 +1315,7 @@ static int nbd_co_receive_request(NBDRequestData
*req, NBDRequest *request,
                                   Error **errp)
 {
     NBDClient *client =3D req->client;
+    int valid_flags;

     g_assert(qemu_in_coroutine());
     assert(client->recv_coroutine =3D=3D qemu_coroutine_self());
@@ -1376,20 +1377,15 @@ static int nbd_co_receive_request(NBDRequestData
*req, NBDRequest *request,
                    (uint64_t)client->exp->size);
         return request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
     }
-    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
-                           NBD_CMD_FLAG_DF))
-    {
-        error_setg(errp, "unsupported flags (got 0x%x)", request->flags)=
;
-        return -EINVAL;
+    valid_flags =3D NBD_CMD_FLAG_FUA;
+    if (request->type =3D=3D NBD_CMD_READ && client->structured_reply) {=

+        valid_flags |=3D NBD_CMD_FLAG_DF;
+    } else if (request->type =3D=3D NBD_CMD_WRITE_ZEROES) {
+        valid_flags |=3D NBD_CMD_FLAG_NO_HOLE;
     }
-    if (request->type !=3D NBD_CMD_READ && (request->flags &
NBD_CMD_FLAG_DF)) {
-        error_setg(errp, "DF flag used with command %d (%s) which is
not READ",
-                   request->type, nbd_cmd_lookup(request->type));
-        return -EINVAL;
-    }
-    if (request->type !=3D NBD_CMD_WRITE_ZEROES &&
-        (request->flags & NBD_CMD_FLAG_NO_HOLE)) {
-        error_setg(errp, "unexpected flags (got 0x%x)", request->flags);=

+    if (request->flags & ~valid_flags) {
+        error_setg(errp, "unsupported flags for command %s (got 0x%x)",
+                   nbd_cmd_lookup(request->type), request->flags);
         return -EINVAL;
     }



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0uMvD783qWUNWXq5T59odujknDe71Xgm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlng5oUACgkQp6FrSiUn
Q2qekQf+J+d42ICpzd0MRG6yONWHFKH2eTPFHFgYXmPh/yoxnnBaI7osrxHZ7m2H
YXPWP5MY7xhCiFKnzfI1Cl/1QiRfkLg6pnAxd1bihL6ugeqo/FwcsZjtbJdvsBGT
EpFBOW1rq3evv1mimu3RWVACLRuBTE6SinVpmERxbEF1Sx46UsC5FK+X3l/9KVgv
1wqumOafhzNNM/T6/n/+SvIoSafTWOJfHBh+62j8LKYn22u4x/MrA/bKc6spvqEn
xdojHoq8Nqe+DC46GQhSlk+SGm3yv8RSzF5qnHbB6XLfRozliiI2EpJaXYBO7+8Z
sMvHydKEiFmL/0B2Vz4AVcEsZ+am0w==
=4jB1
-----END PGP SIGNATURE-----

--0uMvD783qWUNWXq5T59odujknDe71Xgm7--
