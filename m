Received: from eggs.gnu.org ([2001:4830:134:3::10]:58420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXO1-0003by-6f
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXO0-0004CU-0e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:59:09 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64cf790b-485c-06dd-ad0e-7686914e3fa8@redhat.com>
Date: Tue, 16 Jan 2018 13:59:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vdKPCGydvojZ4WlApHZlkhSaE999VssoG"
Subject: Re: [Qemu-devel] [RFC PATCH 09/10] qcow2: Use visitor for options
 in qcow2_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vdKPCGydvojZ4WlApHZlkhSaE999VssoG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <64cf790b-485c-06dd-ad0e-7686914e3fa8@redhat.com>
Subject: Re: [RFC PATCH 09/10] qcow2: Use visitor for options in
 qcow2_create()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-10-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c              | 227 ++++++++++++++++++-------------------=
--------
>  tests/qemu-iotests/049.out |  10 +-
>  2 files changed, 93 insertions(+), 144 deletions(-)
>=20


> +    /* Only the keyval visitor supports the dotted syntax needed for
> +     * encryption, so go through a QDict before getting a QAPI type. I=
gnore
> +     * options meant for the protocol layer so that the visitor doesn'=
t
> +     * complain. */
> +    qdict =3D qemu_opts_to_qdict_filtered(opts, NULL, bdrv_qcow2.creat=
e_opts,
> +                                        true);

Whether we like it or not, the keyval visitor is getting more and more
important!

> +
> +    /* TODO QAPI doesn't allow dots in enum values. Either change QAPI=
 or
> +     * decide on the proper new representation for blockdev-create */
> +    val =3D qdict_get_try_str(qdict, BLOCK_OPT_COMPAT_LEVEL);
> +    if (val && !strcmp(val, "0.10")) {
> +        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "0_10");
> +    } else if (val && !strcmp(val, "1.1")) {
> +        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "1_1");

Yeah, I flagged that in the earlier QAPI patch. The fact that it starts
with a number at all is also a bit worrying (we have to support leading
digits for legacy reasons in QKeyCode, but maybe naming things just 'v2'
and 'v3' might be cleaner than '0_10' and '1_1'?)


> +    /* Now get the QAPI type BlockdevCreateOptions */
> +    qobj =3D qdict_crumple(qdict, errp);
> +    QDECREF(qdict);
> +    qdict =3D qobject_to_qdict(qobj);
> +    if (qdict =3D=3D NULL) {
>          ret =3D -EINVAL;
>          goto finish;
>      }
> =20
> -    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_LAZY_REFCOUNTS, false)) =
{
> -        flags |=3D BLOCK_FLAG_LAZY_REFCOUNTS;
> -    }
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_=
err);
> +    visit_free(v);

Feels like a lot of round-tripping between formats to get things this
compact - but it's as good as anything else I can come up with.


> +++ b/tests/qemu-iotests/049.out
> @@ -106,7 +106,7 @@ qemu-img: Value '-1k' is out of range for parameter=
 'size'
>  qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
> =20
>  qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
> -qemu-img: Invalid image size specified! You may use k, M, G, T, P or E=
 suffixes for
> +qemu-img: Invalid image size specified! You may use k, M, G, T, P or E=
 suffixes for=20

Why are you re-adding trailing whitespace?

Overall seems sane.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vdKPCGydvojZ4WlApHZlkhSaE999VssoG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeWYQACgkQp6FrSiUn
Q2rt1ggArjeaYmxDhZvYguuZ0PBM7PEpfiXDEbXjX3rNMT3+LpuJ4C0pj4oO2szA
CFms7R6jUdFWWpn6BLgFg324Gd/LbIM7i8aOPxhaWRSsv3wcOwPE9xThue9EWPnJ
YwITvGs2o1IyatRF7eJWFEWReyHAha4D+xdaxLNlP7T4jgCq2eA2u0UA01ozY+rr
a6liT1G6gMWZowyohkeT9ofKebj7Z/RaeUrO0i1MdNAZJC6R9mJm6pnWTgig5Y60
N374T9/BF7MOgNs4DEoCBCjEB6ttj2NG+sUBBVyh7eMj8C99ahZJMm0uOS9/Ze0s
wazmfeTuHLKvpiJqDyresUwS7kNYAg==
=y+8V
-----END PGP SIGNATURE-----

--vdKPCGydvojZ4WlApHZlkhSaE999VssoG--
