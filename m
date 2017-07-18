Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRFP-0003g4-Gf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRFM-0002VL-Ci
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXRFM-0002TR-3s
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:05:00 -0400
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
	<20170602150150.258222-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a880cbcb-9a16-bbd3-cda7-28e68bc21b34@redhat.com>
Date: Tue, 18 Jul 2017 07:04:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170602150150.258222-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qHU3niRfpDgoBcHmAEDd9tBJ34KkGS1hN"
Subject: Re: [Qemu-devel] [PATCH v2 03/12] nbd/server: get rid of
 nbd_negotiate_read and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qHU3niRfpDgoBcHmAEDd9tBJ34KkGS1hN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <a880cbcb-9a16-bbd3-cda7-28e68bc21b34@redhat.com>
Subject: Re: [PATCH v2 03/12] nbd/server: get rid of nbd_negotiate_read and
 friends
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
 <20170602150150.258222-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170602150150.258222-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/02/2017 10:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
> 1a6245a5b, when nbd_rwv (was nbd_wr_sync) was working through
> qemu_co_sendv_recvv (the path is nbd_wr_sync -> qemu_co_{recv/send} ->
> qemu_co_send_recv -> qemu_co_sendv_recvv), which just yields, without
> setting any handlers. But starting from ff82911cd nbd_rwv (was
> nbd_wr_syncv) works through qio_channel_yield() which sets handlers, so=

> watchers are redundant in nbd_negotiate_{read,write,drop_sync}, then,
> let's just use nbd_{read,write,drop} functions.
>=20
> Functions nbd_{read,write,drop} has errp parameter, which is unused in
> this patch. This will be fixed later.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 107 ++++++++++++---------------------------------------=
--------
>  1 file changed, 22 insertions(+), 85 deletions(-)

I did not realize it at the time, but this patch plugs a
denial-of-service security hole against malicious clients that were able
to trigger an assertion failure in the server by sending garbage during
negotiation; which was a regression introduced in the mentioned commit
ff82911cd.  This has now been assigned the identifier CVE-2017-7539

The fact that we have now had 4 CVEs against qemu's NBD implementation
in the last year means we are not doing a very good job of unit testing
either the server or the client against a malicious partner; I'm still
trying to figure out ways that we can improve our testsuite coverage
(testing that a sane client can still connect happens during
qemu-iotests, but most of our CVEs have happened due to poor reactions
to out-of-spec clients).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qHU3niRfpDgoBcHmAEDd9tBJ34KkGS1hN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllt+WcACgkQp6FrSiUn
Q2qCrQgAre/bLBVAT/Jq9duHe6fQUR/Z17EfnXGMUxShcaYl6HW5kZWBV7AuVUq7
fKulZBVFXWyK2AkckIKGMTiRAwH1Bn83xTVGP0L/oDux4vswW0/QsW4p8PYyGdL4
dOxSc/I87LYDpuhhhJp3gtUcNeJcR1ygl5sKLyj9wK9gBCvz7eujbrD7BVam208x
t89M+k9EIy5a56pZs80YpR89VeWIjLqMRNNtNvMRFkeywY4jXKGWYsjo1fKdOv6W
na5WvNYfp6+HaBoNYKMvOdadxKYxBAdpYxPkfW2/IWbcJIxFsshmrIVTKoyYfsoW
if82EZqMl1YxfY5OCo6wrHr3bIDnxQ==
=QhJI
-----END PGP SIGNATURE-----

--qHU3niRfpDgoBcHmAEDd9tBJ34KkGS1hN--
