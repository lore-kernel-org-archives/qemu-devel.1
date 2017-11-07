Received: from eggs.gnu.org ([2001:4830:134:3::10]:57007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCAUp-00039x-Qb
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCAUo-0003eE-Tz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:29:19 -0500
References: <20171107172638.29942-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
Date: Tue, 7 Nov 2017 14:29:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171107172638.29942-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="55QInNlGBoB56Jo62mWOXBgLWDhapm723"
Subject: Re: [Qemu-devel] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55QInNlGBoB56Jo62mWOXBgLWDhapm723
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
Subject: Re: [PATCH] block: Deprecate bdrv_set_read_only() and users
References: <20171107172638.29942-1-kwolf@redhat.com>
In-Reply-To: <20171107172638.29942-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 11:26 AM, Kevin Wolf wrote:
> bdrv_set_read_only() is used by some block drivers to override the
> read-only option given by the user. This is not how read-only images
> generally work in QEMU: Instead of second guessing what the user really=

> meant (which currently includes making an image read-only even if the
> user didn't only use the default, but explicitly said read-only=3Doff),=
 we
> should error out if we can't provide what the user requested.
>=20
> This adds deprecation warnings to all callers of bdrv_set_read_only() s=
o
> that the behaviour can be corrected after the usual deprecation period.=

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c       |  5 +++++
>  block/bochs.c | 13 ++++++++++---
>  block/cloop.c | 13 ++++++++++---
>  block/dmg.c   | 12 +++++++++---
>  block/rbd.c   | 14 ++++++++++----
>  block/vvfat.c |  6 +++++-
>  6 files changed, 49 insertions(+), 14 deletions(-)

Dan pointed out the missing documentation, but for the code itself, the
approach looks sane (especially since it was my attempt to make it worse
by extending the idiom to NBD that triggered you to write this patch).

Other documentation: In qapi/block-core.json, @BlockdevOptions, we
probably ought to mention under @read-only that some block drivers
require the use of an explicit read-only.

> +++ b/block/vvfat.c
> @@ -1259,7 +1259,11 @@ static int vvfat_open(BlockDriverState *bs, QDic=
t *options, int flags,
>                         "Unable to set VVFAT to 'rw' when drive is read=
-only");
>              goto fail;
>          }
> -    } else  {
> +    } else  if (!bdrv_is_read_only(bs)) {
> +        error_report("Opening non-rw vvfat images without an explicit =
"
> +                     "read-only=3Don option is deprecated. Future vers=
ions "
> +                     "will refuse to open the image instead of "
> +                     "automatically marking the image read-only.");
>          /* read only is the default for safety */
>          ret =3D bdrv_set_read_only(bs, true, &local_err);

Is this also a good time to deprecate vvfat's duplication of rw vs.
read-only, and consolidate that into a single option?  No other device
defaults to read-only, so the deprecation period is a good point to warn
that a future version may default to read-write without an explicit
read-only.  I guess vvfat is the only driver with a device-specific QAPI
change (for 'rw') that might be impacted if you make that additional chan=
ge.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--55QInNlGBoB56Jo62mWOXBgLWDhapm723
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCF5gACgkQp6FrSiUn
Q2r0PAf+N91woYokAWR4UL98dcDYYkMjSYjVdnZL5FLbynexOPinVoSdrYKieSS6
3xzlkT4qS6IFtCEzG+5AaE/UoqZwZPg36gwXy8z1RXadpqtvOKXldFTbiYtemCBY
VxLqy8biVzMMi0lE7AfdyPjFW+XstWTXCc3TajfQ9yhQiXQZZB93fTiwzJPJD/nb
83F7C1zEvwpUz9gT13+5xv1dFYuqrwcrlpC4iUV2W3bno8YEjtLCsbP6DgsTDOmD
HMHD3MkwKKCucuASpTttIxBCnJqOncdofdG+HZfUUO/x+v1GRz+irc7bjeek7Hna
eWG3gElJkata3X4q0jamo98qYYeCXQ==
=naW3
-----END PGP SIGNATURE-----

--55QInNlGBoB56Jo62mWOXBgLWDhapm723--
