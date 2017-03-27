Received: from eggs.gnu.org ([2001:4830:134:3::10]:41870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXrl-0006lO-Gt
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXri-00085r-90
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXri-00085W-00
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3D751443
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:51:32 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <71832b24-7a94-8924-e18b-3adda0bb6467@redhat.com>
Date: Mon, 27 Mar 2017 18:51:29 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5xXHn7KmlvS7r8W8An63QEbQOI5Bs786V"
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
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5xXHn7KmlvS7r8W8An63QEbQOI5Bs786V
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <71832b24-7a94-8924-e18b-3adda0bb6467@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev and -drive
 parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> This reverts half of commit 0a55679.  We're having second thoughts on
> the QAPI schema (and thus the external interface), and haven't reached
> consensus, yet.  Issues include:
>=20
> * The implementation uses deprecated rados_conf_set() key
>   "auth_supported".  No biggie.
>=20
> * The implementation makes -drive silently ignore invalid parameters
>   "auth" and "auth-supported.*.X" where X isn't "auth".  Fixable (in
>   fact I'm going to fix similar bugs around parameter server), so
>   again no biggie.
>=20
> * BlockdevOptionsRbd member @password-secret applies only to
>   authentication method cephx.  Should it be a variant member of
>   RbdAuthMethod?
>=20
> * BlockdevOptionsRbd member @user could apply to both methods cephx
>   and none, but I'm not sure it's actually used with none.  If it
>   isn't, should it be a variant member of RbdAuthMethod?
>=20
> * The client offers a *set* of authentication methods, not a list.
>   Should the methods be optional members of BlockdevOptionsRbd instead
>   of members of list @auth-supported?  The latter begs the question
>   what multiple entries for the same method mean.  Trivial question
>   now that RbdAuthMethod contains nothing but @type, but less so when
>   RbdAuthMethod acquires other members, such the ones discussed above.
>=20
> * How BlockdevOptionsRbd member @auth-supported interacts with
>   settings from a configuration file specified with @conf is
>   undocumented.  I suspect it's untested, too.
>=20
> Let's avoid painting ourselves into a corner now, and revert the
> feature for 2.9.
>=20
> Note that users can still configure authentication methods with a
> configuration file.  They probably do that anyway if they use Ceph
> outside QEMU as well.
>=20
> qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
> which is silly.  This will be cleaned up shortly.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c          | 31 +++----------------------------
>  qapi/block-core.json | 24 ------------------------
>  2 files changed, 3 insertions(+), 52 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5xXHn7KmlvS7r8W8An63QEbQOI5Bs786V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZQxESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOvcH/0pj+Rkl6J3WdAIyzFWEeUkY0GkgYo7U
PVucuranXqPDVodLWC98ux0IOqg8wnG+d0bGSXa68GaifHqdlKEg5F9b3/sRPNQe
OdldoR02F2x3ubO2O2srgneRcXe00VTmP/iwxBEJ6ULbjn7+xbtcRHuQNhd1A7IA
qu1P145vswQRD3NzQ0OY1uRDdyC3szbkH+aQsK4l3OGuP6k8B6MZzFJkRhrHc+tg
wa1PEBkKDZ3g6LYjPkG1j16UL9fvl+x/1y9EGZyk83xM1zN7/pbvXPhguMBxoQMb
rrCE9vi6YNeVHAGwHVkgefwCNX29s+xcU0p8UIs6cxUF1sP4PrsCF7w=
=RJnL
-----END PGP SIGNATURE-----

--5xXHn7KmlvS7r8W8An63QEbQOI5Bs786V--
