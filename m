Received: from eggs.gnu.org ([2001:4830:134:3::10]:55668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7nS-0003id-3c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7nR-0003Rt-48
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:55:18 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-11-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
Date: Tue, 25 Jul 2017 16:55:07 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-11-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kcgalba6bgbiCHdgOPPKQdQ5rS2EReAmx"
Subject: Re: [Qemu-devel] [PATCH V5 10/10] block/qcow2: add compress info to
 image specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kcgalba6bgbiCHdgOPPKQdQ5rS2EReAmx
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
Subject: Re: [PATCH V5 10/10] block/qcow2: add compress info to image specific
 info
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-11-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-11-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c        | 7 +++++++
>  qapi/block-core.json | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> +++ b/qapi/block-core.json
> @@ -68,6 +68,9 @@
>  # @encrypt: details about encryption parameters; only set if image
>  #           is encrypted (since 2.10)
>  #
> +# @compress: details about parameters for compressed clusters; only se=
t if
> +#            the compress format header extension is present (since 2.=
11)

Thinking aloud:

I still think this is better as "only set if the image uses compressed
headers" (similar to encrypt).  That is, I would like this output to be
present even when opening legacy deflate/0/12 images.

But thinking more, what I am REALLY asking for is "if any cluster is
compressed, then this information is present; if nothing is compressed,
the choice of compression header doesn't matter".  But we don't have a
quick-and-dirty way to tell if an image has any compressed clusters,
short of examining every L2 map (including maps inside internal snapshots=
).

Hmm - we already have 'Dirty bit' and 'Corrupt bit' as
incompatible_features that can quickly identify certain image
properties; do we want another bit set to 1 for images known to use
compressed clusters?  Or even make it an auto-clear bit (or even a pair
of auto-clear bits: one to designate that this image was written by a
new-enough qemu that promises to mark the image if any compressed
clusters exist, and the other is set only if such clusters do exist;
that way, if both bits are clear, we know we have to walk L2 tables to
look for compressed clusters, but if the first bit is set, then the
second bit is reliable)?

So maybe this means we are still debating spec ideas.  Kevin, do you
want to chime in?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Kcgalba6bgbiCHdgOPPKQdQ5rS2EReAmx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3vjwACgkQp6FrSiUn
Q2pZyQgAldh+87nUcZLX+QM2iyid+dRZV4YJYaQr+TsHXUGOPTiekj6+Y/I++TOJ
08PEP1dtAqn/+N+JG26i4lvYOUzj1tHjbjzLgcbiG6gmMMGg1NLAJ1YGTwW44eMa
B6UGPvfFCbtbQY4EHsMbU8xahYn/w2bKrlrfXxltC2BadVR0id1zVQkSfy+anbnX
mLQZ1AGqEAafj5k0IEjXY2JZ9oXTKybacplsfwGNrR9Wf551NHknMgwh0y3HTNsm
5898WnLGQna6Y9ohuqX+78QimDbXfTmQy9pO/i19ZrWfHZXVe9XPX5qEJVIaXtFD
qVpSxSPSlBCP9hrqBgO3FdmJTIv3sA==
=PiNl
-----END PGP SIGNATURE-----

--Kcgalba6bgbiCHdgOPPKQdQ5rS2EReAmx--
