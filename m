Received: from eggs.gnu.org ([2001:4830:134:3::10]:51977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIf0V-0005cw-Gt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIf0U-0003QR-7E
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:44:35 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ded45a2f-c950-c338-373d-63e0c50b16f5@redhat.com>
Date: Wed, 7 Jun 2017 19:44:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QcrrEjjVH4T2xmgEG5UWRhQrkF1SUERj3"
Subject: Re: [Qemu-devel] [PATCH v8 00/20] Convert QCow[2] to QCryptoBlock &
 add LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QcrrEjjVH4T2xmgEG5UWRhQrkF1SUERj3
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <ded45a2f-c950-c338-373d-63e0c50b16f5@redhat.com>
Subject: Re: [PATCH v8 00/20] Convert QCow[2] to QCryptoBlock & add LUKS
 support
References: <20170601172734.9039-1-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 19:27, Daniel P. Berrange wrote:
> Previously posted:
>=20
>  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00201.htm=
l
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05147.htm=
l
>  v3: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05671.htm=
l
>  v4: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02293.htm=
l
>  v5: https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04653.htm=
l
>  v6: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04561.htm=
l
>  v7: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05818.htm=
l
>=20
> This series is a continuation of previous work to support LUKS in
> QEMU. The existing merged code supports LUKS as a standalone
> driver which can be layered over/under any other QEMU block device
> driver. This works well when using LUKS over protocol drivers (file,
> rbd, iscsi, etc, etc), but has some downsides when combined with
> format drivers like qcow2.
>=20
> If you layer LUKS under qcow2 (eg qcow2 -> luks -> file) then you
> cannot get any information about the qcow2 file without first
> decrypting it, as both the header and payload are encrypted.
>=20
> If you layer LUKS over qcow2 (eg luks -> qcow2 -> file) then you
> cannot distinguish between a qcow2 file where the guest has done
> LUKS encryption from a qcow2 file which qemu has done encryption.
> More seriously, when encrypting sectors the guest virtual sector
> is used as the input for deriving the initialization vectors.
> When internal snapshots are used, this means that multiple sectors
> in the qcow2 file may be encrypted with the same initialization
> vector. This is a security weakness when combined with certain
> cryptographic modes.
>=20
> Integrating LUKS natively into qcow2 allows us to combine the
> best aspects of both layering strategies above. In particular
> the header remains unecrypted, but initialization vectors are
> generated using physical sector numbers preserving security
> when snapshots are used. This is a change from previous postings
> of this work, where the IVs were (incorrectly) generated based
> on the virtual disk sector.
>=20
> In a previous posting of this work, Fam had suggested that we
> do integration by layering luks over qcow2, but having QEMU
> block layer automatically create the luks driver above qcow2
> based on the qcow2 header crypt_method field. This is not
> possible though, because such a scheme would suffer from the
> problem of IVs being generated from the virtual disk sector
> instead of physical disk sector. So having LUKS specific
> code in the qcow2 block driver is unavoidable. In comparison
> to the previous posting though, the amount of code in qcow2.c
> has been reduced by allowing re-use of code from block/crypto.c
> for handling QemuOpts -> QAPI conversion. So extra lines of
> code in qcow2 to support LUKS is < 200.
>=20
> I have also split the changes to qcow2 up into 2 patches. The
> first patch simply introduces use of the QCryptoBlock framework
> to qcow2 for the existing (deprecated) AES-CBC encryption method.
> The second patch wires up the LUKS support for qcow2. This makes
> it clearer which parts of the changes are related to plain code
> refactoring, vs enabling the new features. Specifically we can
> now see that the LUKS enablement in qcow2 has this footprint:

I'm trusting Eric and Berto, so I haven't looked at all patches in
depth. But I did have a look at all, and found only some minor stuff to
complain about. I didn't send an R-b for patches I did not find
anything, because (as I said) I didn't look at them sufficiently that
I'd give an R-b (which I didn't because Eric's and Berto's were already
present).

I'm just writing this so you know I'm not planning to write any
complaints for the patches I did not reply to. :-)

Max


--QcrrEjjVH4T2xmgEG5UWRhQrkF1SUERj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZODt4EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFhZ
B/9/nZDbPG3QH8NbD157Q1Pteg+JekNQxIWz+0bEh9i4LnJ6qwzhRH95yLI18vc9
IwEaCDXSlLGo4lnOOVGZsXHRMpDl2uttCxpNuSMhDiS1i/h1Nzk0uQZJlFDX4hsM
uJxebAHqHuY9OOoOaxdJMrglVPeaU6kP9QfbDeD95BE9YaofDi1UlN9tZP56Wily
2zf1AQ9kvknEFFdGIYJj/u+FszDCh8R8UWbPXHAQ7Uvy3YqaK7wAYi/w51wixTg1
nVEMjg1rwKeiiVwjkdVcf8aYdstHar5S31ajx/jUNjNBxnzhkzMuNTHFLPChi2lD
cQrzO0CfuT5E+kIo66xGUiuV
=arZA
-----END PGP SIGNATURE-----

--QcrrEjjVH4T2xmgEG5UWRhQrkF1SUERj3--
