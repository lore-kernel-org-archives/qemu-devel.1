Received: from eggs.gnu.org ([2001:4830:134:3::10]:51524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddehK-0000X8-Sm
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddehJ-0000Ea-N7
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:39:34 -0400
References: <87d18be8tg.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc78d5f1-f846-20f6-4880-890d03607586@redhat.com>
Date: Fri, 4 Aug 2017 10:39:24 -0500
MIME-Version: 1.0
In-Reply-To: <87d18be8tg.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s6PwFi7O41RxMrVSB82bXdIrgBtwgIHRo"
Subject: Re: [Qemu-devel] Is blk_getlength() in find_image_format() and
 img_map() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6PwFi7O41RxMrVSB82bXdIrgBtwgIHRo
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <fc78d5f1-f846-20f6-4880-890d03607586@redhat.com>
Subject: Re: [Qemu-devel] Is blk_getlength() in find_image_format() and
 img_map() kosher?
References: <87d18be8tg.fsf@dusky.pond.sub.org>
In-Reply-To: <87d18be8tg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 08:55 AM, Markus Armbruster wrote:
> Have a look at find_image_format():
>=20
>     if (blk_is_sg(file) || !blk_is_inserted(file) || blk_getlength(file=
) =3D=3D 0) {
>         *pdrv =3D &bdrv_raw;
>         return ret;
>     }
>=20
> blk_getlength() can fail.  Shouldn't we error out then?
>=20
> We pretty obviously should in img_map():
>=20
>     length =3D blk_getlength(blk);
>     while (curr.start + curr.length < length) {
>=20
> Since I have to touch @length in the series I'm working on, I'll stick
> in a fix.

/me goes and checks my byte-based block status series

Hmm, that problem is still present even after my refactoring of
img_map().  I can rebase my series on top of your fix, as your fix
belongs in 2.10.

Alternatively, WHY do we allow blk_getlength() to fail?  Are there
really situations where we can open a BDS but not know its length?  I
know that we allow for online resizing detection, but presumably, either
we always know the (prior) size of the device, or we're going to have
problems talking to the device for anything beyond just a size request.
What semantics would change if we could guarantee that blk_getlength()
never failed?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s6PwFi7O41RxMrVSB82bXdIrgBtwgIHRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmElSwACgkQp6FrSiUn
Q2q1yQgArI9c/YF5kKpxqwNoVoXL+bfjnazJXmM9zYDWDNCO2/4cq8S5AQE3VcIH
vRxVQY90ks+d3VlGGB7ghfJNNdMa7UI0tWRXLCz5ob/FAZSSsSGobCUfgxfoFJ7z
czUeCLyA3ZQOKfnWDGuIlrhdOrP17qMxcwCCFSCOz1BC+lnpl3IY1hu3vCpti/q/
qqxF/P0/MgAMpNiSDM6ro2VXl8gkAR2z3N7asmuOjNZ2mSZJkE1JzOymkXGwinC7
rV2rq5niS+Le4xEPvmUeqdk+YRf2MABDMLs3rGDZ1dVDeOJPplFMylPVliOe6D1P
rZ++04IMo8Yx+pBCl593nDr2llKyxQ==
=MD3I
-----END PGP SIGNATURE-----

--s6PwFi7O41RxMrVSB82bXdIrgBtwgIHRo--
