Received: from eggs.gnu.org ([2001:4830:134:3::10]:40181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteNc-0005jp-JQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteNb-0008EO-NV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:01:04 -0400
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com>
Date: Thu, 30 Mar 2017 13:00:55 -0500
MIME-Version: 1.0
In-Reply-To: <1490895797-29094-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ff4o7RQuFkHGo6GVFDTn2skofJ99PH6bk"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 4/9] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ff4o7RQuFkHGo6GVFDTn2skofJ99PH6bk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com>
Subject: Re: [PATCH v3 for-2.9 4/9] block: Document -drive problematic code
 and bugs
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
 <1490895797-29094-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 12:43 PM, Markus Armbruster wrote:
> -blockdev and blockdev_add convert their arguments via QObject to
> BlockdevOptions for qmp_blockdev_add(), which converts them back to
> QObject, then to a flattened QDict.  The QDict's members are typed
> according to the QAPI schema.
>=20
> -drive converts its argument via QemuOpts to a (flat) QDict.  This
> QDict's members are all QString.
>=20
> Thus, the QType of a flat QDict member depends on whether it comes
> from -drive or -blockdev/blockdev_add, except when the QAPI type maps
> to QString, which is the case for 'str' and enumeration types.
>=20

> +++ b/block/file-posix.c
> @@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDict=
 *options, int flags,
>      int ret;
> =20
>  #if defined(__APPLE__) && defined(__MACH__)
> +    /*
> +     * Caution: while qdict_get_try_str() is fine, getting non-string
> +     * types would require more care.  When @options come from -blockd=
ev
> +     * or blockdev_add, its members are typed according to the QAPI
> +     * schema, but when they come from -drive, they're all QString.
> +     */
>      const char *filename =3D qdict_get_str(options, "filename");

Comment mentions (via copy-and-past) qdict_get_try_str(), but this
instance uses qdict_get_str().  Doesn't bother me enough to withhold
review if you leave it, though.


> +++ b/block/nfs.c
> @@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Error=
 **errp)
>          goto out;
>      }
> =20
> +    /*
> +     * Caution: this works only because all scalar members of
> +     * NFSServer are QString in @crumpled_addr.  The visitor expects
> +     * @crumpled_addr to be typed according to the QAPI scherma.  It

s/scherma/schema/

> +     * is when @options come from -blockdev or blockdev_add.  But when=

> +     * they come from -drive, they're all QString.
> +     */

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ff4o7RQuFkHGo6GVFDTn2skofJ99PH6bk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3UfXAAoJEKeha0olJ0NqWvoH/23h92FDHpDQmxJOO5VHRvuO
18NLJgIcXBqzyH4ngc4KW3qtYDjp2gCiimnjrJL6vhDeWdpxJiwP2g3w4jObmkCt
wSnho4mxuX+cZSQDSLrYd1ooRTwz3F99aMSydu060z+gqWbxDk51bl25fzF4Y5Zf
HLxF8gl/Auh5UXVjdP2ZtT04AXxkw1bWJUvIYNDqKxAJZRpWzwhhfIBHfR85AWEK
hhHnBSMYUlvLGJtBOFv5bpk36mBQ8gPPi0UGmCjivAAQkwxbwN8uDZrd6/Z86wP4
GdZIM/FI8ALhEzVHvK/A/xqM7Ov8s+9z+NlCewAEr7gBj5ZEPpA4sfGalklYIr0=
=rsMJ
-----END PGP SIGNATURE-----

--Ff4o7RQuFkHGo6GVFDTn2skofJ99PH6bk--
