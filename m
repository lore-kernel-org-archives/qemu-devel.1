Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csY35-0001tK-7I
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csY30-0004mH-4q
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csY2z-0004lw-TK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B6757AE90
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 17:03:12 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
Date: Mon, 27 Mar 2017 12:03:04 -0500
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G3t5mjDULKgLeF8ioKuubf2VDhS27aIsm"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G3t5mjDULKgLeF8ioKuubf2VDhS27aIsm
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev and -drive
 parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 08:26 AM, Markus Armbruster wrote:
> This reverts half of commit 0a55679.  We're having second thoughts on
> the QAPI schema (and thus the external interface), and haven't reached
> consensus, yet.  Issues include:
>=20

> Let's avoid painting ourselves into a corner now, and revert the
> feature for 2.9.
>=20
> Note that users can still configure authentication methods with a
> configuration file.  They probably do that anyway if they use Ceph
> outside QEMU as well.

If we're only reverting the QMP blockdev-add feature, then this makes
absolute sense (it's not a regression since we don't have a release with
it yet, and we don't want to bake something into the release that can't
be supported).  But breaking -drive usage seems risky, especially since
libvirt is already expecting to work - I'm worried that doing this may
break existing libvirt command line usage if the QemuOpts side doesn't
permit anything at all.  Maybe we need to rely on your '=3Dfoo' or 'x-foo=
'
hack for letting QemuOpts still accept the old spelling during -drive
but not during QMP.

>=20
> qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
> which is silly.  This will be cleaned up shortly.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c          | 31 +++----------------------------
>  qapi/block-core.json | 24 ------------------------
>  2 files changed, 3 insertions(+), 52 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -2601,27 +2601,6 @@
> =20
> =20
>  ##
> -# @RbdAuthSupport:
> -#
> -# An enumeration of RBD auth support
> -#
> -# Since: 2.9
> -##
> -{ 'enum': 'RbdAuthSupport',
> -  'data': [ 'cephx', 'none' ] }
> -
> -
> -##
> -# @RbdAuthMethod:
> -#
> -# An enumeration of rados auth_supported types
> -#
> -# Since: 2.9
> -##
> -{ 'struct': 'RbdAuthMethod',
> -  'data': { 'auth': 'RbdAuthSupport' } }
> -

Removing the .json QMP support is fine. But I'm reluctant to give R-b
without knowing for sure that -drive usage won't regress.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--G3t5mjDULKgLeF8ioKuubf2VDhS27aIsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2UXIAAoJEKeha0olJ0NqQa8H+wXXMZxtCgLspLVvZ8D+G2sZ
XDr62rJqueeYvhKEqt4kJoagUgNtquGf/uNe/M0pI4C+V4Cbf/DZGKeBC+TINdAg
Vap6cSLCaBbm7RgGTexlOcOypstqy5acG97CP4y+qFO1HzY6dZxhceLvcqNEa6jP
DYNAF2MKTuRvioTLFyfkPa8GRwUQ1+wKxUDIMLhIjz9h781USxsndDZ5gz12ynuL
UfkCsxx/AlUSLTqDdII5LzHI9EyblFlVDNJjLV6XA8fnNja35l0pZyo3EYI2wHmA
mJGDf1Pye1DKoFXhaf2E1EICltizmL4194P/D5w5ZTrCR6xoEI5pBfrDKsdZ1Ns=
=JEGU
-----END PGP SIGNATURE-----

--G3t5mjDULKgLeF8ioKuubf2VDhS27aIsm--
