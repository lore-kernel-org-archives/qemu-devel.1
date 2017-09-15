Received: from eggs.gnu.org ([2001:4830:134:3::10]:55852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsw4T-0001yu-K1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsw4S-0003rp-El
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:14:37 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915170204.14023-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97519d8d-e00e-97f6-aa13-98ba06faca88@redhat.com>
Date: Fri, 15 Sep 2017 14:14:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170915170204.14023-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DMjGRWttnJ4jOPaldhW1hNMjvRhVndqtg"
Subject: Re: [Qemu-devel] [PATCH 7/6] qemu-iotests: Test change-backing-file
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DMjGRWttnJ4jOPaldhW1hNMjvRhVndqtg
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <97519d8d-e00e-97f6-aa13-98ba06faca88@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/6] qemu-iotests: Test change-backing-file
 command
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915170204.14023-1-kwolf@redhat.com>
In-Reply-To: <20170915170204.14023-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 12:02 PM, Kevin Wolf wrote:
> This involves a temporary read-write reopen if the backing file link in=

> the middle of a backing file chain should be changed and is therefore a=

> good test for the latest bdrv_reopen() vs. op blockers fixes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> I actually managed to find a simple case that reproduces the bug that
> is fixed in this series, but outside of my commit job improvements that=

> originally led me to this work.
>=20
>  tests/qemu-iotests/195     | 92 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/195.out | 78 ++++++++++++++++++++++++++++++++++++++=
+
>  tests/qemu-iotests/group   |  1 +

The usual collision in test numbering ;)


> +_cleanup()
> +{
> +    _cleanup_test_img
> +    rm -f "$TEST_IMG.mid"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Semantic conflict with Jeff's work to add './check -s' to save
intermediate files in a per-test temp directory.

> +
> +echo
> +echo "Change backing file of mid (opened read-only)"
> +echo
> +
> +run_qemu -drive if=3Dnone,file=3D"$TEST_IMG",backing.node-name=3Dmid <=
<EOF
> +{"execute":"qmp_capabilities"}
> +{"execute":"change-backing-file", "arguments":{"device":"none0","image=
-node-name":"mid","backing-file":"/dev/null"}}

Since the images don't contain any content, I guess this works.  But
another possible change would be rewriting the backing file to alternate
between absolute and relative (or even between 'file' and './file') (so
that it's pointing to the same file at all times, just by different names=
)

> +{"execute":"quit"}
> +EOF
> +
> +TEST_IMG=3D"$TEST_IMG.mid" _img_info
> +
> +echo
> +echo "Change backing file of top (opened writable)"
> +echo
> +
> +TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
> +
> +run_qemu -drive if=3Dnone,file=3D"$TEST_IMG",node-name=3Dtop <<EOF
> +{"execute":"qmp_capabilities"}
> +{"execute":"change-backing-file", "arguments":{"device":"none0","image=
-node-name":"top","backing-file":"/dev/null"}}
> +{"execute":"quit"}

You've quit qemu between runs.  Would we get any further coverage by doin=
g:

change mid
change active
change mid

all within a single run? (That is, make SURE that actions on one part of
the graph don't interfere with later actions elsewhere)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DMjGRWttnJ4jOPaldhW1hNMjvRhVndqtg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8JpIACgkQp6FrSiUn
Q2qv8gf+LEVsj7CSxujI+fpWateRI8mAk6kwyscFOEqpCtq3gfLHz6Uqe54C6lAN
fflXVVEScRh+01wZcy+FvPXX+4/ynp30EBvAXaWeTcRomhaXk5cqdMBBzdPAKkNU
OO4S+Dt6G7jQ18fpGcfVH21pvbpJ9VQSKIX0S3JD9hpc4iWUK1OaDCHB/rQz0Ke5
ClI5EheGsb/nICIdgJYxXEcy715QL8/oRKSKa1cjYhJu7/v+kATSv/X+yAz1Iy8M
I7xG88JzkVYvZCeVD0L9AbiZcikjnt3mdgUnshLMmco98FfjGmb3SqGxLT2GdpXq
0mNbAOtS+W712Yzc/zELnHA1UHnEFw==
=PkIV
-----END PGP SIGNATURE-----

--DMjGRWttnJ4jOPaldhW1hNMjvRhVndqtg--
