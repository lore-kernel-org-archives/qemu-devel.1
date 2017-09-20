Received: from eggs.gnu.org ([2001:4830:134:3::10]:57471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufp4-0006fU-Ma
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufp3-0006MR-H9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:17:54 -0400
References: <20170920121515.1311-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0b5fdb3-1cd8-c398-ad00-474ed783c7a2@redhat.com>
Date: Wed, 20 Sep 2017 09:17:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170920121515.1311-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TQaXvXU939611iaUrE8QEF0No8wBNXuSd"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests/195: Change multiple nodes in
 one run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQaXvXU939611iaUrE8QEF0No8wBNXuSd
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <e0b5fdb3-1cd8-c398-ad00-474ed783c7a2@redhat.com>
Subject: Re: [PATCH] qemu-iotests/195: Change multiple nodes in one run
References: <20170920121515.1311-1-kwolf@redhat.com>
In-Reply-To: <20170920121515.1311-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 07:15 AM, Kevin Wolf wrote:
> This additional check for change-backing-file makes sure that actions o=
n
> one part of the graph don't interfere with later actions elsewhere.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/195     | 17 ++++++++++++++++
>  tests/qemu-iotests/195.out | 51 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 68 insertions(+)
>=20

> +run_qemu -drive if=3Dnone,file=3D"$TEST_IMG",node-name=3Dtop,backing.n=
ode-name=3Dmid <<EOF
> +{"execute":"qmp_capabilities"}
> +{"execute":"change-backing-file", "arguments":{"device":"none0","image=
-node-name":"mid","backing-file":"/dev/null"}}
> +{"execute":"change-backing-file", "arguments":{"device":"none0","image=
-node-name":"top","backing-file":"/dev/null"}}

I guess 'mid' is still accessible even though 'top' now no longer points
to mid in the header, because we rely on our cache of the relationships
rather than what is written into the header (of course, as soon as qemu
quits, we've broken the chain, but that doesn't matter for this test).

> +{"execute":"change-backing-file", "arguments":{"device":"none0","image=
-node-name":"mid","backing-file":"/dev/null"}}

Should the second modification to 'mid' be distinct from the first (as
in, back to $TEST_IMG.mid), to make sure we are actually making another
change, rather than triggering some short-cut that might treat a no-op
change as something that can be skipped?  Even bouncing between
"$TEST_IMG.mid", "./$TEST_IMG.mid", and "././$TEST_IMG.mid" will access
the same file (and thus not break the chain), while still making it
obvious which changes took effect, when compared to your change to
/dev/null.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TQaXvXU939611iaUrE8QEF0No8wBNXuSd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCeIUACgkQp6FrSiUn
Q2pMRQf+McgfTYeHDRywtJ2vEcdUcnxvVzUwKxPmrxZK042larVsy0KEp0ravzAr
M3TAbYZFCPWhPN+zBYDeRCnx/7W3FlOvHr8tLm1Z+rWy5hx3cLuU7IaK3pBcXb42
x2RXvneyPMyynGFcqcLPdb3d18tJn0UkralYazG8yZPbEEOaxyWnp8pCNPSFsUdG
9CWwN5Btl2qbqHV9eGhBN4/chaf0rcofBp/gYwfBIANg04xAxL/fcyb2/WRXtb63
DWlm/whOpgr87NiLikYKSoWga+oMtufvC6hxbXaqhjmWoqZopWerlCgFQfMKb1Eo
4SPfTtQytE86V8ioQAoPAjzuL8hbpQ==
=jy6w
-----END PGP SIGNATURE-----

--TQaXvXU939611iaUrE8QEF0No8wBNXuSd--
