Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0rZf-0000xB-27
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0rZe-0000l4-1l
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:31:19 -0400
References: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
	<1492614962-20946-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0d041b3-033e-b260-f680-90aec1f9e00c@redhat.com>
Date: Wed, 19 Apr 2017 10:31:06 -0500
MIME-Version: 1.0
In-Reply-To: <1492614962-20946-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4GS2sI3fVIWrjPNv2Bqu20v7X110Ci1go"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-iotests: Filter HMP readline
 escape characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4GS2sI3fVIWrjPNv2Bqu20v7X110Ci1go
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, lvivier@redhat.com
Message-ID: <e0d041b3-033e-b260-f680-90aec1f9e00c@redhat.com>
Subject: Re: [PATCH v2 2/3] qemu-iotests: Filter HMP readline escape
 characters
References: <1492614962-20946-1-git-send-email-kwolf@redhat.com>
 <1492614962-20946-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492614962-20946-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 10:16 AM, Kevin Wolf wrote:
> The only thing the escape characters achieve is making the reference
> output unreadable and lines that are potentially so long that git
> doesn't want to put them into an email any more. Let's filter them out.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/028.out       |   2 +-
>  tests/qemu-iotests/051           |   3 +-
>  tests/qemu-iotests/051.out       | 106 +++++++++++++++----------------=

>  tests/qemu-iotests/051.pc.out    | 132 +++++++++++++++++++------------=
--------
>  tests/qemu-iotests/068           |   4 +-
>  tests/qemu-iotests/068.out       |   6 +-
>  tests/qemu-iotests/130.out       |   4 +-
>  tests/qemu-iotests/142           |   2 +-
>  tests/qemu-iotests/142.out       |  10 +--
>  tests/qemu-iotests/145           |   3 +-
>  tests/qemu-iotests/145.out       |   2 +-
>  tests/qemu-iotests/common.filter |   7 +++
>  tests/qemu-iotests/common.qemu   |   4 +-
>  13 files changed, 147 insertions(+), 138 deletions(-)

> +++ b/tests/qemu-iotests/common.filter
> @@ -86,6 +86,13 @@ _filter_qmp()
>          -e '    QMP_VERSION'
>  }
> =20
> +# readline makes HMP command strings so long that git complains
> +_filter_hmp()
> +{
> +    sed -e $'s/^\((qemu) \)\\?.*\e\\[D/\\1/g' \

Inside $'', \ must be escaped to guarantee defined behavior in cases
where you want literal \ in the result (the fact that bash lets \( pass
through literally for now is not good to rely on).

sed -e $'s/^\\((qemu) \\)\\?.*\e\\[D/\\1/g' \

The other way is to use token concatenation, using '' for the bulk of
the string and $'' only for \e, although I don't know if it reads any
better:

sed -e 's/^\((qemu) \)\?.*'$'\e''\[D/\1/g' \

With that line fixed (by either style),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4GS2sI3fVIWrjPNv2Bqu20v7X110Ci1go
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY94K6AAoJEKeha0olJ0Nq8jkIAJ5Gf6mU7yBHWEZh1xCbPB7q
HZODwAzlkRQVj+LBQxTqKdPPPfR1X6DGRLuJ/eihUIp0ZxM4GlO9b9eXGSFPYm+y
1Z+hXh2brJgEIA/aoQDct0VkLSdOXsdlNsjOeUMFsXx/6/XaMS4HmdZAYjtblGGG
lChOM+7fHY+n3rFmt/y3Okf3A8ElIJPCj1iYuWhKzhUsPmBlKMic/kwhyrShqmuy
yA01qCTuX25OXRf/o0qJAmn3aMOp77DV9rvnQPuHANGhLj0b22a/OcESWT7ee7yp
XNIlstY5XmYyXYaoixq7DGSmo6U1kV1XmgmMC0uuuqSqznWRkZ9V5PPVfsGf7Uw=
=iofY
-----END PGP SIGNATURE-----

--4GS2sI3fVIWrjPNv2Bqu20v7X110Ci1go--
