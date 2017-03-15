Received: from eggs.gnu.org ([2001:4830:134:3::10]:36054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7M0-0004ms-NT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7Lw-0002Uw-OW
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7Lw-0002UW-GC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:44:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44786C04BD51
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:44:28 +0000 (UTC)
References: <20170315105646.32355-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de695865-d569-916d-218e-1faff31d6f4b@redhat.com>
Date: Wed, 15 Mar 2017 06:44:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170315105646.32355-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wEVNWuht2eVx682wU4tUTMlbEh6QAFXE0"
Subject: Re: [Qemu-devel] [PATCH] trace: ensure $(tracetool-y) is defined in
 top level makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wEVNWuht2eVx682wU4tUTMlbEh6QAFXE0
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <de695865-d569-916d-218e-1faff31d6f4b@redhat.com>
Subject: Re: [PATCH] trace: ensure $(tracetool-y) is defined in top level
 makefile
References: <20170315105646.32355-1-berrange@redhat.com>
In-Reply-To: <20170315105646.32355-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 05:56 AM, Daniel P. Berrange wrote:
> The build rules for trace files have a dependancy on $(tracetool-y).
> This variable populated in the trace/Makefile.objs file and thus its
> definition gets pulled into the top level makefile. This happens too
> late in the process though, so by the time $(tracetool-y) is defined,
> make has already evaluated $(tracetool-y) in the dependancies and
> found it to be empty. The result is that when the tracetool source
> is changed, the generated files are not rebuilt. The solution is to
> define the variable in the top level makefile too
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Does this mean the definitions in trace/Makefile.objs are now redundant
and can be omitted?

>=20
> diff --git a/Makefile b/Makefile
> index 1c4c04f..dffc74b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -85,6 +85,9 @@ GENERATED_SOURCES +=3D $(TRACE_SOURCES)
> =20
>  trace-group-name =3D $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')=

> =20
> +tracetool-y =3D $(SRC_PATH)/scripts/tracetool.py
> +tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/tracetool -name "*.p=
y")

Should this also include the comment currently in trace/Makefile.objs:

######################################################################
# tracetool source files
# Every rule that invokes tracetool must depend on this so code is
regenerated
# if tracetool itself changes.

But it certainly looks like you're on the right track for fixing the
issue I ran into.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wEVNWuht2eVx682wU4tUTMlbEh6QAFXE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYySkZAAoJEKeha0olJ0NqL0IIAKIPjwdfLJtIHQzOVH6i037u
hiK9SmDExT68fvlAUuCwS3MsOjJOX95SvqSJ1IQ3wifbe5Lw3Kj3sQMpqineqlH7
Qw7snTPyBgOWsPi1fzITvcTYPCv/fhFSB6dhfCRRwPXaVkzAxeuWVbaRj+ALuefm
uh0B0QlBLWXR/aScwCzqEySxnhRnNohjTuKIob48Z/sAP01SvfCXmxsFRkFVLtOy
8A8cc9qcjRSUoYz2/QMKkztYGzaDfVm2kx+tU64CzACo95Knd65pKl5PL1zZOjW8
dHUPr/eDTluQbUr3qNIbRgGUEdrIA81bZFsPVln3S+cQx0VDtwAH7LoJmlacO4Y=
=TymR
-----END PGP SIGNATURE-----

--wEVNWuht2eVx682wU4tUTMlbEh6QAFXE0--
