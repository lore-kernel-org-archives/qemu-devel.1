Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRyN-0003E7-KF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRyM-0001CS-Eg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:51:31 -0400
References: <20170718003422.4497-1-jsnow@redhat.com>
	<20170718003422.4497-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
Date: Tue, 18 Jul 2017 07:51:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170718003422.4497-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OJfUWG8Nq2MrH1n1iSGrfAlTMFAwFgao4"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Check for backing image
 if specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OJfUWG8Nq2MrH1n1iSGrfAlTMFAwFgao4
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
Subject: Re: [PATCH v5 2/2] qemu-img: Check for backing image if specified
 during create
References: <20170718003422.4497-1-jsnow@redhat.com>
 <20170718003422.4497-3-jsnow@redhat.com>
In-Reply-To: <20170718003422.4497-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 07:34 PM, John Snow wrote:
> Or, rather, force the open of a backing image if one was specified
> for creation. Using a similar -unsafe option as rebase, allow qemu-img
> to ignore the backing file validation if possible.
>=20
> It may not always be possible, as in the existing case when a filesize
> for the new image was not specified.
>=20
> This is accomplished by shifting around the conditionals in
> bdrv_img_create, such that a backing file is always opened unless we
> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
> when -u is provided to create.
>=20
> Sorry for the heinous looking diffstat, but it's mostly whitespace.

This sentence is not quite as applicable as it was on earlier versions,
as you now have added logic for determining which level (warning vs.
error) to print.

>=20
> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Really? It seems like you've changed since v4.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/block.c
> @@ -4396,55 +4396,65 @@ void bdrv_img_create(const char *filename, cons=
t char *fmt,
> =20
>      backing_fmt =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
> =20
> -    // The size for the image must always be specified, with one excep=
tion:
> -    // If we are using a backing file, we can obtain the size from the=
re
> +    /* The size for the image must always be specified, unless we have=
 a backing
> +     * file and we have not been forbidden from opening it */

Worth adding a trailing '.' to the sentence?

>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);

On v4, we talked about making this use qemu_opt_get_size(, -1) to make
it less confusing about how qemu_opt_get_size() refers back to a
caller-provided default embedded in QemuOpt (rather than the parameter).

> +        if (!bs && size !=3D -1) {
> +            /* Couldn't open BS, but we have a size, so it's nonfatal =
*/
> +            error_reportf_err(local_err,
> +                              "Warning: could not verify backing image=
=2E "
> +                              "This may become an error in future vers=
ions.\n");

Patchew rightly complained here about the trailing newline. Also, we
have the new warning* functions merged in, this should probably be using
those (see commit 3dc6f869, for example)

> +            local_err =3D NULL;
> +        } else if (!bs) {
> +            /* Couldn't open bs, do not have size */
> +            error_append_hint(&local_err,
> +                              "Could not open backing image to determi=
ne size.\n");
> +            goto out;
> +        } else {
> +            if (size =3D=3D -1) {
> +                /* Opened BS, have no size */
> +                size =3D bdrv_getlength(bs);
> +                if (size < 0) {
> +                    error_setg_errno(errp, -size, "Could not get size =
of '%s'",
> +                                     backing_file);

These look correct.

> +++ b/tests/qemu-iotests/111.out
> @@ -1,3 +1,4 @@
>  QA output created by 111
>  qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexist=
ent': No such file or directory
> +Could not open backing image to determine size.

Nice demonstration of the hint at work.

The rest of the patch looks fine to me.  We'll need a couple of tweaks,
but between you, Kevin, and myself, I think we can coordinate getting
something ready for a pull request today.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OJfUWG8Nq2MrH1n1iSGrfAlTMFAwFgao4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluBEYACgkQp6FrSiUn
Q2pOJwf/f7BSkQRCh0SPbxX+B+4ciuwRZZ9qjf8COjVBWr8naUSoQshdIckzq7km
gim9dM+/Yvh0czV4jDgc2r9JnqpIaseul1FL/4mtLL+oL90nqr/CYYGPNWnKulBc
m3ed3vpsHMTNFq7DVdt7jQ6hGXhBbMpiF7xBXv1ZV4p0b2UX4v3jODQASpQb4atZ
uZ6d4NJx0WbRFYr0O31xg1EoTv9FRbfCh1ErpQ/bTe3/VQ+UTmvniCCU7PGzFkO4
RF06mislHZ7y3xlPcIYlM/Tpo7eJ9dh1s4UZh2eh+bFda4SKHykKWChkeQDbke+y
6hYMvyTgwuVMXwc3KYgtBQemAciOBA==
=9YUY
-----END PGP SIGNATURE-----

--OJfUWG8Nq2MrH1n1iSGrfAlTMFAwFgao4--
