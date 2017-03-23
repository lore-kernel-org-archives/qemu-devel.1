Received: from eggs.gnu.org ([2001:4830:134:3::10]:35505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Bf-0004dm-0r
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr7Ba-00062U-3g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr7BZ-00061z-R2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F14113DBC7
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 18:10:09 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
Date: Thu, 23 Mar 2017 13:10:06 -0500
MIME-Version: 1.0
In-Reply-To: <1490266548-22500-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DBpWJn57EDLV6GbdFCJpTP3eDi4FIjAcS"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
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
--DBpWJn57EDLV6GbdFCJpTP3eDi4FIjAcS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
Subject: Re: [PATCH for-2.9 4/5] rbd: Peel off redundant RbdAuthMethod wrapper
 struct
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 05:55 AM, Markus Armbruster wrote:
> BlockdevOptionsRbd member auth-supported is a list of struct
> RbdAuthMethod, whose only member is enum RbdAuthSupport.  There is no
> reason for wrapping the enum in a struct.

Well, the previous patch removed the QemuOpts madness as a technical
reason that required the wrapper, leaving nothing else technically using
it at the moment.  But there's still the design to think about...

>  Delete the wrapper, and
> rename the enum.

This patch changes the QMP wire format. It MUST go in 2.9, otherwise,
we've baked in the insanity; that is, if we decide it is insanity [1]

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c          |  2 +-
>  qapi/block-core.json | 15 ++-------------
>  2 files changed, 3 insertions(+), 14 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -2601,25 +2601,14 @@
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
>  # @RbdAuthMethod:
>  #
>  # An enumeration of rados auth_supported types
>  #
>  # Since: 2.9
>  ##
> -{ 'struct': 'RbdAuthMethod',
> -  'data': { 'auth': 'RbdAuthSupport' } }
> +{ 'enum': 'RbdAuthMethod',
> +  'data': [ 'cephx', 'none' ] }

Changes BlockdevOptionsRbd from:

=2E.., "auth-supported": [ { "auth": "none" } ],

to the potentially much nicer:

=2E.., "auth-supported": [ "none" ],

[1] But what if we want to make auth-supported be an array of flat
unions, where 'auth' is the discriminator that determines if additional
members are needed?  In other words, the existing API would allow:

"auth-supported": [ { "auth": "cephx" },
                    { "auth": "new", "password-id": "foo" } ]

for specifying a new auth type 'new' that comes with an associated
'password-id' field for looking up a corresponding 'secret' object used
for retrieving the associated password when using that type of
authorization.  In that scenario, RbdAuthMethod would look more like
this pseudo-qapi:

{ 'union': 'RbdAuthMethod', 'base': { 'auth': 'RbdAuthSupport' },
  'discriminator': 'auth',
  'data': { 'none': {},
            'cephx': {},
            'new': { 'password-id': 'str' } } }

Assuming we are okay with not needing to extend the current one-member
RbdAuthMethod struct into a flat union, then this patch is fine, and you
can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

But if you think the flat union expansion path may ever prove useful,
then maybe we don't want this patch after all.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DBpWJn57EDLV6GbdFCJpTP3eDi4FIjAcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1A9+AAoJEKeha0olJ0Nqr40H/jsNPMlH/HnKDWiSz4R9gwqe
PKpKqgBU1AQkwqFblumGNpa9878vnlzRTSC3l4+foxr5yBj3a5hXjKhQcdiOH3Ro
HVq89ERjiBqlXOfAoChpodzIBUjzxEp7Bjy2EVLrsy9lunkfLT/BgHzDDLl1myY+
w/k7bxSMvl2XDE0FETuc6BnTjUJEvaXJEqsaCqXoXzKyKN9NdA83IMpi036DUlXi
Lx0XOok4yO30mFrC9T7fvko4VLaAnKkNOnJN9fyj4i9JnPSjOzafDNYvLjkc1Zoi
hL0+PHug350LnmJwpF77PqBTkaX/tTIaYmRjiEWScb2m/EyP8KgX9s9B6xyPKK8=
=Pox6
-----END PGP SIGNATURE-----

--DBpWJn57EDLV6GbdFCJpTP3eDi4FIjAcS--
