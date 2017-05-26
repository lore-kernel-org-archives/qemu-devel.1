Received: from eggs.gnu.org ([2001:4830:134:3::10]:43664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEF6I-0001BV-78
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEF6F-0008JF-2F
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEF6E-0008Ig-Ov
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2D36A6DFC
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:16:13 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-7-git-send-email-vyasevic@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86965f80-c0a4-4033-a194-9a9e97c27a0f@redhat.com>
Date: Fri, 26 May 2017 08:16:06 -0500
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-7-git-send-email-vyasevic@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RNlfXK9tit889SNoUteUQAGbg1pa1wEUf"
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com, jdenemar@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RNlfXK9tit889SNoUteUQAGbg1pa1wEUf
From: Eric Blake <eblake@redhat.com>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com,
 jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com,
 jdenemar@redhat.com
Message-ID: <86965f80-c0a4-4033-a194-9a9e97c27a0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
 <1495649128-10529-7-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-7-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 01:05 PM, Vladislav Yasevich wrote:
> Add a qmp command that can trigger guest announcements.
>=20
> Based on work of Germano Veit Michel <germano@redhat.com>
>=20
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>  migration/savevm.c | 14 ++++++++++++++
>  qapi-schema.json   | 19 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20

> +void qmp_announce_self(bool has_params, AnnounceParameters *params,
> +                       Error **errp)
> +{
> +    AnnounceParameters announce_params;
> +
> +    memcpy(&announce_params, qemu_get_announce_params(),
> +           sizeof(announce_params));

Shallow copies of a QAPI type happen to work when the type is all scalar
(as AnnounceParameters currently is), but it's more robust to use
QAPI_CLONE() or QAPI_CLONE_MEMBERS() so that any future non-scalar
additions to the parameters type will be correctly copied without
introducing memory leaks or double frees.

Even this might be better:
AnnounceParameters announce_params =3D { 0 };
qemu_set_announce_parameters(&announce_params, qemu_get_announce_params()=
);

> +
> +    if (has_params)
> +        qemu_set_announce_parameters(&announce_params, params);
> +
> +    qemu_announce_self(&announce_params);
> +}
The QMP changes look okay.  Do you have a testsuite covering the new QMP
command somewhere in the series?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RNlfXK9tit889SNoUteUQAGbg1pa1wEUf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKCqWAAoJEKeha0olJ0NqfzcIAKpPZpe6WLyJnAk/6xUDc20v
+MsoL9fxRP8HClZkztKBdeQ57XO47F2fp1WrQiW3tBC7DD5wjW5/SXSSuvf2kQwD
qGJr6WQNz+xOlHEQS1aIGgcAgNY5j3dUGC16KV468HOKJKqwMmg1nL4ehdOZIdgy
MebDgJ9YKW270y+KeZjOSDttHIxRz/OkUTMDTQA8ljBhQoOdF50fi+3uH3th9euz
IrhNyMwUBLCljV83nV6zqqvth35n+ETjnXNqT83MBwCp1694+nUhPjZ308cD79Zt
AmYLVIdVMtknzdj90fVhu2sZonOPq+s8fD4uwH7LLoGqH45BraX8vWyUW2phIZY=
=gDg4
-----END PGP SIGNATURE-----

--RNlfXK9tit889SNoUteUQAGbg1pa1wEUf--
