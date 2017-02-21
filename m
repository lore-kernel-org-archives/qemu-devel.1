Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD14-0000F7-Ip
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD10-0004jR-4I
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:10:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgD0z-0004j7-Ra
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:10:10 -0500
References: <1487674859-26249-1-git-send-email-armbru@redhat.com>
	<1487674859-26249-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d855ef63-8c3d-3bb3-b6aa-766a297dd095@redhat.com>
Date: Tue, 21 Feb 2017 10:10:07 -0600
MIME-Version: 1.0
In-Reply-To: <1487674859-26249-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4bD4sCpAge60SMEqGmk5Uf00stf50i3pb"
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Improve qobject input visitor
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4bD4sCpAge60SMEqGmk5Uf00stf50i3pb
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <d855ef63-8c3d-3bb3-b6aa-766a297dd095@redhat.com>
Subject: Re: [PATCH 2/2] qapi: Improve qobject input visitor error reporting
References: <1487674859-26249-1-git-send-email-armbru@redhat.com>
 <1487674859-26249-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487674859-26249-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 05:00 AM, Markus Armbruster wrote:
> Error messages refer to nodes of the QObject being visited by name.
> Trouble is the names are sometimes less than helpful:
>=20
> * The name of the root QObject is whatever @name argument got passed
>   to the visitor, except NULL gets mapped to "null".  We commonly pass
>   NULL.  Not good.
>=20
>   Avoiding errors "at the root" mitigates.  For instance,
>   visit_start_struct() can only fail when the visited object is not a
>   dictionary, and we commonly ensure it is beforehand.
>=20
> * The name of a QDict's member is the member key.  Good enough only
>   when this happens to be unique.
>=20
> * The name of a QList's member is "null".  Not good.

At least we didn't crash.  But indeed it was not nice.

>=20
> Improve error messages by referring to nodes by path instead, as
> follows:
>=20
> * The path of the root QObject is whatever @name argument got passed
>   to the visitor, except NULL gets mapped to "<anonymous>".
>=20
> * The path of a root QDict's member is the member key.
>=20
> * The path of a root QList's member is "[%zu]", where %zu is the list
>   index, starting at zero.
>=20
> * The path of a non-root QDict's member is the path of the QDict
>   concatenated with "." and the member key.
>=20
> * The path of a non-root QList's member is the path of the QList
>   concatenated with "[%zu]", where %zu is the list index.

Nice!  We've mentioned this idea in the past, but I'm glad to see actual
code for it.

>=20
> For example, the incorrect QMP command
>=20
>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "dr=
iver": "raw", "file": {"driver": "file" } } }
>=20
> now fails with
>=20
>     {"error": {"class": "GenericError", "desc": "Parameter 'file.filena=
me' is missing"}}
>=20
> instead of
>=20
>     {"error": {"class": "GenericError", "desc": "Parameter 'filename' i=
s missing"}}
>=20
> and
>=20
>     { "execute": "input-send-event", "arguments": { "device": "bar", "e=
vents": [ [] ] } }
>=20
> now fails with
>=20
>     {"error": {"class": "GenericError", "desc": "Invalid parameter type=
 for 'events[0]', expected: object"}}
>=20
> instead of
>=20
>     {"error": {"class": "GenericError", "desc": "Invalid parameter type=
 for 'null', expected: QDict"}}

And that right there justifies this patch!

>=20
> The qobject output visitor doesn't have this problem because it should
> not fail.  Same for dealloc and clone visitors.
>=20
> The string visitors don't have this problem because they visit just
> one value, whose name needs to be passed to the visitor as @name.  The
> string output visitor shouldn't fail anyway.
>=20
> The options visitor uses QemuOpts names.  Their name space is flat, so
> the use of QDict member keys as names is fine.  NULL names used with
> roots and lists could conceivably result in bad error messages.  Left
> for another day.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor.h       |   6 ---
>  qapi/qobject-input-visitor.c | 123 +++++++++++++++++++++++++++++++----=
--------
>  2 files changed, 89 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 9bb6cba..7c91a50 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -66,12 +66,6 @@
>   * object, @name is the key associated with the value; and when
>   * visiting a member of a list, @name is NULL.
>   *
> - * FIXME: Clients must pass NULL for @name when visiting a member of a=

> - * list, but this leads to poor error messages; it might be nicer to
> - * require a non-NULL name such as "key.0" for '{ "key": [ "value" ]
> - * }' if an error is encountered on "value" (or to have the visitor
> - * core auto-generate the nicer name).

Aha - I _knew_ we'd talked about it before :)

Nice change.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4bD4sCpAge60SMEqGmk5Uf00stf50i3pb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGZfAAoJEKeha0olJ0NqgIEH/2gcDoHZA0NimRbu2wqVFxyD
O7D/yvO31ZkNtYRBnnjYR5RBucwfrd71Fg77uRwFXc2GojQru/UlIrThigUp+4Om
gHQZwfixn1fPWs1kvS3dEXEWKz2kPfnOAYzOU3ud5pmtaAVhqtbfDoVTDZd9aG+c
H1xP+25wm/9lNHvFQL2ZWkwYDUAIKxL1nVsto28tlIa4GzvF6Ze8UCFt08/IINE/
4G9DxKmtQ74XR3h9nRc2jl37++pa4lEDFK6LrijccLfQm78M+t7VWH7cVf68px2n
7XcUR9Lt8ABD3hsxQFydtaxV8sylee0gbDfs78kDCySL5Hjk0aiiIM4OWC8ajBk=
=h2R2
-----END PGP SIGNATURE-----

--4bD4sCpAge60SMEqGmk5Uf00stf50i3pb--
