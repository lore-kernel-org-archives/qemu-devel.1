Received: from eggs.gnu.org ([2001:4830:134:3::10]:42587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLtU5-0007DZ-IQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLtU2-0000AT-Be
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:53:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fLtU2-00009o-7F
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:52:58 -0400
Date: Thu, 24 May 2018 17:52:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180524165256.GA31656@stefanha-x1.localdomain>
References: <152715298769.397287.11782572103987618822.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <152715298769.397287.11782572103987618822.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 11:09:47AM +0200, Greg Kurz wrote:
> diff --git a/block.c b/block.c
> index 676e57f5623a..fc9379439883 100644
> --- a/block.c
> +++ b/block.c
> @@ -2127,12 +2127,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *pa=
rent_bs,
> =20
>  static void bdrv_detach_child(BdrvChild *child)
>  {
> +    BlockDriverState *child_bs =3D child->bs;
> +
>      if (child->next.le_prev) {
>          QLIST_REMOVE(child, next);
>          child->next.le_prev =3D NULL;
>      }

This child->next modification makes me nervous.  Please start the
drained region before modifying the graph.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBu3nAAoJEJykq7OBq3PIvWIIAIAL+OWHXZa68pyiLGUPjOaa
nS8Wqq7FRshA0fkte1Qi4eDBQsaUfQSYgsjPAWovt8EJBL9xp1cEzyeOXwqrxFPn
98RS6UXh5RC3S8/krIaZ7hfPzQ/+x9/3MQscmV/TNZPGn9iFvCVOXGZTkrmJ/4G9
rHa+93TYBVAc8yYlFL+4nYg/4+nBheNZft6RYh6jcQXdY7ocvVdIm+D7sua8pO5C
c/wXXQLNLFTMyw0V2iv5Giz+5InWxpA9KoTNwLowQUvoINLtCEz0ivEpa/Q5jwMD
h5VGAKnENM/Cix2Fi6Z/kAbgcmHYOl4YXpVPQLl8NiUyiuCi7KVBh/rzz5DpTD4=
=N0QU
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
