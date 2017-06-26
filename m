Received: from eggs.gnu.org ([2001:4830:134:3::10]:39982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPZZK-0002mE-PP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPZZJ-0007vG-Gi
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:21:06 -0400
References: <20170623162419.26068-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c9f34c93-2c73-2a61-7c32-c730eb75093c@redhat.com>
Date: Mon, 26 Jun 2017 21:20:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JHwcfuUB1WojaAPN0aecEVQpJvNg4uhox"
Subject: Re: [Qemu-devel] [PATCH v10 00/20] Convert QCow[2] to QCryptoBlock
 & add LUKS support
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
--JHwcfuUB1WojaAPN0aecEVQpJvNg4uhox
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <c9f34c93-2c73-2a61-7c32-c730eb75093c@redhat.com>
Subject: Re: [PATCH v10 00/20] Convert QCow[2] to QCryptoBlock & add LUKS
 support
References: <20170623162419.26068-1-berrange@redhat.com>
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-23 18:23, Daniel P. Berrange wrote:
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
>  v8: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00308.htm=
l
>  v9: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04250.htm=
l
>=20
> Patches 7, 10, 11 & 13 have changes needing new R-b tags since previous=

> postings
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

Thanks, fixed the secret objects (s/filename/file/) in the commit
message, made patch 12 to point to docs/interop/qcow2.txt (where the
spec has been moved to recently) and applied the series to my block branc=
h:

https://github.com/XanClic/qemu/commits/block

Max


--JHwcfuUB1WojaAPN0aecEVQpJvNg4uhox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZUV6TEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFuG
B/4pSgCfGTULSexRglEK2WgsMSHxDjK8NghK4cF08auIz0WT4L4/Sr64OV5Q/cjg
1OJXy2MUX2c4DyvJYy7caQvBT8Til0MfniDVPvdzQKdCS3xiTgYILq8yHviln9Ja
D3D13RFrAGtcccOOzjkGHWp6CX2AFcpqZVkP02pfpG080cFyD9sRwRz/IW7zdkBH
0RnQmLBhzNcfgkIvKOpBVMWIluGeQikCMzNp8UQ6DJspJmgg1meIxlXpJdSsB6mK
VNjek2Bmg1ZsWh9pMfODr+WAGlwkFDBUmGsLvM7f9+mgFieedhnSff1ePUqSqMu1
H+DrLV6fwQRLG6htCOANnOzt
=GITK
-----END PGP SIGNATURE-----

--JHwcfuUB1WojaAPN0aecEVQpJvNg4uhox--
