Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLHm-0003Ad-94
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLHj-0003pa-9j
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:24:18 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLHj-0003pV-3N
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:24:15 -0500
Received: by mail-wr0-x241.google.com with SMTP id u48so439901wrc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:24:15 -0800 (PST)
Date: Mon, 27 Feb 2017 13:24:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227132411.GQ28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 00/28] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:41:32PM +0100, Greg Kurz wrote:
> This series tries to fix CVE-2016-9602 reported by Jann Horn of Google
> Project Zero:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1413929
>=20
> This vulnerability affects all accesses to the underlying filesystem in
> the "local" backend code.
>=20
> If QEMU is started with:
>=20
> -fsdev local,security_model=3D<passthrough|none>,path=3D/foo/bar
>=20
> then the guest can cause QEMU to create symlinks in /foo/bar.
>=20
> This causes accesses to any path /foo/bar/some/path to be unsafe, since
> untrusted code within the guest (or in another guest sharing the same
> virtfs folder) could change some/path to point to a random path of the
> host filesystem.
>=20
> The core problem is that the "local" backend relies on path-based syscalls
> to access the underlying filesystem. All path-based syscalls are vulnerab=
le
> to this issue, even open(O_NOFOLLOW) or syscalls that explicitly don't
> dereference symlinks, since the kernel only checks the rightmost element =
of
> the path. Depending on the privilege level of the QEMU process, a guest c=
an
> end up opening, renaming, changing ACLs, unlinking... files on the host
> filesystem.
>=20
> The right way to address this is to use "at" variants of all syscalls in
> the "local" backend code. This requires to open directories without
> traversing any symlink in the intermediate path elements. There was a
> tentative to introduce an O_BENEATH flag for openat() that would address
> this:
>=20
> https://patchwork.kernel.org/patch/7007181/
>=20
> Unfortunately this never got merged.  An alternative is to walk through a=
ll
> path elements manually with openat(O_NOFOLLOW).
>=20
> v2:
> 	- /proc based implementation for xattr code (fixes metadata perf drop
>           observed with v1)
>         - some code refactoring
>=20
> Stefan.
>=20
> I had to rework some patches you had already reviewed, please consider
> giving your Reviewed-by again if the changes are ok.

I have reviewed patches that didn't have R-b from me.  Please see
comments on individual patches.

Stefan

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCh7AAoJEJykq7OBq3PIp4sH/ixzd30dGHyHBPLP80jVetw+
qNduXOWh+50KYZ7kn681E3HM2FTCCcPWitB3iS6zQ91jWm8IKlG841wICnHu7Ui0
Zx3u/5j2YRO8K8nv3nrdIXZi9p2MFJnWFpmdqEQhnw1eG99Of7QwwzohdYAFQMh8
H17uchNPPOn110VDMvysGdw4sBAkTY7+OaCRVHdWSpK7H4K83LQ+gwm4C+RqJMiW
cjSgRZmrk6QA3LCmD/npUaReAes/ttR14rrou1BFC0zQsgwyeoPY+RORhK3wxplE
KeZ57wEoqFejw2+MyJXNh9EJBIkP8qyZH233dkEruXOLy3owTnncugS7mQC1hiU=
=wcJa
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--
